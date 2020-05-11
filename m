Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D36FC54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3C720736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG4nyXSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgEKThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731555AbgEKThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:37:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA906C061A0C;
        Mon, 11 May 2020 12:37:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id v12so12435449wrp.12;
        Mon, 11 May 2020 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RWw/VJbKfsjZ/TEKtk26zG3A3TuMtFTMM9QYTJqnz+k=;
        b=kG4nyXSEINQB2z+ya3qzD/IS82IP+UUi8rVLRY1xZ3WKrOynhyWtp7600cLLDRdjf+
         QMwItMsoYvar1S2wdCpftaTfdCdpXXhl3NlwMzEwpOOh0xAfel/i3tfi4kl9YhhdlVix
         yfs2UzhIKhG3FYJFQbMJg7kZx1Ad0pS82MJs7k1sq+4esIrQ3sA1egR8bbHumhB6ai8s
         aJm7OWkD1mozcm6C2cW0EeaduxlRW1BKe8K8EMdrQO3H39plGIc4TgY6IgUiCaVsxfRV
         nm0wt9YxoXkLEnJxQ9NsrWXjTwze8ZLe5WMyv/WHh69r9Egh4plRSebqRPQcmxAufRul
         /8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RWw/VJbKfsjZ/TEKtk26zG3A3TuMtFTMM9QYTJqnz+k=;
        b=IRscPNLMp83vC3r107naA3pWsY1VBX7C/uZvfJVnWSakfXYyZo8frQAetTCf4aN9tL
         i/xRc1qRZWcn2Z+3GK0cEO8oj3UIpLhlM//OnzTp92SguAuqal3zRXn6OjWg3kKE2Q7L
         hRXkSRaUsVMp7ITgh+cbDxnLxTBATnN2NqJ34DLYuVaG931uGmM5o718qjYeEPd7g3JM
         5BRJ6ysC2IgGQw1KuhijveRCOTtPE9m7X/t53ehz2yd3T72ShbDt5GggG+cp2Q3J+V4/
         SXmUMLYPF/IC/Z3xHiqh2SeiF3gWuunNGJddcIbWzqIAB95vC4nmp1uoiM3/X/hYbeKC
         KnBg==
X-Gm-Message-State: AGi0PuYPpduOGb0e5uiHC82RkaSdvRkA/9Cyy+BXWUQH6aT6rA1obSyk
        vL5qXtBTo0mCRPE5utf+H2wr2ZSS2fs=
X-Google-Smtp-Source: APiQypL0JVe1cRxrz7F/2Ji874SBfM+Jnhb8Q9UozSkejJrq1aHpVYeFhrD/YBzm3ltQN7Dm+90neQ==
X-Received: by 2002:adf:f207:: with SMTP id p7mr20485064wro.20.1589225829364;
        Mon, 11 May 2020 12:37:09 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id o203sm11529030wme.12.2020.05.11.12.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:37:08 -0700 (PDT)
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
Subject: [PATCH v9 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Mon, 11 May 2020 15:36:41 -0400
Message-Id: <20200511193643.30926-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511193643.30926-1-alcooperx@gmail.com>
References: <20200511193643.30926-1-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Broadcom STB SoC's to the xhci platform driver

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
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

