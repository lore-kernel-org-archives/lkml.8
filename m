Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61542C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE5D205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="CMxrEsAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgCXUNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:13:46 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46635 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgCXUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:13:45 -0400
Received: by mail-qt1-f196.google.com with SMTP id g7so96579qtj.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C9b2EFih07Bol0OhuOp+naFJ2QOu8CjYU0vdzwBlssE=;
        b=CMxrEsAyp8SoMtphK9LTHXEQNe0gvYg1kG4es2vY/Cbot4/a9hWYn5blklz6400FbL
         fjtCKnMWVFyIValqMYpQBcctE+nIM3FCSmEJE9KpwkGnDfyqpU95ejovPi8CN4uN3ujw
         JcZZEOcfqRgyR5sasNtVg6iu0Ng4YM+cAoCXu6ofZTKJqlpxKBCx/7ErtIrZC48JQKeE
         g6OEhLyoSiFv52Hz2QJCkO9Id2bwJbgHfgO+t3X163n3GPhu10dppbSKUaF/6c3JLipw
         2encQyfW+aPLKWmgHK80Cz0zjSUUD2w/lNtHix4PZ/vJyNA/bIlnYB59B2G8cGTUXrbp
         6NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=C9b2EFih07Bol0OhuOp+naFJ2QOu8CjYU0vdzwBlssE=;
        b=qeKvH3rmPA4qxdLJG5RdCRG+oNxC7v5aLy/AHQ/3GtWNUinOhGDR4emTS8jBpd9G3H
         6Y17etAOQz5wi9sga9xTfnchvC/uTwDSvvs0u1Hz7qUGnqNMbWIB+QWYo0VX12mVWsbb
         3w3KEKf29E2k24JbuVNjP2AJHSOcZ1EYRWXGOIwPERrtv1sTGchQd4tvckJAQVCEECLl
         LlKgtqJ2/5nv0BZ0gFfmiTQg0kKoNpaoEAZJTBVq6jNlhKVJTwxX1nCH/rf2HO56k8/D
         dzgfHbCmItVcDPF/mrxq/qqpopsH4VNokG/4BZ2v3Uu/s1dr8rMD3YUC2qW+XHCwTRkF
         SZCQ==
X-Gm-Message-State: ANhLgQ18YnsQNGGRtFs7byXoa5Hle6Caf16kAIb/gYrK+UbYKqeiuD7Q
        NllxPLfd7eYru8rlWTT5xz5Qzg==
X-Google-Smtp-Source: ADFU+vvUb5EPEwWM830GWFC8xZrHZgfn11CiVhdGj190JilNUxrE/jVs5R/tSSA6ED7rCnFbo78KcA==
X-Received: by 2002:ac8:1968:: with SMTP id g37mr28036704qtk.322.1585080824046;
        Tue, 24 Mar 2020 13:13:44 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y127sm13540702qkb.76.2020.03.24.13.13.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:13:43 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: Argh, can't find dcache properties !
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <876a5938fbad9d9e176e5f22f12e6b472d0dc4f7.camel@alliedtelesis.co.nz>
Date:   Tue, 24 Mar 2020 16:13:42 -0400
Cc:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "paulus@samba.org" <paulus@samba.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48F1D8CF-13A1-4348-8973-81503782A451@lca.pw>
References: <be8c123a90f6d1664a902b6ad6c754b9f3d9e567.camel@alliedtelesis.co.nz>
 <87tv2exst1.fsf@mpe.ellerman.id.au>
 <876a5938fbad9d9e176e5f22f12e6b472d0dc4f7.camel@alliedtelesis.co.nz>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 24, 2020, at 4:06 PM, Chris Packham =
