Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56C6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AFD520720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kAyoMBvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgBFDz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:55:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35872 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727415AbgBFDz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:55:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so3485401qto.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 19:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzLzAKpVYvs92/D3iPQiHFL/UjwHdH2pu9eS92fC1ys=;
        b=kAyoMBvWMTfqSO3rTdtl0FwCYUWk5X+h1kI3inkaU9Sggqx0Ixe6G8oXAz0KMgChcj
         CyonJNS9OBKiWuhLEfa7ROeeLTPGUD4FSFGyxrlkNVb/AZhq80yeQISV8ShE4prW73mC
         2eMu581c0PmXYblIF88ZmSaXdfxet1ZK8Z5VnI7tBxDiJtC5P7l3HVo2OtEqxfWVMsGq
         EAD272Xv8rh+48YKzRwzAWLcreYy1/6+LOKKBDx7vcnxxTIMSSbC+v8LWVVfuIdH3mTZ
         kTMnOW+U2XK92MEReaJvXtX5lge2qE+w2PE0Q5Xw0DvxeuAbAzuF7lok7ag3O7KjKZUX
         30zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzLzAKpVYvs92/D3iPQiHFL/UjwHdH2pu9eS92fC1ys=;
        b=FuwKfyRMNtMCnld6hY/pCEt5mT46NOogIOOS1oc748JywHcIBrnSceHEwKsU0EMdOs
         M4gCfto+pVy5Ozeh4ZTub1c4ZXLChcZDTTSpXzZ59JAkp5zLdApj0CbxLdU4zrz4CBP8
         SiACnuehfRXVEMWIAvpLBQyviNoa5CgVho3aUU/6KV1k0xxxvrw/hYUIVWNWFjheozss
         HEGCg6NWAwMTEbaC4k7KyUCXYx8+MIVSUlNGzXDEVAM6EwCIG0cGS1UvQzDlf+Ben/Pq
         kZzrsGVLgaMMeCND9u7Pm7RG+kxLh9r2HPE2q8qplun7bhH3EIS2XZV3uOrgmbzh+FgL
         mrDw==
X-Gm-Message-State: APjAAAXMZDHjfChXCRTnZ3Uu8imYZlHT0uyF1KoKPyX9RsqyUYBf+upJ
        HEhVzVYNt/X1s8mpvqRWzi7J7HRReAF18A==
X-Google-Smtp-Source: APXvYqyAkr91f0zPk01DKZvAzhDBAp8/Z2kYpmcUZ+EZZoaZ84e+7H5Ea1Mw2NZ/9j2WlK4bqOLhgQ==
X-Received: by 2002:aed:3f77:: with SMTP id q52mr951873qtf.248.1580961321687;
        Wed, 05 Feb 2020 19:55:21 -0800 (PST)
Received: from ovpn-120-236.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p19sm1024733qte.81.2020.02.05.19.55.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 19:55:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/swap_state: mark an intentional data race
Date:   Wed,  5 Feb 2020 22:55:16 -0500
Message-Id: <20200206035516.2593-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_cache_info.find_total could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in lookup_swap_cache / lookup_swap_cache

 write to 0xffffffff85517318 of 8 bytes by task 94138 on cpu 101:
  lookup_swap_cache+0x12e/0x460
  lookup_swap_cache at mm/swap_state.c:322
  do_swap_page+0x112/0xeb0
  __handle_mm_fault+0xc7a/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffffffff85517318 of 8 bytes by task 91655 on cpu 100:
  lookup_swap_cache+0x117/0x460
  lookup_swap_cache at mm/swap_state.c:322
  shmem_swapin_page+0xc7/0x9e0
  shmem_getpage_gfp+0x2ca/0x16c0
  shmem_fault+0xef/0x3c0
  __do_fault+0x9e/0x220
  do_fault+0x4a0/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 100 PID: 91655 Comm: systemd-journal Tainted: G        W  O L 5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

Both the read and write are done as lockless. Since INC_CACHE_INFO() is
only used for swap_cache_info.find_total and
swap_cache_info.find_success which both are information counters, even
if any of them missed a few incremental due to data races, it will be
harmless, so just mark it as an intentional data race using the
data_race() macro.

While at it, fix a checkpatch.pl warning,

WARNING: Single statement macros should not use a do {} while (0) loop

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/swap_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..b964c1391362 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -58,8 +58,8 @@ static bool enable_vma_readahead __read_mostly = true;
 #define GET_SWAP_RA_VAL(vma)					\
 	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
 
-#define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
-#define ADD_CACHE_INFO(x, nr)	do { swap_cache_info.x += (nr); } while (0)
+#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
+#define ADD_CACHE_INFO(x, nr)	(swap_cache_info.x += (nr))
 
 static struct {
 	unsigned long add_total;
-- 
2.21.0 (Apple Git-122.2)

