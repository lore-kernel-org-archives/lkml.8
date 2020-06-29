Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D33C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EE620656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="faYbDJZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbgF2Swx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgF2Swm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF82C02E2DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:11 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so14226291wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L35hXwGJYWdFNYEqvYo8VWLeKGQ8JU/sfeVxKoFGLpc=;
        b=faYbDJZZ9JpfMImGBJzoscendZhfvHpM47CPMRR4jSzOeOEei37aq3S7hRFnCXYwSV
         Zb755P0uqqSdADz/4FkfjIBjJP1WuRcNIuw9KeFK9QqNK0Ful+iEYhl0g1O1AAz6tSBR
         KzpEwa/0OaX2TP6s2bOY7N9Rvko5LmWtAZMhdiPqQe10JwAo80y0n7Jmv+aLL2l6/kC+
         WKEO6/EjP2mFqCm1PD6WYrl5AQINA+OHgXc5ScW2P1nehzakjMt2A151p8FZQNOz3+fy
         0lW1dznXS2BYhYDzM9/wMTH8jDxTaTx1F+2EScbbimKzD0vRtEliKh+6FfNMGRa88xeY
         yUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L35hXwGJYWdFNYEqvYo8VWLeKGQ8JU/sfeVxKoFGLpc=;
        b=pgpcWvXNyC2SKdlhNpUopHlIRj4K8mgxqLfQQfcHKixe+MgzI5mjZVykR0LFrWANPP
         k55drK7lsdq07VSQs+yCntM+Eh4fnlMo4BsHZg9JNmCCq28a7MzcM/S7QKnbe9Ij2FlV
         GfMDyqXTYQjgezG3tAZI4LniylF2mGLMBdLWA9+UWgQyPHg/2b0209EzLH+ZLVchSa5q
         /7UplGlg6Y81M20A3WwpDIAeQQ6Xuysl1H2/tQl99I410MTblkW0znU56ZnyNPcFmOg3
         +m75hmxLLFxzwWZ94Wie0r4M4dNNKD9gJ9AXOfHzo1UEfinKfkD2QW9f1B5jJm5vAJx6
         CxlQ==
X-Gm-Message-State: AOAM533YWYbuDbt1hAPznsZnUE23DtQY84vz6KSg/56ZyXrB5yTNAHLJ
        UBFzPpYS4jXA/N5+XIUPSIMp5A==
X-Google-Smtp-Source: ABdhPJxjuhlvdoJM+CJIODgeu/TfKjRtqBLpoYlSycTPURSj2Y1LRCuoFybaejKcg5Z1rr5Wh5o1/A==
X-Received: by 2002:a5d:4c82:: with SMTP id z2mr16302472wrs.287.1593439510514;
        Mon, 29 Jun 2020 07:05:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 20/20] misc: genwqe: card_utils: Whole a plethora of documentation issues
Date:   Mon, 29 Jun 2020 15:04:42 +0100
Message-Id: <20200629140442.1043957-21-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Including; demoting file header from kerneldoc to standard comment/
header, adding a variety of missing function argument documentation,
repairing formatting (kerneldoc does not like blank lines) and the
demotion of a kerneldoc header which shows no interest in providing
documentation for any of its arguments.

