Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FEFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87312073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c72Og8Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgC3OBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:01:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44169 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgC3OBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:01:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id p14so18178394lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 07:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eixWJOZHeKlNXSJy3BLwAvp5if5XKoUEUIXdIAnMrB0=;
        b=c72Og8YbBdoQYheIpP1iObEa4ckrMDfiYDgVs5yP747RqHesUl+HzINzh1uH/SNFQ5
         nY/pphj4TMmFecQvi8UBQrPztJHJOq4z7Lxmn4cPXXjdNrx+AHv/X1u+T7VuaCUIjiEt
         rGDAGqahn7xdv0zqbvIl26ySiNgP9X3Spks0G96SlUyX5RyfBCkPYXAURQ6JaA2F1pRC
         Ewa0+jxck7ldkdDEGeFmetHHC3jcUsmjobKVRFnGxlhkJJhfZQtIFW/lJIW+qWX7sW7d
         9v0SsTwKGVWiLtdvUmM5YhqDcsrJGolZmppsGLImi8KFo/wRm1sT7WV8AoQ2Y0Kcc9cM
         pmKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eixWJOZHeKlNXSJy3BLwAvp5if5XKoUEUIXdIAnMrB0=;
        b=igvu+rTg4GvODTfpY8Eu3mslLc+qV9KGYxDns2RZmM2HJYC6x4cYHO2pui+XAYnT8c
         Vtt2YuOm3QNzl3zymTx+126EXT4fVgh75DrYkaatnJKDlCeafdp1z4IoYbP9XCRa+s39
         XyXQq0Mu5kosGsWy7RYJyzBxtJpv1wrgaWgmAr5l7BFSAIBjUl2oELGgtbk8lbxpjOcv
         4+PWF6BAOjKhXktOfZpEq7sd9eSvfaq4mmCCyLe2WsjailULHQW+ED3lPZoXTtN1Xqq7
         hJ0zmpl2OIi26IC58Kxmb0UGavmkWtXPe0KLDodRhFmGqvA4bR4ri72VkSk8bWuFA685
         TZWw==
X-Gm-Message-State: AGi0PuYA6A4LMSr4X1vG764vc6FQaJDRHPF8FJooM5msw2az4+hj7bBK
        +pNNMPZL08ep26QL7jIRfuR/Ry5fnkosfPis5sENTg==
X-Google-Smtp-Source: APiQypIRZLLvIJDCX67QnHVv6UlNo+Tc+lLnZ4GvjTF9Zvi3tN0+XOiXM/wbajhhdhxyWBJuse0FxKelCHcTBIjT2bY=
X-Received: by 2002:a2e:3c08:: with SMTP id j8mr7356883lja.243.1585576898098;
 Mon, 30 Mar 2020 07:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200316205756.146666-1-mike.kravetz@oracle.com>
 <20200316205756.146666-2-mike.kravetz@oracle.com> <CA+G9fYvopJ7v2w3+8Qb+ov_Ji30=mW-DJceZfUOtHFKFMWod8Q@mail.gmail.com>
In-Reply-To: <CA+G9fYvopJ7v2w3+8Qb+ov_Ji30=mW-DJceZfUOtHFKFMWod8Q@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 30 Mar 2020 19:31:25 +0530
Message-ID: <CA+G9fYsJgZhhWLMzUxu_ZQ+THdCcJmFbHQ2ETA_YPP8M6yxOYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing synchronization
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FYI,

The device is x86_64 device running i386 kernel image.

- Naresh

