Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AD6C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE223214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 03:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qZj/hBcH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBFD52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 22:57:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40520 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgBFD52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 22:57:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id v25so3466014qto.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 19:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10h8LQaszZB8kto067/5O+pOylX9gdI2ZGKY//hP60E=;
        b=qZj/hBcH6OWOuaGct5p6Y2Notbh9zBt7vVs3FVwzP3j+2Z9bLfgWmQCKCYwR4BbAiv
         dLIux0vXieJvfkWXeys8zi32OPYVJAXGljHpxuh4N+scc8wKvUuskr/s6VcXor+JZIUw
         7RvIgKfFpUyaU2wY0cWk4dEwGwp9u8I5p9bbLT5Ls4Jug/b+WRfWSWqBECtBrjTW4E10
         GoenGwm3uEUiYdCDfrehN6OXEeSUg0TJPEFf7g4foLx263gBdWQvDFjPpIKB4MbL63NX
         k3kHyTs5aG2tpFR8/oNkvsqGTHjuazMAAoRFXSdgS0CX3cOvFAPRRG72qLGHTfICnA7q
         4TmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=10h8LQaszZB8kto067/5O+pOylX9gdI2ZGKY//hP60E=;
        b=mWaSOgz5KnsjPRsVFF8KP0HgYMryefNDbr+fo5qCJCe2Fp3NFQ42Pf8slkraw46Nt5
         EcQdR+7QH2EFME1EkJhi45G7x5/hSkO+urfMjltfDV7vqYZuS89Y19y39Vci8pYopzUi
         EZ24EFhKCmGo+Tt0tBmUw2Qw/WQYyoskfTIbbYVHDLngtBwrdf4j1hGxRQiwSax/uvkx
         zkcXQDfe8XXhqMghTmYqrvgh2co0JPL7J/ptyHnLITMCM+I16vmqKWf1M9PLusB+wcAf
         Usla7yfdrRzSmAgZUYIlY8V+/41ZSGdf1XixbRHRB773LUjD+110cnZ9zHQsgX/qIPwe
         fLiA==
X-Gm-Message-State: APjAAAWfQX4xuj8m//LF1WGYN0gaNPM1u0SEmM+WHgmN/ng2gHO0/2+T
        3OFZqm7FVMwhnjR2ezyzv2MeFQ==
X-Google-Smtp-Source: APXvYqxX2KBwvRMGi4GbDdPvkhD/vtXv0C6Yr0n5rcNCNWMyAEjX/JOzWnup5AhhrzNCzv0UdKROGw==
X-Received: by 2002:aed:2510:: with SMTP id v16mr963492qtc.306.1580961447045;
        Wed, 05 Feb 2020 19:57:27 -0800 (PST)
Received: from ovpn-120-236.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i13sm837545qkk.78.2020.02.05.19.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Feb 2020 19:57:26 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/page_io: mark an intentional data race
Date:   Wed,  5 Feb 2020 22:56:54 -0500
Message-Id: <20200206035654.2647-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct swap_info_struct si.flags could be accessed concurrently as
noticed by KCSAN,

 BUG: KCSAN: data-race in scan_swap_map_slots / swap_readpage

 write to 0xffff9c77b80ac400 of 8 bytes by task 91325 on cpu 16:
  scan_swap_map_slots+0x6fe/0xb50
  scan_swap_map_slots at mm/swapfile.c:887
  get_swap_pages+0x39d/0x5c0
  get_swap_page+0x377/0x524
  add_to_swap+0xe4/0x1c0
  shrink_page_list+0x1740/0x2820
  shrink_inactive_list+0x316/0x8b0
  shrink_lruvec+0x8dc/0x1380
  shrink_node+0x317/0xd80
  do_try_to_free_pages+0x1f7/0xa10
  try_to_free_pages+0x26c/0x5e0
  __alloc_pages_slowpath+0x458/0x1290
  __alloc_pages_nodemask+0x3bb/0x450
  alloc_pages_vma+0x8a/0x2c0
  do_anonymous_page+0x170/0x700
  __handle_mm_fault+0xc9f/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffff9c77b80ac400 of 8 bytes by task 5422 on cpu 7:
  swap_readpage+0x204/0x6a0
  swap_readpage at mm/page_io.c:380
  read_swap_cache_async+0xa2/0xb0
  swapin_readahead+0x6a0/0x890
  do_swap_page+0x465/0xeb0
  __handle_mm_fault+0xc7a/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 7 PID: 5422 Comm: gmain Tainted: G        W  O L 5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

The write is under &si->lock, but the read is done as lockless. Since
the read only check for a specific bit in the flag, it is harmless even
if load tearing happens. Thus, just mark it as an intentional data race
using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/page_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 76965be1d40e..e33925b9178c 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -377,7 +377,7 @@ int swap_readpage(struct page *page, bool synchronous)
 		goto out;
 	}
 
-	if (sis->flags & SWP_FS) {
+	if (data_race(sis->flags & SWP_FS)) {
 		struct file *swap_file = sis->swap_file;
 		struct address_space *mapping = swap_file->f_mapping;
 
-- 
2.21.0 (Apple Git-122.2)

