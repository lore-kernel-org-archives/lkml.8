Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C58FC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0075208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645426;
	bh=lpmok3Bil27XaA6+FP/m2mDasVztqUgL3V0nTC4ZTYY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=2df42NXRsuKagLqtKqgxGp32VFdeBqJ3i7NQWpHBARWrA36IofVO2ySO1wB7uYauh
	 QrTaXjZsqhDllZIFDzbF0CcyfK6llC70RnBSiQTThZFYv7UkXpHEwO5neS6tNvTe4M
	 yj4IV9FujLJGxX/1aHOS+2voPSBKR6YQSV9Wf8zE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbgCaJDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:44 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42453 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730515AbgCaJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:40 -0400
Received: by mail-wr1-f54.google.com with SMTP id h15so24863482wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 02:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q9/XO8fYcNvTTJyLWlGUfxMTl5XPLuqywJPuPYMMlNc=;
        b=VyxRAN1K3gGDI7rkxa6zHWAtYASTkrFHG+miBSQb4pmUNoUwt5iodVWgoYBhejxjXE
         9lyGYHplFCDU05KW8LAxfslzYnb988kvrgya6GGf2E8xL0kyylO7mUOMLTAx+ZNZGWcN
         5QIKHuXcKrINePtPaadGZy2CISDv2LRuABATQiegVCrg37HEOfAEavpQd4VJ6sbZZP53
         0+WQAFUklFgczW7bzjMsZMmQAqNpwzsj0K6JxAlzVMF4kHWiTSuR24HyEm+ug/pE2u4m
         GwW7uDiAO2j68L98AYZ6CMKcz3B8q+Wwbq7iF1qp2WiS1WHH/AIIAwUsXygT46BSXX2s
         Tx1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=Q9/XO8fYcNvTTJyLWlGUfxMTl5XPLuqywJPuPYMMlNc=;
        b=BjE6Hrm+2RmE7CLTr4HMlHNrtSYJ7hWSng5l4rvR9w4Swen1oeobH0X6X8UVTY4YQs
         LIRl79BeZ71LBnEaFYF38l21g0mXIVdPLgQ/19+5RooC/1zVTYHynMybplB0FPGuASo/
         dHRNvIm5Xirmcf5gzhSFmNmyc5wL+8w+R+7tVy3XFPI8MM2rsHWV92HXS5KAwPHuksqO
         9gtsLOY/NI8KHVE7vdI317ABeQLabsWZP66CrsDjFyHmudxt14MQHubA061bQTfu6wUU
         DxR3AYBIZGcCZKCz4mBqpaXeTgwe9Cv4hogj5MUgeHVn4UK+DLpfcwl+w9anaZPmB6z8
         2Xgg==
X-Gm-Message-State: ANhLgQ04Ah/YgJTySjPziHE3og4HfmQRdrZJmHGuICmz6AwtN1tWlTpL
        KLogSPj1/S7J9dHEkm1jMU0=
X-Google-Smtp-Source: ADFU+vuH5tyUSehNA7LHz3MMoXcvWLVtaxH6+r3Ul34UI8JIFyFP/C1PFyJWMFYRYXOVVaQRPpTY5w==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr19936392wrn.144.1585645418833;
        Tue, 31 Mar 2020 02:03:38 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y200sm3061785wmc.20.2020.03.31.02.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 02:03:38 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:03:36 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mm changes for v5.7
Message-ID: <20200331090336.GA5237@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mm-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-for-linus

   # HEAD: aa61ee7b9ee3cb84c0d3a842b0d17937bf024c46 x86/mm: Remove the now redundant N_MEMORY check

A handful of changes:

 - two memory encryption related fixes

 - don't display the kernel's virtual memory layout plaintext on 32-bit kernels either

 - two simplifications


  out-of-topic modifications in x86-mm-for-linus:
  -------------------------------------------------
  kernel/dma/mapping.c               # 17c4a2ae15a7: dma-mapping: Fix dma_pgprot(

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/mm/init/32: Stop printing the virtual memory layout

Baoquan He (1):
      x86/mm: Remove the now redundant N_MEMORY check

Sebastian Andrzej Siewior (1):
      x86/mm/kmmio: Use this_cpu_ptr() instead get_cpu_var() for kmmio_ctx

Thomas Hellstrom (2):
      x86: Don't let pgprot_modify() change the page encryption bit
      dma-mapping: Fix dma_pgprot() for unencrypted coherent pages


 arch/x86/include/asm/pgtable.h       |  7 +++++--
 arch/x86/include/asm/pgtable_types.h |  2 +-
 arch/x86/mm/init_32.c                | 38 ------------------------------------
 arch/x86/mm/init_64.c                |  3 +--
 arch/x86/mm/kmmio.c                  | 10 +++-------
 kernel/dma/mapping.c                 |  2 ++
 6 files changed, 12 insertions(+), 50 deletions(-)
