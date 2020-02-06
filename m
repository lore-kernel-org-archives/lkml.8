Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0CAC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F5A20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:30:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y9elrmdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbgBFSaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:30:19 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:42459 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:30:19 -0500
Received: by mail-qv1-f67.google.com with SMTP id dc14so3309682qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JL75aBY+rZk3H0gime7n0VDi14qO+XDQsjQrhb4dCCU=;
        b=Y9elrmdXu1s9jb4qNTQQZUlZo0MoZAxDXVkEZWGy5Apy1XGOSW9zfqDQo3nVJbY5fC
         YCMWsAm4hhcP6dc0XH9FWLY/AkzQRA7nzkNeIDEy6D9oa/pZVm7K6CGiitTsGu3NdOHG
         m67nOhGjy+AgB1kxy+8BFcq3maoPJuImfvyNbWQW3PmEv3O3D8bavTKDdnAvb6fj/Ks8
         eQgr6QblA/2YHlNn4V8WHhDdLThemHXeWmAms7F3a3TkmRdKS4BmdsC4PVMyyPOBfqDG
         YZUGHVwc0kH96ooz/AAA1b0yYmdmTog2EuBPMr76Aj9nrXCad4LF+Da7xt0L8lfPHC6e
         hmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JL75aBY+rZk3H0gime7n0VDi14qO+XDQsjQrhb4dCCU=;
        b=aFYXZWakS+3CeEFE0/YKV4YmEmVujMPSU5FTQv59b8hHC1rFpLq0E+rnzaAilPPVId
         kr4G4BeeDyO4GByWHapIdB0JNx2UkEy83ZPwTv+mPlA0R2NdYgNhBDV+jl9gqEev71DO
         riic9iqQR0YrYwQrbB50EcLsnkDqDdIMMkk/PFh1pnfMOS+3RvN8cLFC31XEV9LoSYC0
         vHXfHsTpb8Qi769/qJAYAIYn7g4bV2EstttbWOhswm0CVGuvk5/jx0vKLQ1WHcp2Qz1i
         IzG02yIBP6O5w6p7rAijzv2yyOnKR29eqlsugxzZiv1DwBCgNaHDiiLflcPTMiPwqr6r
         A6GA==
X-Gm-Message-State: APjAAAUcLwnO3oJRUGNd8DHJS/JOhfHYbTlRoyJWVbTzYZjLnu9C7Qv/
        SCUGfREeY/lCDxKDQp+7rPLf+w==
X-Google-Smtp-Source: APXvYqw0/Xgpcw3i5p54MgfadehdUhtQtZo43pmPlIku1IX9sHJPd9raCVM06PrDzr6VJDwPEzShbQ==
X-Received: by 2002:ad4:57c7:: with SMTP id y7mr3407811qvx.174.1581013818171;
        Thu, 06 Feb 2020 10:30:18 -0800 (PST)
Received: from Qians-MBP.fios-router (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f17sm55169qtq.19.2020.02.06.10.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 10:30:17 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, jhubbard@nvidia.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, jack@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm: mark an intentional data race in page_zonenum
Date:   Thu,  6 Feb 2020 13:30:00 -0500
Message-Id: <20200206183000.913-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
held. Since the read only check for a specific bit range (up to 3 bits)
in the flag but the write here never change those 3 bits, so load
tearing would be harmless here. Thus, just mark it as an intentional
data races using the data_race() macro which is designed for those
situations [1].

[1] https://lore.kernel.org/linux-fsdevel/CAHk-=wg5CkOEF8DTez1Qu0XTEFw_oHhxN98bDnFqbY7HL5AB2g@mail.gmail.com/

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: update the commit log.

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