Fixes this the following W=1 issues:

 drivers/misc/genwqe/card_utils.c:37: warning: Incorrect use of kernel-doc format:  * __genwqe_writeq() - Write 64-bit register
 drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or member 'cd' not described in '__genwqe_writeq'
 drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or member 'byte_offs' not described in '__genwqe_writeq'
 drivers/misc/genwqe/card_utils.c:45: warning: Function parameter or member 'val' not described in '__genwqe_writeq'
 drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or member 'cd' not described in 'genwqe_read_app_id'
 drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or member 'app_name' not described in 'genwqe_read_app_id'
 drivers/misc/genwqe/card_utils.c:136: warning: Function parameter or member 'len' not described in 'genwqe_read_app_id'
 drivers/misc/genwqe/card_utils.c:186: warning: bad line:
 drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or member 'cd' not described in 'genwqe_alloc_sync_sgl'
 drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or member 'sgl' not described in 'genwqe_alloc_sync_sgl'
 drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or member 'user_addr' not described in 'genwqe_alloc_sync_sgl'
 drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or member 'user_size' not described in 'genwqe_alloc_sync_sgl'
 drivers/misc/genwqe/card_utils.c:290: warning: Function parameter or member 'write' not described in 'genwqe_alloc_sync_sgl'
 drivers/misc/genwqe/card_utils.c:469: warning: Function parameter or member 'cd' not described in 'genwqe_free_sync_sgl'
 drivers/misc/genwqe/card_utils.c:469: warning: Function parameter or member 'sgl' not described in 'genwqe_free_sync_sgl'
 drivers/misc/genwqe/card_utils.c:716: warning: Function parameter or member 'count' not described in 'genwqe_set_interrupt_capability'
 drivers/misc/genwqe/card_utils.c:747: warning: Function parameter or member 'idx' not described in 'set_reg_idx'
 drivers/misc/genwqe/card_utils.c:747: warning: Excess function parameter 'index' description in 'set_reg_idx'
 drivers/misc/genwqe/card_utils.c:823: warning: Function parameter or member 'cd' not described in 'genwqe_ffdc_buff_size'
 drivers/misc/genwqe/card_utils.c:823: warning: Function parameter or member 'uid' not described in 'genwqe_ffdc_buff_size'
 drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or member 'cd' not described in 'genwqe_ffdc_buff_read'
 drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or member 'uid' not described in 'genwqe_ffdc_buff_read'
 drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or member 'regs' not described in 'genwqe_ffdc_buff_read'
 drivers/misc/genwqe/card_utils.c:877: warning: Function parameter or member 'max_regs' not described in 'genwqe_ffdc_buff_read'
 drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or member 'cd' not described in 'genwqe_write_vreg'
 drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or member 'reg' not described in 'genwqe_write_vreg'
 drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or member 'val' not described in 'genwqe_write_vreg'
 drivers/misc/genwqe/card_utils.c:964: warning: Function parameter or member 'func' not described in 'genwqe_write_vreg'
 drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or member 'cd' not described in 'genwqe_read_vreg'
 drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or member 'reg' not described in 'genwqe_read_vreg'
 drivers/misc/genwqe/card_utils.c:977: warning: Function parameter or member 'func' not described in 'genwqe_read_vreg'
 drivers/misc/genwqe/card_utils.c:995: warning: Function parameter or member 'cd' not described in 'genwqe_base_clock_frequency'
 drivers/misc/genwqe/card_utils.c:1012: warning: Function parameter or member 'cd' not described in 'genwqe_stop_traps'
 drivers/misc/genwqe/card_utils.c:1022: warning: Function parameter or member 'cd' not described in 'genwqe_start_traps'

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>

 # Please enter the commit message for your changes. Lines starting
 # with '#' will be ignored, and an empty message aborts the commit.
 #
 # Date:      Mon Jun 29 10:30:56 2020 +0100
 #
 # On branch tb-mfd-fix-warnings
 # Changes to be committed:
 #	modified:   drivers/misc/genwqe/card_utils.c
 #
 # Untracked files:
 #	qemu-i2c-devs.txt
 #
---
 drivers/misc/genwqe/card_utils.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/genwqe/card_utils.c b/drivers/misc/genwqe/card_utils.c
index 77c21caf2acd1..039b923d1d60a 100644
--- a/drivers/misc/genwqe/card_utils.c
+++ b/drivers/misc/genwqe/card_utils.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/**
+/*
  * IBM Accelerator Family 'GenWQE'
  *
  * (C) Copyright IBM Corp. 2013
@@ -129,6 +129,9 @@ u32 __genwqe_readl(struct genwqe_dev *cd, u64 byte_offs)
 
 /**
  * genwqe_read_app_id() - Extract app_id
+ * @cd:	        genwqe device descriptor
+ * @app_name:   carrier used to pass-back name
+ * @len:        length of data for name
  *
  * app_unitcfg need to be filled with valid data first
  */
@@ -183,7 +186,7 @@ void genwqe_init_crc32(void)
  * @init:       initial crc (0xffffffff at start)
  *
  * polynomial = x^32 * + x^29 + x^18 + x^14 + x^3 + 1 (0x20044009)
-
+ *
  * Example: 4 bytes 0x01 0x02 0x03 0x04 with init=0xffffffff should
  * result in a crc32 of 0xf33cb7d3.
  *
@@ -277,7 +280,7 @@ static int genwqe_sgl_size(int num_pages)
 	return roundup(len, PAGE_SIZE);
 }
 
