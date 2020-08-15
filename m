Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C3DC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 059302072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 21:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CDvdzwQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHQVEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 17:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQVEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:04:44 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D9BC061389;
        Mon, 17 Aug 2020 14:04:44 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r11so8830244pfl.11;
        Mon, 17 Aug 2020 14:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0xsxFxhXZa1EWxR0qccoZxf/DJY4RuXfsMuyEx8Fs4=;
        b=CDvdzwQqRovVxOhgT2RUbZ6X4YCbt6xiALqbZ0yshN7CEr/yMtl3nb+sjcNWGjPNhk
         os0GGifoSws07ZWM8dyLJEIq6VlNGM4XlCgQ3qY5roljLEwpwoZTuZ8VgfHIaNSjElMd
         bUcpeO3Q0iv/M5AVEPXWeZ5/NX71UCbzxp+V056ixoc7XPEtOG6MhHOR/gihRv9CnkIq
         w1O0VVwKamy338MJwQUTvKvMUdzBjJwpyxXAY/pLNdNXFTZQt5A3NvE43dfD7Tj82CBr
         cYbR1UCm41MVbmzp1TediUzG6NwOwPnbYS8XDhsvLLKOadbFimvTwxb3m0g1BdLksBQT
         jvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s0xsxFxhXZa1EWxR0qccoZxf/DJY4RuXfsMuyEx8Fs4=;
        b=D1VP/lrz0eEgOsplZeP7uUjbsR5jTM1VdZse+idLRI0HUyjVkzIsf8Jk/GHpM1zjOa
         ix9gCM5v0INQgQyPLupA9tRV7dG0Oc1lzwN18Ji4zEDW2CttIEFdBX+6DwAnHTLte/Dj
         SrWL7+XaXGVwHQRjkdtpPGCxqz9QRSNlajp+MMft62SUieKKDDLTVvV1vy8WhknGwf7Q
         XKRnQVksdjEgHOrE0ZZww+OdIMTA4qYkK/D8nzw8E+tAbLYH1pvInJoLmlDcfOtKzUQA
         eLpDJDF/p1CQ7KnWAOWulOJKsZurTrWAktiCOzx6xCLAl8hcdzzz13TZ+YVbjI8Cp/Bx
         FNpQ==
X-Gm-Message-State: AOAM530c3ca3DG01wnhysSsTuWNhlg/uzQ1f0+3UECQXX6cawuHXvt0K
        ohl/MnNY/4+RqvzrxBNtaZiuor6wMA/rGw==
X-Google-Smtp-Source: ABdhPJwUhkGlRkmO5t4lKAcNEqs80JBjk72J7fFvxm96RSENW/ROGKXpfL/92x0BUVl8KIua6QBW0g==
X-Received: by 2002:a63:7e42:: with SMTP id o2mr7541262pgn.260.1597698283629;
        Mon, 17 Aug 2020 14:04:43 -0700 (PDT)
Received: from localhost.localdomain (c-107-3-138-210.hsd1.ca.comcast.net. [107.3.138.210])
        by smtp.gmail.com with ESMTPSA id u62sm21092504pfb.4.2020.08.17.14.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:04:42 -0700 (PDT)
From:   Yang Shi <shy828301@gmail.com>
To:     xuyu@linux.alibaba.com, hannes@cmpxchg.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [v3 PATCH] mm/memory.c: skip spurious TLB flush for retried page fault
Date:   Fri, 14 Aug 2020 21:30:41 -0700
Message-Id: <20200815043041.132195-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found regression when running will_it_scale/page_fault3 test
on ARM64.  Over 70% down for the multi processes cases and over 20% down
for the multi threads cases.  It turns out the regression is caused by
commit 89b15332af7c0312a41e50846819ca6613b58b4c ("mm: drop mmap_sem before
calling balance_dirty_pages() in write fault").

The test mmaps a memory size file then write to the mapping, this would
make all memory dirty and trigger dirty pages throttle, that upstream
commit would release mmap_sem then retry the page fault.  The retried page
fault would see correct PTEs installed then just fall through to spurious TLB
flush.  The regression is caused by the excessive spurious TLB flush.  It is
fine on x86 since x86's spurious TLB flush is no-op.

We could just skip the spurious TLB flush to mitigate the regression.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reported-by: Xu Yu <xuyu@linux.alibaba.com>
Debugged-by: Xu Yu <xuyu@linux.alibaba.com>
Tested-by: Xu Yu <xuyu@linux.alibaba.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
v3: Incorporated Linus's suggestion
v2: Incorporated Will Deacon's suggestion

 mm/memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 3a7779d9891d..602f4283122f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4247,6 +4247,9 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 				vmf->flags & FAULT_FLAG_WRITE)) {
 		update_mmu_cache(vmf->vma, vmf->address, vmf->pte);
 	} else {
+		/* Skip spurious TLB flush for retried page fault */
+		if (vmf->flags & FAULT_FLAG_TRIED)
+			goto unlock;
 		/*
 		 * This is needed only for protection faults but the arch code
 		 * is not yet telling us if this is a protection fault or not.
-- 
2.26.2

