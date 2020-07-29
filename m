Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2099C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A752083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 15:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="iDXM1/8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG2PIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgG2PIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 11:08:07 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E470C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:08:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l2so6746383pff.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4vnIQdazwv0RnAO3xap/+yfl/5PtuE2gJfge3l6agU=;
        b=iDXM1/8SawXZ5E83U80On87e5K4aZufAnhJ2GwdylXS1tgKwkzY2zqreO4WDQE5w7J
         eXRSbMf8FgJNXTH0aB7mwA2cVJMbWJjE16zDLhhwz5Q4/Ofed/JiHF6OD7M/Uv0Yg3pP
         iBQlFniCRithPNU26p9ZA5Mdd/qRwvkOnNm5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4vnIQdazwv0RnAO3xap/+yfl/5PtuE2gJfge3l6agU=;
        b=BZmKgJM3hh5qVmSKUlRSB+ENYA2J2Y60oDzvb8HeXpfS6KC2EqGfxIwXmUiQAjH42Y
         WmFNBPWNOan9yLz20Q93qjKTfkHgrCEHAXj8CzMIlgiXT/uC8foJQqXE04+aWDPqaJm9
         RmCRkZNqs+EZQOnawnuxE+VY0aMX6ZW7GtfrVduPankhbcozTyapSNNhHJyKQv3ZtUYA
         6K25ZbLdVyL+KxwQcX4L7eXpzyXmKFnn3kfeEaqCDVzCexoewiwHvlKvH3lUYUgJdcZk
         sVzVclyOmFFLYXZDslc9ZPtJors8fqydeIFWsmsH6ziNpZq53yU7w+xUHX2HO1vr+agM
         s1rg==
X-Gm-Message-State: AOAM531qjVtZB/3POyARfPcjPBsCZzttXfz9AgBVb9acxcKxmlS050MD
        K6kb6F8eEVrjN5g/OvsQPg/oNw==
X-Google-Smtp-Source: ABdhPJzqnctBQjLflJW7XAfkHJZ7HeS4kd6WtFxf8/eUYhk1P3OYbgfPq6TBFkRp/sbmurW6dnlnnA==
X-Received: by 2002:a63:5a60:: with SMTP id k32mr29215121pgm.73.1596035286619;
        Wed, 29 Jul 2020 08:08:06 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id q11sm2688058pgr.69.2020.07.29.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 08:08:05 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] ARM: mstar: Correct the compatible string for pmsleep
Date:   Thu, 30 Jul 2020 00:07:48 +0900
Message-Id: <20200729150748.1945589-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200729150748.1945589-1-daniel@0x0f.com>
References: <20200729150748.1945589-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible string for the pmsleep region has changed.
Update the MStar/Sigmastar v7 base dtsi with the new string.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index c7458c67c4df..3b7b9b793736 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -74,7 +74,7 @@ riu: bus@1f000000 {
 			ranges = <0x0 0x1f000000 0x00400000>;
 
 			pmsleep: syscon@1c00 {
-				compatible = "mstar,pmsleep", "syscon";
+				compatible = "mstar,msc313-pmsleep", "syscon";
 				reg = <0x1c00 0x100>;
 			};
 
-- 
2.27.0

