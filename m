Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DCC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD2A2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WP0dPhEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgEGNmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726074AbgEGNmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:42:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D55C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 06:42:53 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id q13so145095qtp.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=y7Cf25gWADp36Aj0ysti+9OMz9XuWPo8dtl90hKQjyg=;
        b=WP0dPhEPHMMAgEtmb6cahW1DKdy/ZWQcV5kMmadnr2VdhlMX0ojcM6gKPbR8V6kZ/N
         XAXm3CMgD7B2rSk7l0fr8zqoXl9G+W/bHk6iyxJfkA3QV6HkJn/0UQZ98BsfZpCxCec2
         PhfL8uBddQNzjCW/GgVQC7Ab6PIbxygZLzbpDkupUVeAMQGqWCFOihHpDJ8mWjwX6Sti
         WUwhwsidCKjRXAL/6Z5K8XKGM00C7uUKmBZ1z7qyjm/3NkLxeMCaxFfhg9Cphyd4S6nv
         ANzVi51SPdCHaj9+jVFBj+ltPKXDCpAqykWXunNAi4dFN0+CmWFHlhGq3eLQHTDhMU02
         LudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=y7Cf25gWADp36Aj0ysti+9OMz9XuWPo8dtl90hKQjyg=;
        b=ELslJscrowXGqyEYO+hWQpaNS1GiH2YP+b0/uowx2m6T+Ls/OFG4FZcgzAeUmfbpaE
         kEm6k0uOwOBxBrzuILHN5KBnwxiC+K4xJEp2ImRoIAcwYpt0T7ilygwMp7ZOdwbw1z+5
         /CWrwd2p1m/zkOUDilsTSqYubsfMIXQorEp1fVwF78gj0ACXyoMKI69hpAfuvy6zdDax
         xJZn4wP9Uj94KxFsH48i+vlgZs9v3lsO7+eb4Jp0qlGfkWxecAk0eyg5DiPTagOiSxw3
         aqM648VeGGzkNet5ydcW81qCW0pXV6J8s3RvwNfkuHS1j/6GaX61S0mEng/OIEd4Y7Np
         B5Bw==
X-Gm-Message-State: AGi0PuaV9WKwbwOL93APCgxSBMcRXEbk40OOlK/3hDqo8NuHW9g4xATd
        /LxIcCcrNyMlfvtMSqLsZTNi3Q==
X-Google-Smtp-Source: APiQypIYs86TX9PkhvNgDoqQAJEl7T/Qf2pTFwozafFiEbiSOUCk/XFW4OrUHeBzZScL+mvwov7/gA==
X-Received: by 2002:aed:2bc1:: with SMTP id e59mr13896944qtd.313.1588858972273;
        Thu, 07 May 2020 06:42:52 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d6sm2908851qkj.72.2020.05.07.06.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 06:42:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Clang and UBSAN: member access within null pointer of type
Message-Id: <CA6078C3-3489-40E4-B756-A0AF6DB3A3A5@lca.pw>
Date:   Thu, 7 May 2020 09:42:50 -0400
Cc:     clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a Clang (9.0.1) build kernel with UBSAN generated a few warnings =
during boot,

[    0.000000] UBSAN: null-ptr-deref in =
drivers/acpi/acpica/tbfadt.c:459:37
[    0.000000] member access within null pointer of type 'struct =
acpi_table_fadt'
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted =
5.7.0-rc4-next-20200507 #2
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x0/0x22c
[    0.000000]  show_stack+0x28/0x34
[    0.000000]  dump_stack+0x104/0x194
[    0.000000]  handle_null_ptr_deref+0xdc/0x10c
[    0.000000]  __ubsan_handle_type_mismatch_v1+0x64/0x78
[    0.000000]  acpi_tb_create_local_fadt+0x104/0x6ec
[    0.000000]  acpi_tb_parse_fadt+0xa0/0x1a0
[    0.000000]  acpi_tb_parse_root_table+0x284/0x2ac
[    0.000000]  acpi_initialize_tables+0xb4/0xd0
[    0.000000]  acpi_table_init+0x68/0x88
[    0.000000]  acpi_boot_table_init+0x108/0x1a0
[    0.000000]  setup_arch+0xec/0x1f4
[    0.000000]  start_kernel+0x94/0x56c

