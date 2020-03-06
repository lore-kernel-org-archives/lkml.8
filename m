Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC36C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D222070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="EJhGiho/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFDcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:32:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33293 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFDcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:32:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id p62so1097597qkb.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 19:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9qy9ZPH/ZuW3nDGvLp4/TppbAkBcCBblrVERLSwl+U=;
        b=EJhGiho/zGJgY2az9b0WdHTIY7qXZz+j33mWkGNTSGlUxM5PLj/dKfuunaUfemU3zy
         FLx1ph8Dr+v7CwiuA9ELwk2l3f2YeuqhjGS37ggRxfRoRmZOGAE6wyGYrvgcJzHokkkF
         AK3FTgTjGmG+/UkFR29SOHnqayMDuN/bKU+ITzXzsvCi3XVrlFfdxB3hD6WpesKMA5EG
         vrnVT7OKVMexWQjAKTyDxixp9qxSacYeTkpRz21RpCj8Y3ZMblXUluwW6jiav4MBIs74
         e3Qvm24rwACrQx7i//qJ//SpQT7Uy0pIObu/I2VIR7VJPbM+kRp54jjT6chwAOQNAhRo
         HSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=D9qy9ZPH/ZuW3nDGvLp4/TppbAkBcCBblrVERLSwl+U=;
        b=T3BAtpBbD2FMAbVfDxJQhMF3ekocUh+ogNm0zlWL6YZpz7dCypwJbDtL9YVwuFokGJ
         ncjWoFZCh3l3RhvG9uFhFFSqKSfmE98zpzAJYLFqMR4qPnPuRi/CfitgDUBPMnv69mWg
         cFDdrg3JxFFJk4jjyPTxzdu0HGQxKB8P0owesDYdn1VG0Rzz8OvnD9F8SExvbtPDPfTg
         AFdbx9RsgVohf7xw632f6mesvxbO4vNhrwPPKz3W1aATQXzYSimULt69te/589CUMCyE
         UDvJ/wydddoAygo1x+R8fAZOJ3rULVk/VrBeMnCXwPhwTSDqnqQ7tmk1CowWQ2rKcxaF
         t/LA==
X-Gm-Message-State: ANhLgQ0rtB0CTePbNdeaUWBsKvAz52dKpk1jIsVa/+lwV7EdVDk/v/C5
        C2mni4uwdB9H6nMrcO+RdMsg3PAuIW8u9g==
X-Google-Smtp-Source: ADFU+vtLq2w18Axg1TTXMiyaapOnfD+x7gd4g4pIRJWMWG/1lIeiNelp6AviQjmfPLdN3f3GKrU+LQ==
X-Received: by 2002:a05:620a:2209:: with SMTP id m9mr1056415qkh.71.1583465540015;
        Thu, 05 Mar 2020 19:32:20 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p126sm16957027qkd.108.2020.03.05.19.32.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 19:32:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
Date:   Thu, 5 Mar 2020 22:32:18 -0500
Cc:     aarcange@redhat.com, Alex Shi <alex.shi@linux.alibaba.com>,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>=20
>=20
> The patch titled
>     Subject: mm/vmscan: remove unnecessary lruvec adding
> has been removed from the -mm tree.  Its filename was
>     mm-vmscan-remove-unnecessary-lruvec-adding.patch
>=20
> This patch was dropped because it had testing failures

Andrew, do you have more information about this failure? I hit a bug
here under memory pressure and am wondering if this is related
which might save me some time digging=E2=80=A6

[ 4389.727184][ T6600] mem_cgroup_update_lru_size(00000000bb31aaed, 0, =
-7): lru_size -1
[ 4389.735272][ T6600] WARNING: CPU: 9 PID: 6600 at mm/memcontrol.c:1287 =
mem_cgroup_update_lru_size+0x17d/0x1b0
[ 4389.745210][ T6600] Modules linked in: nls_iso8859_1 nls_cp437 vfat =
fat kvm_amd kvm ses enclosure irqbypass dax_pmem dax_pmem_core efivars =
acpi_cpufreq efivarfs ip_tables x_tables xfs sd_mod smartpqi =
scsi_transport_sas tg3 mlx5_core libphy firmware_class dm_mirror =
dm_region_hash dm_log dm_mod
[ 4389.771620][ T6600] CPU: 9 PID: 6600 Comm: oom01 Tainted: G           =
  L    5.6.0-rc4-next-20200305+ #4
