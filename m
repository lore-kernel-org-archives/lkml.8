Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9869C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A54321D56
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 00:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pbwHjYC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgCKAAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 20:00:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37626 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCKAAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 20:00:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id l20so317199qtp.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 17:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LrB/QDB8/+9bMeHbl1G5SHGJAWHX7k/1TXkj1uMy8U=;
        b=pbwHjYC6HIZiGsiNaSQogQyA8mwPFjrSsCN/p9MqJR5r4PIE+X+600DpIax/EpnnMD
         owUdmxNGULtRKav7JAzvOxDo+e214//K51jHYQ+1r/wJi4qkaGagA80V4MbFb1z4XDre
         TSsUpCq5w1gq9118Vy4P0pglXDMHE9W9jLFtX+iUs7wC3/wZwiNR0pc6VwbwtKcuYucj
         7NTN2qBrYKdKRCxPy+nmC5Xhh5E4WPiAarBUhaQDH/vpm+JrTcxYDmbxNXojUbdJ/EHC
         0JWAiRIk+1SRppVBZPWvIVTTvRGdc2CTci6uIzm0eXci7sds6BzvDwKOHnREksVmE+xB
         pwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6LrB/QDB8/+9bMeHbl1G5SHGJAWHX7k/1TXkj1uMy8U=;
        b=tqf9ZIJ7LWeGe3jTqV8qWxAJGZwleG9JmpKMiAznZMus8AooDSBYOtR+pClJo+VRad
         SeEhfSb3VyufQkITg6HIOdpDSAZIFY/PsH36j6ddM1q7ZHNNbFKc6rK72WUTWcOLGqux
         LllifhgCtdt8Nt6GeTc8e+9OImNLyi2feqyE4wOWYyOfZTJhhFYpBFT5HkjH0ylMeW7f
         GehEG6EsK1HvRY7oGVW9qstOP8CdDNwvWddf5e2XAwNHjDZ8IdpclRkeEg4AmcivsC3D
         mn1FUmgm8PldSYMtDhcn6l+BcKZdPbGco6fYCbwVyzVv5C3/SH6YAGAbKF+rnr4S+QnE
         W+aA==
X-Gm-Message-State: ANhLgQ3s0lHl86FSgZ2/ZJCj202WOfufFrJfusNjuWtw+orKQ1WvlRfJ
        R/J1IdpVvwe8mKdubo2TevkkXQ==
X-Google-Smtp-Source: ADFU+vtdB+LdcSVR1g0nETbAZ5AkLI725z4xGiRbhfDsBZb6WqkxKXfMOcA/1mJnXQLZLw5g0L9XYg==
X-Received: by 2002:ac8:41c9:: with SMTP id o9mr422919qtm.156.1583884810848;
        Tue, 10 Mar 2020 17:00:10 -0700 (PDT)
Received: from ovpn-121-75.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id r29sm3431503qtj.76.2020.03.10.17.00.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 17:00:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     ying.huang@intel.com, kirill.shutemov@linux.intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>, stable@vger.kernel.org
Subject: [PATCH] page-flags: fix a crash at SetPageError(THP_SWAP)
Date:   Tue, 10 Mar 2020 19:58:46 -0400
Message-Id: <20200310235846.1319-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
swapped out") supported writing THP to a swap device but forgot to
upgrade an older commit df8c94d13c7e ("page-flags: define behavior of
FS/IO-related flags on compound pages") which could trigger a crash
during THP swapping out with DEBUG_VM_PGFLAGS=y,

kernel BUG at include/linux/page-flags.h:317!

page dumped because: VM_BUG_ON_PAGE(1 && PageCompound(page))
page:fffff3b2ec3a8000 refcount:512 mapcount:0 mapping:000000009eb0338c
index:0x7f6e58200 head:fffff3b2ec3a8000 order:9 compound_mapcount:0
compound_pincount:0
anon flags:
0x45fffe0000d8454(uptodate|lru|workingset|owner_priv_1|writeback|head|reclaim|swapbacked)

end_swap_bio_write()
  SetPageError(page)
    VM_BUG_ON_PAGE(1 && PageCompound(page))

<IRQ>
bio_endio+0x297/0x560
dec_pending+0x218/0x430 [dm_mod]
clone_endio+0xe4/0x2c0 [dm_mod]
bio_endio+0x297/0x560
blk_update_request+0x201/0x920
scsi_end_request+0x6b/0x4b0
scsi_io_completion+0x509/0x7e0
scsi_finish_command+0x1ed/0x2a0
scsi_softirq_done+0x1c9/0x1d0
__blk_mqnterrupt+0xf/0x20
</IRQ>

Fix by checking PF_NO_TAIL in those places instead.

Fixes: bd4c82c22c36 ("mm, THP, swap: delay splitting THP after swapped out")
Cc: <stable@vger.kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/page-flags.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1bf83c8fcaa7..77de28bfefb0 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -311,7 +311,7 @@ static inline int TestClearPage##uname(struct page *page) { return 0; }
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
 PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
-PAGEFLAG(Error, error, PF_NO_COMPOUND) TESTCLEARFLAG(Error, error, PF_NO_COMPOUND)
+PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
 	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
 	__SETPAGEFLAG(Referenced, referenced, PF_HEAD)
-- 
2.21.0 (Apple Git-122.2)

