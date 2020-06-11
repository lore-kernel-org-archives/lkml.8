Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A566C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43031206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="drTt8L3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgFKS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgFKS4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:56:25 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33FDC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:56:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id n23so8176789ljh.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 11:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pbJ2yJSlJPfH0eaPQTsGU37TGe6D2h9IyPzy0Bjwcbs=;
        b=drTt8L3uK9MbBJx+lpown2Lsuc4q9U/gFSoAcGT2yvyiUpA9gupwfc07+e1owEk/Va
         XYn3kjDFIxOoXejncFq/eNuI0WrP2cy3TJG57/vwbt+FRmoHBLCPnxSXSt10VE2speJq
         cVPEyxIiUf6UqjV5RWeXI7tGTY3UHOVV3xmDRq8UjfnFe+nDwTkaW/ZziRtFyrqzF9Ut
         ay8X7CDnpeTfd0NJR1z0yxXzfrkF/6RyQxAkuPler2e05oX48njyRtZ9YnNH3VZL9QA6
         LtaKvnE41FjE90vjd1oPodqoC90qsRH7WQpu6s5o1YYBJf19qgYAQK7jID9C0dpWKF5A
         vl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pbJ2yJSlJPfH0eaPQTsGU37TGe6D2h9IyPzy0Bjwcbs=;
        b=FK5eZGBZolqVbTc2LbjOp053bxmgaFgyh3iOSlaz98Q8boJrVrjVs/a5xVivDBnRsY
         8xBuob/cow2sb5G36xL7qM0FtO6n2WE0X1y69jkQ41BUGBJQdnFbyfRtPIEsg1Vd8KFZ
         nFEiHg9Ad6JReqVYcPjGmpgMeJKI03SfKkuSEloleA+/mQi47MP6Plv0TkwVblaBxkZf
         wtOV4WIxRW5zLenD78pZsybwrBOcZpa0nlAIlEIO05drXYVjNuVQeZVAcv7uDnFFrzq2
         vN34wZGJBtR9g14e0zUEQsuVURChser2FvUVNiULiifoUZvQE8I+NR7laTz5agFV7jhy
         s+2A==
X-Gm-Message-State: AOAM531x6kY5XkDY6+Ocg7F257IiDvrn9f15r/T7midavoD0u8hHFC1J
        AgAJ9C9MCtNSoiJEzSo1SH8p39gHDxWJhqxxXar8GrxMEqfHJA==
X-Google-Smtp-Source: ABdhPJxZ2a6jXpTWZZ2tB1JNdZ9YgeS1kI0BxA6O7KgWH7f3DClIS7y/3If042DGm3QeBU+azWdFK1w7MfW+i/d/1s4=
X-Received: by 2002:a2e:9116:: with SMTP id m22mr4953677ljg.431.1591901781957;
 Thu, 11 Jun 2020 11:56:21 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 12 Jun 2020 00:26:10 +0530
Message-ID: <CA+G9fYvF3cyrY+-iw_SZtpN-i2qA2BruHg4M=QYECU2-dNdsMw@mail.gmail.com>
Subject: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     open list <linux-kernel@vger.kernel.org>, x86@kernel.org
Cc:     cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <walken@google.com>,
        lkft-triage@lists.linaro.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running perf test and selftest x86 single_step_syscall_32 on
i386 kernel linux
next 5.7.0-next-20200610 kernel warning noticed.

steps to reproduce:
--------------------------
perf test
and
cd /opt/kselftests/default-in-kernel/x86
./single_step_syscall_32

