Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34698C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1056124650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="h1mDx4kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBMSil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:38:41 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35238 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:38:40 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so3086222qvi.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lp1o9POrIXNU9QMX0XEPjIuVPjdDiITg5CILyvIeijA=;
        b=h1mDx4kUHP8yR+BsVLaYU7T2c+hc4d5tTOh9cV9Oe+h1KBjEbv0paDaIMf5FLnvB9N
         jLZoYAwdXkeBknHk4H+5Vh/IL9Wdf9F0uleNYSHnm8BktccuWq/AX9afKFkKWRMSl087
         cqDXFyxhExAcO/20bYrl9CySsD3F2ctwlXzVSiv1vpUg6lWXO8V7/rl1msK9ORT5ra5B
         6FBlmvlHmsOp2W+FvjLnSLON2jpRoSqVUrpLGHL/fVorQFKNrzNEbhdsWiz0lZOqZY5S
         azovmAQDEKvBOBimkOTbKaBau4A06XJHWSYctWTL7zU+lE8cKesj16h9/0tNsOeGeZgA
         rdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lp1o9POrIXNU9QMX0XEPjIuVPjdDiITg5CILyvIeijA=;
        b=P4y/AoMqFx6NDPxgU2zNDUcofJRLRKQQtWktLAc6OsrgSSeiHlKjlOTr7L4s5FJpgD
         bihIGkPLneY5wNU/9wkrtPvkstJvg8otVUbTfpOL08QixcdSdY1Q2aGtQi49WH3zIg7T
         cB9ymDwQPOLVBf2I6UWzDhBRA2kDBQxuRnA9IX3weT/CHX3PVJdEPPP/fle431PDtLpy
         bcscwJISfIQbZDdrD1TopOKj8tMK04xv7odWTFtpqKJbOgd20WK8tzw7A2IbIfgmHCsL
         Qyn3haubgknqpc064fJhPjutGYga3Cd0f7Ytag63cRPtwKSyO1loDvowexAZaLVEOFU/
         duUg==
X-Gm-Message-State: APjAAAVnJ1vjjGe6tcztmHlZOmJE5AqNnYNCqwdfbmLnVXRVhnPMXUCi
        QgsKW4UkEBAbLdN7yc/BwI9fbQ==
X-Google-Smtp-Source: APXvYqy3uUn/tJTXk+CHgIMsGfhlKqqNGh9x7ixbXkGNXwp21u+b0surTJraqUiFAM6yOF73d3V4VA==
X-Received: by 2002:a0c:fe0d:: with SMTP id x13mr12869907qvr.88.1581619119671;
        Thu, 13 Feb 2020 10:38:39 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id c45sm1962116qtd.43.2020.02.13.10.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Feb 2020 10:38:39 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org
Cc:     akpm@linux-foundation.org, elver@google.com, david@redhat.com,
        jack@suse.cz, jhubbard@nvidia.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm: annotate a data race in page_zonenum()
Date:   Thu, 13 Feb 2020 13:38:09 -0500
Message-Id: <1581619089-14472-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

A page never changes its zone number. The zone number happens to be
stored in the same word as other bits which are modified, but the zone
number bits will never be modified by any other write, so it can accept
a reload of the zone bits after an intervening write and it don't need
to use READ_ONCE(). Thus, annotate this data race using
ASSERT_EXCLUSIVE_BITS() to also assert that there are no concurrent
writes to it.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: use ASSERT_EXCLUSIVE_BITS().

BTW, not sure if it is easier for Andrew with Paul to pick this up (with
Andrew's ACK), since ASSERT_EXCLUSIVE_BITS() is in -rcu tree only (or likely
tomorrow's -next tree).

 include/linux/mm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..0d70fafd055c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -920,6 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
+	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
 	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
 }
 
-- 
1.8.3.1

