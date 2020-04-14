Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E9FC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEFF22064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NoM5+FHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390957AbgDNOcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390946AbgDNOcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:32:47 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E5C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:32:46 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y3so13363068qky.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=K2onlYh5LPuDBoMzlpg7dGDe4b9VAKhvfZV7J0uQUeY=;
        b=NoM5+FHj3MEqbpmnMCYjklg7zLl1DafVNWWWgH1d0niF6/McQXQjvOQb/l6b6CWyZX
         T4Rh+c7dHG4HP7MZ7l7vE6QReZpoiqVsQu31RFS6M9609jZBv5jKoww91EJYM/bBH0lg
         xhMQIoq7bqatgh993JQ5/JVAPv/g0jhAGYuyOzxgEJWaflrY/cWWhS5ZF7K1eTzD4eCc
         AGlYbCpHG/HJuMKIKyp+z0kHpxow6O8OesaDz6Yg518YawFU7yOv+4JAYKFpzcYPRcMZ
         +E66wzkvRG/eck0mYeBJGlzBoYDuQh0LeYDgpNSooBrWtevldNWQsygTxhcTqNmeH9Cq
         h2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=K2onlYh5LPuDBoMzlpg7dGDe4b9VAKhvfZV7J0uQUeY=;
        b=XrhL/M7dcGWJ8Za/234sbowO6DlZtly5T99W5R/bRn3yg7H39IC+O0RyuuJMkvqG31
         oYRW2x7UjyVQ/DHxi5H/BBs76zeeUrnEw/9JzTaYY0cl+SbNevYtt7tnpkQTHtzdpkun
         66seWpPZRXH+rGYqcSgwv3ykc9cdQ72MdSYHWgPEAIQWCnNMB4braMi4h+I6vcRCNzSu
         BlUwT4SDkVk3pPqCI5IHRUHEQalBIQoir2dzSf0HWYyFsR+QASXEelrnLWzXxXQ4GDtr
         c5IVuWFLP+auUjBl/nm2AliyiClNxaKr350aOWvviH0067FL27jyoqE6LN1f4ywhueqc
         ra5w==
X-Gm-Message-State: AGi0PuY3JEoCqD0BqkEtL6Q61mvnq2partQjZDh3i7bRqsIE16fsmp0r
        7QkW3Iwz3sEIvZXELG5N8fYHDskY1mVRIw==
X-Google-Smtp-Source: APiQypIfYN56P7MOQiEOwy5zLwzTszdmfwBimZOsCVGqvvd2hVYITU4K8R2GsL/JVieZdIridjL0cQ==
X-Received: by 2002:ae9:ec12:: with SMTP id h18mr20040561qkg.387.1586874765886;
        Tue, 14 Apr 2020 07:32:45 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p186sm10635859qkb.71.2020.04.14.07.32.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 07:32:45 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: linux-next: not-present page at swap_vma_readahead()
Message-Id: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
Date:   Tue, 14 Apr 2020 10:32:44 -0400
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
To:     Linux-MM <linux-mm@kvack.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fuzzers are unhappy. Thoughts?

[34944.838318][T48906] BUG: unable to handle page fault for address: =
ffff888cb196bfe8
[34944.845970][T48906] #PF: supervisor read access in kernel mode
[34944.847199][T50168] futex_wake_op: trinity-c58 tries to shift op by =
-1; fix this program
[34944.851855][T48906] #PF: error_code(0x0000) - not-present page
[34944.851866][T48906] PGD f63401067 P4D f63401067 PUD 1079630067 PMD =
10794a3067 PTE 800ffff34e694060
[34944.874964][T48906] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[34944.881289][T48906] CPU: 72 PID: 48906 Comm: trinity-c85 Tainted: G   =
          L    5.7.0-rc1-next-20200414+ #8
