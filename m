Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A12C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C0D720A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AZtgNyXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgEGSas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGSar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:30:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCBEC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 11:30:47 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id z6so2396090plk.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R9h9q1Cl5L9jBOGkjpl3YKNQYZ81ZJlVZdV6ucpz6gk=;
        b=AZtgNyXCDwUGPGp1PM9cWIAZauBdoePqX96vjEBL/kvdk1EJxcVbZwl+Ls50tv+BrX
         IotQbUkrC74MmZVi3nI5TQ3F/d8sqmeLnoyno6J13vewS/bnga9JnEOSJcuflDSOkR2e
         Xhk1FnSXKBLUN92SM7mB7rfvSLGP3LK/wIEKWyDyPm/i0WkBpFY7mziTrocjzeRjwOsf
         5++itW52O2SNa6DV0nQDuODtY/FRcB6S99imGW9J2vKESgnr0lruQ/x9Rjd4W3BZQ56I
         DIg66yAs4Aoe+ug+Ub3SJrgEX8wqlCVu95yTI8axeaRFNmaw/I378kSF5UmTN4eH6rQP
         yUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R9h9q1Cl5L9jBOGkjpl3YKNQYZ81ZJlVZdV6ucpz6gk=;
        b=tlXsdtSSvR8bDVRGnx6ZT9620yQEVCwsB8dPCY6+6CLkR2m2R5f4mnHeN86lSbnSsg
         xK+3VypXcwB3JEn/j9n2/+mDHL9fsnSeqiHq8EErwlROktuteEOQhSnyaLJ6+aX9Cr1Q
         mXCCeh9UQg7aFpF6eqPAD86vGfB1Z3V8PXinA/CaSy+PpTUfsnl5T/1rfDvPAUpijCFJ
         hW02SsBDrlYWfsFoyaQBo5l+gsUHKfrYpvyay86IiA5wKYbDwx7jDb1zMKSHVNDzmO8F
         uiDYTPSh8pIFSTcWC4QdyWWqBkKZz5ZDx602tFV5ItP3V330L/hue/cKQUnG9xsAU+1u
         S6Rw==
X-Gm-Message-State: AGi0PuagO1UZ3ndmpBx2r9wPDaFGnlmGYozr7pVlb4wLyk3K7Nxo8zok
        xkO0v9+OrMX8QDLOCsSL0YNZNkDVwymzZfw/isSwtQ==
X-Google-Smtp-Source: APiQypK9IbN+TgxOKUhhzPc9GeBCFFkrYnPPl+d23ZIB6mFcEt9OGKw/yU0L2ZxW41dT7BLjGdCFm/MeV5NXVHNDke0=
X-Received: by 2002:a17:90a:6d03:: with SMTP id z3mr1563529pjj.32.1588876246349;
 Thu, 07 May 2020 11:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw>
In-Reply-To: <CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 May 2020 11:30:34 -0700
Message-ID: <CAKwvOdmMjwoTZFSp2DnzeKePxgczfOJyOH_T-vyzHGcm5cFXgA@mail.gmail.com>
Subject: Re: Clang and UBSAN: member access within null pointer of type
To:     Qian Cai <cai@lca.pw>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 6:42 AM Qian Cai <cai@lca.pw> wrote:
>
> Running a Clang (9.0.1) build kernel with UBSAN generated a few warnings during boot,

Very cool, these reports are so nice! They hand you everything on a
silver platter.  Thanks for testing/sending!  Let's take a look.

>
> [    0.000000] UBSAN: null-ptr-deref in drivers/acpi/acpica/tbfadt.c:459:37
> [    0.000000] member access within null pointer of type 'struct acpi_table_fadt'
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc4-next-20200507 #2
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x22c
> [    0.000000]  show_stack+0x28/0x34
> [    0.000000]  dump_stack+0x104/0x194
> [    0.000000]  handle_null_ptr_deref+0xdc/0x10c
> [    0.000000]  __ubsan_handle_type_mismatch_v1+0x64/0x78
> [    0.000000]  acpi_tb_create_local_fadt+0x104/0x6ec

ok so acpi_tb_create_local_fadt() dereferenced a `null pointer of type
'struct acpi_table_fadt'` in null-ptr-deref in
drivers/acpi/acpica/tbfadt.c:459.

That line number doesn't line up with linux-next; which tree was this?
 That will probably help track these down faster.

