Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961D7C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66939217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tFWWvENZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgBFNSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:18:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35464 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbgBFNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 08:18:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so5474991qki.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ij9zh2Fk/nM0oE+nmBPWJrs7hJT7Ohtzqp7VhxNOgEw=;
        b=tFWWvENZgXMeUBTPLirkGTKiJo1/9BR1r1j5bawrE7mMiFlA2ER1lgLmCOlXG04Bd+
         vDRC6QlgknoKXgQKWT6ajeaMKaWELFcccb0H499rMtSxIhn0nIN4ytrOK6g8DC1NGyTF
         PHqeOBzMwZ4DKSAWlGxdIXCuqDUQwJsmonAN7KuFkJ4g2yePx/TlxMRyzbzJd9SW/JYm
         DcuKOspROWKJHJNHx7jObKAJm7f4knoSkHrgJ8BkTsfWvadTDDc8w23EhkUuxHEXx7dR
         xWqrL326W2vZ53EZiLTJGPL/K7Z5vg+AxLg2E7rs2Ge2qgk82L//dnsTTmnDz2A2NuOc
         ISaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ij9zh2Fk/nM0oE+nmBPWJrs7hJT7Ohtzqp7VhxNOgEw=;
        b=AfbtFbuB3pSIrU0trnFAOb6cg8O44c/YkrXepF12mVvIRFCR7bAVyLx/NR4K3vaHwG
         gB+HMx/RcYRLAOQ/l6JL2rBS1czFMDQeb+ZyomRoqPgR1RsFUAbx5Fl29xUwN5Pf+e8+
         caQd9uZ71q8brZqx6O4ro8oL2ymqXYRUn1xkmQqb9M3tsTCb91vE36KThlvAuYcWUIbe
         LVj+TktRBzMG5hdJp7SJQL3cToqf0Hz/pBrdSsMMktJNwRa7DpLA7MtpD+hR22I0rUoe
         IyyEO86+yV5gcyOMcXqfDAtIJn8liq8g9HyO9hXXPEuw+C5htH45h4+LpG0GB3NYEQCO
         yMew==
X-Gm-Message-State: APjAAAX+4FUoepw75Ckb3JzqrcVHq2OuMdSwdOMmnGGccrDq3XoCH+0V
        r+bWeCKLjAy2GoV4+vOQI6jkBw==
X-Google-Smtp-Source: APXvYqw2Ul5gH3QtRlvsUnOJ9sP1jJ5Rm5F3nofsswufI0dYo9OfEyPUqnxdVPQsK4yL6w4/c+ImEA==
X-Received: by 2002:a05:620a:13fa:: with SMTP id h26mr2459891qkl.150.1580995088053;
        Thu, 06 Feb 2020 05:18:08 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id m16sm1352738qka.8.2020.02.06.05.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 05:18:07 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        jack@suse.cz, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm: fix a data race in put_page()
Date:   Thu,  6 Feb 2020 08:17:50 -0500
Message-Id: <1580995070-25139-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

page->flags could be accessed concurrently as noticied by KCSAN,

 BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page

 write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
  page_cpupid_xchg_last+0x51/0x80
  page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
  wp_page_reuse+0x3e/0xc0
  wp_page_reuse at mm/memory.c:2453
  do_wp_page+0x472/0x7b0
  do_wp_page at mm/memory.c:2798
  __handle_mm_fault+0xcb0/0xd00
  handle_pte_fault at mm/memory.c:4049
  (inlined by) __handle_mm_fault at mm/memory.c:4163
  handle_mm_fault+0xfc/0x2f0
  handle_mm_fault at mm/memory.c:4200
  do_page_fault+0x263/0x6f9
  do_user_addr_fault at arch/x86/mm/fault.c:1465
  (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
  page_fault+0x34/0x40

 read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
  put_page+0x15a/0x1f0
  page_zonenum at include/linux/mm.h:923
  (inlined by) is_zone_device_page at include/linux/mm.h:929
  (inlined by) page_is_devmap_managed at include/linux/mm.h:948
  (inlined by) put_page at include/linux/mm.h:1023
  wp_page_copy+0x571/0x930
  wp_page_copy at mm/memory.c:2615
  do_wp_page+0x107/0x7b0
  __handle_mm_fault+0xcb0/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

Both the read and write are done only with the non-exclusive mmap_sem
held. Since the read will check for specific bits (up to three bits for
now) in the flag, load tearing could in theory trigger a logic bug.

To fix it, it could introduce put_page_lockless() in those places but
that could be an overkill, and difficult to use. Thus, just add
READ_ONCE() for the read in page_zonenum() for now where it should not
affect the performance and correctness with a small trade-off that
compilers might generate less efficient optimization in some places.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..f8529aa971c0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -920,7 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
-	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
+	return (READ_ONCE(page->flags) >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-- 
1.8.3.1

