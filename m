Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A1C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C4B0207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="chpaM9fl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHST5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:57:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726585AbgHST5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597867020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=JDGvX0s3CfGuroZ3WjQYFXy/cRxyJCVnz+Pf0p7uSV8=;
        b=chpaM9flQOJ2t8U0f7PgxsUJpwOVdAgZVjVb8ulrpKW6wUXx0OqUcv/pECiZujPXhhGkwy
        BLyLiS9RTN8CEGyygear3/L1kmUxhCN4h7Itt0A/53JMtTV6VAbLWJ/uG9j1RE5otKz9ol
        02U6NVyMzHUHCBOtO+gJpnE8ySViY24=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-OVFynVMkPaObxO7E2QQ77Q-1; Wed, 19 Aug 2020 15:56:58 -0400
X-MC-Unique: OVFynVMkPaObxO7E2QQ77Q-1
Received: by mail-pj1-f70.google.com with SMTP id c3so281297pjr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JDGvX0s3CfGuroZ3WjQYFXy/cRxyJCVnz+Pf0p7uSV8=;
        b=PsNovsUA5I+og+bw0/ZPsd2ZW9nMFEAzDw6hdojmsUnYE+s5Fw07WhnUrJdbj+XxpA
         sQKrzLdLfkTxeV2c51u1DECsKLAp4h3J/saOhDEKW3P0YW+k/KECbQrGITjNvCK9xdvm
         h1+5unkXbDmk+ASbAemMmNvtEGjBtlQ1a2XregPjsGWNlJMRNgi+lxKTHPIGyqMGvtbS
         MI7dRybqmlh78zrY8153igBAnmssRsFRU4J9XWfRAelR6sJuaBXyy7wdnXPXvocq+XzZ
         GTOvLMoX6iiu/OW6bRWGQfoIFunlddNK+1LVstFuVtZdWqbMnRAn9BU5Ym9KGjriC+Ea
         HUfw==
X-Gm-Message-State: AOAM531g7PXBneeGMkb/CUGBpm/97Uz3MAaIWNCfhGUIOh4hzkWiDWDb
        KM7vhf0wvwV22A6s8nOTTRJH7J6TuHfGjduaB8uiTp/meCqQw0dOOV/NYpCAYwaxHJAnEa0vXhn
        dbTOrJRmhYuUN5fwc0conwfpl
X-Received: by 2002:a63:7d3:: with SMTP id 202mr32005pgh.230.1597867017031;
        Wed, 19 Aug 2020 12:56:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+3Pl230CH6ILGZIOeiNaXL82ndPKRgPsgS1lrqvcaMUejchfEYQFco8vhnakaJtiE2tTzPw==
X-Received: by 2002:a63:7d3:: with SMTP id 202mr31995pgh.230.1597867016665;
        Wed, 19 Aug 2020 12:56:56 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i39sm3906880pje.8.2020.08.19.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:56:56 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        Gao Xiang <hsiangkao@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH] mm, THP, swap: fix allocating cluster for swapfile by mistake
Date:   Thu, 20 Aug 2020 03:56:13 +0800
Message-Id: <20200819195613.24269-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWP_FS doesn't mean the device is file-backed swap device,
which just means each writeback request should go through fs
by DIO. Or it'll just use extents added by .swap_activate(),
but it also works as file-backed swap device.

So in order to achieve the goal of the original patch,
SWP_BLKDEV should be used instead.

FS corruption can be observed with SSD device + XFS +
fragmented swapfile due to CONFIG_THP_SWAP=y.

Fixes: f0eea189e8e9 ("mm, THP, swap: Don't allocate huge cluster for file backed swap device")
Fixes: 38d8b4e6bdc8 ("mm, THP, swap: delay splitting THP during swap out")
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---

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
 ... 

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

