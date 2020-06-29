Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F93EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618782081A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zB7LyQxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbgF2VVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729759AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A11CC02E2DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so16681820wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vqNBDouTK8PphAMbImg0Rb2dZabHhQnfuFaJhvwhGMc=;
        b=zB7LyQxQm5VAV564JDk+hIRS+rFVYoTLn+2odNt5cJA2OZCbVqBV6/ojoVy8kbcd6N
         phRRRw4efeVbgdvzOAHc7Vp8J7CyxV7EwSvlFDHqv39hIagaRpuRPzMgyZIGD+rVyGtm
         rqPBZ93NHBdfB8QdPg5miFgYKJUz2jPE7zqJfIntxdxqOaTSi+rzbDT5JgVWV1PbexWN
         L0ucbbcLk9vWrLWAql7k+X8bPBnp5pHFUNpsdNAIbBqIXftZ6RPDIw8GQYVtbMZWFDoc
         0R/I6TfjId5f32mbIN48VzhDo6icVIW630KZEgN5er9lBK4VbRbfznr4OoushIRloORH
         Xxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vqNBDouTK8PphAMbImg0Rb2dZabHhQnfuFaJhvwhGMc=;
        b=SerFRcB6Zi9bBMwarYYWTTwWISb9Lvvl4enGeWk+hMmbVLBlYJauZYh9it/1uQcdp+
         IcmUd6MIImQZEvOiCQS0TV1or4AmKR0ZUKAj0etYIxF2wnGw8qq41jzk7lOYqHAtj1Sm
         NutbN88IKKZrjDHzUa+xBeMg0cTgq7BuBskxaXYbjBELlkBaZLrPGWv9wVybN1lpdiMx
         dNHGlFNSMTFoivP7nAJgHvUCwo6xMHPM/hHw/2+DZGLof4JkBldZgTSE5GMtiXV2FLYs
         hB4yp2AkxmhpS63djvLnEPnkPcWJOBzsZW1fDNMjfWW5kBmh1p06M2Pnkc3wBn9rxJ/T
         k6+w==
X-Gm-Message-State: AOAM532UxHicrmKpDHz+nMYIHR9EjZ2QSnUyS5r3/naezFiC2Pgf1/d7
        bODzU7/xajydlhqmyFVj6a/B1g==
X-Google-Smtp-Source: ABdhPJxwXHImUgT4Ji8ujROEtLVQiDyh2r8H5CowRBsagghC0NtuoezWsUvt7hSsxqBQ3E7UkwNxYg==
X-Received: by 2002:a5d:650e:: with SMTP id x14mr18020746wru.187.1593439509213;
        Mon, 29 Jun 2020 07:05:09 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:08 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 19/20] misc: genwqe: card_dev: Whole host of kerneldoc fixes
Date:   Mon, 29 Jun 2020 15:04:41 +0100
Message-Id: <20200629140442.1043957-20-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including; add missing documentation for function arguments, re-ordering
of #defines i.e. not placed between kerneldoc headers and the functions
they are documenting, demotion of file header/comment from kerneldoc
format and removal of documentation for non-existent args.

Fixes the following W=1 kernel build warnings:

 drivers/misc/genwqe/card_dev.c:33: warning: Function parameter or member 'cd' not described in 'genwqe_open_files'
 drivers/misc/genwqe/card_dev.c:98: warning: Function parameter or member 'virt_addr' not described in 'genwqe_search_pin'
 drivers/misc/genwqe/card_dev.c:98: warning: Excess function parameter 'dma_addr' description in 'genwqe_search_pin'
 drivers/misc/genwqe/card_dev.c:154: warning: Function parameter or member 'virt_addr' not described in '__genwqe_search_mapping'
 drivers/misc/genwqe/card_dev.c:256: warning: Function parameter or member 'cd' not described in 'genwqe_kill_fasync'
 drivers/misc/genwqe/card_dev.c:256: warning: Function parameter or member 'sig' not described in 'genwqe_kill_fasync'
 drivers/misc/genwqe/card_dev.c:387: warning: Function parameter or member 'vma' not described in 'genwqe_vma_close'
 drivers/misc/genwqe/card_dev.c:430: warning: Function parameter or member 'filp' not described in 'genwqe_mmap'
 drivers/misc/genwqe/card_dev.c:430: warning: Function parameter or member 'vma' not described in 'genwqe_mmap'
 drivers/misc/genwqe/card_dev.c:495: warning: Excess function parameter 'cd' description in 'FLASH_BLOCK'
 drivers/misc/genwqe/card_dev.c:495: warning: Excess function parameter 'load' description in 'FLASH_BLOCK'
 drivers/misc/genwqe/card_dev.c:827: warning: Function parameter or member 'cfile' not described in 'ddcb_cmd_cleanup'
 drivers/misc/genwqe/card_dev.c:827: warning: Function parameter or member 'req' not described in 'ddcb_cmd_cleanup'
 drivers/misc/genwqe/card_dev.c:854: warning: Function parameter or member 'cfile' not described in 'ddcb_cmd_fixups'
 drivers/misc/genwqe/card_dev.c:854: warning: Function parameter or member 'req' not described in 'ddcb_cmd_fixups'
 drivers/misc/genwqe/card_dev.c:984: warning: Function parameter or member 'cfile' not described in 'genwqe_execute_ddcb'
 drivers/misc/genwqe/card_dev.c:984: warning: Function parameter or member 'cmd' not described in 'genwqe_execute_ddcb'
 drivers/misc/genwqe/card_dev.c:1350: warning: Function parameter or member 'cd' not described in 'genwqe_device_remove'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_dev.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 040a0bda31254..55fc5b80e649f 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
