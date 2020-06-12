Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B0FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 814BE207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 07:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vk8nXv4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFLHKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 03:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgFLHKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:10:16 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53134C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b5so2756285pgm.8
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 00:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TqEeZZCFAo9j2EFFuYpPOcmAMjD+t0h5vXYjlCC88NI=;
        b=Vk8nXv4lbi60VdlETy0d9EHMvCMv6fvKZN7WSJqO8Yazl8SmgsXXBVnpEdhhbfA6U6
         IsRjgiXT1RcyvifqbfANAKXfWf9zgSjGNNC8zwH2SOwquvk0yPTzl/bgCFuQvzFqJVyx
         T/QnIAE8JHW27tQv2laLYiXgPZnqbMeTEMiE2nvFH+fCSSAfZjuwOK4wkAmNt3J4egyL
         gktCEfFKGLc2yAws1DCe3q7msFiIg+t0pCeXmtIz1dc3lyIA1jA4hgQBOWSVnW1zVIaZ
         xRD8wy6R1sSLyOKQ3EMRr9OAKnrmjNq17Y7jyMTfEQM9LNMIv38SwTMU/MwVxNnmXpwG
         mlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TqEeZZCFAo9j2EFFuYpPOcmAMjD+t0h5vXYjlCC88NI=;
        b=hTX4FveDZVWNwMOJSdgfCYLvCa4R9bZanlpuiOsl3y25SQ+hzeyS8CmgcMGbRFhFra
         3c5NmJ8XfBuFIxipdhTgu8xzeiD2AqDrTh3u+dnQnoNBw/rY+jzjlhj570kRwX355Xf7
         f8BdBnH9xlvVDPB/I5HFbV+NGFPs8zSUAvdBK2IZwT4TgpM3xtlKLWbtAWsYCclbJ99Q
         pAsjzQISAU+6bpbDBzK2sKBbql52amvIw8OR+tNV525afQgV9X2yUNRDJY8YxKs1J35S
         WYOjHWNfOyMbZgs5WxOp7qHDTaqnKFtsDMol1JaEDMbiRLEhqB99A9wkOcvS9rJ9pKFh
         K1bQ==
X-Gm-Message-State: AOAM531ysL08DbuchHSPtPt6/f1YitAOlpKQ1O6h/tkE0k5kM4Kwk9GF
        /XhpchIj0NB8yuIzoBK8xdFOsw==
X-Google-Smtp-Source: ABdhPJyjEH+ADL2W4THCxsHXC9WxaaeveHWyMCLC47yacVreM5QB1kMYVKztlYuLn7XFuwTbzNN8eQ==
X-Received: by 2002:a62:7b41:: with SMTP id w62mr9986107pfc.142.1591945814828;
        Fri, 12 Jun 2020 00:10:14 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4336919pgp.56.2020.06.12.00.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 00:10:14 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, oleg@redhat.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] riscv: Separate patch for cflags and aflags
Date:   Fri, 12 Jun 2020 15:09:51 +0800
Message-Id: <fb337ff3ed0f6d04da25f45db3c5c7713824ab13.1591344965.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1591344965.git.greentime.hu@sifive.com>
References: <cover.1591344965.git.greentime.hu@sifive.com>
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
2.27.0

