Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804FC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BC3206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCoRjV6q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730448AbgELPAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELPAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:00:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA2BC061A0C;
        Tue, 12 May 2020 08:00:46 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x13so585815pfn.11;
        Tue, 12 May 2020 08:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RWw/VJbKfsjZ/TEKtk26zG3A3TuMtFTMM9QYTJqnz+k=;
        b=SCoRjV6qmuz2FaVHtl+OxeYQqfU+qmQp3OFbyc41SLT2Fwmm+A5xAtqiKdkj5rJvOY
         xlPbbGvuR2Ob40XQHTjjQ2rs7NlFGpuP843YhSmF0lNQvT2gAyfVbj6zlIx54zLCuWbO
         BE/Lgi9eEhgSNp+EjmwqBYs9ve9sHvynhbIEnJGSS4T8goNF0r+noHAESpDGqU84e0Ty
         4487r9Xk9U1siVJKV+hhgMFTzv+yh7yct2JtwX9JzW+K8K8j2pyhgMCo9eAiPz/89dy2
         OJDb++dSHB6wlmGwQYMNJ8Jg9+5tGbzGlUMwoJppjgFohwEmITrfoe67jQuVr12XOK3w
         yKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RWw/VJbKfsjZ/TEKtk26zG3A3TuMtFTMM9QYTJqnz+k=;
        b=IxXsXJhqY3VuSl0Yzvo1JDATgS/oAHJKRClAa2pIjAbn21otPPbaDr37YiQp9TRnag
         hS2hV/tkgXwh+WBcKbZabq99CdI+h0jqf2Ij+pPvuWNUwAaJ0h6gDyf5wgrpFByKwuRV
         1fOFVwLqFaKk9eokLOjn8bNxBcPa0eFZu+r12U0/GIcvD+f1dy5oGfC8rM6NJExBgNsd
         c05ExHeZFM9l8XHchc1CYyqAryu1LTpwljQ7qlQAMYp6OIS25PwPt3stP/ZsWJnpMnap
         o0kaQTK0AzxBsOd7LfGYymON8co/U4nDMZqY7BPtF62fzTVx+jIydZRoDX5CBJcp6owG
         dXjw==
X-Gm-Message-State: AGi0PuY8CK5WmppifJRohQWxDPGWByAzmPQ5g8vHyVyCjEPpESKlsHxI
        ytVHlER1to0XIWJc0Gk8m2935wnYawU=
X-Google-Smtp-Source: APiQypKdOtrcGII43XkbiQDl/vW3a/I5bgyCVE41j4ZQYMDcyDTupjfWmphArrfd7eVSwQc1GSIKHg==
X-Received: by 2002:a62:7e8e:: with SMTP id z136mr20535920pfc.151.1589295645671;
        Tue, 12 May 2020 08:00:45 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c2sm8359779pgj.93.2020.05.12.08.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 08:00:45 -0700 (PDT)
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
Subject: [PATCH v10 3/5] usb: xhci: xhci-plat: Add support for Broadcom STB SoC's
Date:   Tue, 12 May 2020 11:00:17 -0400
Message-Id: <20200512150019.25903-4-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512150019.25903-1-alcooperx@gmail.com>
References: <20200512150019.25903-1-alcooperx@gmail.com>
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