On Mon, 30 Mar 2020 at 19:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On i386 running LTP hugetlb tests found kernel BUG at fs/hugetlbfs/inode.c:458
> Running Linux version 5.6.0-rc7-next-20200330
> And hugemmap test failed due to ENOMEM.
>
> steps to reproduce:
>         # cd /opt/ltp
>         # ./runltp -f hugetlb
>
> [   48.007281] ------------[ cut here ]------------
> [   48.013251] kernel BUG at fs/hugetlbfs/inode.c:458!
> [   48.018160] invalid opcode: 0000 [#1] SMP
> [   48.022180] CPU: 0 PID: 626 Comm: hugemmap01 Not tainted
> 5.6.0-rc7-next-20200330 #1
> [   48.029845] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   48.037246] EIP: remove_inode_hugepages+0x23d/0x3d0
> [   48.042117] Code: 89 f2 e8 86 2e ef ff 8b 95 4c ff ff ff 89 85 48
> ff ff ff 85 d2 0f 85 32 ff ff ff 89 d8 e8 4b b5 eb ff 84 c0 0f 84 49
> ff ff ff <0f> 0b 90 89 d8 83 c7 01 e8 c6 e6 e9 ff 0f b6 55 b0 39 fa 77
> b4 84
> [   48.060855] EAX: 00000001 EBX: f670c000 ECX: 0554f960 EDX: c4f2af87
> [   48.067111] ESI: 00000000 EDI: 00000000 EBP: f3c23f08 ESP: f3c23e24
> [   48.073368] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
> [   48.080147] CR0: 80050033 CR2: b7800000 CR3: 229ac000 CR4: 003406d0
> [   48.086403] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   48.092680] DR6: fffe0ff0 DR7: 00000400
> [   48.096508] Call Trace:
> [   48.098955]  ? link_path_walk.part.0+0x213/0x360
> [   48.103574]  ? fsnotify_destroy_marks+0x1a/0x126
> [   48.108192]  ? __inode_wait_for_writeback+0x55/0xa0
> [   48.113064]  ? var_wake_function+0x40/0x40
> [   48.117152]  hugetlbfs_evict_inode+0x16/0x40
> [   48.121416]  evict+0xa0/0x170
> [   48.124381]  iput+0x108/0x1c0
> [   48.127346]  do_unlinkat+0x166/0x260
> [   48.130915]  __ia32_sys_unlink+0x1a/0x20
> [   48.134833]  do_fast_syscall_32+0x6b/0x270
> [   48.138925]  entry_SYSENTER_32+0xa5/0xf8
> [   48.142848] EIP: 0xb7fa4cbd
> [   48.145641] Code: 0a 01 00 00 89 da 89 f3 e8 14 00 00 00 89 d3 5b
> 5e 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 90 90 51 52 55 89 e5 0f
> 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
> 8d 76
> [   48.164376] EAX: ffffffda EBX: 08069460 ECX: 0000000a EDX: 00000000
> [   48.170633] ESI: 00000000 EDI: 00000000 EBP: 00000001 ESP: bff5b58c
> [   48.176893] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
> [   48.183678] Modules linked in: x86_pkg_temp_thermal
> [   48.188579] ---[ end trace 81151001af9fe013 ]---
> [   48.193214] EIP: remove_inode_hugepages+0x23d/0x3d0
> [   48.198092] Code: 89 f2 e8 86 2e ef ff 8b 95 4c ff ff ff 89 85 48
> ff ff ff 85 d2 0f 85 32 ff ff ff 89 d8 e8 4b b5 eb ff 84 c0 0f 84 49
> ff ff ff <0f> 0b 90 89 d8 83 c7 01 e8 c6 e6 e9 ff 0f b6 55 b0 39 fa 77
> b4 84
> [   48.216839] EAX: 00000001 EBX: f670c000 ECX: 0554f960 EDX: c4f2af87
> [   48.223112] ESI: 00000000 EDI: 00000000 EBP: f3c23f08 ESP: f3c23e24
> [   48.229378] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
> [   48.236156] CR0: 80050033 CR2: b7800000 CR3: 229ac000 CR4: 003406d0
> [   48.242424] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   48.248701] DR6: fffe0ff0 DR7: 00000400
> tlb.failed -T /opt/ltp/output/LTP_RUN_ON-LTP_hugetlb.log.tconf
> LOG File: /lava-1318949/1/tests/1_ltp-hugetlb-tests/automated/linux/ltp/output/LTP_hugetlb.log
> [   48.265189] mm/pgtable-generic.c:50: bad pgd 470000e7
> FAILED COMMAND F[   48.271614] ------------[ cut here ]------------
> [   48.277555] kernel BUG at fs/hugetlbfs/inode.c:458!
> ile: /lava-13189[   48.282532] invalid opcode: 0000 [#2] SMP
> [   48.287877] CPU: 2 PID: 630 Comm: hugemmap04 Tainted: G      D
>      5.6.0-rc7-next-20200330 #1
> [   48.296905] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.2 05/23/2018
> [   48.304291] EIP: remove_inode_hugepages+0x23d/0x3d0
> [   48.309160] Code: 89 f2 e8 86 2e ef ff 8b 95 4c ff ff ff 89 85 48
> ff ff ff 85 d2 0f 85 32 ff ff ff 89 d8 e8 4b b5 eb ff 84 c0 0f 84 49
> ff ff ff <0f> 0b 90 89 d8 83 c7 01 e8 c6 e6 e9 ff 0f b6 55 b0 39 fa 77
> b4 84
> [   48.327898] EAX: 00000001 EBX: f6716000 ECX: fab2b28e EDX: f670c003
> [   48.334155] ESI: 00000000 EDI: 00000000 EBP: f3c23f08 ESP: f3c23e24
> [   48.340412] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010202
> [   48.347190] CR0: 80050033 CR2: 98000000 CR3: 22d7b000 CR4: 003406d0
> [   48.353448] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   48.359739] DR6: fffe0ff0 DR7: 00000400
> [   48.363571] Call Trace:
> [   48.366015]  ? link_path_walk.part.0+0x213/0x360
> [   48.370635]  ? fsnotify_destroy_marks+0x1a/0x126
> [   48.375252]  ? __inode_wait_for_writeback+0x55/0xa0
> [   48.380124]  ? var_wake_function+0x40/0x40
> [   48.384212]  hugetlbfs_evict_inode+0x16/0x40
> [   48.388479]  evict+0xa0/0x170
> [   48.391452]  iput+0x108/0x1c0
> [   48.394415]  do_unlinkat+0x166/0x260
> [   48.397986]  __ia32_sys_unlink+0x1a/0x20
> [   48.401903]  do_fast_syscall_32+0x6b/0x270
> [   48.405995]  entry_SYSENTER_32+0xa5/0xf8
> [   48.409918] EIP: 0xb7f60cbd
> [   48.412747] Code: 0a 01 00 00 89 da 89 f3 e8 14 00 00 00 89 d3 5b
> 5e 5d c3 8b 04 24 c3 8b 1c 24 c3 8b 34 24 c3 90 90 51 52 55 89 e5 0f
> 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
> 8d 76
> [   48.431490] EAX: ffffffda EBX: 08069480 ECX: 0000000a EDX: 00000000
> [   48.437752] ESI: 00000000 EDI: 00000000 EBP: 00000001 ESP: bf98df3c
> [   48.444014] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
> [   48.450789] Modules linked in: x86_pkg_temp_thermal
> 49/1/tests/1_ltp[   48.455835] ---[ end trace 81151001af9fe014 ]---
> [   48.461751] EIP: remove_inode_hugepages+0x23d/0x3d0
> -hugetlb-tests/a[   48.466751] Code: 89 f2 e8 86 2e ef ff 8b 95 4c ff
> ff ff 89 85 48 ff ff ff 85 d2 0f 85 32 ff ff ff 89 d8 e8 4b b5 eb ff
> 84 c0 0f 84 49 ff ff ff <0f> 0b 90 89 d8 83 c7 01 e8 c6 e6 e9 ff 0f b6
> 55 b0 39 fa 77 b4 84
> utomated/linux/l[   48.486889] EAX: 00000001 EBX: f670c000 ECX:
> 0554f960 EDX: c4f2af87
> [   48.494465] ESI: 00000000 EDI: 00000000 EBP: f3c23f08 ESP: f3c23e24
> tp/output/LTP_hu[   48.500835] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS:
> 0068 EFLAGS: 00010202
> [   48.508903] CR0: 80050033 CR2: 98000000 CR3: 22d7b000 CR4: 003406d0
> getlb.failed
> TC[   48.515234] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
> [   48.522821] DR6: fffe0ff0 DR7: 00000400
> ONF COMMAND File: /opt/ltp/output/LTP_RUN_ON-LTP_hugetlb.log.tconf
> Running tests.......
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> mem.c:814: INFO: set nr_hugepage[   48.541741]
> mm/pgtable-generic.c:50: bad pgd 308000e7
> [   48.547014] mm/pgtable-generic.c:50: bad pgd 080000e7
> s to 128
> hugemmap01.c:73: PASS:[   48.554531] mm/pgtable-generic.c:50: bad pgd 2f4000e7
> [   48.559962] mm/pgtable-generic.c:50: bad pgd 0a8000e7
> [   48.565020] mm/pgtable-generic.c:50: bad pgd 0c8000e7
> [   48.570072] mm/pgtable-generic.c:50: bad pgd 074000e7
> [   48.575123] mm/pgtable-generic.c:50: bad pgd 2fc000e7
> [   48.580177] mm/pgtable-generic.c:50: bad pgd 0a0000e7
> [   48.585230] mm/pgtable-generic.c:50: bad pgd 2f0000e7
>  call succeeded
> tst_test.c:1163: BROK: Test kil[   48.593614] mm/pgtable-generic.c:50:
> bad pgd 118000e7
> [   48.599561] mm/pgtable-generic.c:50: bad pgd 028000e7
> led by SIGSEGV![   48.604794] mm/pgtable-generic.c:50: bad pgd 2d4000e7
> [   48.611118] mm/pgtable-generic.c:50: bad pgd 13c000e7
> tst_tmpdir.c:33[   48.616260] mm/pgtable-generic.c:50: bad pgd 2cc000e7
> [   48.622651] mm/pgtable-generic.c:50: bad pgd 054000e7
> 0: WARN: tst_rmd[   48.627871] mm/pgtable-generic.c:50: bad pgd 030000e7
> [   48.634219] mm/pgtable-generic.c:50: bad pgd 050000e7
> ir: rmobj(/scrat[   48.639363] mm/pgtable-generic.c:50: bad pgd 164000e7
> ch/ltp-wqVj4yjKn5/AlcDqC) failed:
> remove(/scratch/ltp-wqVj4yjKn5/AlcDqC) failed; errno=16: EBUSY
> Summary:
> passed   1
> failed   0
> skipped  0
> warnings 0
> ts[   48.658868] mm/pgtable-generic.c:50: bad pgd 318000e7
> [   48.664680] mm/pgtable-generic.c:50: bad pgd 2e4000e7
> [   48.669784] mm/pgtable-generic.c:50: bad pgd 130000e7
> [   48.674884] mm/pgtable-generic.c:50: bad pgd 300000e7
> [   48.679971] mm/pgtable-generic.c:50: bad pgd 288000e7
> [   48.685075] mm/pgtable-generic.c:50: bad pgd 304000e7
> [   48.690146] mm/pgtable-generic.c:50: bad pgd 2c0000e7
> [   48.695250] mm/pgtable-generic.c:50: bad pgd 26c000e7
> [   48.700356] mm/pgtable-generic.c:50: bad pgd 260000e7
> [   48.705460] mm/pgtable-generic.c:50: bad pgd 060000e7
> [   48.710565] mm/pgtable-generic.c:50: bad pgd 280000e7
> [   48.715681] mm/pgtable-generic.c:50: bad pgd 258000e7
> [   48.720747] mm/pgtable-generic.c:50: bad pgd 254000e7
> [   48.725852] mm/pgtable-generic.c:50: bad pgd 2ac000e7
> [   48.730956] mm/pgtable-generic.c:50: bad pgd 2b0000e7
> [   48.736061] mm/pgtable-generic.c:50: bad pgd 270000e7
> [   48.741132] mm/pgtable-generic.c:50: bad pgd 29c000e7
> [   48.746185] mm/pgtable-generic.c:50: bad pgd 27c000e7
> [   48.751289] mm/pgtable-generic.c:50: bad pgd 2b8000e7
> [   48.756341] mm/pgtable-generic.c:50: bad pgd 2ec000e7
> [   48.761446] mm/pgtable-generic.c:50: bad pgd 278000e7
> [   48.766507] mm/pgtable-generic.c:50: bad pgd 0f8000e7
> [   48.771611] mm/pgtable-generic.c:50: bad pgd 2e8000e7
> [   48.776680] mm/pgtable-generic.c:50: bad pgd 28c000e7
> [   48.781778] mm/pgtable-generic.c:50: bad pgd 24c000e7
> [   48.786881] mm/pgtable-generic.c:50: bad pgd 10c000e7
> [   48.791988] mm/pgtable-generic.c:50: bad pgd 2b4000e7
> [   48.797040] mm/pgtable-generic.c:50: bad pgd 264000e7
> [   48.802145] mm/pgtable-generic.c:50: bad pgd 294000e7
> [   48.807213] mm/pgtable-generic.c:50: bad pgd 2a8000e7
> [   48.812257] mm/pgtable-generic.c:50: bad pgd 250000e7
> [   48.817311] mm/pgtable-generic.c:50: bad pgd 30c000e7
> [   48.822365] mm/pgtable-generic.c:50: bad pgd 284000e7
> t_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> mem.c:814: I[   48.832133] mm/pgtable-generic.c:50: bad pgd 37c000e7
> [   48.838103] mm/pgtable-generic.c:50: bad pgd 2a0000e7
> [   48.843211] mm/pgtable-generic.c:50: bad pgd 01c000e7
> [   48.848267] mm/pgtable-generic.c:50: bad pgd 374000e7
> [   48.853322] mm/pgtable-generic.c:50: bad pgd 2c4000e7
> [   48.858389] mm/pgtable-generic.c:50: bad pgd 298000e7
> [   48.863433] mm/pgtable-generic.c:50: bad pgd 378000e7
> [   48.868480] mm/pgtable-generic.c:50: bad pgd 2a4000e7
> [   48.873532] mm/pgtable-generic.c:50: bad pgd 370000e7
> [   48.878582] mm/pgtable-generic.c:50: bad pgd 2d0000e7
> [   48.883628] mm/pgtable-generic.c:50: bad pgd 23c000e7
> [   48.888681] mm/pgtable-generic.c:50: bad pgd 2f8000e7
> [   48.893734] mm/pgtable-generic.c:50: bad pgd 238000e7
> NFO: set nr_hugepages to 128
> hugemmap02.c:117: CONF: huge mmap failed to test the scenario
> mem.c:814: INFO: set nr_hugepages to 128
> Summary:
> passed   0
> failed   0
> skipp[   48.913525] mm/pgtable-generic.c:50: bad pgd 418000e7
> [   48.919156] mm/pgtable-generic.c:50: bad pgd 3fc000e7
> [   48.924258] mm/pgtable-generic.c:50: bad pgd 3d0000e7
> [   48.929334] mm/pgtable-generic.c:50: bad pgd 3f4000e7
> [   48.934404] mm/pgtable-generic.c:50: bad pgd 3d8000e7
> [   48.939475] mm/pgtable-generic.c:50: bad pgd 414000e7
> [   48.944527] mm/pgtable-generic.c:50: bad pgd 3f8000e7
> [   48.949580] mm/pgtable-generic.c:50: bad pgd 3f0000e7
> [   48.954632] mm/pgtable-generic.c:50: bad pgd 428000e7
> [   48.959741] mm/pgtable-generic.c:50: bad pgd 400000e7
> [   48.964791] mm/pgtable-generic.c:50: bad pgd 3c0000e7
> [   48.969842] mm/pgtable-generic.c:50: bad pgd 408000e7
> [   48.974897] mm/pgtable-generic.c:50: bad pgd 40c000e7
> [   48.979949] mm/pgtable-generic.c:50: bad pgd 404000e7
> [   48.985001] mm/pgtable-generic.c:50: bad pgd 3b8000e7
> [   48.990054] mm/pgtable-generic.c:50: bad pgd 3c4000e7
> [   48.995104] mm/pgtable-generic.c:50: bad pgd 3c8000e7
> [   49.000149] mm/pgtable-generic.c:50: bad pgd 3cc000e7
> [   49.005202] mm/pgtable-generic.c:50: bad pgd 3e4000e7
> [   49.010256] mm/pgtable-generic.c:50: bad pgd 3e8000e7
> [   49.015308] mm/pgtable-generic.c:50: bad pgd 3ac000e7
> [   49.020359] mm/pgtable-generic.c:50: bad pgd 420000e7
> [   49.025404] mm/pgtable-generic.c:50: bad pgd 380000e7
> [   49.030456] mm/pgtable-generic.c:50: bad pgd 388000e7
> [   49.035510] mm/pgtable-generic.c:50: bad pgd 394000e7
> [   49.040561] mm/pgtable-generic.c:50: bad pgd 3b4000e7
> [   49.045606] mm/pgtable-generic.c:50: bad pgd 3a4000e7
> [   49.050659] mm/pgtable-generic.c:50: bad pgd 3a8000e7
> [   49.055738] mm/pgtable-generic.c:50: bad pgd 39c000e7
> [   49.060789] mm/pgtable-generic.c:50: bad pgd 3bc000e7
> [   49.065835] mm/pgtable-generic.c:50: bad pgd 390000e7
> [   49.070886] mm/pgtable-generic.c:50: bad pgd 398000e7
> [   49.075930] mm/pgtable-generic.c:50: bad pgd 410000e7
> [   49.080982] mm/pgtable-generic.c:50: bad pgd 42c000e7
> [   49.086026] mm/pgtable-generic.c:50: bad pgd 3d4000e7
> [   49.091071] mm/pgtable-generic.c:50: bad pgd 3a0000e7
> [   49.096123] mm/pgtable-generic.c:50: bad pgd 3e0000e7
> [   49.101167] mm/pgtable-generic.c:50: bad pgd 41c000e7
> [   49.106219] mm/pgtable-generic.c:50: bad pgd 3b0000e7
> [   49.111274] mm/pgtable-generic.c:50: bad pgd 384000e7
> [   49.116325] mm/pgtable-generic.c:50: bad pgd 38c000e7
> [   49.121376] mm/pgtable-generic.c:50: bad pgd 3dc000e7
> ed  1
> warnings [   49.126578] hugemmap06[638]: segfault at b5c00000 ip
> 0804aaf8 sp a97fc340 error 6 in hugemmap06[8048000+20000]
> [   49.127037] hugemmap06[636]: segfault at b1400000 ip 0804aaf8 sp
> aa7fe340 error 6 in hugemmap06[8048000+20000]
> 0
> tst_test.c:11[   49.137857] hugemmap06[641]: segfault at b5c00000 ip
> 0804aaf8 sp a7ff9340 error 6 in hugemmap06[8048000+20000]
> [   49.137861] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> 18: INFO: Timeou[   49.137877] hugemmap06[635]: segfault at ab000000
> ip 0804aaf8 sp aafff340 error 6 in hugemmap06[8048000+20000]
> [   49.137879] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> [   49.137903] hugemmap06[640]: segfault at ab000000 ip 0804aaf8 sp
> a87fa340 error 6
> [   49.137905] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> [   49.137942] audit: type=1701 audit(1585561970.177:3):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=634
> comm=\"hugemmap06\" exe=\"/opt/ltp/testcases/bin/hugemmap06\" sig=11
> res=1
> [   49.137943] audit: type=1701 audit(1585561970.177:4):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=634
> comm=\"hugemmap06\" exe=\"/opt/ltp/testcases/bin/hugemmap06\" sig=11
> res=1
> [   49.137944] audit: type=1701 audit(1585561970.177:5):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=634
> comm=\"hugemmap06\" exe=\"/opt/ltp/testcases/bin/hugemmap06\" sig=11
> res=1
> [   49.147844] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> [   49.147876] audit: type=1701 audit(1585561970.186:6):
> auid=4294967295 uid=0 gid=0 ses=4294967295 subj=kernel pid=634
> comm=\"hugemmap06\" exe=\"/opt/ltp/testcases/bin/hugemmap06\" sig=11
> res=1
> [   49.148265] hugemmap06[639]: segfault at b5c00000 ip 0804aaf8 sp
> a8ffb340 error 6
> [   49.159218] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> [   49.345938] Code: 2d 24 94 06 08 8d 42 01 31 ff 89 44 24 04 8d 74
> 26 00 e8 2b f8 ff ff 83 c7 01 99 f7 7e 04 89 d3 e8 1d f8 ff ff 8b 16
> 0f af dd <88> 04 1a 39 7c 24 04 75 df 83 44 24 08 01 8b 44 24 08 39 44
> 24 0c
> t per run is 0h 15m 00s
> mem.c:8[   49.367033] mm/pgtable-generic.c:50: bad pgd 3ec000e7
> [   49.372582] mm/pgtable-generic.c:50: bad pgd 430000e7
> [   49.377635] mm/pgtable-generic.c:50: bad pgd 274000e7
> [   49.382698] mm/pgtable-generic.c:50: bad pgd 328000e7
> [   49.387773] mm/pgtable-generic.c:50: bad pgd 25c000e7
> [   49.392825] mm/pgtable-generic.c:50: bad pgd 31c000e7
> [   49.397878] mm/pgtable-generic.c:50: bad pgd 424000e7
> 14: INFO: set nr_hugepages to 128
> hugemmap04.c:72: INFO: Size of huge pages is 4096 KB
> hugemmap04.c:76: INFO: Total amount of free huge pages is 127
> hugemmap04.c:78: INFO: Max number allowed for 1 mmap file in 32-bits is 128
> hugemmap04.c:91: PASS: Succeeded mapping file using 127 pages
> tst_test.c:1163: BROK: Test killed by SIGSEGV!
> tst_tmpdir.c:330: WARN: tst_rmdir:
> rmobj(/scratch/ltp-wqVj4yjKn5/wfn6NW) failed:
> remove(/scratch/ltp-wqVj4yjKn5/wfn6NW) failed; errno=16: EBUSY
> Summary:
> passed   1
> failed   0
> skipped  0
> warnings 0
> tst_test.c:1118: INFO: Timeout per run is 0h 15m 00s
> hugemmap05.c:223: INFO: original nr_hugepages is 128
> hugemmap05.c:236: INFO: original nr_overcommit_hugepages is 0
> hugemmap05.c:89: BROK: mmap((nil),805306368,3,1,6,0) failed: ENOMEM (12)
> hugemmap05.c:180: INFO: restore nr_hugepages to 128.
> hugemmap05.c:189: INFO: restore nr_overcommit_hugepages to 0.
>
> ref:
> https://lkft.validation.linaro.org/scheduler/job/1319125#L1534
> https://lkft.validation.linaro.org/scheduler/job/1318949#L1532
>
> On Tue, 17 Mar 2020 at 02:28, Mike Kravetz <mike.kravetz@oracle.com> wrote:
> >
> > While looking at BUGs associated with invalid huge page map counts,
> > it was discovered and observed that a huge pte pointer could become
> > 'invalid' and point to another task's page table.  Consider the
> > following:
> >
> > A task takes a page fault on a shared hugetlbfs file and calls
> > huge_pte_alloc to get a ptep.  Suppose the returned ptep points to a
> > shared pmd.
> >
> > Now, another task truncates the hugetlbfs file.  As part of truncation,
> > it unmaps everyone who has the file mapped.  If the range being
> > truncated is covered by a shared pmd, huge_pmd_unshare will be called.
> > For all but the last user of the shared pmd, huge_pmd_unshare will
> > clear the pud pointing to the pmd.  If the task in the middle of the
> > page fault is not the last user, the ptep returned by huge_pte_alloc
> > now points to another task's page table or worse.  This leads to bad
> > things such as incorrect page map/reference counts or invalid memory
> > references.
> >
> > To fix, expand the use of i_mmap_rwsem as follows:
> > - i_mmap_rwsem is held in read mode whenever huge_pmd_share is called.
> >   huge_pmd_share is only called via huge_pte_alloc, so callers of
> >   huge_pte_alloc take i_mmap_rwsem before calling.  In addition, callers
> >   of huge_pte_alloc continue to hold the semaphore until finished with
> >   the ptep.
> > - i_mmap_rwsem is held in write mode whenever huge_pmd_unshare is called.
> >
> > One problem with this scheme is that it requires taking i_mmap_rwsem
> > before taking the page lock during page faults.  This is not the order
> > specified in the rest of mm code.  Handling of hugetlbfs pages is mostly
> > isolated today.  Therefore, we use this alternative locking order for
> > PageHuge() pages.
> >          mapping->i_mmap_rwsem
> >            hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> >              page->flags PG_locked (lock_page)
> >
> > To help with lock ordering issues, hugetlb_page_mapping_lock_write()
> > is introduced to write lock the i_mmap_rwsem associated with a page.
> >
> > In most cases it is easy to get address_space via vma->vm_file->f_mapping.
> > However, in the case of migration or memory errors for anon pages we do
> > not have an associated vma.  A new routine _get_hugetlb_page_mapping()
> > will use anon_vma to get address_space in these cases.
> >
> > Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> > ---
> > v2 - Fixed a hang that could be reproduced via a ltp move_pages12 caused
> >      by a bad return path in unmap_and_move_huge_page.
> >
> >  fs/hugetlbfs/inode.c    |   2 +
> >  include/linux/fs.h      |   5 ++
> >  include/linux/hugetlb.h |   8 +++
> >  mm/hugetlb.c            | 156 +++++++++++++++++++++++++++++++++++++---
> >  mm/memory-failure.c     |  29 +++++++-
> >  mm/migrate.c            |  25 ++++++-
> >  mm/rmap.c               |  17 ++++-
> >  mm/userfaultfd.c        |  11 ++-
> >  8 files changed, 234 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> > index aff8642f0c2e..ce9d354ea5c2 100644
> > --- a/fs/hugetlbfs/inode.c
> > +++ b/fs/hugetlbfs/inode.c
> > @@ -450,7 +450,9 @@ static void remove_inode_hugepages(struct inode *inode, loff_t lstart,
> >                         if (unlikely(page_mapped(page))) {
> >                                 BUG_ON(truncate_op);
> >
> > +                               mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> >                                 i_mmap_lock_write(mapping);
> > +                               mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >                                 hugetlb_vmdelete_list(&mapping->i_mmap,
> >                                         index * pages_per_huge_page(h),
> >                                         (index + 1) * pages_per_huge_page(h));
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 8c14396bf7a6..6070616f1351 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -526,6 +526,11 @@ static inline void i_mmap_lock_write(struct address_space *mapping)
> >         down_write(&mapping->i_mmap_rwsem);
> >  }
> >
> > +static inline int i_mmap_trylock_write(struct address_space *mapping)
> > +{
> > +       return down_write_trylock(&mapping->i_mmap_rwsem);
> > +}
> > +
> >  static inline void i_mmap_unlock_write(struct address_space *mapping)
> >  {
> >         up_write(&mapping->i_mmap_rwsem);
> > diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> > index b831e9fa1a26..ad96515f2a88 100644
> > --- a/include/linux/hugetlb.h
> > +++ b/include/linux/hugetlb.h
> > @@ -154,6 +154,8 @@ u32 hugetlb_fault_mutex_hash(struct address_space *mapping, pgoff_t idx);
> >
> >  pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud);
> >
> > +struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage);
> > +
> >  extern int sysctl_hugetlb_shm_group;
> >  extern struct list_head huge_boot_pages;
> >
> > @@ -196,6 +198,12 @@ static inline unsigned long hugetlb_total_pages(void)
> >         return 0;
> >  }
> >
> > +static inline struct address_space *hugetlb_page_mapping_lock_write(
> > +                                                       struct page *hpage)
> > +{
> > +       return NULL;
> > +}
> > +
> >  static inline int huge_pmd_unshare(struct mm_struct *mm, unsigned long *addr,
> >                                         pte_t *ptep)
> >  {
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index d8ebd876871d..1709fbfd6b4e 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1558,6 +1558,106 @@ int PageHeadHuge(struct page *page_head)
> >         return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
> >  }
> >
> > +/*
> > + * Find address_space associated with hugetlbfs page.
> > + * Upon entry page is locked and page 'was' mapped although mapped state
> > + * could change.  If necessary, use anon_vma to find vma and associated
> > + * address space.  The returned mapping may be stale, but it can not be
> > + * invalid as page lock (which is held) is required to destroy mapping.
> > + */
> > +static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
> > +{
> > +       struct anon_vma *anon_vma;
> > +       pgoff_t pgoff_start, pgoff_end;
> > +       struct anon_vma_chain *avc;
> > +       struct address_space *mapping = page_mapping(hpage);
> > +
> > +       /* Simple file based mapping */
> > +       if (mapping)
> > +               return mapping;
> > +
> > +       /*
> > +        * Even anonymous hugetlbfs mappings are associated with an
> > +        * underlying hugetlbfs file (see hugetlb_file_setup in mmap
> > +        * code).  Find a vma associated with the anonymous vma, and
> > +        * use the file pointer to get address_space.
> > +        */
> > +       anon_vma = page_lock_anon_vma_read(hpage);
> > +       if (!anon_vma)
> > +               return mapping;  /* NULL */
> > +
> > +       /* Use first found vma */
> > +       pgoff_start = page_to_pgoff(hpage);
> > +       pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
> > +       anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
> > +                                       pgoff_start, pgoff_end) {
> > +               struct vm_area_struct *vma = avc->vma;
> > +
> > +               mapping = vma->vm_file->f_mapping;
> > +               break;
> > +       }
> > +
> > +       anon_vma_unlock_read(anon_vma);
> > +       return mapping;
> > +}
> > +
> > +/*
> > + * Find and lock address space (mapping) in write mode.
> > + *
> > + * Upon entry, the page is locked which allows us to find the mapping
> > + * even in the case of an anon page.  However, locking order dictates
> > + * the i_mmap_rwsem be acquired BEFORE the page lock.  This is hugetlbfs
> > + * specific.  So, we first try to lock the sema while still holding the
> > + * page lock.  If this works, great!  If not, then we need to drop the
> > + * page lock and then acquire i_mmap_rwsem and reacquire page lock.  Of
> > + * course, need to revalidate state along the way.
> > + */
> > +struct address_space *hugetlb_page_mapping_lock_write(struct page *hpage)
> > +{
> > +       struct address_space *mapping, *mapping2;
> > +
> > +       mapping = _get_hugetlb_page_mapping(hpage);
> > +retry:
> > +       if (!mapping)
> > +               return mapping;
> > +
> > +       /*
> > +        * If no contention, take lock and return
> > +        */
> > +       if (i_mmap_trylock_write(mapping))
> > +               return mapping;
> > +
> > +       /*
> > +        * Must drop page lock and wait on mapping sema.
> > +        * Note:  Once page lock is dropped, mapping could become invalid.
> > +        * As a hack, increase map count until we lock page again.
> > +        */
> > +       atomic_inc(&hpage->_mapcount);
> > +       unlock_page(hpage);
> > +       i_mmap_lock_write(mapping);
> > +       lock_page(hpage);
> > +       atomic_add_negative(-1, &hpage->_mapcount);
> > +
> > +       /* verify page is still mapped */
> > +       if (!page_mapped(hpage)) {
> > +               i_mmap_unlock_write(mapping);
> > +               return NULL;
> > +       }
> > +
> > +       /*
> > +        * Get address space again and verify it is the same one
> > +        * we locked.  If not, drop lock and retry.
> > +        */
> > +       mapping2 = _get_hugetlb_page_mapping(hpage);
> > +       if (mapping2 != mapping) {
> > +               i_mmap_unlock_write(mapping);
> > +               mapping = mapping2;
> > +               goto retry;
> > +       }
> > +
> > +       return mapping;
> > +}
> > +
> >  pgoff_t __basepage_index(struct page *page)
> >  {
> >         struct page *page_head = compound_head(page);
> > @@ -3586,6 +3686,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >         int cow;
> >         struct hstate *h = hstate_vma(vma);
> >         unsigned long sz = huge_page_size(h);
> > +       struct address_space *mapping = vma->vm_file->f_mapping;
> >         struct mmu_notifier_range range;
> >         int ret = 0;
> >
> > @@ -3596,6 +3697,14 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >                                         vma->vm_start,
> >                                         vma->vm_end);
> >                 mmu_notifier_invalidate_range_start(&range);
> > +       } else {
> > +               /*
> > +                * For shared mappings i_mmap_rwsem must be held to call
> > +                * huge_pte_alloc, otherwise the returned ptep could go
> > +                * away if part of a shared pmd and another thread calls
> > +                * huge_pmd_unshare.
> > +                */
> > +               i_mmap_lock_read(mapping);
> >         }
> >
> >         for (addr = vma->vm_start; addr < vma->vm_end; addr += sz) {
> > @@ -3673,6 +3782,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
> >
> >         if (cow)
> >                 mmu_notifier_invalidate_range_end(&range);
> > +       else
> > +               i_mmap_unlock_read(mapping);
> >
> >         return ret;
> >  }
> > @@ -4121,13 +4232,15 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
> >                         };
> >
> >                         /*
> > -                        * hugetlb_fault_mutex must be dropped before
> > -                        * handling userfault.  Reacquire after handling
> > -                        * fault to make calling code simpler.
> > +                        * hugetlb_fault_mutex and i_mmap_rwsem must be
> > +                        * dropped before handling userfault.  Reacquire
> > +                        * after handling fault to make calling code simpler.
> >                          */
> >                         hash = hugetlb_fault_mutex_hash(mapping, idx);
> >                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                       i_mmap_unlock_read(mapping);
> >                         ret = handle_userfault(&vmf, VM_UFFD_MISSING);
> > +                       i_mmap_lock_read(mapping);
> >                         mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >                         goto out;
> >                 }
> > @@ -4292,6 +4405,11 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >
> >         ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
> >         if (ptep) {
> > +               /*
> > +                * Since we hold no locks, ptep could be stale.  That is
> > +                * OK as we are only making decisions based on content and
> > +                * not actually modifying content here.
> > +                */
> >                 entry = huge_ptep_get(ptep);
> >                 if (unlikely(is_hugetlb_entry_migration(entry))) {
> >                         migration_entry_wait_huge(vma, mm, ptep);
> > @@ -4305,14 +4423,29 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >                         return VM_FAULT_OOM;
> >         }
> >
> > +       /*
> > +        * Acquire i_mmap_rwsem before calling huge_pte_alloc and hold
> > +        * until finished with ptep.  This prevents huge_pmd_unshare from
> > +        * being called elsewhere and making the ptep no longer valid.
> > +        *
> > +        * ptep could have already be assigned via huge_pte_offset.  That
> > +        * is OK, as huge_pte_alloc will return the same value unless
> > +        * something has changed.
> > +        */
> >         mapping = vma->vm_file->f_mapping;
> > -       idx = vma_hugecache_offset(h, vma, haddr);
> > +       i_mmap_lock_read(mapping);
> > +       ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
> > +       if (!ptep) {
> > +               i_mmap_unlock_read(mapping);
> > +               return VM_FAULT_OOM;
> > +       }
> >
> >         /*
> >          * Serialize hugepage allocation and instantiation, so that we don't
> >          * get spurious allocation failures if two CPUs race to instantiate
> >          * the same page in the page cache.
> >          */
> > +       idx = vma_hugecache_offset(h, vma, haddr);
> >         hash = hugetlb_fault_mutex_hash(mapping, idx);
> >         mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >
> > @@ -4400,6 +4533,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >         }
> >  out_mutex:
> >         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +       i_mmap_unlock_read(mapping);
> >         /*
> >          * Generally it's safe to hold refcount during waiting page lock. But
> >          * here we just wait to defer the next page fault to avoid busy loop and
> > @@ -5080,10 +5214,12 @@ void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
> >   * Search for a shareable pmd page for hugetlb. In any case calls pmd_alloc()
> >   * and returns the corresponding pte. While this is not necessary for the
> >   * !shared pmd case because we can allocate the pmd later as well, it makes the
> > - * code much cleaner. pmd allocation is essential for the shared case because
> > - * pud has to be populated inside the same i_mmap_rwsem section - otherwise
> > - * racing tasks could either miss the sharing (see huge_pte_offset) or select a
> > - * bad pmd for sharing.
> > + * code much cleaner.
> > + *
> > + * This routine must be called with i_mmap_rwsem held in at least read mode.
> > + * For hugetlbfs, this prevents removal of any page table entries associated
> > + * with the address space.  This is important as we are setting up sharing
> > + * based on existing page table entries (mappings).
> >   */
> >  pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
> >  {
> > @@ -5100,7 +5236,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
> >         if (!vma_shareable(vma, addr))
> >                 return (pte_t *)pmd_alloc(mm, pud, addr);
> >
> > -       i_mmap_lock_read(mapping);
> >         vma_interval_tree_foreach(svma, &mapping->i_mmap, idx, idx) {
> >                 if (svma == vma)
> >                         continue;
> > @@ -5130,7 +5265,6 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
> >         spin_unlock(ptl);
> >  out:
> >         pte = (pte_t *)pmd_alloc(mm, pud, addr);
> > -       i_mmap_unlock_read(mapping);
> >         return pte;
> >  }
> >
> > @@ -5141,7 +5275,7 @@ pte_t *huge_pmd_share(struct mm_struct *mm, unsigned long addr, pud_t *pud)
> >   * indicated by page_count > 1, unmap is achieved by clearing pud and
> >   * decrementing the ref count. If count == 1, the pte page is not shared.
> >   *
> > - * called with page table lock held.
> > + * Called with page table lock held and i_mmap_rwsem held in write mode.
> >   *
> >   * returns: 1 successfully unmapped a shared pte page
> >   *         0 the underlying pte page is not shared, or it is the last user
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 41c634f45d45..1c961cd26c0b 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -954,7 +954,7 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >         enum ttu_flags ttu = TTU_IGNORE_MLOCK | TTU_IGNORE_ACCESS;
> >         struct address_space *mapping;
> >         LIST_HEAD(tokill);
> > -       bool unmap_success;
> > +       bool unmap_success = true;
> >         int kill = 1, forcekill;
> >         struct page *hpage = *hpagep;
> >         bool mlocked = PageMlocked(hpage);
> > @@ -1016,7 +1016,32 @@ static bool hwpoison_user_mappings(struct page *p, unsigned long pfn,
> >         if (kill)
> >                 collect_procs(hpage, &tokill, flags & MF_ACTION_REQUIRED);
> >
> > -       unmap_success = try_to_unmap(hpage, ttu);
> > +       if (!PageHuge(hpage)) {
> > +               unmap_success = try_to_unmap(hpage, ttu);
> > +       } else {
> > +               /*
> > +                * For hugetlb pages, try_to_unmap could potentially call
> > +                * huge_pmd_unshare.  Because of this, take semaphore in
> > +                * write mode here and set TTU_RMAP_LOCKED to indicate we
> > +                * have taken the lock at this higer level.
> > +                *
> > +                * Note that the call to hugetlb_page_mapping_lock_write
> > +                * is necessary even if mapping is already set.  It handles
> > +                * ugliness of potentially having to drop page lock to obtain
> > +                * i_mmap_rwsem.
> > +                */
> > +               mapping = hugetlb_page_mapping_lock_write(hpage);
> > +
> > +               if (mapping) {
> > +                       unmap_success = try_to_unmap(hpage,
> > +                                                    ttu|TTU_RMAP_LOCKED);
> > +                       i_mmap_unlock_write(mapping);
> > +               } else {
> > +                       pr_info("Memory failure: %#lx: could not find mapping for mapped huge page\n",
> > +                               pfn);
> > +                       unmap_success = false;
> > +               }
> > +       }
> >         if (!unmap_success)
> >                 pr_err("Memory failure: %#lx: failed to unmap page (mapcount=%d)\n",
> >                        pfn, page_mapcount(hpage));
> > diff --git a/mm/migrate.c b/mm/migrate.c
> > index 1fb90c0ef9c3..c0ec383b3c03 100644
> > --- a/mm/migrate.c
> > +++ b/mm/migrate.c
> > @@ -1294,6 +1294,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >         int page_was_mapped = 0;
> >         struct page *new_hpage;
> >         struct anon_vma *anon_vma = NULL;
> > +       struct address_space *mapping = NULL;
> >
> >         /*
> >          * Migratability of hugepages depends on architectures and their size.
> > @@ -1341,18 +1342,36 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
> >                 goto put_anon;
> >
> >         if (page_mapped(hpage)) {
> > +               /*
> > +                * try_to_unmap could potentially call huge_pmd_unshare.
> > +                * Because of this, take semaphore in write mode here and
> > +                * set TTU_RMAP_LOCKED to let lower levels know we have
> > +                * taken the lock.
> > +                */
> > +               mapping = hugetlb_page_mapping_lock_write(hpage);
> > +               if (unlikely(!mapping))
> > +                       goto unlock_put_anon;
> > +
> >                 try_to_unmap(hpage,
> > -                       TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS);
> > +                       TTU_MIGRATION|TTU_IGNORE_MLOCK|TTU_IGNORE_ACCESS|
> > +                       TTU_RMAP_LOCKED);
> >                 page_was_mapped = 1;
> > +               /*
> > +                * Leave mapping locked until after subsequent call to
> > +                * remove_migration_ptes()
> > +                */
> >         }
> >
> >         if (!page_mapped(hpage))
> >                 rc = move_to_new_page(new_hpage, hpage, mode);
> >
> > -       if (page_was_mapped)
> > +       if (page_was_mapped) {
> >                 remove_migration_ptes(hpage,
> > -                       rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
> > +                       rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, true);
> > +               i_mmap_unlock_write(mapping);
> > +       }
> >
> > +unlock_put_anon:
> >         unlock_page(new_hpage);
> >
> >  put_anon:
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 633101a57ad9..b83864763f78 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -22,9 +22,10 @@
> >   *
> >   * inode->i_mutex      (while writing or truncating, not reading or faulting)
> >   *   mm->mmap_sem
> > - *     page->flags PG_locked (lock_page)
> > + *     page->flags PG_locked (lock_page)   * (see huegtlbfs below)
> >   *       hugetlbfs_i_mmap_rwsem_key (in huge_pmd_share)
> >   *         mapping->i_mmap_rwsem
> > + *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> >   *           anon_vma->rwsem
> >   *             mm->page_table_lock or pte_lock
> >   *               pgdat->lru_lock (in mark_page_accessed, isolate_lru_page)
> > @@ -43,6 +44,11 @@
> >   * anon_vma->rwsem,mapping->i_mutex      (memory_failure, collect_procs_anon)
> >   *   ->tasklist_lock
> >   *     pte map lock
> > + *
> > + * * hugetlbfs PageHuge() pages take locks in this order:
> > + *         mapping->i_mmap_rwsem
> > + *           hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
> > + *             page->flags PG_locked (lock_page)
> >   */
> >
> >  #include <linux/mm.h>
> > @@ -1396,6 +1402,9 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >                 /*
> >                  * If sharing is possible, start and end will be adjusted
> >                  * accordingly.
> > +                *
> > +                * If called for a huge page, caller must hold i_mmap_rwsem
> > +                * in write mode as it is possible to call huge_pmd_unshare.
> >                  */
> >                 adjust_range_if_pmd_sharing_possible(vma, &range.start,
> >                                                      &range.end);
> > @@ -1443,6 +1452,12 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >                 address = pvmw.address;
> >
> >                 if (PageHuge(page)) {
> > +                       /*
> > +                        * To call huge_pmd_unshare, i_mmap_rwsem must be
> > +                        * held in write mode.  Caller needs to explicitly
> > +                        * do this outside rmap routines.
> > +                        */
> > +                       VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
> >                         if (huge_pmd_unshare(mm, &address, pvmw.pte)) {
> >                                 /*
> >                                  * huge_pmd_unshare unmapped an entire PMD
> > diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> > index cf1217e6f956..512576e171ce 100644
> > --- a/mm/userfaultfd.c
> > +++ b/mm/userfaultfd.c
> > @@ -281,10 +281,14 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                 BUG_ON(dst_addr >= dst_start + len);
> >
> >                 /*
> > -                * Serialize via hugetlb_fault_mutex
> > +                * Serialize via i_mmap_rwsem and hugetlb_fault_mutex.
> > +                * i_mmap_rwsem ensures the dst_pte remains valid even
> > +                * in the case of shared pmds.  fault mutex prevents
> > +                * races with other faulting threads.
> >                  */
> > -               idx = linear_page_index(dst_vma, dst_addr);
> >                 mapping = dst_vma->vm_file->f_mapping;
> > +               i_mmap_lock_read(mapping);
> > +               idx = linear_page_index(dst_vma, dst_addr);
> >                 hash = hugetlb_fault_mutex_hash(mapping, idx);
> >                 mutex_lock(&hugetlb_fault_mutex_table[hash]);
> >
> > @@ -292,6 +296,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                 dst_pte = huge_pte_alloc(dst_mm, dst_addr, vma_hpagesize);
> >                 if (!dst_pte) {
> >                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                       i_mmap_unlock_read(mapping);
> >                         goto out_unlock;
> >                 }
> >
> > @@ -299,6 +304,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                 dst_pteval = huge_ptep_get(dst_pte);
> >                 if (!huge_pte_none(dst_pteval)) {
> >                         mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +                       i_mmap_unlock_read(mapping);
> >                         goto out_unlock;
> >                 }
> >
> > @@ -306,6 +312,7 @@ static __always_inline ssize_t __mcopy_atomic_hugetlb(struct mm_struct *dst_mm,
> >                                                 dst_addr, src_addr, &page);
> >
> >                 mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> > +               i_mmap_unlock_read(mapping);
> >                 vm_alloc_shared = vm_shared;
> >
> >                 cond_resched();
> > --
> > 2.24.1
> >
