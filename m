Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DB2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64ED6207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="eHAGvzKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE1Glp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgE1GlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:20 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF38FC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y11so2829310plt.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6Km2JD+kQ/unmKeqzGOP9FqhZeNEC29tSKtvmTopBc0=;
        b=eHAGvzKEfkhBWYR7ZCsH8Tv2QIgWzmVUGdrmWiJGdNpf9o2/WcSHdzFRXrXwoNLdjB
         GI7opFoA/tEJH+TAJ7y303pW57PSQIbj3FEDI/+KBiUKpHmFQRA5Q/94pvgoQ+zIxZOc
         Pz6fXgOtXpYdFmyVUxaI8oItfYVs0cigXLcYgBOpjLE2+fWxIvXN0dBZOESFFu4qoqOj
         pM9vXWSQGHRJEtdnxL40g4GstJOnv+/CJQ1iA4D1eSHxtgB8fGvs2UHZbQf3AXsDcYQ0
         aehZ1BIjbNF/cHFajFDl93sleF9YcpXZqD3Z+W1CCMv+D8qMp0M52rBwcYQ1pNF5qOBh
         MqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Km2JD+kQ/unmKeqzGOP9FqhZeNEC29tSKtvmTopBc0=;
        b=a5kAzBMJlQVsyisDa5qImvKhBVdy9K1xPKH//kCJPThGO6CEtANsmWA5xjzY1zit/I
         txACWWPnUvg8HqhlxlwrS2ghLTpSH56RYJ+jIsg0K/R+x29WeSJFCkz2gDhwewpyOp5I
         13s8ZONX2HRDHt3c5t9QYWs9/XH49Ca5H1Ud29cCkEmZdCxS+3VNSNeomHzkZe13dctN
         2DnpptLZSI7exSj3StV3ynYKqBblThldQ50c1WHc9nP0Hwe0ia1edXz7pKcqisBBsr2P
         fLuJQmPqHYl60S1oKb4rhLYOYv0+dOel5VND1usrB34mLzrcpDc+ORnraSDUYdrIB7hw
         Odvw==
X-Gm-Message-State: AOAM53345cSkbMN5RcrrWDUfHsxQXz/AtQpMVOLQm/rwRbYGf4E4J8GQ
        Z/pydwYGuTp9ze6FiCWG327dhQ==
X-Google-Smtp-Source: ABdhPJwTx3wBz8DBpNQDdEJvvEatFh22MfXQ3sZ4OnC9GJJZPTzdlaBNmmev3s8MVSRcJK7mqNg5Jw==
X-Received: by 2002:a17:90a:20ae:: with SMTP id f43mr2292203pjg.29.1590648080155;
        Wed, 27 May 2020 23:41:20 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:19 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 06/13] riscv: Add vector feature to compile
Date:   Thu, 28 May 2020 14:40:54 +0800
Message-Id: <ff4f02ebc92bef0b85769cea014e3bee42e7cd04.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch adds a new config option which could enable assembler's
vector feature.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/Kconfig  | 9 +++++++++
 arch/riscv/Makefile | 1 +
 2 files changed, 10 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 74f82cf4f781..3b742d949a09 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -305,6 +305,15 @@ config FPU
 
 	  If you don't know what to do here, say Y.
 
+config VECTOR
+	bool "VECTOR support"
+	default n
+	help
+	  Say N here if you want to disable all vector related procedure
+	  in the kernel.
+
+	  If you don't know what to do here, say Y.
+
 endmenu
 
 menu "Kernel features"
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 957d064bead0..7c80c95582e3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -46,6 +46,7 @@ riscv-march-aflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
 riscv-march-aflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
 riscv-march-aflags-$(CONFIG_FPU)		:= $(riscv-march-aflags-y)fd
 riscv-march-aflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-aflags-y)c
+riscv-march-aflags-$(CONFIG_VECTOR)		:= $(riscv-march-aflags-y)v
 
 KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
 KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
-- 
2.26.2

