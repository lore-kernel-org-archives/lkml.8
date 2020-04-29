Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB59C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8767F2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHrUk0Zl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2UIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgD2UIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:08:45 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05BCC03C1AE;
        Wed, 29 Apr 2020 13:08:44 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z6so1235504plk.10;
        Wed, 29 Apr 2020 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=WHrUk0ZlOGYuneAz73utDSCSrYStuw6Byqfn6leJ3x11uSJkVjWPN5951uS1bmwhW/
         SgcF6qRDoH1kf7F067nRa9TnjxNH806ns8D+Z3WVNO7H0wyN/B+043gWHzSfoyOZEVL5
         cj86N3itmLr6pO0ZzIvrjLRcnOln01DjHsS4MX208txg2hcpSAPGaA73pT/QfdSt1Iih
         GdGd6Bs7PWYQOCTJITIGK7nkoHIY47Wi9PKhPjCC6NoYlbDtJttPgDuaFI37slyK7HIa
         OqtWS/09aFDNi6t1J/KDcMdc2jdwHjAK/OhWSlaI043qscLhil1Vh11iaRuDNTFFojY5
         Wtqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=UxG7mvrLUw9/O5ttLB8QeN9o1xdzV2gBGiHciPMTdvjAPbDUcb2Ie37hptYxsKMt3i
         Rao89C1oLWDJ9fdhC/qjQCYl9y8Gz4I1hi0A75jfwOMtFOxpnqhbW3LwhkNDXJFPTDDO
         kHWEM8yX32Elu38rdhqCDCRNO0Bx0geHu2+AbV4Is1QjJsdQA1Cgb2HZFpOffQNxV10v
         mLRjLq0FNX3oR/8XKPfyjJf2oNMwFzE3q3m+h8KuUKCVQ84BWURaVf2ltO6QbUk+ex88
         1J7MbeUvmG5zcF3MlfxdvKSuA//id9MCNMxFkqe2xFQBLN7pjITinX9m/02dd7hMnNlR
         Mjtg==
X-Gm-Message-State: AGi0PuZcuKaOOiIS0+QLI/rSVl36RDIpwYjN3uF0XEof72nFnltxY6kj
        nGPrpe2dY4WJW3M7K4/l1/5YDASgN2M=
X-Google-Smtp-Source: APiQypI15zelGvx7x7Qb1y8Tk52JzvrsGiYoqtPG/TnEyrslxaApytF4oGqsp8ns5Ayiwfi2ZTXumg==
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11mr75469plo.208.1588190924269;
        Wed, 29 Apr 2020 13:08:44 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id z23sm1638957pfr.136.2020.04.29.13.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:08:43 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v5 2/4] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Wed, 29 Apr 2020 16:08:24 -0400
Message-Id: <20200429200826.20177-3-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200429200826.20177-1-alcooperx@gmail.com>
References: <20200429200826.20177-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
---
 drivers/usb/host/xhci-plat.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 1d4f6f85f0fe..44406d0eb317 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -112,6 +112,10 @@ static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
 	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
 };
 
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.quirks = XHCI_RESET_ON_RESUME,
+};
+
 static const struct of_device_id usb_xhci_of_match[] = {
 	{
 		.compatible = "generic-xhci",
@@ -147,6 +151,12 @@ static const struct of_device_id usb_xhci_of_match[] = {
 	}, {
 		.compatible = "renesas,rcar-gen3-xhci",
 		.data = &xhci_plat_renesas_rcar_gen3,
+	}, {
+		.compatible = "brcm,xhci-brcm-v2",
+		.data = &xhci_plat_brcm,
+	}, {
+		.compatible = "brcm,bcm7445-xhci",
+		.data = &xhci_plat_brcm,
 	},
 	{},
 };
-- 
2.17.1

