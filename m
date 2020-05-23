Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7BBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A3B20738
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="1w5qJPmr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgEWRwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 13:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387507AbgEWRwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 13:52:34 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AB6C05BD43
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:52:32 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ee19so6246820qvb.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 10:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbNXqEdiNXrvhkFc9AbifeBSEF3iF1+uuqL2sVkcP4U=;
        b=1w5qJPmr6SeJcD+EI09b+e0KZxTY6kXeh0o6ir7Ezxu89PCZzfjKtL14HoktpHAFCo
         UhtBSzENcfXb1t0Sreg6T2isFy2hXsjHS5R0/qtyqB8N/VbsYrnBf7Cqv8P90vLBqI7R
         EcXjOICNe631HRNct5wKlocR0GM507aB5pFr6o8hxHDQx0LqPof0JAGa0GsIQBwRw0af
         xdmK4Vvxq3zB+8HQQ2RjDy8YCFRlJpVOW+BvUXnnV2bFHxaoHQ0ogIVu/w2I3aDrXU4d
         aIsCVlTtZx5F5azA7igNSp7ZThBcdtbPdZJjHhyX8CYsiUBg2oZQDyMEsToeQyXHME/t
         ntLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbNXqEdiNXrvhkFc9AbifeBSEF3iF1+uuqL2sVkcP4U=;
        b=ky4VJ9Xx2GjknQqVq8Dyc1RvEqghIeSPQFsoc9f+i6Zmn2ML6XMXeSi6eTExIf2rSe
         QJ9R3/kSsFh7YOTPmKUwp0qmB9OKpW+CQYMTAIWjIHtk9KjvTNxX6G5ua/QBvxzXGcTi
         tEFT0c1EGfD3pL2Nednz0haR3bbJ/bbIZUtIYDphIr7Qap2vBGr2ps4SSt29N37p6DLf
         oypdGCPhkxLUmaqdcoVIUten5SS75HW0oqSNqPXGlELSEqxE/yC3GjtHLLxzzvGjtpA3
         XpK6wEuo+aeUDZA8gLlA3nXPfE1GgGa7b8yUOMiRLMYzZCIYt+gAsZrVBvlhNEnA8kKw
         CbOw==
X-Gm-Message-State: AOAM532xKqoUwf4806JxeYUMDjrkA1WRlu04xrVdWxSe4zn8ep+zJk4c
        34p9TCggB21tM3heAiOCYUP22g==
X-Google-Smtp-Source: ABdhPJxJqNc3s0k1S710OBgGWFWnNh/JFkMpuvIAPC7eSNS1lKSR6qsxIP7BSRmmL3JZAD5Irz+gIw==
X-Received: by 2002:ad4:5282:: with SMTP id v2mr8777819qvr.167.1590256351873;
        Sat, 23 May 2020 10:52:31 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id 80sm5147784qkl.116.2020.05.23.10.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 10:52:31 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: dts: qcom: sm8250: change ufs node name to ufshc
Date:   Sat, 23 May 2020 13:52:32 -0400
Message-Id: <20200523175232.13721-1-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ufs-qcom driver checks that the name matches the androidboot.bootdevice
parameter provided by the bootloader, which uses the name ufshc. Without
this change UFS fails to probe.

I think this is broken behavior from the ufs-qcom driver, but using the
name ufshc is consistent with dts for sdm845/sm8150/etc.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index e0344d3ba159..3bdce658c08a 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -309,7 +309,7 @@ uart2: serial@a90000 {
 			};
 		};
 
-		ufs_mem_hc: ufs@1d84000 {
+		ufs_mem_hc: ufshc@1d84000 {
 			compatible = "qcom,sm8250-ufshc", "qcom,ufshc",
 				     "jedec,ufs-2.0";
 			reg = <0 0x01d84000 0 0x3000>;
-- 
2.26.1

