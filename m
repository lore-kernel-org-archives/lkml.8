Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE86C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C39246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NElH0YTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbgB1Eko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:40:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39666 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730793AbgB1Ekn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:40:43 -0500
Received: by mail-qk1-f194.google.com with SMTP id e16so1836831qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 20:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cj4hvzbBWIfOD8PxlloU5ZTDppd4yjMAQkBeIQCm4QA=;
        b=NElH0YTvluZZtk+XFuCxtrtsKlZEGWjjaBcH67X3dDIfYDTjjFM+8gemK/MMXkGi/z
         5KviLvUdf+dxfyzif3R96xiPegvQEHBtqnCEqAwtPVR7qHN/TYqg67D5Yo+3m+OA1dND
         7DKoQT07c7BvpHABjdDdK7EzbBhhn8u0ZKgm8O7jLFp3Wae8xbihqeFH/7S5iqDpF+d6
         +XgNts3Nm2dX7LAH1V/mqPcmDFc5jP6lFR8shPiWQmZRVwJQzhax0N7UHSuMvmuzloex
         dnhSwTGtW0wvtn0Q60JCGy11cRX6nsbBDxwYZlvieMquiKdBYyEN5uBuodaMSrtANhDp
         QBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Cj4hvzbBWIfOD8PxlloU5ZTDppd4yjMAQkBeIQCm4QA=;
        b=l3vlyCBRG/RJf3IMEVCiPenXaEwlXCq/P8Hknb9RhLNDPBaOgzzPny4FHUHHjGz93W
         Vu6g/NNCSh5R9X5urvH12GVvyr/DHFutTu6ArNBk4+zQfe5qdlN3zVNHPowTdhK4cWNl
         2M7jJL8VBtzYbIMWSRsT4/TFlJVhAIF562K+RMMvs56nV+01CifSLhvrR0bmLLPL/ZVo
         5GaXrcM8Q8h/HvbwmZDWdHbOJ3RYFCxUwxOnTY6aSY3q7tz4at6dt0scg3wZcZgvSXgg
         kFW/s66PMt4Z3rPWC31p5GVNDNqp+LIQLfv+EVfZSjuhwcOjJ5robJ5RW4xJxyn5eg/o
         CXlw==
X-Gm-Message-State: APjAAAVs4PDJlo6iJs/4ApS+F4kcdW11muiVQZQ4AZ+jOlEaFxi6v2wh
        aeBLWYeLf3jnB0wW7CbCbuUtaVV3pmKchw==
X-Google-Smtp-Source: APXvYqwZ/QJEx93wsnPRUp6ZcOY3tgnSoTSq6wF0iPltVIJRSnN3QYVmzfHtLKWY/fw7pWgPsxEtBg==
X-Received: by 2002:a05:620a:13e1:: with SMTP id h1mr2795764qkl.462.1582864842415;
        Thu, 27 Feb 2020 20:40:42 -0800 (PST)
