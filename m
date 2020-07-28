Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C13CC433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9F320786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="kRi5SkZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgG1KDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728624AbgG1KDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED45C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id z188so2804836pfc.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxwX2AIPHGdhCk9KqDzZeCU4mfFsakd7X68zNyxQ72o=;
        b=kRi5SkZv8IHg4TsHBmPxoAIQrMfk/7RqlXrlV2KdfiwYpu8Aof+prql+jql0KvKP5B
         0cx1fjZhvSyJFQ0J41PzkXy8qL6ibrANmpURngEckm3m+/klq8t3N8z5ovqt3MuVeeuM
         5SjHQpx8ERBxOiTYxTMt3l3AfNdJjiAvOPkoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxwX2AIPHGdhCk9KqDzZeCU4mfFsakd7X68zNyxQ72o=;
        b=G3GLbJeHkGbf5ePj+2qHxxJTFPdYBkd/zDz9DHvOhixXg50llp0rKEncU6LHy88PoD
         sPCkLle1Kf0/fvp2djWI8VSdl6JzAd6r+nM9FqJwRIvpi7o7n1qHf8Yg0usr43mFmb9n
         Wyipnk76KVgzUAzQxI+8bZRP+p3N6fNqMl5T3MxiizODN14xEtCssi7HL1zI+L4j6JoU
         BS0kSnWlCrpON0fJQ2DCRzgr+JOWx6+JJSprpCMKpJjO3dY9TD2TFoklL3RkhE1z89fQ
         um0teGsjyCp9qzeIhn8bxPc4RlugcgSLWMeZ7u47tLVUtoLBNfhwe8q5cOeW6eNADELk
         0cxg==
X-Gm-Message-State: AOAM532HNxplA05NaEypcHPFUPFHentpF7tHpJTJmLIlitXKlQ2tgPpk
        IaH8M8vybG2V/82yo0bSSSh1yQ==
X-Google-Smtp-Source: ABdhPJykO4NL4VrLIapmtE6Vs+7sXczgf5nsq2JGZVl2s6Vb/zlG7D8OcRP/RsaZu40a58FNtP9a3g==
X-Received: by 2002:a63:e008:: with SMTP id e8mr17790326pgh.50.1595930628503;
        Tue, 28 Jul 2020 03:03:48 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:47 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 6/9] ARM: mstar: Adjust IMI size for infinity3
Date:   Tue, 28 Jul 2020 19:03:18 +0900
Message-Id: <20200728100321.1691745-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

infinity3 has 128KB of SRAM at the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/infinity3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/infinity3.dtsi b/arch/arm/boot/dts/infinity3.dtsi
index 2830d064c07d..9b918c802654 100644
--- a/arch/arm/boot/dts/infinity3.dtsi
+++ b/arch/arm/boot/dts/infinity3.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "infinity.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x20000>;
+};
-- 
2.27.0