perf warning log:
----------------------
[   57.260865] ------------[ cut here ]------------
[   57.266576] IRQs not disabled as expected
[   57.270583] WARNING: CPU: 1 PID: 500 at
/usr/src/kernel/arch/x86/entry/common.c:624
idtentry_exit_cond_rcu+0x92/0xc0
[   57.281092] Modules linked in: x86_pkg_temp_thermal fuse
[   57.286406] CPU: 1 PID: 500 Comm: perf Not tainted 5.7.0-next-20200610 #1
[   57.293190] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   57.300577] EIP: idtentry_exit_cond_rcu+0x92/0xc0
[   57.305280] Code: 8b 89 d8 05 00 00 85 c9 74 ae 80 3d b1 64 2c d4
00 75 a5 68 94 2d fb d3 89 55 f8 89 45 fc c6 05 b1 64 2c d4 01 e8 8e
f5 2b ff <0f> 0b 58 8b 55 f8 8b 45 fc eb 83 8d 76 00 e8 5b fd ff ff c9
c3 89
[   57.324017] EAX: 0000001d EBX: 0d00022a ECX: 00000027 EDX: f5b9e14c
[   57.330274] ESI: f2a2ffb4 EDI: ffff0ff4 EBP: f2a2ff8c ESP: f2a2ff80
[   57.336531] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010096
[   57.343345] CR0: 80050033 CR2: 08700a58 CR3: 14ad7000 CR4: 003406d0
[   57.349608] DR0: 080dfb80 DR1: 080dfc00 DR2: 08700a58 DR3: 00000000
[   57.355866] DR6: fffe0ff0 DR7: 0d00062a
[   57.359697] Call Trace:
[   57.362143]  exc_debug+0x84/0x1b0
[   57.365487]  ? exc_int3+0x1d0/0x1d0
[   57.368981]  handle_exception+0x145/0x145
[   57.372991] EIP: 0x80dfbcd
[   57.375694] Code: Bad RIP value.
[   57.378918] EAX: 00000000 EBX: 00000005 ECX: 00002400 EDX: 00000000
[   57.385175] ESI: 00000003 EDI: 00000004 EBP: bfd59798 ESP: bfd59770
[   57.391431] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000246
[   57.398215] irq event stamp: 1896
[   57.401556] hardirqs last  enabled at (1895): [<d3c316b9>]
idtentry_exit_user+0x39/0x60
[   57.409556] hardirqs last disabled at (1896): [<d2f6e742>]
vprintk_emit+0x42/0x290
[   57.417120] softirqs last  enabled at (0): [<d2eee73a>]
copy_process+0x3ea/0x17d0
[   57.424590] softirqs last disabled at (0): [<00000000>] 0x0
[   57.430155] ---[ end trace 421998f6ba46136b ]---
10.2: PMU event [   57.434872] ------------[ cut here ]------------
[   57.440858] IRQs not disabled as expected
[   57.444870] WARNING: CPU: 1 PID: 500 at
/usr/src/kernel/arch/x86/entry/common.c:240
__prepare_exit_to_usermode+0x164/0x1b0
[   57.455900] Modules linked in: x86_pkg_temp_thermal fuse
[   57.461207] CPU: 1 PID: 500 Comm: perf Tainted: G        W
5.7.0-next-20200610 #1
[   57.469379] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.2 05/23/2018
[   57.476770] EIP: __prepare_exit_to_usermode+0x164/0x1b0
[   57.481988] Code: d8 05 00 00 85 db 0f 84 08 ff ff ff 80 3d b2 64
2c d4 00 0f 85 fb fe ff ff 68 94 2d fb d3 c6 05 b2 64 2c d4 01 e8 8c
ec 0e 00 <0f> 0b 59 e9 e2 fe ff ff 8d 74 26 00 68 3c 2d fb d3 e8 76 ec
0e 00
[   57.500732] EAX: 0000001d EBX: 00000001 ECX: 00000027 EDX: f5b9e14c
[   57.506991] ESI: f1e9a400 EDI: f2a2ffb4 EBP: f2a2ff74 ESP: f2a2ff64
[   57.513275] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010086
[   57.520060] CR0: 80050033 CR2: 08700a58 CR3: 14ad7000 CR4: 003406d0
[   57.526346] DR0: 080dfb80 DR1: 080dfc00 DR2: 08700a58 DR3: 00000000
[   57.532608] DR6: fffe0ff0 DR7: 0d00062a
[   57.536439] Call Trace:
[   57.538885]  prepare_exit_to_usermode+0x8/0x30
[   57.543356]  idtentry_exit_cond_rcu+0xa5/0xc0
[   57.547714]  ? idtentry_exit_user+0x39/0x60
[   57.551892]  exc_debug+0x84/0x1b0
[   57.555212]  ? exc_int3+0x1d0/0x1d0
[   57.558704]  handle_exception+0x145/0x145
[   57.562715] EIP: 0x80dfc00
[   57.565417] Code: Bad RIP value.
[   57.568644] EAX: 0000001d EBX: 00000005 ECX: bfd5920c EDX: bfd5918c
[   57.574899] ESI: 00000003 EDI: 00000004 EBP: bfd59798 ESP: bfd5917c
[   57.581158] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010246
[   57.587948] irq event stamp: 1942
[   57.591340] hardirqs last  enabled at (1941): [<d3c316b9>]
idtentry_exit_user+0x39/0x60
[   57.599345] hardirqs last disabled at (1942): [<d2f6e742>]
vprintk_emit+0x42/0x290
[   57.606906] softirqs last  enabled at (1934): [<d2eb1b68>]
fpu__clear+0x78/0xd0
[   57.614210] softirqs last disabled at (1932): [<d2eb1b11>]
fpu__clear+0x21/0xd0
[   57.621509] ---[ end trace 421998f6ba46136c ]---

map aliases                    :

Full test log link,
----------------------
perf test full output log:
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200610/testrun/2808447/suite/linux-log-parser/test/check-kernel-warning-1486409/log

kselftest full output log,
https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20200610/testrun/2808443/suite/linux-log-parser/test/check-kernel-exception-1486406/log


metadata:
--------------
  git branch: master
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
  git commit: 976c320052ff22a7f9b8be0d56aefacb3a40f466
  git describe: next-20200610
  kernel-config:
http://snapshots.linaro.org/openembedded/lkft/lkft/sumo/intel-core2-32/lkft/linux-next/786/config

-- 
Linaro LKFT
https://lkft.linaro.org
