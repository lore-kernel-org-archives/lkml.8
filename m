Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C617BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA90207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qD0U/sOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgFOP0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFOP0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:26:48 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37147C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:26:48 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z206so9807653lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=adMfAjW2Nk8UnoT5lzvYHTooopDnU/gLONWg04lcJ6c=;
        b=qD0U/sOPcA3yv7WFkycPaRX0s2QfVQT6/xNmhgq/4UNaW3QhFwG6YIVkiUSJzUowxQ
         GA1gr5HSh7/O8k0Go5dF8abcQvr9cTdCUxeZdg4Gm3PrafE88M4vM8klNABkYBjHpHhI
         sq/9x0a3Bt32AmU4NlbmU5tcsba+jL9GbIpYT9dtQbUjdghFjGXaPXjGgH9fP5OaDV++
         lyGOdRFn/ulryTkGDXLiNfXYVX4wKp1QwKGmi/hD1uhUp3i7nARRFcgahEJZ7Y1tGQVZ
         GJmQtY8Y8hldj6aZT+WVOw9dL2k506QHhGLlxquOteGEWh0p/tCCN2wtwyekgeYfVtlG
         iDIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=adMfAjW2Nk8UnoT5lzvYHTooopDnU/gLONWg04lcJ6c=;
        b=KvDD8Lw+Oagx6xKtl4Xypkszf5uQnK2v1WBnuiUSYPKUSlyWWHVJIYd7HqofvQ9+1T
         VcMpFDeKraqtgY4UkPkNXRw9Py5bI1HAPxDl/Ju0OLK9UTqaXU62T9EOfAJaVtD4nTyT
         U7HYiqAPlxycX2S0PpNUrxT1MKoIRB+1WjQFnV2jPanZ1YEbtb46Ws6AgPZzgi6lvBkK
         yt62VmuBBBo/irRK84qG/8cfiL458dq95uEFbdfYNS9wABa++0uz6rfBoZXqcqk4zaKZ
         lFdqvHdxJtEDUUzpP+OE3UpQGubK8wUwz6EuhPa1RcBi8ikLQGTITaAelXaaG7jnk+nJ
         vd1g==
X-Gm-Message-State: AOAM531f/FwvO4oUPBIEBp1XHSDrCn9K5omvxyCiz+HNPh9ZEw2nPB6k
        wNroTlLRjM2xPn7Fom9cieo=
X-Google-Smtp-Source: ABdhPJzhcTFQlwae9ThU6628sdp4Odw1LWBA1iNOTPZnIIZfxI3KKhiFYZPbxKJsPQQlV3x7JSeEBg==
X-Received: by 2002:ac2:4a87:: with SMTP id l7mr13711486lfp.171.1592234806424;
        Mon, 15 Jun 2020 08:26:46 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id o23sm5487909lfg.0.2020.06.15.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 08:26:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 15 Jun 2020 17:26:43 +0200
To:     Ingo Molnar <mingo@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        lkp@lists.01.org
Subject: Re: [mm/vmalloc] 0acd9a0ded: kernel_BUG_at_mm/vmalloc.c
Message-ID: <20200615152643.GA24242@pc636>
References: <20200613142028.GP12456@shao2-debian>
 <20200613160758.GA11426@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613160758.GA11426@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Ingo.

> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 0acd9a0ded80c986ccc9588ba2703436769ead74 ("Revert "mm/vmalloc: modify struct vmap_area to reduce its size"")
> > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git WIP.fixes
> > 
> > in testcase: trinity
> > with following parameters:
> > 
> > 	runtime: 300s
> > 
> > test-description: Trinity is a linux system call fuzz tester.
> > test-url: http://codemonkey.org.uk/projects/trinity/
> > 
> > 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> > 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > 
> > 
> > +----------------------------------------------------------------------------+------+------------+
> > |                                                                            | v5.7 | 0acd9a0ded |
> > +----------------------------------------------------------------------------+------+------------+
> > | boot_successes                                                             | 214  | 142        |
> > | boot_failures                                                              | 3    | 16         |
> > | WARNING:at_kernel/rcu/tree_stall.h:#rcu_check_gp_start_stall               | 1    |            |
> > | EIP:rcu_check_gp_start_stall                                               | 1    |            |
> > | WARNING:at_net/sched/sch_generic.c:#dev_watchdog                           | 1    | 2          |
> > | EIP:dev_watchdog                                                           | 1    | 2          |
> > | Kernel_panic-not_syncing:VFS:Unable_to_mount_root_fs_on_unknown-block(#,#) | 1    |            |
> > | kernel_BUG_at_mm/vmalloc.c                                                 | 0    | 11         |
> > | invalid_opcode:#[##]                                                       | 0    | 11         |
> > | EIP:free_vm_area                                                           | 0    | 11         |
> > | Kernel_panic-not_syncing:Fatal_exception                                   | 0    | 11         |
> > | INFO:rcu_sched_detected_stalls_on_CPUs/tasks                               | 0    | 2          |
> > | EIP:smp_call_function_single                                               | 0    | 2          |
> > | INFO:rcu_sched_self-detected_stall_on_CPU                                  | 0    | 1          |
> > | EIP:bvec_iter_advance                                                      | 0    | 1          |
> > | EIP:iov_iter_copy_from_user_atomic                                         | 0    | 1          |
> > +----------------------------------------------------------------------------+------+------------+
> > 
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > 
> > 
> > [  330.604224] kernel BUG at mm/vmalloc.c:3211!
> > [  330.605254] invalid opcode: 0000 [#1] SMP
> > [  330.606027] CPU: 1 PID: 18 Comm: kworker/1:0 Not tainted 5.7.0-00001-g0acd9a0ded80c #1
> > [  330.607482] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> > [  330.623780] Workqueue: events pcpu_balance_workfn
> > [  330.624815] EIP: free_vm_area+0x33/0x77
> > [  330.625601] Code: 49 56 b5 01 83 15 64 49 56 b5 00 89 e5 53 89 c3 8b 40 04 e8 de fe ff ff 39 c3 74 2c 83 05 68 49 56 b5 01 83 15 6c 49 56 b5 00 <0f> 0b 83 05 78 49 56 b5 01 83 15 7c 49 56 b5 00 83 05 80 49 56 b5
> > [  330.629386] EAX: 00000000 EBX: ef7a8380 ECX: 00000003 EDX: f46fa0c0
> > [  330.630660] ESI: 00000000 EDI: 00000001 EBP: f473bedc ESP: f473bed8
> > [  330.631954] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010246
> > [  330.633317] CR0: 80050033 CR2: a763a9e4 CR3: 3bc55000 CR4: 000006d0
> > [  330.634576] Call Trace:
> > [  330.635134]  pcpu_free_vm_areas+0x2b/0x64
> > [  330.635973]  pcpu_balance_workfn+0x673/0x9ac
> > [  330.636846]  process_one_work+0x4e0/0x8b0
> > [  330.637662]  worker_thread+0x370/0x589
> > [  330.638448]  kthread+0x1f9/0x20c
> > [  330.639153]  ? create_worker+0x24d/0x24d
> > [  330.639958]  ? kthread_create_worker+0x38/0x38
> > [  330.640863]  ret_from_fork+0x19/0x30
> > [  330.641597] Modules linked in:
> > [  330.643261] ---[ end trace acbe7a17ad39ff71 ]---
> > 
> > 
> > To reproduce:
> > 

I interpreted this BUG_ON() differently. I thought that below revert
fixes the BUG_ON() reported by the test robot:

<snip>
commit: 0acd9a0ded80c986ccc9588ba2703436769ead74 ("Revert "mm/vmalloc: modify struct vmap_area to reduce its size"")
<snip>

so basically it is vice versa. Due to that revert the vmalloc code
triggers the BUG_ON().

Are you planning to keep revert and mainline it or that is just for
test purposes?

Thank you!

--
Vlad Rezki
