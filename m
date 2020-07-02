Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD3D20890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cI9vvIfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgGBO2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729404AbgGBO2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:28:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E21CC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:28:09 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f8so20151333ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gHo78oHQeWs/WnEXLHTEqMfjmtcFZy8QE4+6FPLrlDY=;
        b=cI9vvIfD7N9TbCWjAMnCmqsaZ9jI05cDPyjSUQKyW2OA407u8GlzBb8ohwqRll1+49
         wVxf0IrqCRQU24vxqdpW59rzTUgQzdZiYN4cXTx8zPWcFtXKviHniw5g9Vwd7GMnbL3M
         7geqzlZI0nK+eOgCk2dupCuR4azxifuAtIwMAeMYzllkb4I0uQerznX5tjeIZiCzvxRu
         kKbfWPZG+wMCvDas2n9DilengzxdnOBYDtaN5QO4kWLv3W45JcQLweV8rbumy73uoeMi
         eI3PK5r6pXbqQBHuCT14ESlCA2rqM4a4yknQAjrT+MsnznlaPncReWP4qVpZDKTLp6b5
         B2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gHo78oHQeWs/WnEXLHTEqMfjmtcFZy8QE4+6FPLrlDY=;
        b=Yg+zkAkGJclxS8MjAj+VOcaHyLZ2XNB4MypdFTGaiclqHR0bUZCm05jRnrZhT96OUR
         mW0jUJ1C6BvSGeCkAYFSkPEV4yRTCJlH0ILDUkGD32zti3IUkSj798iY1OJehvfZlRJr
         BSHHaxy7LGJ6AggeSkd4vaWNeJsfjZsWx0aRhZ0GdkiM7rCropRqWx0yT3c3L/figg+a
         rbPR8EnpSrAfIvQUYhHOXTdDMKjPvhFQoInm9XyBi3jKkNt0zenA1OLnCJ7LyhMCF11/
         jX513xZdXtaGiWZY8APIgonQYL9ntjeK+11JYaBSwopQ1+hWf1UbvNqgzksJdge2UFg4
         KytQ==
X-Gm-Message-State: AOAM533sHoF56ZwrpeqmMESiMqB3ueHeYY4Ilk7fFzcDU+Gf+vkEJuaw
        xtHyiHkhtvCY1GkbdA8719yc40llVbdfDtev/K+Euw==
X-Google-Smtp-Source: ABdhPJxQ4ctB/bN7eO46H0HYGUwYExywSpa3RyTNDJxIG/8faCNq0PAzcEcurkz8l+HITdzZlLIpj5q8hdr9rmJAAag=
X-Received: by 2002:a2e:9089:: with SMTP id l9mr9164692ljg.431.1593700087357;
 Thu, 02 Jul 2020 07:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <87imfwd5f6.fsf@nanos.tec.linutronix.de> <8DD3180E-0E69-4FD6-92C3-311AAB3F688F@amacapital.net>
 <87d064d13p.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87d064d13p.fsf@nanos.tec.linutronix.de>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Jul 2020 19:57:54 +0530
Message-ID: <CA+G9fYvVEMVaF=qzhCpJ8NMb1-VN4cEh6sw8P_eNFCLQYOjCzA@mail.gmail.com>
Subject: Re: Perf: WARNING: arch/x86/entry/common.c:624 idtentry_exit_cond_rcu+0x92/0xc0
To:     Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, cj.chengjian@huawei.com,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
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

I have reported this warning on linux-next and now it is happening on
linux mainline tree.
May I know , are we missing a fix patch on linus 's tree ?

- Naresh
---
While running selftest x86 single_step_syscall_32 on
i386 kernel linux 5.8.0-rc3 kernel warning noticed.

steps to reproduce:
--------------------------
perf test
and
cd /opt/kselftests/default-in-kernel/x86
./single_step_syscall_32

