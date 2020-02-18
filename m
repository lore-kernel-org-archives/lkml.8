Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B1AC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C1620801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vY/wCGAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgBRR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:26:00 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:37004 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgBRR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:26:00 -0500
Received: by mail-pf1-f201.google.com with SMTP id x10so13671730pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 09:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lyf2EcSh16c+FJvJ7zk5/nVq8X1hNmS4hPMHSudZurU=;
        b=vY/wCGANEuyQVy7n1cXuvJA6kDpv9TZiRDMnJk8/AFUvBJQpjq07YFRbnMuXQmebVu
         sQfsTZ0b1SDZN4REs4wsIUsMBIt6tHY5A4qOsO6Hq1pSHhOFQlGezlewQ03EKNBjZw9m
         bUwy3oorlJjTbc90+08m5iRiltG7Cg+0NpkBnsKPKLoMIIoDBiIXr1i1eZTeVJsg0RtM
         HqRmlhs0u8zXdmdEFII9d6IUnPcP0B6P6PjdnAyBsKnREja4V+F3DlcWVF/jxs5PuaPs
         j1N4F/1ApMYWaTFdl2kHy+H/mmDK0U+e0c1PL+1XAVuxKpavg+EbVKKgW3YcSXtUgkNR
         k5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lyf2EcSh16c+FJvJ7zk5/nVq8X1hNmS4hPMHSudZurU=;
        b=p3Xqd5cenyMRFCQ3lNAZkj47DNNkz6/GvSxbRVHoo7TWUWMCfqcBdvFyl64vq4TnTj
         Sk3ACbt822dfcVyGeStNkMEriy04vYsytNSRKNVxg3qcrriy8KWBEUebmrMe8HQG/c80
         iJUWAAXfQlUP7SDLTzu2syDT99hax51BMRd3rK7vT0MJ1DzcI9PIF9WP6UF1h1mR2FM8
         YgtE97T4DV+CegpFObNA6HInZPiE+suVvIEZ6mXqdvPGBcSk6lZHOu2or4G4wgLl4aF+
         GNMHcNVcqw89usiFjje9fwThJXxFIFLufLVfTFhrR4R2/Ecc5ORUNUknDCj5Mi9LPJYl
         FE+A==
X-Gm-Message-State: APjAAAXIvG+YQB/HWAFceZnxMUuyB+2BuFEjZW0FzvICPh2J1oP5i66U
        Y7at5KVlpLBc4Pb2bCfF0Kgl1V3/+bj0
X-Google-Smtp-Source: APXvYqw3POrOlQL3qmkPAMYunWSKWobAfMfRAMMyJpuKeQl2oRDOKPBZkXofJN93WXxFTfZpPfmLDaJetbSe
X-Received: by 2002:a63:fe43:: with SMTP id x3mr24852110pgj.119.1582046759601;
 Tue, 18 Feb 2020 09:25:59 -0800 (PST)
Date:   Tue, 18 Feb 2020 09:25:52 -0800
Message-Id: <20200218172552.215077-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 bpf] bpf: Do not grab the bucket spinlock by default on
 htab batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Grabbing the spinlock for every bucket even if it's empty, was causing
significant perfomance cost when traversing htab maps that have only a
few entries. This patch addresses the issue by checking first the
bucket_cnt, if the bucket has some entries then we go and grab the
spinlock and proceed with the batching.

Tested with a htab of size 50K and different value of populated entries.

Before:
  Benchmark             Time(ns)        CPU(ns)
  ---------------------------------------------
  BM_DumpHashMap/1       2759655        2752033
  BM_DumpHashMap/10      2933722        2930825
  BM_DumpHashMap/200     3171680        3170265
  BM_DumpHashMap/500     3639607        3635511
  BM_DumpHashMap/1000    4369008        4364981
  BM_DumpHashMap/5k     11171919       11134028
  BM_DumpHashMap/20k    69150080       69033496
  BM_DumpHashMap/39k   190501036      190226162

After:
  Benchmark             Time(ns)        CPU(ns)
  ---------------------------------------------
  BM_DumpHashMap/1        202707         200109
  BM_DumpHashMap/10       213441         210569
  BM_DumpHashMap/200      478641         472350
  BM_DumpHashMap/500      980061         967102
  BM_DumpHashMap/1000    1863835        1839575
  BM_DumpHashMap/5k      8961836        8902540
  BM_DumpHashMap/20k    69761497       69322756
  BM_DumpHashMap/39k   187437830      186551111

Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
Cc: Yonghong Song <yhs@fb.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
v1 -> v2: Skip hlist_nulls_for_each_entry_safe if lock is not held

 kernel/bpf/hashtab.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2d182c4ee9d99..ea3bf04a0a7b6 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1260,6 +1260,7 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	struct hlist_nulls_head *head;
 	struct hlist_nulls_node *n;
 	unsigned long flags;
+	bool locked = false;
 	struct htab_elem *l;
 	struct bucket *b;
 	int ret = 0;
@@ -1319,15 +1320,25 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	dst_val = values;
 	b = &htab->buckets[batch];
 	head = &b->head;
-	raw_spin_lock_irqsave(&b->lock, flags);
+	/* do not grab the lock unless need it (bucket_cnt > 0). */
+	if (locked)
+		raw_spin_lock_irqsave(&b->lock, flags);
 
 	bucket_cnt = 0;
 	hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
 		bucket_cnt++;
 
+	if (bucket_cnt && !locked) {
+		locked = true;
+		goto again_nocopy;
+	}
+
 	if (bucket_cnt > (max_count - total)) {
 		if (total == 0)
 			ret = -ENOSPC;
+		/* Note that since bucket_cnt > 0 here, it is implicit
+		 * that the locked was grabbed, so release it.
+		 */
 		raw_spin_unlock_irqrestore(&b->lock, flags);
 		rcu_read_unlock();
 		this_cpu_dec(bpf_prog_active);
@@ -1337,6 +1348,9 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 
 	if (bucket_cnt > bucket_size) {
 		bucket_size = bucket_cnt;
+		/* Note that since bucket_cnt > 0 here, it is implicit
+		 * that the locked was grabbed, so release it.
+		 */
 		raw_spin_unlock_irqrestore(&b->lock, flags);
 		rcu_read_unlock();
 		this_cpu_dec(bpf_prog_active);
@@ -1346,6 +1360,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		goto alloc;
 	}
 
+	/* Next block is only safe to run if you have grabbed the lock */
+	if (!locked)
+		goto next_batch;
+
 	hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
 		memcpy(dst_key, l->key, key_size);
 
@@ -1380,6 +1398,8 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}
 
 	raw_spin_unlock_irqrestore(&b->lock, flags);
+	locked = false;
+next_batch:
 	/* If we are not copying data, we can go to next bucket and avoid
 	 * unlocking the rcu.
 	 */
-- 
2.25.0.265.gbab2e86ba0-goog

