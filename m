Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA64BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C1214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MuK6rw1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgA3UO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:14:58 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:42496 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgA3UO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:14:57 -0500
Received: by mail-pg1-f201.google.com with SMTP id 193so2519762pgh.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=HlKKpg7ZjV76vxI7Xx+EGX2+XDB/ZbEOE3aGV0uGAJU=;
        b=MuK6rw1VKmjDpcW2hCj5zPecHj6a5aFQBY42EcDk57gI1XAAXXRAeigAiwxbLP3cwz
         LbG+wZY5IsfR3HtFLnrn+J4/rwn/EbyC+BAhYVSIoSSYy0pgSfz5jIHB7rAJBVqg5Jo9
         +TByoBb3f67w1zmv8yTClg8y4aoR57s4olqCfJEFLQLhPud6H8/7PA68h9t1BMXIJNkY
         8tPInZ+oIakFYO5ELYhP7ciUcCT0laZ4bnjzRkFujaRHlCrP1NwXDx/44dvKHi3qrCc/
         tFzzL2ICult0UdUNEHY3LpmUrTTGpkfx+ihcvskc/G96CyZHZZEjoQzBsAql36fMHxZG
         uIMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=HlKKpg7ZjV76vxI7Xx+EGX2+XDB/ZbEOE3aGV0uGAJU=;
        b=iF0cKM+qYwo4DLuXiH46u9TmbD6DXFfLFN1KJATN/sAV6eyunN4N9Motu8106m3woC
         D0RiU8HxGAk5teH3p2u1sJzTle3s+qBvcmQP+PLPXbxNsI3x48k4xNJQSYHMjZ12lgOR
         MQS7szVwVa4khKAobbrrwevLVzbhbAKtoWWHkpdhoN8wEXLjUpLpieoYJYyF0k4Y8BuL
         ZmedjBL6nXDEckzTg4Dl5huSKwRYeRjOZuGqXz8MmKig7WRDdyG8g66PUw8+TsQZyAoD
         lVt4s0SqjHYeEH59ptoY16UAZn2hAlFQxb7BKs4SyGjW7dxl/V6GqBVMFeG2wE3OG63t
         SC/g==
X-Gm-Message-State: APjAAAU7CAjKE4iknA9yzm6EslE0pvenFxOrKzZlwm5ai4Z/QkBOod++
        AQ0b1JxAyBf8a4kI1VzkFSAUX0Pzcc93Yg==
X-Google-Smtp-Source: APXvYqzJwvvP+Ib7mJZPmx/9cOuT+l71pmKBvK0yw337IHvGg20CL49auvi6pJEF5Bu1ekXqm5rIlhelsNpWtg==
X-Received: by 2002:a63:1f16:: with SMTP id f22mr6196940pgf.2.1580415295525;
 Thu, 30 Jan 2020 12:14:55 -0800 (PST)
Date:   Thu, 30 Jan 2020 12:14:51 -0800
Message-Id: <20200130201451.253115-1-edumazet@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] dma-debug: add a per-cpu cache to avoid lock contention
From:   Eric Dumazet <edumazet@google.com>
To:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Networking drivers very often have to replace one page with
another for their RX ring buffers.

A multi-queue NIC will severly hit a contention point
in dma-debug while grabbing free_entries_lock spinlock.

Adding a one entry per-cpu cache removes the need
to grab this spinlock twice per page replacement.

Tested on a 40Gbit mlx4 NIC, with 16 RX queues and about
1,000,000 replacements per second.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/debug.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index a310dbb1515e92c081f8f3f9a7290dd5e53fc889..b7221426ef49cf640db5bcb261b0817d714a3033 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -97,6 +97,8 @@ static LIST_HEAD(free_entries);
 /* Lock for the list above */
 static DEFINE_SPINLOCK(free_entries_lock);
 
+static DEFINE_PER_CPU(struct dma_debug_entry *, dma_debug_entry_cache);
+
 /* Global disable flag - will be set in case of an error */
 static bool global_disable __read_mostly;
 
@@ -676,6 +678,10 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	struct dma_debug_entry *entry;
 	unsigned long flags;
 
+	entry = this_cpu_xchg(dma_debug_entry_cache, NULL);
+	if (entry)
+		goto end;
+
 	spin_lock_irqsave(&free_entries_lock, flags);
 	if (num_free_entries == 0) {
 		if (dma_debug_create_entries(GFP_ATOMIC)) {
@@ -690,7 +696,7 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	entry = __dma_entry_alloc();
 
 	spin_unlock_irqrestore(&free_entries_lock, flags);
-
+end:
 #ifdef CONFIG_STACKTRACE
 	entry->stack_len = stack_trace_save(entry->stack_entries,
 					    ARRAY_SIZE(entry->stack_entries),
@@ -705,6 +711,9 @@ static void dma_entry_free(struct dma_debug_entry *entry)
 
 	active_cacheline_remove(entry);
 
+	if (!this_cpu_cmpxchg(dma_debug_entry_cache, NULL, entry))
+		return;
+
 	/*
 	 * add to beginning of the list - this way the entries are
 	 * more likely cache hot when they are reallocated.
-- 
2.25.0.341.g760bfbb309-goog

