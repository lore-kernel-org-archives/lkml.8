Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227A7C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A5C2081E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IeXW9Ek8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBNWnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:43:15 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:55780 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgBNWnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:43:15 -0500
Received: by mail-pg1-f201.google.com with SMTP id v30so6929108pga.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uHN7vdUXj9zg5j6BFSm9FeBemrt4Oks3aUAhhkdikgA=;
        b=IeXW9Ek8IIWzbRkroTSuaubhFbW+FB8nYXCtlIy26K7MVDvhCdpSfLETg8Si9wMve2
         UiHxMDhpjR9Dl0QaCK8Ds1kdIqYaTlWqA+xmfPOpbrCMXauCY5Y+ai7GExkl/HfSa311
         KOX/CueF5MxQbOZroE0U02KBQDrTdv15TAd1Cm8PjniDcK3eEOBwOAQzYCvT4NDKSpR3
         1eH+b20qtF0OAJKVSaBsZzr3MynnY33jR1dntOVJntwWWxuPUHmeL01TxDRViqbSGhcV
         HE1vNcxhg8Ou9tkWYURTl9jJ9ebB3ZbnuSa6UJMll1dgr5TlVS7BNVkDGlpGTQR+l1cq
         ndAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uHN7vdUXj9zg5j6BFSm9FeBemrt4Oks3aUAhhkdikgA=;
        b=jHeqMhQYG0SMTzipbI2LLI/QhFRjmV+HImnOB0ckdVs81Gn3fX1h+H+J0o1MoMQhMp
         mOvU9AS/eeOcm6NShRWKHeCUAe3sxbTa8Bq7EE87wZ0NgjDqXn24YAF6UuH43zOCpyPH
         MoRIR9dvVUezeK1fPmqIwC/DzygvUvqW3HSaueXpwx8XJOtL85Lkcpw6TWI+uGeUxRSn
         sKqz8oj7mqMR4WfP6sdxGw/ZEmomCV5vctjW+nA9TxpQ6GohQlwbnaaGBJoEWBLjx93D
         HwVkUyI7Zf902q9hEZ7sAtyjnlu2/da6cPFVxF2gCgnygEVJO4uaL0hY/SjHmEI8FvuS
         7+0A==
X-Gm-Message-State: APjAAAXIW9CsukY0Gb1jjljHHRjo7p11OrgTkQdfdHTfn+mU3UL645m3
        ALFybCDibOYqqfx155jl86RquaLOgGJ2
X-Google-Smtp-Source: APXvYqyByT20Xf2cS83FQR4XFLJ7Tfrbx1N29R/vELEta1kYPJIR+JGWxOYQELvfk6vRtBTB8wdqez/C4cDs
X-Received: by 2002:a63:2254:: with SMTP id t20mr5909022pgm.423.1581720194053;
 Fri, 14 Feb 2020 14:43:14 -0800 (PST)
Date:   Fri, 14 Feb 2020 14:43:02 -0800
Message-Id: <20200214224302.229920-1-brianvv@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH bpf] bpf: Do not grab the bucket spinlock by default on htab
 batch ops
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
 kernel/bpf/hashtab.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 2d182c4ee9d99..fdbde28b0fe06 100644
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
@@ -1379,7 +1393,10 @@ __htab_map_lookup_and_delete_batch(struct bpf_map *map,
 		dst_val += value_size;
 	}
 
-	raw_spin_unlock_irqrestore(&b->lock, flags);
+	if (locked) {
+		raw_spin_unlock_irqrestore(&b->lock, flags);
+		locked = false;
+	}
 	/* If we are not copying data, we can go to next bucket and avoid
 	 * unlocking the rcu.
 	 */
-- 
2.25.0.265.gbab2e86ba0-goog

