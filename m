Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54970C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B31420786
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zb7Txy+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgHTEyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:54:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50625 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725772AbgHTEyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597899250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5+VTUkZxM5oNmypKkhPEwWwEokFyqkG+NZrtkR/m294=;
        b=Zb7Txy+fp+vxslDJ6GB8hwDM3iZgxSi05FGUTnVz5kSJQidCogqbbWi67M7al43pBJbjzH
        bSW6vqhr+wURzZa83Mhh8W4wSfLetn8Gftsgsefn0cuVuileGEJabfkc0W68iqTSSGRuvs
        BMwaYX0P+IPhWRA1muhs26Q4moBD1EU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-60R8k3HFNHiNfGm_uPeHsg-1; Thu, 20 Aug 2020 00:54:08 -0400
X-MC-Unique: 60R8k3HFNHiNfGm_uPeHsg-1
Received: by mail-pg1-f198.google.com with SMTP id h36so541028pgl.14
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5+VTUkZxM5oNmypKkhPEwWwEokFyqkG+NZrtkR/m294=;
        b=W5CWBR2VRSh9BoxVZSS2MDe/eCIBFzJb6eRk1WqZfUhX0wDAWqVsPVQo3UJZlbRZJM
         aXfXxCYxEfKcqoX3D/EnQObg0L3ISdd5khSUYb8z4h9i/KOMLEnFTfyPcZyAg7lss8jo
         A22CK9EGOl/xQBBP2eb4LIRspC3mZ8LE9ZKxoZC0EIJeyDUl6hvBFVo726shx0vQ/2dK
         X+CZ7z7eCp+uSuVGOS8cXLGrJteqGOdxoRkTEWvdta26oYPUEPRYsMZba6khSq2y7hxD
         OR+nKwfXWpLRwi3UA8h0cArer/zPhTb8VHi43h3zctn8N2SzoOazkRSeICJc2EBskFvr
         YbIA==
X-Gm-Message-State: AOAM531v7JrsIOuAB4dbGHveL8+8dDVTus46uSAgL9tueodS2bP3Z87j
        bdjNyg1dosMbxQHl7+GagoNNq/K5F1oRgmMPcF/nUdGmfUOvKz2v9qpFWf002iptlolI2J8S/tw
        ngfMs6qi/7VlveaL0VfiXKLAV
X-Received: by 2002:a62:5a87:: with SMTP id o129mr954888pfb.204.1597899247837;
        Wed, 19 Aug 2020 21:54:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+eEuz/lXHLcXBgHgYxHWdcGo0cQru9Km40vz5Mcw+NKZD7EVUPE35k7tZi3N+gJsdzQjD7g==
X-Received: by 2002:a62:5a87:: with SMTP id o129mr954876pfb.204.1597899247575;
        Wed, 19 Aug 2020 21:54:07 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id q16sm1017900pfg.153.2020.08.19.21.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 21:54:07 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Rafael Aquini <aquini@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH v2] mm, THP, swap: fix allocating cluster for swapfile by mistake
Date:   Thu, 20 Aug 2020 12:53:23 +0800
Message-Id: <20200820045323.7809-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWP_FS is used to make swap_{read,write}page() go through
the filesystem, and it's only used for swap files over
NFS. So, !SWP_FS means non NFS for now, it could be either
file backed or device backed. Something similar goes with
legacy SWP_FILE.

So in order to achieve the goal of the original patch,
SWP_BLKDEV should be used instead.

FS corruption can be observed with SSD device + XFS +
fragmented swapfile due to CONFIG_THP_SWAP=y.

I reproduced the issue with the following details:

Environment:
QEMU + upstream kernel + buildroot + NVMe (2 GB)

Kernel config:
CONFIG_BLK_DEV_NVME=y
CONFIG_THP_SWAP=y

Some reproducable steps:
mkfs.xfs -f /dev/nvme0n1
mkdir /tmp/mnt
mount /dev/nvme0n1 /tmp/mnt
bs="32k"
sz="1024m"    # doesn't matter too much, I also tried 16m
xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
xfs_io -f -c "pwrite -F -S 0 -b $bs 0 $sz" -c "fdatasync" /tmp/mnt/sw
xfs_io -f -c "pwrite -R -b $bs 0 $sz" -c "fsync" /tmp/mnt/sw

mkswap /tmp/mnt/sw
swapon /tmp/mnt/sw

stress --vm 2 --vm-bytes 600M   # doesn't matter too much as well

Symptoms:
 - FS corruption (e.g. checksum failure)
 - memory corruption at: 0xd2808010
 - segfault

Fixes: f0eea189e8e9 ("mm, THP, swap: Don't allocate huge cluster for file backed swap device")
Fixes: 38d8b4e6bdc8 ("mm, THP, swap: delay splitting THP during swap out")
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: Yang Shi <yang.shi@linux.alibaba.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
v1: https://lore.kernel.org/r/20200819195613.24269-1-hsiangkao@redhat.com

changes since v1:
 - improve commit message description

Hi Andrew,
Kindly consider this one instead if no other concerns...

Thanks,
Gao Xiang

 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6c26916e95fd..2937daf3ca02 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1074,7 +1074,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 			goto nextsi;
 		}
 		if (size == SWAPFILE_CLUSTER) {
-			if (!(si->flags & SWP_FS))
+			if (si->flags & SWP_BLKDEV)
 				n_ret = swap_alloc_cluster(si, swp_entries);
 		} else
 			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
-- 
2.18.1

