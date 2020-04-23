Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A86C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07E8020857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pPTVWSjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgDWV0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgDWVZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:25:59 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE93C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:25:59 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 20so8089432qkl.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=fiu+JQZQPXJPiEmmOEU7j08WhRdocvFkC0G/L46eb6M=;
        b=pPTVWSjx1Qpn7qlWcKfWq1kofBSQ2UNmh35HrhajVgbABD9a7JCHtYGVwB3EiG5jNx
         NxjPMZWWVWAyHSr2n78fy9ItEmjFUHJaPAEaH04PiOIf7sOfUQEVgoWn/UJb7G38pdpa
         cBYTJqNMuAt2sItHG4+s1vZQFPZFMpurKaExyB67teQcDde400Cl3cr62uKqy6x21A0S
         fN7nZtVGf1PghxlBQCcZcdDf19+u9+hmzjDrOCSoIvR6RT6MbSrR8rPnBgnd8FohV0nL
         o4cNFwcuJn/VxkY89PblrmQizDz25+M4tlz5zpo3MT6bpAG9B2gQojpxvgs8fn7THe7y
         u3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=fiu+JQZQPXJPiEmmOEU7j08WhRdocvFkC0G/L46eb6M=;
        b=j4GuclM5v9J1JnHVKdeYwwh95XTSGwz1zTTfO8TE9s+ZrA8A5dCm/xq2W+HLYXLPQC
         F8TrupgZfb19d8BDS1aU3vTV5yPbdFWtI9YFC8vmrQv/dDGHuGGCdb5/S24hoxVR+owZ
         MudkFLsIw4E0maLXRMb8pDwmmMlDISzdR88LO3z7hNrtxkwxZwonF7wDJSak3zG803YS
         h+dcB0Tf+BLdzdirl0pbJQ9Dc5UMoDasjGEjIcKOZ6+aCFKkowOjBv+cwfM5HFoln5cX
         +NaZv+0YZtr7YjdF5C5CtrDgJeDcyspoHr+lW1NUlaaqEsFxeEplkV7C9WEX7L8ZrE8/
         CBxA==
X-Gm-Message-State: AGi0PubI320catNNQrOpf0oV8eipzV8FpxY50EGgNABFajiKkbgRmvDk
        vg3kxF+9qRU4CdJ9RBsoCS1JPw==
X-Google-Smtp-Source: APiQypIZmEe7miJBn1Up9fc2o95VbbHViJKSiV+LhjwvKkZ9i2HZRtNRGPAxSJCr/I6GKmC8vds8pw==
X-Received: by 2002:a05:620a:166d:: with SMTP id d13mr5378228qko.448.1587677157915;
        Thu, 23 Apr 2020 14:25:57 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v2sm2676210qth.66.2020.04.23.14.25.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2020 14:25:57 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
Message-Id: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
Date:   Thu, 23 Apr 2020 17:25:56 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Baoquan He <bhe@redhat.com>
To:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compaction starts to crash below on linux-next today. The faulty page =
belongs to Node 0 DMA32 zone.
I=E2=80=99ll continue to narrow it down, but just want to give a headup =
in case someone could beat me to it.

Debug output from free_area_init_core()
[    0.000000] KK start page =3D ffffea0000000040, end page =3D =
ffffea0000040000, nid =3D 0 DMA
[    0.000000] KK start page =3D ffffea0000040000, end page =3D =
ffffea0004000000, nid =3D 0 DMA32
[    0.000000] KK start page =3D ffffea0004000000, end page =3D =
ffffea0012000000, nid =3D 0 NORMAL
[    0.000000] KK start page =3D ffffea0012000000, end page =3D =
ffffea0021fc0000, nid =3D 4 NORMAL

I don=E2=80=99t understand how it could end up in such a situation. =
There are several recent patches look
more related than some others.

- mm: rework free_area_init*() funcitons
https://lore.kernel.org/linux-mm/20200412194859.12663-1-rppt@kernel.org/
Could this somehow allow an invalid pfn to escape into the page =
allocator?
Especially, is it related to skip the checks in memmap_init_zone()?
https://lore.kernel.org/linux-mm/20200412194859.12663-16-rppt@kernel.org

