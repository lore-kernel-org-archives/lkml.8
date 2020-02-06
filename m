Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC2C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5CD20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bAGKJFAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBFDwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:52:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34802 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBFDwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:52:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id g3so4248109qka.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 19:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Htl2QyOrnt7Rw22eVBkqGfdWYswdzSpMTMzVm1sOS8=;
        b=bAGKJFAOQVqic3EBF5r+8D09nAddX4/Tz+XBzSjQ8ykw/JH4+zly5hm9xkrAZAfZ87
         Ecrwt8irdqym4sp9pb3iYx7+c86/FbvmREtTJeuSbH6P+PK4kDrG5aXe1Eixenq6p/oD
         g8mzhdHbcW/rcERdIzSTOlklowx15/J3l6sK5EE0xRQ8m/ZuP3BRUUVXUYI4rMnU7J4Z
         6oq3PI8+O4VNhWEpDjdftK5TXhimkFytJy8j6jpGnMwWl5SnRYpGD1AlDaPKPz/r7vwL
         eXXUwaeLWussQ+Ahz9iSKn9cCpy+2OsjC2B0vvMqQ3DzcZD6BwewjH+KAfflNbLYRBNz
         DPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2Htl2QyOrnt7Rw22eVBkqGfdWYswdzSpMTMzVm1sOS8=;
        b=GPawKdKQJKl6e/2xFbW+M8k/VTYo/laPnMBS9Y4W6D5nQqbucytAeVFl+TO/saCBxd
         3YYMVsZVgsW0BdyHwb088dWuz4mqb1O7PUxRdm7VQ0YFqlGVkHBLJwxRyiQc4LkWLArj
         E3JHVXaFk5LiAjcgnHMZIiktMmMbaGcMPbkhloLbdz2cm778JgTLwI2BnPgU9wf/Td5k
         lfcPnK83hXEB7+4zLvH1DSU1eMd2t26UJwedtLdT43hEshVywumeEwe5TOo6VYSrFixr
         XWGRrwbvaJ2NSPlc+4bFEI1r32rYTtLXJQJDPWo+BzeskCej58zq4Qq7UNj3apbp3yXf
         8iFA==
X-Gm-Message-State: APjAAAWDBXhs/Jw4S7umju3lCDtEUPDp7p9JFvszxcG2ll4iiRQtdt/d
        mMOk6wOd9wposMlToAVdzaarTg==
X-Google-Smtp-Source: APXvYqxZwwYqasmvJVARgELybgCbDWHzkLevPTLgtGpbOqLsvmH6u0Ei+qu4Ccd0ewfHkuPivTPgUw==
X-Received: by 2002:ae9:e306:: with SMTP id v6mr828941qkf.162.1580961162500;
        Wed, 05 Feb 2020 19:52:42 -0800 (PST)
Received: from ovpn-120-236.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k50sm1015337qtc.90.2020.02.05.19.52.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 19:52:42 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     jhubbard@nvidia.com, ira.weiny@intel.com, dan.j.williams@intel.com,
        jack@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm: mark a intentional data race in page_zonenum()
Date:   Wed,  5 Feb 2020 22:52:35 -0500
Message-Id: <20200206035235.2537-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 07d802699528 ("mm: devmap: refactor 1-based refcounting for
ZONE_DEVICE pages") introduced a data race as page->flags could be
accessed concurrently as noticied by KCSAN,

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
held. Since the read only check for a specific bit in the flag, even if
load tearing happens, it will be harmless, so just mark it as an
intentional data races using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..cafccad584c2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -920,7 +920,7 @@ vm_fault_t finish_mkwrite_fault(struct vm_fault *vmf);
 
 static inline enum zone_type page_zonenum(const struct page *page)
 {
-	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
+	return data_race((page->flags >> ZONES_PGSHIFT) & ZONES_MASK);
 }
 
 #ifdef CONFIG_ZONE_DEVICE
-- 
2.21.0 (Apple Git-122.2)