[ 4389.781209][ T6600] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[ 4389.790577][ T6600] RIP: 0010:mem_cgroup_update_lru_size+0x17d/0x1b0
[ 4389.797108][ T6600] Code: d9 c7 e5 ff 49 89 d9 45 89 e0 44 89 f1 4c =
89 ea 48 c7 c6 a0 86 81 83 48 c7 c7 9e 07 9e 83 c6 05 90 53 18 01 01 e8 =
25 a5 c8 ff <0f> 0b eb bc 48 89 de 48 c7 c7 80 e7 ce 83 e8 10 14 23 00 =
e9 e1 fe
[ 4389.816750][ T6600] RSP: 0018:ffffbf7b0adc3598 EFLAGS: 00010082
[ 4389.822793][ T6600] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: =
0000000000000000
[ 4389.830737][ T6600] RDX: 0000000000000001 RSI: 0000000000000000 RDI: =
ffffbf7b0adc341c
[ 4389.838685][ T6600] RBP: ffffbf7b0adc35d8 R08: 0000000000000000 R09: =
0000bf7b0adc341c
[ 4389.846631][ T6600] R10: 0000bf7b0adc33a8 R11: 0000bf7b0adc341f R12: =
00000000fffffff9
[ 4389.854556][ T6600] R13: ffff978a77534400 R14: 0000000000000000 R15: =
0000000000000000
[ 4389.862525][ T6600] FS:  00007f64a8f3b700(0000) =
GS:ffff979272880000(0000) knlGS:0000000000000000
[ 4389.871498][ T6600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4389.878065][ T6600] CR2: 00007f632d210000 CR3: 000000067ee08000 CR4: =
00000000003406e0
[ 4389.885986][ T6600] Call Trace:
[ 4389.889259][ T6600]  isolate_lru_pages+0x6c5/0xfd0
[ 4389.894227][ T6600]  ? __const_udelay+0x3c/0x40
[ 4389.898935][ T6600]  shrink_inactive_list+0x18a/0x860
[ 4389.904182][ T6600]  shrink_lruvec+0x5d9/0xb70
[ 4389.908736][ T6600]  ? find_held_lock+0x35/0xa0
[ 4389.913382][ T6600]  ? percpu_ref_put_many+0xdd/0x1c0
[ 4389.918579][ T6600]  shrink_node+0x2d6/0xca0
[ 4389.923032][ T6600]  do_try_to_free_pages+0x1f7/0x9a0
[ 4389.928226][ T6600]  try_to_free_pages+0x252/0x5b0
[ 4389.933112][ T6600]  __alloc_pages_slowpath+0x458/0x1290
[ 4389.938548][ T6600]  __alloc_pages_nodemask+0x3bb/0x450
[ 4389.943889][ T6600]  alloc_pages_vma+0x8a/0x2c0
[ 4389.948631][ T6600]  do_anonymous_page+0x16e/0x6f0
[ 4389.953523][ T6600]  ? __lock_acquire+0x443/0x37c0
[ 4389.958426][ T6600]  __handle_mm_fault+0xce1/0xd50
[ 4389.963415][ T6600]  handle_mm_fault+0xfc/0x2f0
[ 4389.968055][ T6600]  do_page_fault+0x263/0x6f9
[ 4389.972629][ T6600]  page_fault+0x34/0x40
[ 4389.976741][ T6600] RIP: 0033:0x411ab0
[ 4389.980600][ T6600] Code: 89 de e8 83 16 ff ff 48 83 f8 ff 0f 84 86 =
00 00 00 48 89 c5 41 83 fc 02 74 28 41 83 fc 03 74 62 e8 75 1c ff ff 31 =
d2 48 98 90 <c6> 44 15 00 07 48 01 c2 48 39 d3 7f f3 31 c0 5b 5d 41 5c =
c3 0f 1f
[ 4390.000293][ T6600] RSP: 002b:00007f64a8f3aec0 EFLAGS: 00010206
[ 4390.006320][ T6600] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: =
00007f837e05cb77
[ 4390.014254][ T6600] RDX: 00000000052d6000 RSI: 00000000c0000000 RDI: =
0000000000000000
[ 4390.022213][ T6600] RBP: 00007f6327f3a000 R08: 00000000ffffffff R09: =
0000000000000000
[ 4390.030150][ T6600] R10: 0000000000000022 R11: 0000000000000246 R12: =
0000000000000001
[ 4390.038104][ T6600] R13: 00007ffd7960ec0f R14: 0000000000000000 R15: =
00007f64a8f3afc0
[ 4390.046046][ T6600] irq event stamp: 400622
[ 4390.050376][ T6600] hardirqs last  enabled at (400621): =
[<ffffffff82b94df7>] free_unref_page_list+0x1c7/0x2b0
[ 4390.060430][ T6600] hardirqs last disabled at (400622): =
[<ffffffff832d8fbc>] _raw_spin_lock_irq+0x1c/0x60
[ 4390.070144][ T6600] softirqs last  enabled at (400510): =
[<ffffffff8360034c>] __do_softirq+0x34c/0x57c
[ 4390.079487][ T6600] softirqs last disabled at (400501): =
[<ffffffff828c68d2>] irq_exit+0xa2/0xc0
[ 4390.088394][ T6600] ---[ end trace eb6136217ea3d652 ]---
[ 4390.093976][ T6600] ------------[ cut here ]------------
[ 4390.099379][ T6600] kernel BUG at mm/memcontrol.c:1288!
[ 4390.104712][ T6600] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC =
NOPTI
[ 4390.111523][ T6600] CPU: 9 PID: 6600 Comm: oom01 Tainted: G        W  =
  L    5.6.0-rc4-next-20200305+ #4
