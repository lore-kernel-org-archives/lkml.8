Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69110C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A737207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948323;
	bh=o8nUac153Zhp9kKJXh7VSgyrThceuzDG1+BM86N1P/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wo9Y4oB2d91+rOj28rz5jMvwEIjvL0zaL8ui8XUL0oCeeKBTylDxDSM0Npju8BxPq
	 0AgPBZPBW5GzyhXGZjgyohtRVh6hJBSflbd4qtkyUJASesG3me+8D0NPfl4HXFSoRz
	 f8QCuWHz+4Y8y9ZGe06RW2eDhzQrpBmchkytw/pA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388672AbgFWUHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388659AbgFWUHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:07:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDD62206C3;
        Tue, 23 Jun 2020 20:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942867;
        bh=o8nUac153Zhp9kKJXh7VSgyrThceuzDG1+BM86N1P/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIxMh1kjyjT7O2ttR5dEyiPHJfBJ0Z2qYueEsjD6G9GyLv98PfbX9FV6Rqlhal1cI
         CjqHgCUgBa3o0+FF2skYcSJaIZUosmz/eIJPR7G6kYYSKiO1284dC9O2MlpTggmkOF
         c2DnGm9LYNGt1OHTGgjYVfshF7kc/OV0OqwtbAvI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Felipe Balbi <balbi@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 165/477] usb: dwc3: meson-g12a: check return of dwc3_meson_g12a_usb_init
Date:   Tue, 23 Jun 2020 21:52:42 +0200
Message-Id: <20200623195415.386274170@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neil Armstrong <narmstrong@baylibre.com>

[ Upstream commit 8f5bc1ec770c2bdc8c604ba4119a77d81d8f3529 ]

The dwc3_meson_g12a_usb_init function can return an error, check it.

Fixes: c99993376f72ca ("usb: dwc3: Add Amlogic G12A DWC3 glue")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index b81d085bc534c..2d257bdfe8485 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -525,7 +525,9 @@ static int dwc3_meson_g12a_probe(struct platform_device *pdev)
 	/* Get dr_mode */
 	priv->otg_mode = usb_get_dr_mode(dev);
 
-	dwc3_meson_g12a_usb_init(priv);
+	ret = dwc3_meson_g12a_usb_init(priv);
+	if (ret)
+		goto err_disable_clks;
 
 	/* Init PHYs */
 	for (i = 0 ; i < PHY_COUNT ; ++i) {
-- 
2.25.1



