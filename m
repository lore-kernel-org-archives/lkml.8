Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9445EC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64D9A20757
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ09pXU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbgDBRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:25:36 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45843 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbgDBRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:25:35 -0400
Received: by mail-lj1-f193.google.com with SMTP id t17so4062243ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWDIFfRAlavtGE6jzeO9w72h52shtO0U/BlvUQ46yTw=;
        b=AJ09pXU1cbCg/KYUK/vQ0KXm0OirYEwq1UWHn37t1f4TkH4rFF7Zle+QFSzIVhm20f
         cosGkPli4R/y/O67SxHfZKHbBkDvO3xFB01goqDwqtQKOGoooZCxzvHNRShE7OZFsgP+
         n7LdB5wIMGLIvGMshYm0RUvnXkGc8OJy1/5/3Zxd3j8Hf7e1QBHkuBPl1tQpZAUzsY5g
         YYeI4Hny+AT6OQwvWAE/JUuOS00ikV7PSk7TxhoVMYALuvYJvnFdYF2RKHSSBSz8yvkr
         qhQbowgf6gG4LTN6jE7lY4UqNZN2R6ONntxB9TIzm+Cj6OS0p79cGNzUVUAV9iAOSmgW
         hHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DWDIFfRAlavtGE6jzeO9w72h52shtO0U/BlvUQ46yTw=;
        b=g4RJJfX0ryj9qN8Ww+fBMIm0/Kxf6DGtgZZOaRCJFl/JsQPEb9Qps8y0kTr5uz4/t0
         gP/veqpvF1rYGXGppiFKcIWOw92jtpPh4deiXFPRBxzlDFjAtvhJVTHlZHqaa10Yldyn
         LORsoxlCOYD+lZ0BKNSuD2xNGWiZLXq0LVGq+P5e8hPcWMXDorlnxGWII22Kr81ocWPe
         FlC3ibRzrnzq+6xldq8lcoWLK1TENl3VzElAP/8IkYxNR2ol2lM8dXCXaKurdxKIkUf7
         qcVf0gAdhJ1aJFNEfFuQ0kzKwsUvE8yj6d461/2GmQ7buARblDUMUE7I8gDRa+Y+cK8c
         mejg==
X-Gm-Message-State: AGi0PuZtzQe1CFWPOcBn4v5LEM/WYF3BVCPx2sK16qMeRHxFMx27XAIC
        UehNdUvUHUFj/5yGZYZgCUPUL6Zz
X-Google-Smtp-Source: APiQypKRQ+xKvImDHJ86Vvq4FiUdNDvcmifjwhm6ZayIDq0fwGt5xX3GkfJaLUCwImnZwlZC4Vsl+A==
X-Received: by 2002:a2e:8146:: with SMTP id t6mr2635555ljg.236.1585848333112;
        Thu, 02 Apr 2020 10:25:33 -0700 (PDT)
Received: from localhost.localdomain (h-4-68-234.A785.priv.bahnhof.se. [155.4.68.234])
        by smtp.gmail.com with ESMTPSA id y23sm3613286ljh.42.2020.04.02.10.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 10:25:32 -0700 (PDT)
From:   Jimmy Assarsson <jimmyassarsson@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jimmy Assarsson <jimmyassarsson@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Subject: [PATCH] x86/mpx: remove MPX leftovers
Date:   Thu,  2 Apr 2020 19:25:07 +0200
Message-Id: <20200402172507.2786-1-jimmyassarsson@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove leftovers from x86/mpx.

Fixes: 45fc24e89b7c ("x86/mpx: remove MPX from arch/x86")
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Signed-off-by: Jimmy Assarsson <jimmyassarsson@gmail.com>
---
 fs/proc/task_mmu.c | 3 ---
 include/linux/mm.h | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 3ba9ae83bff5..53dce43fdd9a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -652,9 +652,6 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_GROWSDOWN)]	= "gd",
 		[ilog2(VM_PFNMAP)]	= "pf",
 		[ilog2(VM_DENYWRITE)]	= "dw",
-#ifdef CONFIG_X86_INTEL_MPX
-		[ilog2(VM_MPX)]		= "mp",
-#endif
 		[ilog2(VM_LOCKED)]	= "lo",
 		[ilog2(VM_IO)]		= "io",
 		[ilog2(VM_SEQ_READ)]	= "sr",
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c54fb96cb1e6..70717ae2be7f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -328,13 +328,6 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
 #endif
 
-#if defined(CONFIG_X86_INTEL_MPX)
-/* MPX specific bounds table or bounds directory */
-# define VM_MPX		VM_HIGH_ARCH_4
-#else
-# define VM_MPX		VM_NONE
-#endif
-
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
-- 
2.26.0