<Chris.Packham@alliedtelesis.co.nz> wrote:
>=20
> On Tue, 2020-03-24 at 15:47 +1100, Michael Ellerman wrote:
>> Chris Packham <Chris.Packham@alliedtelesis.co.nz> writes:
>>> Hi All,
>>>=20
>>> Just booting up v5.5.11 on a Freescale T2080RDB and I'm seeing the
>>> following mesage.
>>>=20
>>> kern.warning linuxbox kernel: Argh, can't find dcache properties !
>>> kern.warning linuxbox kernel: Argh, can't find icache properties !
>>>=20
>>> This was changed from DBG() to pr_warn() in commit 3b9176e9a874
>>> ("powerpc/setup_64: fix -Wempty-body warnings") but the message
>>> seems
>>> to be much older than that. So it's probably been an issue on the
>>> T2080
>>> (and other QorIQ SoCs) for a while.
>>=20
>> That's an e6500 I think? So 64-bit Book3E.
>>=20
>=20
> Yes that's correct.
>=20
>> You'll be getting the default values, which is 64 bytes so I guess
>> that
>> works in practice.
>>=20
>>> Looking at the code the t208x doesn't specifiy any of the d-cache-
>>> size/i-cache-size properties. Should I add them to silence the
>>> warning
>>> or switch it to pr_debug()/pr_info()?
>>=20
>> Yeah ideally you'd add them to the device tree(s) for those boards.
>>=20
>=20
> I think the info I need is in the block diagram[0]. I'll whip up
> a patch.
>=20
> --
> [1] - =
https://www.nxp.com/products/processors-and-microcontrollers/power-archite=
cture/qoriq-communication-processors/t-series/qoriq-t2080-and-t2081-multic=
ore-communications-processors:T2080

BTW, POWER9 PowerNV would have the same thing.=20

[    0.000000][    T0] Setting debug_guardpage_minorder to 1
[    0.000000][    T0] Reserving 512MB of memory at 128MB for =
crashkernel (System RAM: 262144MB)
[    0.000000][    T0] radix-mmu: Page sizes from device-tree:
[    0.000000][    T0] radix-mmu: Page size shift =3D 12 AP=3D0x0
[    0.000000][    T0] radix-mmu: Page size shift =3D 16 AP=3D0x5
[    0.000000][    T0] radix-mmu: Page size shift =3D 21 AP=3D0x1
[    0.000000][    T0] radix-mmu: Page size shift =3D 30 AP=3D0x2
[    0.000000][    T0] radix-mmu: Activating Kernel Userspace Execution =
Prevention
[    0.000000][    T0] radix-mmu: Activating Kernel Userspace Access =
Prevention
[    0.000000][    T0] radix-mmu: Mapped =
0x0000000000000000-0x0000000001600000 with 2.00 MiB pages (exec)
[    0.000000][    T0] radix-mmu: Mapped =
0x0000000001600000-0x0000000040000000 with 2.00 MiB pages
[    0.000000][    T0] radix-mmu: Mapped =
0x0000000040000000-0x0000002000000000 with 1.00 GiB pages
[    0.000000][    T0] radix-mmu: Mapped =
0x0000200000000000-0x0000202000000000 with 1.00 GiB pages
[    0.000000][    T0] radix-mmu: Initializing Radix MMU
[    0.000000][    T0] Linux version 5.6.0-rc7-next-20200324+ =
(root@ibm-p9wr) (gcc version 8.3.1 20191121 (Red Hat 8.3.1-5) (GCC)) #2 =
SMP Tue Mar 24 15:52:36 EDT 2020
[    0.000000][    T0] Argh, can't find dcache properties !
[    0.000000][    T0] Argh, can't find icache properties !
[    0.000000][    T0] Found initrd at =
0xc000000007850000:0xc00000000ad26142
[    0.000000][    T0] OPAL: Found memory mapped LPC bus on chip 0
[    0.000000][    T0] Using PowerNV machine description
[    0.000000][    T0] printk: bootconsole [udbg0] enabled
[    0.000000][    T0] CPU maps initialized for 4 threads per core
[    0.000000][    T0] =
-----------------------------------------------------
[    0.000000][    T0] phys_mem_size     =3D 0x4000000000
[    0.000000][    T0] dcache_bsize      =3D 0x80
[    0.000000][    T0] icache_bsize      =3D 0x80
[    0.000000][    T0] cpu_features      =3D 0x0001f86f8f5fb1a7
[    0.000000][    T0]   possible        =3D 0x0003fbffcf5fb1a7
[    0.000000][    T0]   always          =3D 0x0000006f8b5c91a1
[    0.000000][    T0] cpu_user_features =3D 0xdc0065c2 0xaee00000
[    0.000000][    T0] mmu_features      =3D 0xbc006041
[    0.000000][    T0] firmware_features =3D 0x0000000010000000
[    0.000000][    T0] vmalloc start     =3D 0xc008000000000000
[    0.000000][    T0] IO start          =3D 0xc00a000000000000
[    0.000000][    T0] vmemmap start     =3D 0xc00c000000000000
[    0.000000][    T0] =
-----------------------------------------------------=