@@ -87,7 +87,7 @@ static int genwqe_del_pin(struct genwqe_file *cfile, struct dma_mapping *m)
  * @cfile:	Descriptor of opened file
  * @u_addr:	User virtual address
  * @size:	Size of buffer
- * @dma_addr:	DMA address to be updated
+ * @virt_addr:	Virtual address to be updated
  *
  * Return: Pointer to the corresponding mapping	NULL if not found
  */
@@ -144,6 +144,7 @@ static void __genwqe_del_mapping(struct genwqe_file *cfile,
  * @u_addr:	user virtual address
  * @size:	size of buffer
  * @dma_addr:	DMA address to be updated
+ * @virt_addr:	Virtual address to be updated
  * Return: Pointer to the corresponding mapping	NULL if not found
  */
 static struct dma_mapping *__genwqe_search_mapping(struct genwqe_file *cfile,
@@ -249,6 +250,8 @@ static void genwqe_remove_pinnings(struct genwqe_file *cfile)
 
 /**
  * genwqe_kill_fasync() - Send signal to all processes with open GenWQE files
+ * @cd: GenWQE device information
+ * @sig: Signal to send out
  *
  * E.g. genwqe_send_signal(cd, SIGIO);
  */
@@ -380,6 +383,7 @@ static void genwqe_vma_open(struct vm_area_struct *vma)
 
 /**
  * genwqe_vma_close() - Called each time when vma is unmapped
+ * @vma: VMA area to close
  *
  * Free memory which got allocated by GenWQE mmap().
  */
@@ -416,6 +420,8 @@ static const struct vm_operations_struct genwqe_vma_ops = {
 
 /**
  * genwqe_mmap() - Provide contignous buffers to userspace
+ * @filp:	File pointer (unused)
+ * @vma:	VMA area to map
  *
  * We use mmap() to allocate contignous buffers used for DMA
  * transfers. After the buffer is allocated we remap it to user-space
@@ -484,16 +490,15 @@ static int genwqe_mmap(struct file *filp, struct vm_area_struct *vma)
 	return rc;
 }
 
+#define	FLASH_BLOCK	0x40000	/* we use 256k blocks */
+
 /**
  * do_flash_update() - Excute flash update (write image or CVPD)
- * @cd:        genwqe device
+ * @cfile:	Descriptor of opened file
  * @load:      details about image load
  *
  * Return: 0 if successful
  */
-
-#define	FLASH_BLOCK	0x40000	/* we use 256k blocks */
-
 static int do_flash_update(struct genwqe_file *cfile,
 			   struct genwqe_bitstream *load)
 {
@@ -820,6 +825,8 @@ static int genwqe_unpin_mem(struct genwqe_file *cfile, struct genwqe_mem *m)
 
 /**
  * ddcb_cmd_cleanup() - Remove dynamically created fixup entries
+ * @cfile:	Descriptor of opened file
+ * @req:	DDCB work request
  *
  * Only if there are any. Pinnings are not removed.
  */
@@ -844,6 +851,8 @@ static int ddcb_cmd_cleanup(struct genwqe_file *cfile, struct ddcb_requ *req)
 
 /**
  * ddcb_cmd_fixups() - Establish DMA fixups/sglists for user memory references
+ * @cfile:	Descriptor of opened file
+ * @req:	DDCB work request
  *
  * Before the DDCB gets executed we need to handle the fixups. We
  * replace the user-space addresses with DMA addresses or do
@@ -974,6 +983,8 @@ static int ddcb_cmd_fixups(struct genwqe_file *cfile, struct ddcb_requ *req)
 
 /**
  * genwqe_execute_ddcb() - Execute DDCB using userspace address fixups
+ * @cfile:	Descriptor of opened file
+ * @cmd:        Command identifier (passed from user)
  *
  * The code will build up the translation tables or lookup the
  * contignous memory allocation table to find the right translations
@@ -1339,6 +1350,7 @@ static int genwqe_inform_and_stop_processes(struct genwqe_dev *cd)
 
 /**
  * genwqe_device_remove() - Remove genwqe's char device
+ * @cd: GenWQE device information
  *
  * This function must be called after the client devices are removed
  * because it will free the major/minor number range for the genwqe
-- 
2.25.1

