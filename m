Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AF0C52D27
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06FB24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813045;
	bh=S/lCLJfRx7rrtZqEHxOCELQHv6pcJ4W7qh5YuUQB7Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hc98+7cPDuFfKzbhVJoJR9lVYNY+56wM2cMi6w0ZRhSlmz5tUIx35zu37ePLM4YNa
	 2EnrLe408+w+iu4XhpeeoR0Hj8C1xSFiKdiOYvGZ87FR+26q6MuIj/49uYlHl2afgU
	 nJSJz7mquHskbz3bcUn678P6LRwAI4j3lszs0pv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389693AbgB0ORX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:17:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730557AbgB0ORU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:17:20 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 804522468F;
        Thu, 27 Feb 2020 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582813040;
        bh=S/lCLJfRx7rrtZqEHxOCELQHv6pcJ4W7qh5YuUQB7Yo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFRXgMul09XW72ZmxyXNcSgqrsNMT1zLl2xOSZ/9vTsIbrMINZvX34bj6Qa5wY+LD
         BLj75aqkkD5yQ+fljrVe8y4PAPCScNme4mlsypcH6J9KgJPvhYspRlMX+s9v+5NfLw
         OLUiKWWZAfU+O23SaQdeb8v+e+PywuL1SozIjwRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 5.5 114/150] drm/bridge: tc358767: fix poll timeouts
Date:   Thu, 27 Feb 2020 14:37:31 +0100
Message-Id: <20200227132249.571649531@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomi Valkeinen <tomi.valkeinen@ti.com>

commit 8a6483ac634acda3f599f50082c652d2d37199c7 upstream.

Link training fails with:

  Link training timeout waiting for LT_LOOPDONE!
  main link enable error: -110

This is caused by too tight timeouts, which were changed recently in
aa92213f388b ("drm/bridge: tc358767: Simplify polling in tc_link_training()").

With a quick glance, the commit does not change the timeouts. However,
the method of delaying/sleeping is different, and as the timeout in the
previous implementation was not explicit, the new version in practice
has much tighter timeout.

The same change was made to other parts in the driver, but the link
training timeout is the only one I have seen causing issues.
Nevertheless, 1 us sleep is not very sane, and the timeouts look pretty
tight, so lets fix all the timeouts.

One exception was the aux busy poll, where the poll sleep was much
longer than necessary (or optimal).

I measured the times on my setup, and now the sleep times are set to
such values that they result in multiple loops, but not too many (say,
5-10 loops). The timeouts were all increased to 100ms, which should be
more than enough for all of these, but in case of bad errors, shouldn't
stop the driver as multi-second timeouts could do.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Fixes: aa92213f388b ("drm/bridge: tc358767: Simplify polling in tc_link_training()")
Tested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20191209082707.24531-1-tomi.valkeinen@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/bridge/tc358767.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -297,7 +297,7 @@ static inline int tc_poll_timeout(struct
 
 static int tc_aux_wait_busy(struct tc_data *tc)
 {
-	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0, 1000, 100000);
+	return tc_poll_timeout(tc, DP0_AUXSTATUS, AUX_BUSY, 0, 100, 100000);
 }
 
 static int tc_aux_write_data(struct tc_data *tc, const void *data,
@@ -640,7 +640,7 @@ static int tc_aux_link_setup(struct tc_d
 	if (ret)
 		goto err;
 
-	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 100, 100000);
 	if (ret == -ETIMEDOUT) {
 		dev_err(tc->dev, "Timeout waiting for PHY to become ready");
 		return ret;
@@ -876,7 +876,7 @@ static int tc_wait_link_training(struct
 	int ret;
 
 	ret = tc_poll_timeout(tc, DP0_LTSTAT, LT_LOOPDONE,
-			      LT_LOOPDONE, 1, 1000);
+			      LT_LOOPDONE, 500, 100000);
 	if (ret) {
 		dev_err(tc->dev, "Link training timeout waiting for LT_LOOPDONE!\n");
 		return ret;
@@ -949,7 +949,7 @@ static int tc_main_link_enable(struct tc
 	dp_phy_ctrl &= ~(DP_PHY_RST | PHY_M1_RST | PHY_M0_RST);
 	ret = regmap_write(tc->regmap, DP_PHY_CTRL, dp_phy_ctrl);
 
-	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 1, 1000);
+	ret = tc_poll_timeout(tc, DP_PHY_CTRL, PHY_RDY, PHY_RDY, 500, 100000);
 	if (ret) {
 		dev_err(dev, "timeout waiting for phy become ready");
 		return ret;