[ 4390.121105][ T6600] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[ 4390.130485][ T6600] RIP: 0010:mem_cgroup_update_lru_size+0x13d/0x1b0
[ 4390.136987][ T6600] Code: 00 48 85 db 79 b7 48 c7 c7 78 32 db 83 e8 =
7b cd e5 ff 44 0f b6 3d db 53 18 01 41 80 ff 01 0f 87 e3 69 00 00 41 83 =
e7 01 74 0e <0f> 0b 48 c7 c7 70 e7 ce 83 e8 47 17 23 00 48 c7 c7 78 32 =
db 83 e8
[ 4390.156680][ T6600] RSP: 0018:ffffbf7b0adc3598 EFLAGS: 00010082
[ 4390.162716][ T6600] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: =
0000000000000000
[ 4390.170664][ T6600] RDX: 0000000000000001 RSI: 0000000000000000 RDI: =
ffffbf7b0adc341c
[ 4390.178598][ T6600] RBP: ffffbf7b0adc35d8 R08: 0000000000000000 R09: =
0000bf7b0adc341c
[ 4390.186551][ T6600] R10: 0000bf7b0adc33a8 R11: 0000bf7b0adc341f R12: =
00000000fffffff9
[ 4390.194468][ T6600] R13: ffff978a77534400 R14: 0000000000000000 R15: =
0000000000000000
[ 4390.202478][ T6600] FS:  00007f64a8f3b700(0000) =
GS:ffff979272880000(0000) knlGS:0000000000000000
[ 4390.211380][ T6600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4390.217923][ T6600] CR2: 00007f632d210000 CR3: 000000067ee08000 CR4: =
00000000003406e0
[ 4390.225852][ T6600] Call Trace:
[ 4390.229064][ T6600]  isolate_lru_pages+0x6c5/0xfd0
[ 4390.233926][ T6600]  ? __const_udelay+0x3c/0x40
[ 4390.238594][ T6600]  shrink_inactive_list+0x18a/0x860
[ 4390.243779][ T6600]  shrink_lruvec+0x5d9/0xb70
[ 4390.248312][ T6600]  ? find_held_lock+0x35/0xa0
[ 4390.252945][ T6600]  ? percpu_ref_put_many+0xdd/0x1c0
[ 4390.258106][ T6600]  shrink_node+0x2d6/0xca0
[ 4390.262472][ T6600]  do_try_to_free_pages+0x1f7/0x9a0
[ 4390.267627][ T6600]  try_to_free_pages+0x252/0x5b0
[ 4390.272527][ T6600]  __alloc_pages_slowpath+0x458/0x1290
[ 4390.277953][ T6600]  __alloc_pages_nodemask+0x3bb/0x450
[ 4390.283264][ T6600]  alloc_pages_vma+0x8a/0x2c0
[ 4390.287889][ T6600]  do_anonymous_page+0x16e/0x6f0
[ 4390.292760][ T6600]  ? __lock_acquire+0x443/0x37c0
[ 4390.297650][ T6600]  __handle_mm_fault+0xce1/0xd50
[ 4390.302551][ T6600]  handle_mm_fault+0xfc/0x2f0
[ 4390.307177][ T6600]  do_page_fault+0x263/0x6f9
[ 4390.311780][ T6600]  page_fault+0x34/0x40
[ 4390.315899][ T6600] RIP: 0033:0x411ab0
[ 4390.319854][ T6600] Code: 89 de e8 83 16 ff ff 48 83 f8 ff 0f 84 86 =
00 00 00 48 89 c5 41 83 fc 02 74 28 41 83 fc 03 74 62 e8 75 1c ff ff 31 =
d2 48 98 90 <c6> 44 15 00 07 48 01 c2 48 39 d3 7f f3 31 c0 5b 5d 41 5c =
c3 0f 1f
[ 4390.339502][ T6600] RSP: 002b:00007f64a8f3aec0 EFLAGS: 00010206
[ 4390.345521][ T6600] RAX: 0000000000001000 RBX: 00000000c0000000 RCX: =
00007f837e05cb77
[ 4390.353463][ T6600] RDX: 00000000052d6000 RSI: 00000000c0000000 RDI: =
0000000000000000
[ 4390.361389][ T6600] RBP: 00007f6327f3a000 R08: 00000000ffffffff R09: =
0000000000000000
[ 4390.369318][ T6600] R10: 0000000000000022 R11: 0000000000000246 R12: =
0000000000000001
[ 4390.377256][ T6600] R13: 00007ffd7960ec0f R14: 0000000000000000 R15: =
00007f64a8f3afc0
[ 4390.385241][ T6600] Modules linked in: nls_iso8859_1 nls_cp437 vfat =
fat kvm_amd kvm ses enclosure irqbypass dax_pmem dax_pmem_core efivars =
acpi_cpufreq efivarfs ip_tables x_tables xfs sd_mod smartpqi =
scsi_transport_sas tg3 mlx5_core libphy firmware_class dm_mirror =
dm_region_hash dm_log dm_mod
[ 4390.412408][ T6600] ---[ end trace eb6136217ea3d653 ]---
[ 4390.417817][ T6600] RIP: 0010:mem_cgroup_update_lru_size+0x13d/0x1b0
[ 4390.424306][ T6600] Code: 00 48 85 db 79 b7 48 c7 c7 78 32 db 83 e8 =
7b cd e5 ff 44 0f b6 3d db 53 18 01 41 80 ff 01 0f 87 e3 69 00 00 41 83 =
e7 01 74 0e <0f> 0b 48 c7 c7 70 e7 ce 83 e8 47 17 23 00 48 c7 c7 78 32 =
db 83 e8
[ 4390.443957][ T6600] RSP: 0018:ffffbf7b0adc3598 EFLAGS: 00010082
[ 4390.449975][ T6600] RAX: 0000000000000000 RBX: ffffffffffffffff RCX: =
0000000000000000
[ 4390.457930][ T6600] RDX: 0000000000000001 RSI: 0000000000000000 RDI: =
ffffbf7b0adc341c
[ 4390.465853][ T6600] RBP: ffffbf7b0adc35d8 R08: 0000000000000000 R09: =
0000bf7b0adc341c
[ 4390.473808][ T6600] R10: 0000bf7b0adc33a8 R11: 0000bf7b0adc341f R12: =
00000000fffffff9
[ 4390.481743][ T6600] R13: ffff978a77534400 R14: 0000000000000000 R15: =
0000000000000000
[ 4390.489718][ T6600] FS:  00007f64a8f3b700(0000) =
GS:ffff979272880000(0000) knlGS:0000000000000000
[ 4390.498624][ T6600] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4390.505162][ T6600] CR2: 00007f632d210000 CR3: 000000067ee08000 CR4: =
00000000003406e0
[ 4390.513086][ T6600] Kernel panic - not syncing: Fatal exception
[ 4391.870599][ T6600] Shutting down cpus with NMI
[ 4391.875212][ T6600] Kernel Offset: 0x1800000 from 0xffffffff81000000 =
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[ 4391.886841][ T6600] ---[ end Kernel panic - not syncing: Fatal =
exception ]---


