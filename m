Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A202AC18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7895620409
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583846031;
	bh=/CU3mvUbfKrgSRnu4lrZ0glLn0Q5SoFRYLGyMaHLNmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q+VvkPiIKoK4GsKxRTjgHr8A/tkpsG6VSGF7YaEZD/g/UIGyps67QjHMQsmSA9K+7
	 utDDykAyD4Nl1NG+SjP+D8pwYdapYUyYErB+hfXfa73XNrxSf1v8UTzQb3/aQyL7H+
	 LkExita9j1wz+wBoNRtDN+6fzDKMGt83gxNR9C5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbgCJNNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731782AbgCJNNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:13:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D49382468C;
        Tue, 10 Mar 2020 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583846027;
        bh=/CU3mvUbfKrgSRnu4lrZ0glLn0Q5SoFRYLGyMaHLNmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b6M1Bror49Q4XYGcasd2LIEIg7ERme1m8n7fOBD4pdfcJs0DXxMZdFYloLy87s29B
         +vQo5dEsOkttH5Wb1k1Vf5Z/l8+WrdUXXo1Yt7hzAKRPhAvQmjkqtSA9kxkAgUj07G
         CrAbKtfXaTXlNHmKIU7g73V49stGrclDrVOl4g6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jonas Gorski <jonas.gorski@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.19 59/86] spi: bcm63xx-hsspi: Really keep pll clk enabled
Date:   Tue, 10 Mar 2020 13:45:23 +0100
Message-Id: <20200310124533.985288833@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 51bddd4501bc414b8b1e8f4d096b4a5304068169 upstream.

The purpose of commit 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
was to keep the pll clk enabled through the lifetime of the device.

In order to do that, some 'clk_prepare_enable()'/'clk_disable_unprepare()'
calls have been added in the error handling path of the probe function, in
the remove function and in the suspend and resume functions.

However, a 'clk_disable_unprepare()' call has been unfortunately left in
the probe function. So the commit seems to be more or less a no-op.

Axe it now, so that the pll clk is left enabled through the lifetime of
the device, as described in the commit.

Fixes: 0fd85869c2a9 ("spi/bcm63xx-hsspi: keep pll clk enabled")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://lore.kernel.org/r/20200228213838.7124-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-bcm63xx-hsspi.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -371,7 +371,6 @@ static int bcm63xx_hsspi_probe(struct pl
 			goto out_disable_clk;
 
 		rate = clk_get_rate(pll_clk);
-		clk_disable_unprepare(pll_clk);
 		if (!rate) {
 			ret = -EINVAL;
 			goto out_disable_pll_clk;


