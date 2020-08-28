Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC6DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1F3C208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 06:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RduLXisF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgH1Gii (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 02:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1Gif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 02:38:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F296C061264;
        Thu, 27 Aug 2020 23:38:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so79997pjb.3;
        Thu, 27 Aug 2020 23:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9NrqtGA0lEAyvaWExHEOIkVPg1Ur6ql2DVuQwYEcRI=;
        b=RduLXisFsEQzUmokLu8gVohrbfs3Yi3mSW+4TbL7YZgQQ3/aZcpnYnHLScI4+UuzBU
         N2IUrrW6FAZXVM/n+n+7rPCfBl85j+538sRO8uiGBbNnwDtNuWUypt09X9zeiHgMii0v
         8pkPrCvPARwQA1bHqL4fiT+aNdkPy4tEEwKe0myb2VUYdnCT+aUepjGePG8GY87HdJ+O
         oW60geGXTK0i0hd8sLTzK/T1cnlrxbliSLulJHmsQtZTcDmQUSaUQkoEin2fPPsIpVNg
         s5594T/jV37+xUcucPEl3rZHbc7KAU7iIucna9FHVQplpemsHea4Sah4OvIXGlnRgnac
         byGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p9NrqtGA0lEAyvaWExHEOIkVPg1Ur6ql2DVuQwYEcRI=;
        b=alcupNMIAoqe+FuP1fwRJxTglZ24/4gLfrRQJAF0oFO5V2jKu1v24qPfR2IGZG9MWs
         masM1HDRenLa/7GwmNYQe1kDKyd2WqTOmS0MUeK/lSGfUmsJeRjhdWvt275O6JZDhvKm
         bSUIYVuJsd5M+e6MVTLSbxEsna0VGICyyX2h62E8I0V+iolT76UcDJf/1Ecq24Es7Csp
         LtvlzvEJ8SaSjwOWHGgEczcujexn+e46JCMF9tTImT2zveXc+vGn8BJpI8Aa5M95WqYq
         YC8BUuql7CFkkW2fymwT+tNYjCByGHpDsDsPuzdY9JLA4NDf0ZnbQJhO9IeTSvr0w2zf
         +yaA==
X-Gm-Message-State: AOAM530qJDSBs3+Dg4VyDgLkufyKw9tlW0hhelIFdqVAHQw6SfG30NVx
        qY6xm17B+LriAguv9xwM6f4=
X-Google-Smtp-Source: ABdhPJxJugxcrisQy51S+DhhH5XVTik2EScUjH+nlVz9HSkLZd+WEAfljrs/0p3kTdhlACFzl0pafg==
X-Received: by 2002:a17:902:b40b:: with SMTP id x11mr187530plr.196.1598596714863;
        Thu, 27 Aug 2020 23:38:34 -0700 (PDT)
Received: from kun-vb-ubnt64.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id b8sm304757pfp.48.2020.08.27.23.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 23:38:33 -0700 (PDT)
From:   Kun Zhao <zk.zkxz@gmail.com>
Cc:     zkxz@hotmail.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] In the device tree file openbmc-flash-layout.dtsi, rofs partition offset is defined as 0x4c0000, while its node name is "rofs@c0000" which is a typo. It should be "rofs@4c0000".
Date:   Thu, 27 Aug 2020 23:38:31 -0700
Message-Id: <20200828063831.12578-1-zk.zkxz@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM: dts: openbmc-flash-layout: Fix a typo of rofs offset

Signed-off-by: Kun Zhao <zk.zkxz@gmail.com>
---
 arch/arm/boot/dts/openbmc-flash-layout.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/openbmc-flash-layout.dtsi b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
index 6c26524e93e1..b47e14063c38 100644
--- a/arch/arm/boot/dts/openbmc-flash-layout.dtsi
+++ b/arch/arm/boot/dts/openbmc-flash-layout.dtsi
@@ -20,7 +20,7 @@ kernel@80000 {
 		label = "kernel";
 	};
 
-	rofs@c0000 {
+	rofs@4c0000 {
 		reg = <0x4c0000 0x1740000>;
 		label = "rofs";
 	};
-- 
2.28.0