[    0.000000] UBSAN: null-ptr-deref in arch/arm64/kernel/smp.c:596:6
[    0.000000] member access within null pointer of type 'struct =
acpi_madt_generic_interrupt'
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted =
5.7.0-rc4-next-20200507 #2
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x0/0x22c
[    0.000000]  show_stack+0x28/0x34
[    0.000000]  dump_stack+0x104/0x194
[    0.000000]  handle_null_ptr_deref+0xdc/0x10c
[    0.000000]  __ubsan_handle_type_mismatch_v1+0x64/0x78
[    0.000000]  acpi_parse_gic_cpu_interface+0x40/0xa8
[    0.000000]  acpi_parse_entries_array+0x1d4/0x2e8
[    0.000000]  acpi_table_parse_entries_array+0x11c/0x138
[    0.000000]  acpi_table_parse_madt+0x84/0xb0
[    0.000000]  acpi_parse_and_init_cpus+0x24/0x80
[    0.000000]  smp_init_cpus+0x38/0x17c
[    0.000000]  setup_arch+0x140/0x1f4
[    0.000000]  start_kernel+0x94/0x56c

[  255.388250] UBSAN: null-ptr-deref in ./fs/xfs/xfs_sysfs.h:37:23
[  255.394898] member access within null pointer of type 'struct =
xfs_kobj'
[  255.402346] CPU: 230 PID: 2364 Comm: modprobe Tainted: G             =
L    5.7.0-rc4-next-20200507 #2
[  255.412191] Hardware name: HPE Apollo 70             /C01_APACHE_MB   =
      , BIOS L50_5.13_1.11 06/18/2019
[  255.422641] Call trace:
[  255.425811]  dump_backtrace+0x0/0x22c
[  255.430188]  show_stack+0x28/0x34
[  255.434225]  dump_stack+0x104/0x194
[  255.438441]  handle_null_ptr_deref+0xdc/0x10c
[  255.443511]  __ubsan_handle_type_mismatch_v1+0x64/0x78
[  255.450016]  init_module+0x130/0x1d4 [xfs]
[  255.454831]  do_one_initcall+0x6c/0x144
[  255.459383]  do_init_module+0x100/0x388
[  255.463931]  load_module+0x2518/0x2b9c
[  255.468404]  __se_sys_finit_module+0x144/0x150
[  255.473560]  __arm64_sys_finit_module+0x54/0x88
[  255.478804]  do_el0_svc+0x128/0x1dc
[  255.483010]  el0_sync_handler+0xd0/0x268
[  255.487655]  el0_sync+0x164/0x180
[  255.491782] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[  255.769799] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[  255.779164] UBSAN: null-ptr-deref in ./fs/xfs/xfs_sysfs.h:37:23
[  255.785816] member access within null pointer of type 'struct =
xfs_kobj'
[  255.793268] CPU: 132 PID: 2363 Comm: mount Tainted: G             L   =
 5.7.0-rc4-next-20200507 #2
[  255.802854] Hardware name: HPE Apollo 70             /C01_APACHE_MB   =
      , BIOS L50_5.13_1.11 06/18/2019
[  255.813306] Call trace:
[  255.816471]  dump_backtrace+0x0/0x22c
[  255.820849]  show_stack+0x28/0x34
[  255.824882]  dump_stack+0x104/0x194
[  255.829090]  handle_null_ptr_deref+0xdc/0x10c
[  255.834163]  __ubsan_handle_type_mismatch_v1+0x64/0x78
[  255.840665]  xfs_mountfs+0x310/0xc64 [xfs]
[  255.846071]  xfs_fc_fill_super+0x5cc/0x75c [xfs]
[  255.851411]  get_tree_bdev+0x24c/0x328
[  255.856463]  xfs_fc_get_tree+0x24/0x30 [xfs]
[  255.861453]  vfs_get_tree+0x54/0x158
[  255.865754]  do_mount+0x80c/0xaf0
[  255.869786]  __arm64_sys_mount+0xe0/0x18c
[  255.874510]  do_el0_svc+0x128/0x1dc
[  255.878720]  el0_sync_handler+0xd0/0x268
[  255.883357]  el0_sync+0x164/0x180=
