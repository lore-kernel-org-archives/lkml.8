Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A01C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3EC320731
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Cq0nErZd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgIJIOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIJIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:12:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71685C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bd2so540710plb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44trK1+mp6acGCAyJDXufHhioxG2IhBJmkTpcqeajCw=;
        b=Cq0nErZdYPGc+wAuLEcPow5AKaE4CEaydecrT+24rUO21TCx0VSHei2JJyanMsVxZG
         h8ArP6bjGCYAcMJc6fMfrBg72m9cUAZaUkT2P0uDAROB4I8FisHJKRWAhheAOrpJ3j03
         /OOZm3PWq5AozKLX4QGeytxLeK8GC3Pysy7L/whH0K5LXriRC+vdhVjG0GUIzmsSKhRk
         8FEBEdZ5mbaeABeE1oOeqXRxzyhLGOhYzGoUg7vLTnNoY13tnCg5NZK0MU1x4pQLS7qi
         cg3MJm4WYFmftj8N6J5mCIZs9dLDfOnKrPLMlUDtfnrSX+G5qoUUknZpmCrEsiYMj1/4
         U9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44trK1+mp6acGCAyJDXufHhioxG2IhBJmkTpcqeajCw=;
        b=mkaiVoAUssznd2ceGxAvqLfDlGdFzBemRri/2Uye3Scw7MUmEVJSCd7+jYllZlqsZy
         ZeIDhuHFH5OFmcMyi/CQQIlNcVPjHEg1NYQASzZTGpvKEXa9UAmVOLrKKf6lhuIH65/r
         03MfUc8EEibmuK4K5vlwXn/d53eQtGqhVKjU9RDvs6/OgNH/trI7EbuLnhKd3zWO4LpJ
         2B63V3WVrphkywc+Meq7+e+boeSzbXcBlhwo610uTp8VRKd2UmpxhmolZmvHBYSdDgNS
         OIURlIj6FOpksSFrKuo/Ezg5ypmnEUUd1VdaDtdoJrBbdIj8l87teh7nZxOhdFNcKxlC
         Xv6Q==
X-Gm-Message-State: AOAM533gO/CAlu0wKjtyED1T6drNH/KIxJclhGG436L8Jmqf5sbaltUI
        VhgI7ZWUI6qPnEMurJm/vq83JA==
X-Google-Smtp-Source: ABdhPJwRpiaO4sJw2ldjNOPiEaMaHc93aWXd+XlpwavaSzOpsugZWky+iNfgHgwVB4ZNZvlDGU6inw==
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr4210890pjx.90.1599725558979;
        Thu, 10 Sep 2020 01:12:38 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id e1sm2196056pfl.162.2020.09.10.01.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 01:12:38 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH v7 01/21] riscv: Separate patch for cflags and aflags
Date:   Thu, 10 Sep 2020 16:11:56 +0800
Message-Id: <2bd207c3d0da6a5d632ef0a931395d45f088ae7a.1599719352.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1599719352.git.greentime.hu@sifive.com>
References: <cover.1599719352.git.greentime.hu@sifive.com>
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
2.28.0

