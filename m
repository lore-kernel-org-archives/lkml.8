Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D123C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE50C2081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxq/39J/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgFYXek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFYXeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB16AC08C5DB;
        Thu, 25 Jun 2020 16:34:30 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so7605767ejc.8;
        Thu, 25 Jun 2020 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lJKpt55I3R2NHkjVsgV/EWx4EQxkw9Y42GuSmQWOQXU=;
        b=pxq/39J/HzF5FnfLG8tYvq1/+c390Jd0rqKCrUnunytlGr9uZw/Mgq2w578+pjIWJf
         WZqUJGbCO61ur2vd7QCevQsZcj+NIi9UjSGnS3YyHmKw3FxkkoZcCt3LlfEV4338ev1w
         9Bczs27fTbJNr8bndTTisKK/ZsdojA4a99pK/7aW0oWgwjmceybFrFrI7r4lYOmlbeS8
         qgDV+Lsej+AEfSyfqXggpmO2mPO3Sx20Pbqvh6Yxbgvw/OU42MCAioMYHpqXMqC7j46Y
         yKWxn5Up4XKx3McGfhMd+7m4gW+AjX6tBco9M+0xkU4e4ZE7/fdCYihoFTr9b7EKJSgC
         LCZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lJKpt55I3R2NHkjVsgV/EWx4EQxkw9Y42GuSmQWOQXU=;
        b=m9IcWq6ly229FnK9XDdCYnxk47MNwtmqWlerasZLU4HmOwNlvucnH1vIFlzu1A/i28
         4W0G3dX9UqCz1PyC8rAeXBU0p06+adEJABJiA+O+nG/KDZpPcGKwTm423eEdWGeSOwfF
         LgPszkDWC4xN9sKRoxTOwxVyNvWgUZcL323T46A1ZThfaaZI4a5oFujgPCyqcZjJfyl7
         BpEiHespqBPDZVOeI3FAKen3bxfr1X59RHTQlTFx2edaDl2rSmpp47izEOiZHdEQfNJV
         wZwnSrK1iCQlTFsXRkTEq7sDyWMPn+Xtr3tCze5RkeJqae8vPYAF9l6tjp9amPHiQbkp
         SJVg==
X-Gm-Message-State: AOAM5327xqRnYIq6AO4ZlAqjFvMTQZc85XEO1Lg8Z7Z/ONKcvAD92V0X
        0k4T1OTR4930I810l25jYcI=
X-Google-Smtp-Source: ABdhPJxXoJeAuTaXqzLAHRPDqgOakuV+GrqFOKerXoME00ak1nOrv3A8bPEJDYhUJURBLd67gnE0aA==
X-Received: by 2002:a17:906:1c4b:: with SMTP id l11mr160095ejg.307.1593128069669;
        Thu, 25 Jun 2020 16:34:29 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:29 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 04/10] arm: dts: owl-s500: Add Reset Controller support
Date:   Fri, 26 Jun 2020 02:34:16 +0300
Message-Id: <9fac12b305c4b4b79cbc9ffa874b1614ffc10dae.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
References: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset controller property and bindings header for the
Actions Semi S500 SoC DTS.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
index 0f4fc5487dad..0b7ba2926f0e 100644
--- a/arch/arm/boot/dts/owl-s500.dtsi
+++ b/arch/arm/boot/dts/owl-s500.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/actions,s500-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
+#include <dt-bindings/reset/actions,s500-reset.h>
 
 / {
 	compatible = "actions,s500";
@@ -188,6 +189,7 @@ cmu: clock-controller@b0160000 {
 			reg = <0xb0160000 0x8000>;
 			clocks = <&hosc>, <&losc>;
 			#clock-cells = <1>;
+			#reset-cells = <1>;
 		};
 
 		timer: timer@b0168000 {
-- 
2.27.0