>=20
> ------------------------------------------------------
> From: Alex Shi <alex.shi@linux.alibaba.com>
> Subject: mm/vmscan: remove unnecessary lruvec adding
>=20
> Patch series "per lruvec lru_lock for memcg", v9.
>=20
> A partial merge.  The first 6 patches from a 20 patch series.  Some =
code
> cleanups and minimal optimizations.
>=20
>=20
> This patch (of 6):
>=20
> We don't have to add a freeable page into lru and then remove from it.=20=

> This change saves a couple of actions and makes the moving more clear.
>=20
> The SetPageLRU needs to be kept here for list intergrity.
> Otherwise:
> #0 mave_pages_to_lru              #1 release_pages
>                                   if (put_page_testzero())
> if !put_page_testzero
>                                     !PageLRU //skip lru_lock
>                                       list_add(&page->lru,)
>   list_add(&page->lru,) //corrupt
>=20
> [akpm@linux-foundation.org: coding style fixes]
> Link: =
http://lkml.kernel.org/r/1583146830-169516-2-git-send-email-alex.shi@linux=
.alibaba.com
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Yang Shi <yang.shi@linux.alibaba.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Kirill A. Shutemov <kirill@shutemov.name>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Mike Kravetz <kravetz@us.ibm.com>
> Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>=20
> mm/vmscan.c |   32 +++++++++++++++++++++-----------
> 1 file changed, 21 insertions(+), 11 deletions(-)
>=20
> --- a/mm/vmscan.c~mm-vmscan-remove-unnecessary-lruvec-adding
> +++ a/mm/vmscan.c
> @@ -1838,26 +1838,29 @@ static unsigned noinline_for_stack move_
> 	while (!list_empty(list)) {
> 		page =3D lru_to_page(list);
> 		VM_BUG_ON_PAGE(PageLRU(page), page);
> +		list_del(&page->lru);
> 		if (unlikely(!page_evictable(page))) {
> -			list_del(&page->lru);
> 			spin_unlock_irq(&pgdat->lru_lock);
> 			putback_lru_page(page);
> 			spin_lock_irq(&pgdat->lru_lock);
> 			continue;
> 		}
> -		lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
>=20
> +		/*
> +		 * The SetPageLRU needs to be kept here for list =
intergrity.
> +		 * Otherwise:
> +		 *   #0 mave_pages_to_lru           #1 release_pages
> +		 *				    if =
(put_page_testzero())
> +		 *   if !put_page_testzero
> +		 *				      !PageLRU //skip =
lru_lock
> +		 *                                      =
list_add(&page->lru,)
> +		 *     list_add(&page->lru,) //corrupt
> +		 */
> 		SetPageLRU(page);
> -		lru =3D page_lru(page);
> -
> -		nr_pages =3D hpage_nr_pages(page);
> -		update_lru_size(lruvec, lru, page_zonenum(page), =
nr_pages);
> -		list_move(&page->lru, &lruvec->lists[lru]);
>=20
> -		if (put_page_testzero(page)) {
> +		if (unlikely(put_page_testzero(page))) {
> 			__ClearPageLRU(page);
> 			__ClearPageActive(page);
> -			del_page_from_lru_list(page, lruvec, lru);
>=20
> 			if (unlikely(PageCompound(page))) {
> 				spin_unlock_irq(&pgdat->lru_lock);
> @@ -1865,9 +1868,16 @@ static unsigned noinline_for_stack move_
> 				spin_lock_irq(&pgdat->lru_lock);
> 			} else
> 				list_add(&page->lru, &pages_to_free);
> -		} else {
> -			nr_moved +=3D nr_pages;
> +			continue;
> 		}
> +
> +		lruvec =3D mem_cgroup_page_lruvec(page, pgdat);
> +		lru =3D page_lru(page);
> +		nr_pages =3D hpage_nr_pages(page);
> +
> +		update_lru_size(lruvec, lru, page_zonenum(page), =
nr_pages);
> +		list_add(&page->lru, &lruvec->lists[lru]);
> +		nr_moved +=3D nr_pages;
> 	}
>=20
> 	/*
> _
>=20
> Patches currently in -mm which might be from =
alex.shi@linux.alibaba.com are
>=20
> ocfs2-remove-fs_ocfs2_nm.patch
> ocfs2-remove-unused-macros.patch
> ocfs2-use-ocfs2_sec_bits-in-macro.patch
> ocfs2-remove-dlm_lock_is_remote.patch
> ocfs2-remove-useless-err.patch
> mm-memcg-fold-lock_page_lru-into-commit_charge.patch
> mm-page_idle-no-unlikely-double-check-for-idle-page-counting.patch
> mm-thp-move-lru_add_page_tail-func-to-huge_memoryc.patch
> mm-thp-clean-up-lru_add_page_tail.patch
> mm-thp-narrow-lru-locking.patch
>=20