[34944.891559][T48906] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[34944.900860][T48906] RIP: 0010:swapin_readahead+0x40a/0x85f
swap_vma_readahead at mm/swap_state.c:741
(inlined by) swapin_readahead at mm/swap_state.c:785
[34944.906394][T48906] Code: 6c 24 70 44 8b 64 24 0c 4c 89 6c 24 18 eb =
13 41 83 c4 01 49 83 c6 08 44 3b 64 24 20 0f 84 38 03 00 00 4c 89 f7 e8 =
66 74 04 00 <4d> 8b 3e 49 f7 c7 9f ff ff ff 74 d9 48 c7 c7 a0 83 23 91 =
e8 4e 74
[34944.925989][T48906] RSP: 0018:ffffc9002622f620 EFLAGS: 00010246
[34944.931960][T48906] RAX: 0000000000000000 RBX: ffffc9002622f8d8 RCX: =
ffffffff902370aa
[34944.939849][T48906] RDX: dffffc0000000000 RSI: 0000000000000001 RDI: =
ffff888cb196bfe8
[34944.947737][T48906] RBP: ffffc9002622f758 R08: 0000000000000000 R09: =
ffffed112d8078e7
[34944.955625][T48906] R10: ffff88896c03c737 R11: ffffed112d8078e6 R12: =
0000000000000000
[34944.963580][T48906] R13: ffffc9002622f690 R14: ffff888cb196bfe8 R15: =
ffff888cb196c000
[34944.971479][T48906] FS:  00007f17c465a740(0000) =
GS:ffff889032c00000(0000) knlGS:0000000000000000
[34944.980329][T48906] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[34944.986820][T48906] CR2: ffff888cb196bfe8 CR3: 0000000c17964000 CR4: =
00000000003406e0
[34944.994709][T48906] Call Trace:
[34944.997895][T48906]  ? exit_swap_address_space+0x160/0x160
[34945.003429][T48906]  ? lookup_swap_cache+0x144/0x410
[34945.008516][T48906]  ? swapcache_prepare+0x20/0x20
[34945.013352][T48906]  do_swap_page+0x4ef/0xe70
do_swap_page at mm/memory.c:3141
[34945.017751][T48906]  ? unmap_mapping_range+0x30/0x30
[34945.022763][T48906]  __handle_mm_fault+0xb80/0xbe0
[34945.027601][T48906]  ? copy_page_range+0x420/0x420
[34945.032438][T48906]  handle_mm_fault+0xdc/0x2e0
[34945.037013][T48906]  do_page_fault+0x2cb/0x9d7
[34945.041607][T48906]  page_fault+0x34/0x40
[34945.045655][T48906] RIP: 0010:strncpy_from_user+0xc9/0x2a0
[34945.051184][T48906] Code: 14 00 00 4c 01 e8 0f 92 c1 0f 82 45 01 00 =
00 48 39 c2 0f 82 3c 01 00 00 0f 01 cb 0f ae e8 49 83 fd 07 0f 86 b7 01 =
00 00 31 f6 <49> 8b 14 24 85 f6 0f 85 9b 01 00 00 49 8d 45 f8 4c 89 6d =
c0 49 89
[34945.070775][T48906] RSP: 0018:ffffc9002622fb28 EFLAGS: 00050246
[34945.076742][T48906] RAX: 0000000000000fe0 RBX: ffff888c17830040 RCX: =
0000000000000000
[34945.084626][T48906] RDX: 00007ffffffff000 RSI: 0000000000000000 RDI: =
ffff888c178314d0
[34945.092516][T48906] RBP: ffffc9002622fb70 R08: 0000000000000fe0 R09: =
fffff940065ea9e1
[34945.100402][T48906] R10: ffffea0032f54f07 R11: fffff940065ea9e0 R12: =
0000000000000000
[34945.108288][T48906] R13: 0000000000000fe0 R14: ffff888cbd53c060 R15: =
0000000000000fe0
[34945.116184][T48906]  ? strncpy_from_user+0x96/0x2a0
[34945.121106][T48906]  getname_flags+0x6a/0x220
[34945.125502][T48906]  do_renameat2+0x17c/0x7e0
[34945.129895][T48906]  ? user_path_create+0x40/0x40
[34945.134642][T48906]  ? register_lock_class+0xb40/0xb40
[34945.139824][T48906]  ? match_held_lock+0x20/0x250
[34945.144569][T48906]  ? find_held_lock+0xca/0xf0
[34945.149140][T48906]  ? __kasan_check_read+0x11/0x20
[34945.154062][T48906]  ? perf_syscall_enter+0xf9/0x370
[34945.159065][T48906]  ? lock_downgrade+0x3e0/0x3e0
[34945.163804][T48906]  ? check_flags.part.28+0x86/0x220
[34945.168896][T48906]  ? rcu_read_lock_sched_held+0xac/0xe0
[34945.174339][T48906]  ? do_syscall_64+0x79/0xaf0
[34945.178907][T48906]  ? rcu_read_lock_bh_held+0xc0/0xc0
[34945.184091][T48906]  __x64_sys_rename+0x3b/0x50
[34945.188659][T48906]  do_syscall_64+0xcc/0xaf0
[34945.193050][T48906]  ? perf_call_bpf_enter+0x1a0/0x1a0
[34945.198230][T48906]  ? syscall_return_slowpath+0x580/0x580
[34945.203760][T48906]  ? entry_SYSCALL_64_after_hwframe+0x3e/0xb3
[34945.209725][T48906]  ? trace_hardirqs_off_caller+0x3a/0x150
[34945.215340][T48906]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[34945.220780][T48906]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[34945.226568][T48906] RIP: 0033:0x7f17c3f5c839
[34945.230872][T48906] Code: 00 f3 c3 66 2e 0f 1f 84 00 00 00 00 00 0f =
1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c =
24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1f f6 2c 00 f7 d8 64 =
89 01 48
[34945.250461][T48906] RSP: 002b:00007fff822be2d8 EFLAGS: 00000246 =
ORIG_RAX: 0000000000000052
[34945.258802][T48906] RAX: ffffffffffffffda RBX: 0000000000000052 RCX: =
00007f17c3f5c839
[34945.266685][T48906] RDX: 00000000000000e8 RSI: 0000000000000000 RDI: =
0000000000000000=