# numactl -H
available: 8 nodes (0-7)
node 0 cpus: 0 1 16 17
node 0 size: 7951 MB
node 0 free: 4445 MB
node 1 cpus: 2 3 18 19
node 1 size: 0 MB
node 1 free: 0 MB
node 2 cpus: 4 5 20 21
node 2 size: 0 MB
node 2 free: 0 MB
node 3 cpus: 6 7 22 23
node 3 size: 0 MB
node 3 free: 0 MB
node 4 cpus: 8 9 24 25
node 4 size: 15354 MB
node 4 free: 78 MB
node 5 cpus: 10 11 26 27
node 5 size: 0 MB
node 5 free: 0 MB
node 6 cpus: 12 13 28 29
node 6 size: 0 MB
node 6 free: 0 MB
node 7 cpus: 14 15 30 31
node 7 size: 0 MB
node 7 free: 0 MB
node distances:
node   0   1   2   3   4   5   6   7=20
  0:  10  16  16  16  32  32  32  32=20
  1:  16  10  16  16  32  32  32  32=20
  2:  16  16  10  16  32  32  32  32=20
  3:  16  16  16  10  32  32  32  32=20
  4:  32  32  32  32  10  16  16  16=20
  5:  32  32  32  32  16  10  16  16=20
  6:  32  32  32  32  16  16  10  16=20
  7:  32  32  32  32  16  16  16  10

