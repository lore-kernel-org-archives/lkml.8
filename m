Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA853C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB14A206F9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 02:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Vm2AdqHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbgDPCuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 22:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732153AbgDPCup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:50:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6994C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:50:43 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id np9so715731pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 19:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Q7W5ehzWsjUkkp8y3o1ZGWaS+29RuWOEbUwQ2aJUz0=;
        b=Vm2AdqHGTKxj9VJj13wnb+zAUcOswIjBK5VnhqfV2BLubluRkBk/Yc+nBulO38JAj4
         2BQkPknjITamBPQzP5jBGm3Ru1iYjGde01b8FFPjA52qCf7gwc0TH4y8q/yzW1Hsjn5l
         p5tnVTpgoiVvIFKXmaOS4z2F4u8pj4rZqLQscS5ihSDg7ZARk1Jp7G8ZT3/7Jf8i9z5U
         65M7OxyUBM5zm1NL6Mq4JVNX1BoZm2gPyiyXyUJvgN/R+rN77ZwPzRBQSB/Druq4QR9R
         pm4ERv3YpGGaNQ6yirqlwoMMsN8IOHcGgaLBHZMrF/uS1dct9PSbeytgIg7RRtqb2gEO
         iG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6Q7W5ehzWsjUkkp8y3o1ZGWaS+29RuWOEbUwQ2aJUz0=;
        b=rqBrImc5xBHJ4ZsgdRbi1775FV7mXUGf8Gt15vexwpmTDNrkNxUwiT11rAWLSQLVRq
         zxhMNI1DODSIh5xdSqq4p2cntVQUfRJgh08J1mi0wQRkvq6DATabc/7LueT0J9+GHoZy
         iG217lJv/WG69xRR054iSh/sH+AC1mvJu5ebipZQCjnuUzY3H6JLsHz56jIrAYeNSPbb
         IeNVU3SXPsvpiU3QPJ88U1YkLelIA+K16mlRYqhcIUH5BMXKazWmPSSeEr88qD+qzyFj
         mcSRdC7Rv/10V7k2mZ+lIKGaRzVJuU4VxViMZbvIN6ZOtBcfbVXzRyjEqiuoLWFZRYK3
         0U+w==
X-Gm-Message-State: AGi0PubShhYeJGKE6I4JzPWyBKb8G0+WCa939qgbZU6nx48LtpqI0fCW
        Hz0/UQ1d5q9nvKpmZnweh7CMBw==
X-Google-Smtp-Source: APiQypKXTbL28FPX0Sg4JxD6/bpaTlE9T3uuNe4w/98SvRRFZDZgHIwZeEfa/7u+hLz0lYKtnNhdew==
X-Received: by 2002:a17:90a:15d6:: with SMTP id w22mr2310413pjd.173.1587005443063;
        Wed, 15 Apr 2020 19:50:43 -0700 (PDT)
Received: from Smcdef-MBP.lan ([103.136.220.69])
        by smtp.gmail.com with ESMTPSA id o11sm8704421pgd.58.2020.04.15.19.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 19:50:42 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, Markus.Elfring@web.de, david@redhat.com,
        ktkhai@virtuozzo.com, yang.shi@linux.alibaba.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Subject: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero page is enabled
Date:   Thu, 16 Apr 2020 10:50:34 +0800
Message-Id: <20200416025034.29780-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The find_mergeable_vma can return NULL. In this case, it leads
to a crash when we access vm_mm(its offset is 0x40) later in
write_protect_page. And this case did happen on our server. The
following call trace is captured in kernel 4.19 with the following
patch applied and KSM zero page enabled on our server.

  commit e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")

So add a vma check to fix it.

--------------------------------------------------------------------------
  BUG: unable to handle kernel NULL pointer dereference at 0000000000000040
  Oops: 0000 [#1] SMP NOPTI
  CPU: 9 PID: 510 Comm: ksmd Kdump: loaded Tainted: G OE 4.19.36.bsk.9-amd64 #4.19.36.bsk.9
  RIP: 0010:try_to_merge_one_page+0xc7/0x760
  Code: 24 58 65 48 33 34 25 28 00 00 00 89 e8 0f 85 a3 06 00 00 48 83 c4
        60 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 8b 46 08 a8 01 75 b8 <49>
        8b 44 24 40 4c 8d 7c 24 20 b9 07 00 00 00 4c 89 e6 4c 89 ff 48
  RSP: 0018:ffffadbdd9fffdb0 EFLAGS: 00010246
  RAX: ffffda83ffd4be08 RBX: ffffda83ffd4be40 RCX: 0000002c6e800000
  RDX: 0000000000000000 RSI: ffffda83ffd4be40 RDI: 0000000000000000
  RBP: ffffa11939f02ec0 R08: 0000000094e1a447 R09: 00000000abe76577
  R10: 0000000000000962 R11: 0000000000004e6a R12: 0000000000000000
  R13: ffffda83b1e06380 R14: ffffa18f31f072c0 R15: ffffda83ffd4be40
  FS: 0000000000000000(0000) GS:ffffa0da43b80000(0000) knlGS:0000000000000000
  CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 0000000000000040 CR3: 0000002c77c0a003 CR4: 00000000007626e0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  PKRU: 55555554
  Call Trace:
    ? follow_page_pte+0x36d/0x5e0
    ksm_scan_thread+0x115e/0x1960
    ? remove_wait_queue+0x60/0x60
    kthread+0xf5/0x130
    ? try_to_merge_with_ksm_page+0x90/0x90
    ? kthread_create_worker_on_cpu+0x70/0x70
    ret_from_fork+0x1f/0x30
--------------------------------------------------------------------------

Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Co-developed-by: Xiongchun Duan <duanxiongchun@bytedance.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---

Change in v4:
    1. Update commit message.
    2. If the vma is out of date, just exit.

Change in v3:
    1. Update "Signed-off-by" to "Co-developed-by"
    2. Update commit message

Change in v2:
    1. Update commit message.
    2. Update patch subject from:
         "mm/ksm: Fix kernel NULL pointer dereference at 0000000000000040"
       to:
         "mm/ksm: Fix NULL pointer dereference when KSM zero page is enabled"

 mm/ksm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index a558da9e71770..15339538da299 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2112,8 +2112,15 @@ static void cmp_and_merge_page(struct page *page, struct rmap_item *rmap_item)

 		down_read(&mm->mmap_sem);
 		vma = find_mergeable_vma(mm, rmap_item->address);
-		err = try_to_merge_one_page(vma, page,
-					    ZERO_PAGE(rmap_item->address));
+		if (vma)
+			err = try_to_merge_one_page(vma, page,
+					ZERO_PAGE(rmap_item->address));
+		else
+			/**
+			 * If the vma is out of date, we do not need to
+			 * continue.
+			 */
+			err = 0;
 		up_read(&mm->mmap_sem);
 		/*
 		 * In case of failure, the page was not really empty, so we
--
2.11.0

