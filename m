Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB483C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C927B21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TnDBo78s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgEGRei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgEGReg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:34:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69469C05BD43;
        Thu,  7 May 2020 10:34:36 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x15so3340641pfa.1;
        Thu, 07 May 2020 10:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=TnDBo78s7cBpRgn0S6WIDv0o3/4IfEK/atnJ7lhpFO6YqwQX3Qj3ycYemb1ffpB+1M
         1oewE6tp6k05WyVPVYLwIe+CcujRDixIiOBIEvgb/rwqkWdqrianZNnZaaAa0Fpoxjii
         PoQskKsTaaa+b1ylwhZM2axEcSW2RE8MUDLLxS6ROJ0lwGzBym1zqdboxzoTxjz+IoG3
         1mL/l0aQxEmLaBZNXHm+YugZUhpwLaAbi4qZNVu6WHy1io/HIW3gbbi4/2/CRlMVsqqH
         WMVzSGaNhq2HhjuqI2f0wpqPxwerR2Pk5mvOF1b6CHG+zML3+Yl88VdSqv+RKZymxqzt
         OMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vkQbZ0OEnEU7UUbpzBp0+WjmUbWo04Z45g1QFzRKmTk=;
        b=tut0o/YBUp/3WPr2QSNKUTA/0L8/eSRGwAvV659y7SInnDp7A2/fLEK5MEJV80TKx8
         7bSt5A5GX7SJnfT5sedjzs1OC2hBobsotNDtlAihggtUYjLFd/yG20EhxxtBJ5q0XKOM
         G/sdy+0I4x+7UzUM+Mxg3djNlOrRcQm5OMEApueQIAZUBblphvvfky6wVSJPBuc/5S2u
         GDJp4S8YG3QDIYQETWxKBGU3M+4YS+YxzwAe+5LRTjnv1RdqWu0JEhdi9IUtaogdW3v5
         Z3QNni5y2PfEYYwcijR363ukWCXiaxEu+8cnqn9b/UuExh3fj6eVJgBMYBgZywlwwPrY
         01lA==
X-Gm-Message-State: AGi0Pubqk6cqCbMj8Be0YM85CCYGFnujIwAzJlCuJMUQKKd44bsCbtR+
        A6IcMnOr7MkOEYvddXT/otRAR+JpuBw=
X-Google-Smtp-Source: APiQypK5gB+eyAQJWa7xfW3qOGMW4iu2Omc7fvzx//c3l34FZVfPMzDpiEiJAAq4seYbq9CJTwhTKA==
X-Received: by 2002:a63:5b41:: with SMTP id l1mr12523262pgm.88.1588872875636;
        Thu, 07 May 2020 10:34:35 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id y14sm5368802pff.205.2020.05.07.10.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 10:34:35 -0700 (PDT)
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
Subject: [PATCH v7 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Thu,  7 May 2020 13:34:06 -0400
Message-Id: <20200507173408.20754-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507173408.20754-1-alcooperx@gmail.com>
References: <20200507173408.20754-1-alcooperx@gmail.com>
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

