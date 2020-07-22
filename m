Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6161220717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJvmytfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgGVIM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgGVIM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:12:56 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246DDC0619E0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:12:56 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id q15so670364vso.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 01:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W076aF0pkVnevDwhzxCKbE8g4hkBp73FmZlkbs1P7qI=;
        b=EJvmytfSokKO7JKn01fpIGNNcDIwYqddu5VHauVWUGc3goiTFLOMh/jS6GOMU5u8fV
         afUX5FEujNCgFhe9IgKVk11AmYBxs8SDVZ/33xRJ6fclZI3iEbvd+I8JWZ20P0Ogp99k
         05OkW1+TJbQB4wziG5tBJqCUqnu5Fum6fhYrItkEX/Ql7rPQB4gvVgUNgCGTAMu+a46G
         Cr8+kEDVxXB23qpVtdjFhmN6gyaVIdYUQ+p2S9hJ9W1JAllvSfFHvBr3FN7arjqVvM27
         38sPnVTONLxWzS/9Og5FqICPliuMHrY9n5ft9bEcJaBY87UGztv5oI/Nj+JfPpUqQNZA
         eovA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W076aF0pkVnevDwhzxCKbE8g4hkBp73FmZlkbs1P7qI=;
        b=SvDDDNm/guIULfoTcNFwRbq0B81ZHvVn2sg69+FYbLhLSOM+jsSSU6wFCY56Z+Kil8
         R1BDve4rpphMyzAZ7ibWmOqkCP6bJ3ATRNukb9Me0Y4FOqA9tO3IXFm4pKGSifUN7drC
         Oc+9SaeUXHl76pu/BDr3JIK5nMhaVazEF9S1S4ZxtAaovbSJ++oPaFhlnubYiGikP5+B
         cWJwtTYe/FIWgIDFJzOxYFxVNRT+2TT43DcmoaOQlDgiFEKSdWqZ7872Nk9Mc/9twsbh
         Hs1C94LRqfxRXj4BLcHKln1u5nUVCu6S0jBfYxrSwkBt1xi7/5RQHjkYZPPov2RoPJVc
         rOeA==
X-Gm-Message-State: AOAM531H7oO5KsgiOm0OywqnN6HIW2TTEZ9G88bP5felnRKCtulMF1W3
        wHcQwhyNUgEWtBYn5153y/RImU+XfMPGvMJQCSDBdKEMOR9PbFmx
X-Google-Smtp-Source: ABdhPJzouE3ayXob168ZiUBCBR5VEnzkMxo5l6S3qNRk39xqgecbpgIN4va5/wubbhAfJjSUa2F7SfeShPjXI+/Oo+8=
X-Received: by 2002:a67:2d0e:: with SMTP id t14mr21191740vst.22.1595405574822;
 Wed, 22 Jul 2020 01:12:54 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 22 Jul 2020 13:42:42 +0530
Message-ID: <CA+G9fYuj3bHUMz8XQztbmTgF0c5+rZ5-FkUjFyvEftej2jLT+Q@mail.gmail.com>
Subject: BUG at mm/vmalloc.c:3089! - invalid opcode: 0000 [#1] SMP KASAN PTI
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, lkft-triage@lists.linaro.org,
        LTP List <ltp@lists.linux.it>,
        Cgroups <cgroups@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, urezki@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        oleksiy.avramchenko@sonymobile.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rppt@linux.ibm.com,
        david@redhat.com, Joerg Roedel <jroedel@suse.de>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel BUG at mm/vmalloc.c:3089! on x86_64 Kasan configured kernel reported
this while testing LTP cgroup_fj_stress_memory_4_4_none test cases.

Also found on arm64 and i386 devices and qemu.

metadata:
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: de2e69cfe54a8f2ed4b75f09d3110c514f45d38e
  git describe: next-20200721
  make_kernelversion: 5.8.0-rc6
  kernel-config:
https://builds.tuxbuild.com/zU-I3LEfC1AaKQ59Er60ZQ/kernel.config

crash log,
[ 1421.080221] ------------[ cut here ]------------
[ 1421.084874] kernel BUG at mm/vmalloc.c:3089!
[ 1421.090356] invalid opcode: 0000 [#1] SMP KASAN PTI
[ 1421.096009] CPU: 1 PID: 19100 Comm: kworker/1:1 Not tainted
5.8.0-rc6-next-20200721 #1
[ 1421.103933] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[ 1421.111418] Workqueue: events pcpu_balance_workfn
[ 1421.116138] RIP: 0010:free_vm_area+0x2d/0x30
[ 1421.120413] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
89 fe
[ 1421.139154] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
[ 1421.144381] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
[ 1421.151515] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
[ 1421.158647] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
[ 1421.165780] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
[ 1421.172913] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
[ 1421.180045] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 1421.188132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1421.193876] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
[ 1421.201008] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1421.208132] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1421.215255] Call Trace:
[ 1421.217703]  pcpu_free_vm_areas+0x30/0x44
[ 1421.221714]  pcpu_balance_workfn+0x7bd/0x8f0
[ 1421.225987]  ? pcpu_create_chunk+0x2f0/0x2f0
[ 1421.230261]  ? read_word_at_a_time+0x12/0x20
[ 1421.234531]  ? strscpy+0xc1/0x190
[ 1421.237842]  process_one_work+0x474/0x7b0
[ 1421.241856]  worker_thread+0x7b/0x6a0
[ 1421.245521]  ? wake_up_process+0x10/0x20
[ 1421.249448]  ? process_one_work+0x7b0/0x7b0
[ 1421.253635]  kthread+0x1aa/0x200
[ 1421.256867]  ? kthread_create_on_node+0xd0/0xd0
[ 1421.261400]  ret_from_fork+0x22/0x30
[ 1421.264978] Modules linked in: x86_pkg_temp_thermal
[ 1421.269869] ---[ end trace 6352cf97284f07da ]---
[ 1421.274955] RIP: 0010:free_vm_area+0x2d/0x30
[ 1421.281026] Code: e5 41 54 49 89 fc 48 83 c7 08 e8 9e 5e 04 00 49
8b 7c 24 08 e8 74 f8 ff ff 49 39 c4 75 0c 4c 89 e7 e8 97 d2 03 00 41
5c 5d c3 <0f> 0b 90 48 b8 00 00 00 00 00 fc ff df 55 48 89 e5 41 56 49
89 fe
[ 1421.300553] RSP: 0018:ffff88840142fc80 EFLAGS: 00010282
[ 1421.307051] RAX: 0000000000000000 RBX: ffff88841b843738 RCX: ffffffff86ca1d78
[ 1421.314184] RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffff8883bfacd630
[ 1421.321317] RBP: ffff88840142fc88 R08: 0000000000000001 R09: ffffed1080285f7e
[ 1421.328477] R10: 0000000000000003 R11: ffffed1080285f7d R12: ffff888409e89880
[ 1421.335639] R13: ffff88841b843730 R14: 0000000000000080 R15: 0000000000000080
[ 1421.342777] FS:  0000000000000000(0000) GS:ffff88841fa80000(0000)
knlGS:0000000000000000
[ 1421.350870] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1421.356643] CR2: 00007f1230b41080 CR3: 000000025d40e002 CR4: 00000000003706e0
[ 1421.363811] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1421.370951] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Full test log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200721/testrun/2972982/suite/linux-log-parser/test/check-kernel-bug-1594684/log

--
Linaro LKFT
https://lkft.linaro.org
