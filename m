Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD31C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0B9207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="n+zgnpl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgG1KDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgG1KDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:47 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3829CC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b9so9623824plx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXJ1NcT71dEwTgLwEHbAIexF2sZraNkG0dfcffq3WTc=;
        b=n+zgnpl6izxCdwPColEiF7BthmQSJu0W9qVcaU8w2jpHl4AlhvKMhWHYNQ2KGBDP1f
         ht0rOB6qFSPnc51Kw+CVijEUlnreN0DWFdA3IBdNYstF1vrupxKFKhxC+jEEhjcIikPx
         FBhge84POcFmeA3T3N6Cbh6Dg95yj9i/mVmIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXJ1NcT71dEwTgLwEHbAIexF2sZraNkG0dfcffq3WTc=;
        b=M1DcflnYrRhiKC1q2H09O3QQCHo68AeILSBmLUuXtTsXRGAVw9vuFT2Ixcj47hrUjK
         rygMGTbD+9//q+j9jO1PD5Q2dRO7447PY0CQ/ZRylaMuABvBCXSjglNmpQnfzB5M8Z9F
         A/XgGMtxvj5AkzZ/CFKf8V3Q8OfBJ/JIDItxZp6bF8CseDQWxSAfpLOFTU0f+EpZvlQc
         z/cOKLEJqIl5SFl/BSdQQWPOAsHcEJrs0bZ0DfA8mHv43gzw/AiuoNqTcEavb6FE7GF+
         bxThKcB79rMMrWMPOpTjI1i7N5xUOB70B/vZHFnnukvmv3L3bxI8V9qyazbtpeH7mUuq
         kX1g==
X-Gm-Message-State: AOAM531fFr4GKoCoXe5YJ2F8rij20q8ET6sNVfu1tacH+8OSil8plGAQ
        khAfLrmV2gR9FNbtyfgiDGOtFg==
X-Google-Smtp-Source: ABdhPJymtzzdhRqF/IbX/Qzvm3iVr+Td5JceDYBkjyIaF9cNweNSdmOTtlzXUjz+bkjmqWFrxpjE3A==
X-Received: by 2002:a17:90a:a68:: with SMTP id o95mr4007863pjo.64.1595930625746;
        Tue, 28 Jul 2020 03:03:45 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:44 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 5/9] ARM: mstar: Adjust IMI size for mercury5
Date:   Tue, 28 Jul 2020 19:03:17 +0900
Message-Id: <20200728100321.1691745-6-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mercury5 family chips have 128KB of SRAM in the IMI region.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mercury5.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/mercury5.dtsi b/arch/arm/boot/dts/mercury5.dtsi
index f68e6d59c328..a7d0dd9d6132 100644
--- a/arch/arm/boot/dts/mercury5.dtsi
+++ b/arch/arm/boot/dts/mercury5.dtsi
@@ -5,3 +5,7 @@
  */
 
 #include "mstar-v7.dtsi"
+
+&imi {
+	reg = <0xa0000000 0x20000>;
+};
-- 
2.27.0

