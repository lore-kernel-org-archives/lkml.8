Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB1FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1085E207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="FaftoKe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731434AbgEZHC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgEZHCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:02:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8457DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u22so8263074plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=82NB9lCPMwXynDeXK6u4yXJsBZGIDVjhoL3cA6mdRsQ=;
        b=FaftoKe+0VZVQZfx6UqrMrjEGKXsDAMQES+qIZJ2/T5sVpacKZTqHEKzYwPkn8u3Yn
         JKthoGXIp3ZuFeRPBM6tCVTFE1pvm/klC/QDuGmact9URjVXCTDaRzHQzGbV3nBoqTD+
         3Afh4Z2yD7rE+JgNq6Gkeqa1IW5gxkucbB+RIhQihixaToLipBJVA/OeTmsRhrehKSRN
         dGkDv15x2U1w9i9skTs3zr0XY28wbuxQy7ttu0tHLi6Ltu0Hu6kPXzOYpNRi71p44whN
         03MbhRIsC1i9Ha6mwACeLPzjD2RXAAN2ZJUvJeIhRpsNjl85Pq4LwXZlGmEJkjOt5bn6
         mkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=82NB9lCPMwXynDeXK6u4yXJsBZGIDVjhoL3cA6mdRsQ=;
        b=Yi/6N8KpiYNNW9kSCjlfGzo/xVAqdZih07j169SxjwlGoJsNqNVkhKj7uFWX+wUcz1
         y4b/hug01/4Tl8WbHDIDce1cQCIFjl6NF9x+GKTqdA4xnhwEvdn6leNv3yUBkbwE12Mz
         u3zoGyiwMAAzjSngiHHB3FX1g3w1V57kzViQ0XybA1GZYjuipVThcXjuGiYh0BkbM0LA
         iBpWVa0FJ+ZTVkaPSDNoufJ7/sKSPXwxNdpRUA5GSNpjGR69VDJAK7UjyxL5hXx/el5x
         i6WtfirRfi7KIXyxNKBujySKTzKK9q5af3oSBkcArVzIUlGvnonN0ifknx2wiUVqhgQg
         5Y3w==
X-Gm-Message-State: AOAM531FYpLfCXCRi65nDw3dKSvsNc10qmrFIdpKBbOR05FNx+veqHfv
        y7CiJWrf4kS4+skbQF0dvChPASMw13v0Mg==
X-Google-Smtp-Source: ABdhPJyVEh5eCMuVwWRIqvOS5Rmwcsk10fGY/pssgC0u8rfLvDwccBtBh6NrYpEaRpu5pP8FSWPp2A==
X-Received: by 2002:a17:902:bb86:: with SMTP id m6mr31111794pls.341.1590476574044;
        Tue, 26 May 2020 00:02:54 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q34sm15167431pja.22.2020.05.26.00.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:02:53 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v4 02/13] riscv: Separate patch for cflags and aflags
Date:   Tue, 26 May 2020 15:02:31 +0800
Message-Id: <0c949212bff708dcbd530bfd7c13a04a2ca2bbd8.1590474856.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590474856.git.greentime.hu@sifive.com>
References: <cover.1590474856.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

From: Guo Ren <ren_guo@c-sky.com>

Use "subst fd" in Makefile is a hack way and it's not convenient
to add new ISA feature. Just separate them into riscv-march-cflags
and riscv-march-aflags.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Makefile | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index fb6e37db836d..957d064bead0 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -37,12 +37,18 @@ else
 endif
 
 # ISA string setting
-riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
-riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
-riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
-riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
-KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
-KBUILD_AFLAGS += -march=$(riscv-march-y)
+riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-$(CONFIG_FPU)			:= $(riscv-march-y)fd
+riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
+
+riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
+riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+
+KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
+KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
 
 KBUILD_CFLAGS += -mno-save-restore
 KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
-- 
2.26.2