Received: from ovpn-121-145.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u49sm4557239qtb.37.2020.02.27.20.40.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 20:40:41 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/swap: annotate data races for lru_rotate_pvecs
Date:   Thu, 27 Feb 2020 23:40:18 -0500
Message-Id: <20200228044018.1263-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read to lru_add_pvec->nr could be interrupted and then write to the same
variable. The write has local interrupt disabled, but the plain reads
result in data races. However, it is unlikely the compilers could
do much damage here given that lru_add_pvec->nr is a "unsigned char" and
there is an existing compiler barrier. Thus, annotate the reads using the
data_race() macro. The data races were reported by KCSAN,

 BUG: KCSAN: data-race in lru_add_drain_cpu / rotate_reclaimable_page

 write to 0xffff9291ebcb8a40 of 1 bytes by interrupt on cpu 23:
  rotate_reclaimable_page+0x2df/0x490
  pagevec_add at include/linux/pagevec.h:81
  (inlined by) rotate_reclaimable_page at mm/swap.c:259
  end_page_writeback+0x1b5/0x2b0
  end_swap_bio_write+0x1d0/0x280
  bio_endio+0x297/0x560
  dec_pending+0x218/0x430 [dm_mod]
  clone_endio+0xe4/0x2c0 [dm_mod]
  bio_endio+0x297/0x560
  blk_update_request+0x201/0x920
  scsi_end_request+0x6b/0x4a0
  scsi_io_completion+0xb7/0x7e0
  scsi_finish_command+0x1ed/0x2a0
  scsi_softirq_done+0x1c9/0x1d0
  blk_done_softirq+0x181/0x1d0
  __do_softirq+0xd9/0x57c
  irq_exit+0xa2/0xc0
  do_IRQ+0x8b/0x190
  ret_from_intr+0x0/0x42
  delay_tsc+0x46/0x80
  __const_udelay+0x3c/0x40
  __udelay+0x10/0x20
  kcsan_setup_watchpoint+0x202/0x3a0
  __tsan_read1+0xc2/0x100
  lru_add_drain_cpu+0xb8/0x3f0
  lru_add_drain+0x25/0x40
  shrink_active_list+0xe1/0xc80
  shrink_lruvec+0x766/0xb70
  shrink_node+0x2d6/0xca0
  do_try_to_free_pages+0x1f7/0x9a0
  try_to_free_pages+0x252/0x5b0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9291ebcb8a40 of 1 bytes by task 37761 on cpu 23:
  lru_add_drain_cpu+0xb8/0x3f0
  lru_add_drain_cpu at mm/swap.c:602
  lru_add_drain+0x25/0x40
  shrink_active_list+0xe1/0xc80
  shrink_lruvec+0x766/0xb70
  shrink_node+0x2d6/0xca0
  do_try_to_free_pages+0x1f7/0x9a0
  try_to_free_pages+0x252/0x5b0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x16e/0x6f0
  __handle_mm_fault+0xcd5/0xd40
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 2 locks held by oom02/37761:
  #0: ffff9281e5928808 (&mm->mmap_sem#2){++++}, at: do_page_fault
  #1: ffffffffb3ade380 (fs_reclaim){+.+.}, at: fs_reclaim_acquire.part
 irq event stamp: 1949217
 trace_hardirqs_on_thunk+0x1a/0x1c
 __do_softirq+0x2e7/0x57c
 __do_softirq+0x34c/0x57c
 irq_exit+0xa2/0xc0

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 23 PID: 37761 Comm: oom02 Not tainted 5.6.0-rc3-next-20200226+ #6
 Hardware name: HP ProLiant BL660c Gen9, BIOS I38 10/17/2018

Signed-off-by: Qian Cai <cai@lca.pw>
---

BTW, while at it, I had also looked at other pagevec there, but could
not tell for  sure if they could be interrupted resulting in data races,
so I leave them out for now.

 mm/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index cf39d24ada2a..c922f99dab85 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -599,7 +599,8 @@ void lru_add_drain_cpu(int cpu)
 		__pagevec_lru_add(pvec);
 
 	pvec = &per_cpu(lru_rotate_pvecs, cpu);
-	if (pagevec_count(pvec)) {
+	/* Disabling interrupts below acts as a compiler barrier. */
+	if (data_race(pagevec_count(pvec))) {
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
@@ -744,7 +745,7 @@ void lru_add_drain_all(void)
 		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
 
 		if (pagevec_count(&per_cpu(lru_add_pvec, cpu)) ||
-		    pagevec_count(&per_cpu(lru_rotate_pvecs, cpu)) ||
+		    data_race(pagevec_count(&per_cpu(lru_rotate_pvecs, cpu))) ||
 		    pagevec_count(&per_cpu(lru_deactivate_file_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_deactivate_pvecs, cpu)) ||
 		    pagevec_count(&per_cpu(lru_lazyfree_pvecs, cpu)) ||
-- 
2.21.0 (Apple Git-122.2)