> [    0.000000]  acpi_tb_parse_fadt+0xa0/0x1a0
> [    0.000000]  acpi_tb_parse_root_table+0x284/0x2ac
> [    0.000000]  acpi_initialize_tables+0xb4/0xd0
> [    0.000000]  acpi_table_init+0x68/0x88
> [    0.000000]  acpi_boot_table_init+0x108/0x1a0
> [    0.000000]  setup_arch+0xec/0x1f4
> [    0.000000]  start_kernel+0x94/0x56c
>
> [    0.000000] UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
> [    0.000000] member access within null pointer of type 'struct acpi_madt_generic_interrupt'
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.7.0-rc4-next-20200507 #2
> [    0.000000] Call trace:
> [    0.000000]  dump_backtrace+0x0/0x22c
> [    0.000000]  show_stack+0x28/0x34
> [    0.000000]  dump_stack+0x104/0x194
> [    0.000000]  handle_null_ptr_deref+0xdc/0x10c
> [    0.000000]  __ubsan_handle_type_mismatch_v1+0x64/0x78
> [    0.000000]  acpi_parse_gic_cpu_interface+0x40/0xa8
> [    0.000000]  acpi_parse_entries_array+0x1d4/0x2e8
> [    0.000000]  acpi_table_parse_entries_array+0x11c/0x138
> [    0.000000]  acpi_table_parse_madt+0x84/0xb0
> [    0.000000]  acpi_parse_and_init_cpus+0x24/0x80
> [    0.000000]  smp_init_cpus+0x38/0x17c
> [    0.000000]  setup_arch+0x140/0x1f4
> [    0.000000]  start_kernel+0x94/0x56c
>
> [  255.388250] UBSAN: null-ptr-deref in ./fs/xfs/xfs_sysfs.h:37:23
> [  255.394898] member access within null pointer of type 'struct xfs_kobj'
> [  255.402346] CPU: 230 PID: 2364 Comm: modprobe Tainted: G             L    5.7.0-rc4-next-20200507 #2
> [  255.412191] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  255.422641] Call trace:
> [  255.425811]  dump_backtrace+0x0/0x22c
> [  255.430188]  show_stack+0x28/0x34
> [  255.434225]  dump_stack+0x104/0x194
> [  255.438441]  handle_null_ptr_deref+0xdc/0x10c
> [  255.443511]  __ubsan_handle_type_mismatch_v1+0x64/0x78
> [  255.450016]  init_module+0x130/0x1d4 [xfs]
> [  255.454831]  do_one_initcall+0x6c/0x144
> [  255.459383]  do_init_module+0x100/0x388
> [  255.463931]  load_module+0x2518/0x2b9c
> [  255.468404]  __se_sys_finit_module+0x144/0x150
> [  255.473560]  __arm64_sys_finit_module+0x54/0x88
> [  255.478804]  do_el0_svc+0x128/0x1dc
> [  255.483010]  el0_sync_handler+0xd0/0x268
> [  255.487655]  el0_sync+0x164/0x180
> [  255.491782] ================================================================================
> [  255.769799] ================================================================================
> [  255.779164] UBSAN: null-ptr-deref in ./fs/xfs/xfs_sysfs.h:37:23
> [  255.785816] member access within null pointer of type 'struct xfs_kobj'
> [  255.793268] CPU: 132 PID: 2363 Comm: mount Tainted: G             L    5.7.0-rc4-next-20200507 #2
> [  255.802854] Hardware name: HPE Apollo 70             /C01_APACHE_MB         , BIOS L50_5.13_1.11 06/18/2019
> [  255.813306] Call trace:
> [  255.816471]  dump_backtrace+0x0/0x22c
> [  255.820849]  show_stack+0x28/0x34
> [  255.824882]  dump_stack+0x104/0x194
> [  255.829090]  handle_null_ptr_deref+0xdc/0x10c
> [  255.834163]  __ubsan_handle_type_mismatch_v1+0x64/0x78
> [  255.840665]  xfs_mountfs+0x310/0xc64 [xfs]
> [  255.846071]  xfs_fc_fill_super+0x5cc/0x75c [xfs]
> [  255.851411]  get_tree_bdev+0x24c/0x328
> [  255.856463]  xfs_fc_get_tree+0x24/0x30 [xfs]
> [  255.861453]  vfs_get_tree+0x54/0x158
> [  255.865754]  do_mount+0x80c/0xaf0
> [  255.869786]  __arm64_sys_mount+0xe0/0x18c
> [  255.874510]  do_el0_svc+0x128/0x1dc
> [  255.878720]  el0_sync_handler+0xd0/0x268
> [  255.883357]  el0_sync+0x164/0x180



-- 
Thanks,
~Nick Desaulniers