crash dump,
[ 1324.774385] kselftest: Running tests in x86
[ 1324.830187] ------------[ cut here ]------------
[ 1324.834820] IRQs not disabled as expected
[ 1324.838838] WARNING: CPU: 2 PID: 5365 at
/usr/src/kernel/arch/x86/entry/common.c:645
idtentry_exit_cond_rcu+0x92/0xc0
[ 1324.849448] Modules linked in: test_sysctl nf_tables act_mirred
cls_u32 sch_netem sch_ingress mpls_iptunnel mpls_router sch_etf sch_fq
sit x86_pkg_temp_thermal fuse [last unloaded: test_user_copy]
[ 1324.866909] CPU: 2 PID: 5365 Comm: single_step_sys Not tainted 5.8.0-rc3 #1
[ 1324.873866] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[ 1324.881340] EIP: idtentry_exit_cond_rcu+0x92/0xc0
[ 1324.886045] Code: 8b 89 d8 05 00 00 85 c9 74 ae 80 3d 3f 1d f8 de
00 75 a5 68 3c 6f c5 de 89 55 f8 89 45 fc c6 05 3f 1d f8 de 01 e8 7e
17 23 ff <0f> 0b 58 8b 55 f8 8b 45 fc eb 83 8d 76 00 e8 5b fd ff ff c9
c3 89
[ 1324.904790] EAX: 0000001d EBX: 00000000 ECX: 00000027 EDX: f594c14c
[ 1324.911055] ESI: f1da3fb4 EDI: ffff4ff0 EBP: f1da3f8c ESP: f1da3f80
[ 1324.917312] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010096
[ 1324.924090] CR0: 80050033 CR2: 0883a16c CR3: 26c06000 CR4: 003406d0
[ 1324.930347] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 1324.936622] DR6: fffe0ff0 DR7: 00000400
[ 1324.940460] Call Trace:
[ 1324.942906]  exc_debug+0x84/0x1b0
[ 1324.946224]  ? exc_int3+0x1d0/0x1d0
[ 1324.949716]  handle_exception+0x145/0x145
[ 1324.953720] EIP: 0x8048900
[ 1324.956423] Code: Bad RIP value.
[ 1324.959646] EAX: 00000005 EBX: 00000000 ECX: bfe19f0c EDX: bfe19e8c
[ 1324.965903] ESI: b7e3a000 EDI: 00000000 EBP: bfe1a488 ESP: bfe19e7c
[ 1324.972161] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[ 1324.978942] irq event stamp: 3694
[ 1324.982257] hardirqs last  enabled at (3693): [<de8bf6b9>]
idtentry_exit_user+0x39/0x60
[ 1324.990251] hardirqs last disabled at (3694): [<ddb6ea62>]
vprintk_emit+0x42/0x290
[ 1324.997814] softirqs last  enabled at (3688): [<ddab1d98>]
fpu__clear+0x78/0xd0
[ 1325.005110] softirqs last disabled at (3686): [<ddab1d41>]
fpu__clear+0x21/0xd0
[ 1325.012406] ---[ end trace d68e89e2115323e2 ]---
[ 1325.017075] ------------[ cut here ]------------
[ 1325.021688] IRQs not disabled as expected
[ 1325.025695] WARNING: CPU: 2 PID: 5365 at
/usr/src/kernel/arch/x86/entry/common.c:240
__prepare_exit_to_usermode+0x164/0x1b0
[ 1325.036811] Modules linked in: test_sysctl nf_tables act_mirred
cls_u32 sch_netem sch_ingress mpls_iptunnel mpls_router sch_etf sch_fq
sit x86_pkg_temp_thermal fuse [last unloaded: test_user_copy]
[ 1325.054258] CPU: 2 PID: 5365 Comm: single_step_sys Tainted: G
 W         5.8.0-rc3 #1
[ 1325.062624] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
2.0b 07/27/2017
[ 1325.070099] EIP: __prepare_exit_to_usermode+0x164/0x1b0
[ 1325.075315] Code: d8 05 00 00 85 db 0f 84 08 ff ff ff 80 3d 40 1d
f8 de 00 0f 85 fb fe ff ff 68 3c 6f c5 de c6 05 40 1d f8 de 01 e8 7c
ee 0e 00 <0f> 0b 59 e9 e2 fe ff ff 8d 74 26 00 68 e4 6e c5 de e8 66 ee
0e 00
[ 1325.094053] EAX: 0000001d EBX: 00000001 ECX: 00000027 EDX: f594c14c
[ 1325.100309] ESI: f5766c00 EDI: f1da3fb4 EBP: f1da3f74 ESP: f1da3f64
[ 1325.106583] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010086
[ 1325.113378] CR0: 80050033 CR2: 0804d084 CR3: 26c06000 CR4: 003406d0
[ 1325.119637] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[ 1325.125902] DR6: fffe0ff0 DR7: 00000400
[ 1325.129731] Call Trace:
[ 1325.132179]  prepare_exit_to_usermode+0x8/0x30
[ 1325.136624]  idtentry_exit_cond_rcu+0xa5/0xc0
[ 1325.140983]  ? idtentry_exit_user+0x39/0x60
[ 1325.145168]  exc_debug+0x84/0x1b0
[ 1325.148480]  ? exc_int3+0x1d0/0x1d0
[ 1325.151970]  handle_exception+0x145/0x145
[ 1325.155973] EIP: 0x8048900
[ 1325.158677] Code: Bad RIP value.
[ 1325.161901] EAX: 00000005 EBX: 00000000 ECX: bfe19f0c EDX: bfe19e8c
[ 1325.168160] ESI: b7e3a000 EDI: 00000000 EBP: bfe1a488 ESP: bfe19e7c
[ 1325.174423] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000282
[ 1325.181205] irq event stamp: 3808
[ 1325.184520] hardirqs last  enabled at (3807): [<de8bf6b9>]
idtentry_exit_user+0x39/0x60
[ 1325.192512] hardirqs last disabled at (3808): [<ddb6ea62>]
vprintk_emit+0x42/0x290
[ 1325.200079] softirqs last  enabled at (3802): [<ddab1d98>]
fpu__clear+0x78/0xd0
[ 1325.207384] softirqs last disabled at (3800): [<ddab1d41>]
fpu__clear+0x21/0xd0
[ 1325.214688] ---[ end trace d68e89e2115323e3 ]---
