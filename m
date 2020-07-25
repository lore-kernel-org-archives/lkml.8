Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD9BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC192070E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 06:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="IgnsOHg3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGYGgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 02:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgGYGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 02:36:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0EBC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 23:36:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so6515898pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 23:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJfY4PeeJTWf527Xi9GgiWqsJP2qU7GsskPOgNHSUZs=;
        b=IgnsOHg36E9hTj2PW8WHAsP6kHf32cwxFBALLkhAnBVq76fE4UErmYJ1SryvF93TzG
         m1oKOCOzIK5h/PbfooTkJc4cN5CNrEZuDRryNtQXDVLqGJvOq3EPYjGU64tYqDKoAaD8
         2QFD2qC3AKkC94c2jbFShCLGPCUkOcGTiPVWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DJfY4PeeJTWf527Xi9GgiWqsJP2qU7GsskPOgNHSUZs=;
        b=iXQDcKeI0LOS5LFl5V5oL7WvApJt31l3T33YvNnFY3TgU/0Buti/+bK4XiJoOEVIbV
         opixYh3bfzv4u56rUzev1oA+hAeuZkSxysdb700uUzrodYAkKCeoiQOya+xOUsD1FfXm
         zq50H/ZAGG6Tii8UeCLEBHLfkVhx8RPjxBenEHiYQJyEp/0qMhq8qDzyKD8lZMmKnym8
         4SaoSrRR6dNm/m79bPMOss6kW2J1oHWlykmZKdb4CZtlWFHYU5IR/NkOp6rQ8rgRa1JT
         VArXNp7UumpTD9wDy1jxOe3RNBvpwvv6y4UZ4KaLBk8M3d8By8RFsjIewhVJBdNarQN8
         G1ng==
X-Gm-Message-State: AOAM532cdWOLtiA0W/yuYazUY7WlZNyg0hgmpC9cPpdQBTyghWE+tw9g
        u2+UFwqmVBSyPurl3ChsgoRUDw==
X-Google-Smtp-Source: ABdhPJwihGRdOrju/8XlJY5pgpptmD2iz1G4ovMJEfoCAxb4gT4c9npo9FjVkgWJqeKjAWrC+AAO2A==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr8922875pjb.194.1595659012579;
        Fri, 24 Jul 2020 23:36:52 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id v28sm8036819pgc.44.2020.07.24.23.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 23:36:51 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] ARM: mstar: Fix dts filename for 70mai midrive d08
Date:   Sat, 25 Jul 2020 15:36:39 +0900
Message-Id: <20200725063639.1221075-1-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the filename for the 70mai midrive d08 dts.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35c7ecc52c60..caf4a47ba799 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1345,7 +1345,7 @@ dtb-$(CONFIG_ARCH_MILBEAUT) += milbeaut-m10v-evb.dtb
 dtb-$(CONFIG_ARCH_MSTARV7) += \
 	infinity-msc313-breadbee_crust.dtb \
 	infinity3-msc313e-breadbee.dtb \
-	mercury5-ssc8336n-midrive08.dtb
+	mercury5-ssc8336n-midrived08.dtb
 dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
 dtb-$(CONFIG_ARCH_ASPEED) += \
 	aspeed-ast2500-evb.dtb \
-- 
2.27.0