[ 6803.941550] LTP: starting swapping01 (swapping01 -i 5)
[ 6821.098489] page:ffffea0000aa0000 refcount:1 mapcount:0 =
mapping:000000002243743b index:0x0
[ 6821.107077] flags: 0x1fffe000001000(reserved)
[ 6821.111534] raw: 001fffe000001000 ffffea0000aa0008 ffffea0000aa0008 =
0000000000000000
[ 6821.119365] raw: 0000000000000000 0000000000000000 00000001ffffffff =
0000000000000000
[ 6821.127167] page dumped because: =
VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
[ 6821.135399] page_owner info is not present (never set?)
[ 6821.140717] ------------[ cut here ]------------
[ 6821.145372] kernel BUG at mm/page_alloc.c:533!
[ 6821.150075] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[ 6821.150083] irq event stamp: 10075005
[ 6821.150102] hardirqs last  enabled at (10075005): =
[<ffffffff99ea403f>] do_page_fault+0x45f/0x9d7
[ 6821.156829] CPU: 17 PID: 218 Comm: kcompactd0 Not tainted =
5.7.0-rc2-next-20200423+ #7
[ 6821.160522] hardirqs last disabled at (10075004): =
[<ffffffff99e03ed1>] trace_hardirqs_off_thunk+0x1a/0x1c
[ 6821.160535] softirqs last  enabled at (10067158): =
[<ffffffff9ac00478>] __do_softirq+0x478/0x77f
[ 6821.169366] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 =
Gen10, BIOS A40 03/09/2018
[ 6821.169378] RIP: 0010:set_pfnblock_flags_mask+0x150/0x210
[ 6821.177257] softirqs last disabled at (10067149): =
[<ffffffff99ed22a6>] irq_exit+0xd6/0xf0
[ 6821.218362] Code: 1a 49 8d 7f 38 e8 80 ee 05 00 48 8b 45 a0 48 8b 55 =
a8 48 03 50 78 49 39 d4 72 1d 48 c7 c6 80 ee ef 9a 4c 89 ef e8 70 73 fb =
ff <0f> 0b 48 c7 c7 40 50 75 9b e8 c4 09 2b 00 4c 8b 65 d0 b9 3f 00 00
[ 6821.237457] RSP: 0018:ffffc900042ff858 EFLAGS: 00010282
[ 6821.242719] RAX: 0000000000000000 RBX: 0000000000000001 RCX: =
ffffffff9a002382
[ 6821.249900] RDX: 0000000000000000 RSI: 0000000000000008 RDI: =
ffff8884535b8e6c
[ 6821.257384] RBP: ffffc900042ff8b8 R08: ffffed108a6b8459 R09: =
ffffed108a6b8459
[ 6821.264566] R10: ffff8884535c22c7 R11: ffffed108a6b8458 R12: =
000000000002a800
[ 6821.271748] R13: ffffea0000aa0000 R14: ffff88847fff3000 R15: =
ffff88847fff3040
[ 6821.278930] FS:  0000000000000000(0000) GS:ffff888453580000(0000) =
knlGS:0000000000000000
[ 6821.287318] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6821.293102] CR2: 00007fd1eb4a1000 CR3: 000000083154c000 CR4: =
00000000003406e0
[ 6821.300283] Call Trace:
[ 6821.302752]  isolate_freepages+0xb20/0x1140
[ 6821.307167]  ? isolate_freepages_block+0x730/0x730
[ 6821.311993]  ? mark_held_locks+0x34/0xb0
[ 6821.315942]  ? free_unref_page+0x7d/0x90
[ 6821.319891]  ? free_unref_page+0x7d/0x90
[ 6821.323842]  ? check_flags.part.28+0x86/0x220
[ 6821.328234]  compaction_alloc+0xdd/0x100
[ 6821.332401]  migrate_pages+0x304/0x17e0
[ 6821.336277]  ? __ClearPageMovable+0x100/0x100
[ 6821.340674]  ? isolate_freepages+0x1140/0x1140
[ 6821.345153]  compact_zone+0x1249/0x1e90
[ 6821.349020]  ? compaction_suitable+0x260/0x260
[ 6821.353494]  kcompactd_do_work+0x231/0x650
[ 6821.357873]  ? sysfs_compact_node+0x80/0x80
[ 6821.362088]  ? finish_wait+0xe6/0x110
[ 6821.365775]  kcompactd+0x162/0x490
[ 6821.369202]  ? kcompactd_do_work+0x650/0x650
[ 6821.373501]  ? finish_wait+0x110/0x110
[ 6821.377280]  ? __kasan_check_read+0x11/0x20
[ 6821.381693]  ? __kthread_parkme+0xd4/0xf0
[ 6821.385729]  ? kcompactd_do_work+0x650/0x650
[ 6821.390027]  kthread+0x1f7/0x220
[ 6821.393280]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[ 6821.398369]  ret_from_fork+0x27/0x50
[ 6821.401968] Modules linked in: brd vfat fat ext4 crc16 mbcache jbd2 =
loop kvm_amd ses kvm enclosure dax_pmem dax_pmem_core irqbypass =
acpi_cpufreq ip_tables x_tables xfs sd_mod smartpqi scsi_transport_sas =
tg3 firmware_class libphy dm_mirror dm_region_hash dm_log dm_mod
[ 6821.426127] ---[ end trace 9783087562801ccf ]---
[ 6821.430800] RIP: 0010:set_pfnblock_flags_mask+0x150/0x210
[ 6821.436410] Code: 1a 49 8d 7f 38 e8 80 ee 05 00 48 8b 45 a0 48 8b 55 =
a8 48 03 50 78 49 39 d4 72 1d 48 c7 c6 80 ee ef 9a 4c 89 ef e8 70 73 fb =
ff <0f> 0b 48 c7 c7 40 50 75 9b e8 c4 09 2b 00 4c 8b 65 d0 b9 3f 00 00
[ 6821.455319] RSP: 0018:ffffc900042ff858 EFLAGS: 00010282
[ 6821.460863] RAX: 0000000000000000 RBX: 0000000000000001 RCX: =
ffffffff9a002382
[ 6821.468063] RDX: 0000000000000000 RSI: 0000000000000008 RDI: =
ffff8884535b8e6c
[ 6821.475245] RBP: ffffc900042ff8b8 R08: ffffed108a6b8459 R09: =
ffffed108a6b8459
[ 6821.482675] R10: ffff8884535c22c7 R11: ffffed108a6b8458 R12: =
000000000002a800
[ 6821.489877] R13: ffffea0000aa0000 R14: ffff88847fff3000 R15: =
ffff88847fff3040
[ 6821.497062] FS:  0000000000000000(0000) GS:ffff888453580000(0000) =
knlGS:0000000000000000
[ 6821.505218] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6821.511284] CR2: 00007fd1eb4a1000 CR3: 000000083154c000 CR4: =
00000000003406e0
[ 6821.518487] Kernel panic - not syncing: Fatal exception
[ 6821.523876] Kernel Offset: 0x18e00000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 6821.534915] ---[ end Kernel panic - not syncing: Fatal exception ]---=
