Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C8CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C962541B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Yqea0SAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgFVGeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbgFVGd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:33:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219BEC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:58 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 35so7172085ple.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=79mLCqgR2TWJkFKs+0zZjudKKC4J+TXmNnrwJCDQpds=;
        b=Yqea0SAv3aoQMqj/RDoys0F2J6lpuwJYGAZOOhsI/Ol4jei2Edvu17UrrldH1nXCj0
         xK2xMVGGLlrAM9QVG0rNT0csb8Qbk/KwXqKY3qwuTLo0eJlZXXSCACrtg/xby/7cYKG/
         6tbjoItHw5ptJlHWQ21jExAI6MMZH3GLm8DEsDrodcvx6pZOz8EQgUjG12TCNjeRyfEh
         wO0c8w0J9vTXQvCtJ2WIdekEr0ZdC3cD9UfMsD5nXgtnHCqiIy+lBOSmaZnNmhzPS/+G
         9P4GV23kR6Kg46S2axHGwByJ5hj3Dj4k7tlfXpWvlpixfgr8N8VGSCN6uWODA2SGwmsE
         EGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=79mLCqgR2TWJkFKs+0zZjudKKC4J+TXmNnrwJCDQpds=;
        b=KtUmaHqtewwuailC58tsOf+wsr76/XOHUCv370k3vMEaT8vJI2/ihCvLByPOzodDZ4
         cIf9AkvDDLEKdr3+6Oma9n4VWXANyMdJrPXPESifCr4HOff6UozTPPqcA/qhhFu4ShJc
         r8NIQfQqCv9I8DnhM23LqhrET1acH9hg8zjkapSdX5FPCdkinv9Y78++X6uQx/QlySry
         Y/C3BirsbOHenGis/cqu38O6JAMbUBHHl7495uORxpcLIaNxOSZldC2N7LN4E5LTSU6a
         YDv+2gY1bXdFvwL/uCnd8seuULdn/fAIkD2nOPksV6Sg6bbWiMK76zB7CKE6gbbflQIU
         1Kmw==
X-Gm-Message-State: AOAM533OT3QFPjXXgzIyqa8k5liiChf0SEl/RiL3+PVJdnUeBvYlQSMf
        LdyNw+zjU5pSgscFxz4vc3Kgfw==
X-Google-Smtp-Source: ABdhPJyJxrNJBgL4khDAGY/Qn2Rr0M3no6NvPaHOckuQNuoS/e31BILBtCP8a5EbQQ4b4DIyZiHY9A==
X-Received: by 2002:a17:90a:db16:: with SMTP id g22mr15654793pjv.26.1592807637600;
        Sun, 21 Jun 2020 23:33:57 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id w11sm12530999pfi.93.2020.06.21.23.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 23:33:57 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com, mick@ics.forth.gr,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 2/2] riscv: mm: refine the Makefile
Date:   Mon, 22 Jun 2020 14:33:50 +0800
Message-Id: <86134f2c2e88da1caa9bb361505218458e3c63ec.1592807136.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1592807136.git.zong.li@sifive.com>
References: <cover.1592807136.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put all objects which selected by obj-y together.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/mm/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 4530ad52f1d6..7f95f66e135a 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -5,12 +5,8 @@ ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_init.o = -pg
 endif
 
-obj-y += init.o
-obj-y += extable.o
+obj-y += init.o extable.o cacheflush.o context.o mmap.o
 obj-$(CONFIG_MMU) += fault.o pageattr.o
-obj-y += cacheflush.o
-obj-y += context.o
-obj-y += mmap.o
 
 ifeq ($(CONFIG_MMU),y)
 obj-$(CONFIG_SMP) += tlbflush.o
-- 
2.27.0