-/**
+/*
  * genwqe_alloc_sync_sgl() - Allocate memory for sgl and overlapping pages
  *
  * Allocates memory for sgl and overlapping pages. Pages which might
@@ -460,6 +463,8 @@ int genwqe_setup_sgl(struct genwqe_dev *cd, struct genwqe_sgl *sgl,
 
 /**
  * genwqe_free_sync_sgl() - Free memory for sgl and overlapping pages
+ * @cd:	        genwqe device descriptor
+ * @sgl:        scatter gather list describing user-space memory
  *
  * After the DMA transfer has been completed we free the memory for
  * the sgl and the cached pages. Data is being transferred from cached
@@ -710,6 +715,7 @@ int genwqe_read_softreset(struct genwqe_dev *cd)
 /**
  * genwqe_set_interrupt_capability() - Configure MSI capability structure
  * @cd:         pointer to the device
+ * @count:      number of vectors to allocate
  * Return: 0 if no error
  */
 int genwqe_set_interrupt_capability(struct genwqe_dev *cd, int count)
@@ -738,7 +744,7 @@ void genwqe_reset_interrupt_capability(struct genwqe_dev *cd)
  * @i:          index to desired entry
  * @m:          maximum possible entries
  * @addr:       addr which is read
- * @index:      index in debug array
+ * @idx:        index in debug array
  * @val:        read value
  */
 static int set_reg_idx(struct genwqe_dev *cd, struct genwqe_reg *r,
@@ -818,6 +824,8 @@ int genwqe_read_ffdc_regs(struct genwqe_dev *cd, struct genwqe_reg *regs,
 
 /**
  * genwqe_ffdc_buff_size() - Calculates the number of dump registers
+ * @cd:	        genwqe device descriptor
+ * @uid:	unit ID
  */
 int genwqe_ffdc_buff_size(struct genwqe_dev *cd, int uid)
 {
@@ -871,6 +879,10 @@ int genwqe_ffdc_buff_size(struct genwqe_dev *cd, int uid)
 
 /**
  * genwqe_ffdc_buff_read() - Implements LogoutExtendedErrorRegisters procedure
+ * @cd:	        genwqe device descriptor
+ * @uid:	unit ID
+ * @regs:       register information
+ * @max_regs:   number of register entries
  */
 int genwqe_ffdc_buff_read(struct genwqe_dev *cd, int uid,
 			  struct genwqe_reg *regs, unsigned int max_regs)
@@ -956,6 +968,10 @@ int genwqe_ffdc_buff_read(struct genwqe_dev *cd, int uid,
 
 /**
  * genwqe_write_vreg() - Write register in virtual window
+ * @cd:	        genwqe device descriptor
+ * @reg:	register (byte) offset within BAR
+ * @val:	value to write
+ * @func:	PCI virtual function
  *
  * Note, these registers are only accessible to the PF through the
  * VF-window. It is not intended for the VF to access.
@@ -969,6 +985,9 @@ int genwqe_write_vreg(struct genwqe_dev *cd, u32 reg, u64 val, int func)
 
 /**
  * genwqe_read_vreg() - Read register in virtual window
+ * @cd:	        genwqe device descriptor
+ * @reg:	register (byte) offset within BAR
+ * @func:	PCI virtual function
  *
  * Note, these registers are only accessible to the PF through the
  * VF-window. It is not intended for the VF to access.
@@ -981,6 +1000,7 @@ u64 genwqe_read_vreg(struct genwqe_dev *cd, u32 reg, int func)
 
 /**
  * genwqe_base_clock_frequency() - Deteremine base clock frequency of the card
+ * @cd:	        genwqe device descriptor
  *
  * Note: From a design perspective it turned out to be a bad idea to
  * use codes here to specifiy the frequency/speed values. An old
@@ -1005,6 +1025,7 @@ int genwqe_base_clock_frequency(struct genwqe_dev *cd)
 
 /**
  * genwqe_stop_traps() - Stop traps
+ * @cd:	        genwqe device descriptor
  *
  * Before reading out the analysis data, we need to stop the traps.
  */
@@ -1015,6 +1036,7 @@ void genwqe_stop_traps(struct genwqe_dev *cd)
 
 /**
  * genwqe_start_traps() - Start traps
+ * @cd:	        genwqe device descriptor
  *
  * After having read the data, we can/must enable the traps again.
  */
-- 
2.25.1

