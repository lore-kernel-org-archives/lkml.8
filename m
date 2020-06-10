Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E878C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A9A20734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 05:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="OCU+XXFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgFJFWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgFJFWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 01:22:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DE4C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 22:22:22 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q14so821643qtr.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 22:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QdWS47TQ1Szf9UCQ4isLDh5BjiBexfLw+qwLr2MzEw=;
        b=OCU+XXFzrS4ai50Np9aZhbn19RNc2bnShkVkV8MLxQN2uJDPsqKuyNIhYPoQ/I05Bf
         LjboC7mC14jw+qhwG/PPPOPqYFy6HRRaWoVYVlQ2NlVwSrzUAChOoG3tIZYdLp5HKxyy
         fUGwtp2o++EXckki0Z9sOJmealnfizMwTbSOxuc2R7yVi5ImeS5/e8rVkwyJLyN5QfnG
         86xNL+QfjOlAwiR8X9DUiDipaWoC+txwyqfLAg6ViaRZ38jH87M7LHzvswhNwprkM1U3
         Z/ru0cpVetqQ6RC+AnQqfNuLt3gW8i77xxokKTz2DZ63qtHuBEiQMkJuyhkhXdoXlqp8
         3L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8QdWS47TQ1Szf9UCQ4isLDh5BjiBexfLw+qwLr2MzEw=;
        b=Whm2QDng1zbGqs+GugpVSm8sC5JlV+khalyDjkoSFC8yjYa8RUkgX1n6h/svYnEsbO
         UpEiD7rNkGCN61afzNWiqqekqP9LhlSfVq2S1u1zOsRKKL7vkE3VnxeF9GAYBsMlcKWm
         MFHVnhBL+AMxoNU8sB4dibvn6v1N42IevOvO2EWjQ98VBYmtWUotXCwKPaRY6DSq+252
         Hw4GgJxQ2YfPPoWQMYe8mKcQYnwpnoSpCEt102v2PKV5VmNA9u03dcX6GWEXFtHwsKzF
         CzuUEep93SWf9uhuLnK8ZReA6i7MckqFHvevmVbfZwdKm3Ad6RwyF7jKCfRjLjHapBbi
         JCmw==
X-Gm-Message-State: AOAM532VtsHI4ALi8YhW+fSrBLqjbCA8Oxi1XSiKqoOKZyYhgndIVHH/
        kV2ioNxZuc0mz3ym0DG1zi8uIA==
X-Google-Smtp-Source: ABdhPJxu0jgXyK9IXjFAr7eI3aNQFUTA7yhVo6Cz+97MafAvWUnd3xNTF/6D8+pFUXvnePGcNvWKrQ==
X-Received: by 2002:ac8:1892:: with SMTP id s18mr1471482qtj.306.1591766541396;
        Tue, 09 Jun 2020 22:22:21 -0700 (PDT)
Received: from ovpn-113-201.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d23sm11831827qtn.38.2020.06.09.22.22.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 22:22:20 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     borntraeger@de.ibm.com, glider@google.com, keescook@chromium.org,
        dvyukov@google.com, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/page_alloc: silence a KASAN false positive
Date:   Wed, 10 Jun 2020 01:21:54 -0400
Message-Id: <20200610052154.5180-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel_init_free_pages() will use memset() on s390 to clear all pages
from kmalloc_order() which will override KASAN redzones because a
redzone was setup from the end of the allocation size to the end of the
last page. Silence it by not reporting it there. An example of the
report is,

 BUG: KASAN: slab-out-of-bounds in __free_pages_ok
 Write of size 4096 at addr 000000014beaa000
 Call Trace:
 show_stack+0x152/0x210
 dump_stack+0x1f8/0x248
 print_address_description.isra.13+0x5e/0x4d0
 kasan_report+0x130/0x178
 check_memory_region+0x190/0x218
 memset+0x34/0x60
 __free_pages_ok+0x894/0x12f0
 kfree+0x4f2/0x5e0
 unpack_to_rootfs+0x60e/0x650
 populate_rootfs+0x56/0x358
 do_one_initcall+0x1f4/0xa20
 kernel_init_freeable+0x758/0x7e8
 kernel_init+0x1c/0x170
 ret_from_fork+0x24/0x28
 Memory state around the buggy address:
 000000014bea9f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 000000014bea9f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>000000014beaa000: 03 fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
                    ^
 000000014beaa080: fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe fe
 000000014beaa100: fe fe fe fe fe fe fe fe fe fe fe fe fe fe

Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 727751219003..9954973f89a3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1164,8 +1164,11 @@ static void kernel_init_free_pages(struct page *page, int numpages)
 {
 	int i;
 
+	/* s390's use of memset() could override KASAN redzones. */
+	kasan_disable_current();
 	for (i = 0; i < numpages; i++)
 		clear_highpage(page + i);
+	kasan_enable_current();
 }
 
 static __always_inline bool free_pages_prepare(struct page *page,
-- 
2.21.0 (Apple Git-122.2)

