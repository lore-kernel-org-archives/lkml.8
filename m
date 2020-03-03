Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B65C3F2DA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D0A214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GhpdZ4Ch"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgCCRMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:12:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50613 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730647AbgCCRMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:12:03 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so4173531wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oTtnFV6YHXHl0gESv53msmY1Agb4GevPkfe3E3DRMq8=;
        b=GhpdZ4ChmbGciaXDNIOlKv03kA2DO+0TgAr5iEkB/E1LhpdSpeqBBTZHP2Tr56KZKe
         It/ohTRS5OHcQ0f2KPVtzeuG8we4NKvJ9/ec/FQ6fEqymGBWHuWE37TECa93QHhhXwvu
         nGV4pk23dMtS8IRtK25SXJki4Pw3TANHTykzYBgcL0KYimeY1+42pfCl9M+E6zI7ogWI
         uh7Owa/EA3S164JmDu1zf02B4wjXhLlcQyOzTWiGcK6WNVLGTjuxOh59MQdnXm7LXjV3
         fhw2UWp9mvAa1TPZY39ywhZasJ8RnP4TelDj0KLS0kmsGCDln98uURdi0E09z0ynz34s
         W29g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oTtnFV6YHXHl0gESv53msmY1Agb4GevPkfe3E3DRMq8=;
        b=VgRV6wh8KE+5aW4QPgrRvHw6nJZYwPF8s+HEeA94R2Qm4wL+9oIOHU84IF6bCQtr8B
         KRm9K3kX6nsZDmjqCXnIvy7kj2Ef2sR9pMquBImmZZmcShd2TrBbXZkIgj0FqLpX2VEu
         OixSzmud7xTLiWVGvoT6jKIZ/BKoXkaiUd8oi9a6obISTvUB2oni9DE/MDwjkeZTkLLV
         /vEWwARCeI2dfMSxZ/bn0mtq11aWP6tyILnDMeb8e+fMnFXhkhBVHvmFtVDGuiF9ladU
         2yNBvQpGmS4Vi+wy+VWEUO9V8EoIXDDE0UBsdkBD8cqRsU0azaLxrxYfljYSeZ231n1L
         69jw==
X-Gm-Message-State: ANhLgQ19ZFeX1VV549DXJ/TsE6Wg2LDqUMp7JNbvonmoqXz1ZEfaPSKy
        Rkj0GPv7tOE+FCXcgVtDK0Y1Jg==
X-Google-Smtp-Source: ADFU+vudG2UE5W+dBkeI9eeXdE2Mjhx4lCDZ7NWmQzFs7VGf+ZNZu57PTNYFViIgDQ4n4SJmv7CQaA==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr5351449wmd.91.1583255522016;
        Tue, 03 Mar 2020 09:12:02 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z13sm5425319wrw.88.2020.03.03.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:12:01 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v7 08/18] dt-bindings: usb: dwc3: Add a usb-role-switch to the example
Date:   Tue,  3 Mar 2020 17:11:49 +0000
Message-Id: <20200303171159.246992-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
References: <20200303171159.246992-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds usb-role-switch to the example dwc3 given in the file.

Documentation/devicetree/bindings/usb/generic.txt makes this a valid
declaration for dwc3 this patch gives an example of how to use it.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 4e1e4afccee6..8c6c7b355356 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -121,6 +121,7 @@ dwc3@4a030000 {
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
 	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+	usb-role-switch;
 
 	usb_con: connector {
 		compatible = "gpio-usb-b-connector";
-- 
2.25.1

