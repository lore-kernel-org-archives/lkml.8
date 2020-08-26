Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A814CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E0020707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pIfhHm84"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHZDCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgHZDCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:02:42 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B832C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 20:02:42 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so413742qtm.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bBtj8BOGuVCwuCUtU9BujnP6yeM9XARBTfZAPqcfaW4=;
        b=pIfhHm8495RUt1xSexojlv3iX2KraJIkmsMf5578fv+zsRywnca7yc946YLee8L7or
         2h1j04Rl0tevAn5UxT4wOcAfQ8do59RMoxzvML9VRQp1TLXJUr7AIXFgEF2nbuxa8Pwb
         ZaTEOU0wIbXC8aUtOLZpc76WrXl9JjQrDqr8hLYlbKupeadbFm+WQ39vrRpp5MLpq0PK
         n7isUhYH0xxDX9QHbFUBVQvz5j0bSHklekuqAsyh1pViM1AHfOjzQG3Ws3iqHB6CbOfG
         LRvCBwujv1WuJzBkGq4jT1ZkfWjt3DuvKnWBRmfOuJjhA3UoMXM8edtmzMLscbh8Tcvs
         QUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bBtj8BOGuVCwuCUtU9BujnP6yeM9XARBTfZAPqcfaW4=;
        b=SkIzALWEOq5ILSLjXzMQjQYEc2vhbdRHfT6RzIhBltoB9tdyIKzDC0Qv+FKDGEaCo2
         5NfVjSdk82ulPNKgQtiUL710oouVeAS8Dgxmys5UuLrGdHmKChLlkiznQWMgD5Uf5S8N
         dU06cRbTpL0TjeJUqnAxA6bOhMfRnjQbDBZWbZEG5QxPWkSLaawRYGA0rcPLaBxH25/p
         h4oWWJ2M3WqMz79lwPLJ80xjxmlkAVOqnvEoIoXR2+PGGO0wvv/GgZErR/9WUjIFW7Kq
         inOptWeSJmcXES4v6b7mw1fbXikW5Q3bcnGzwGI3gv+lZJykUDovvOErym4CQb40EfBK
         mPEw==
X-Gm-Message-State: AOAM532ngcfDWDa65l345USSYgFPB7NdcakElWajUeQqbL3V5KFq+LHS
        U7D2ZCHcixbhKUjeuRHtvCZsQg==
X-Google-Smtp-Source: ABdhPJx7JoPpIaawjxbK+f0V6njk9pwHSJWwMY62T2TGV/lhrkViqACrPsTG/SY0ZC7iophAo67SGA==
X-Received: by 2002:ac8:32dd:: with SMTP id a29mr12205419qtb.191.1598410961598;
        Tue, 25 Aug 2020 20:02:41 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 19sm652994qkj.123.2020.08.25.20.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 20:02:41 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm] c566586818: BUG:kernel_hang_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
Date:   Tue, 25 Aug 2020 23:02:40 -0400
Message-Id: <9D9FBD8D-DF19-4DA9-B0B1-260BA72D3712@lca.pw>
References: <34a960a0-ec0b-3c26-ec73-e415a8197757@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
In-Reply-To: <34a960a0-ec0b-3c26-ec73-e415a8197757@intel.com>
To:     Rong Chen <rong.a.chen@intel.com>
X-Mailer: iPhone Mail (17G80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 25, 2020, at 8:44 PM, Rong Chen <rong.a.chen@intel.com> wrote:
>=20
> I rebuilt the kernel on commit c566586818 but the error changed to "RIP: 0=
010:clear_page_orig+0x12/0x40",
> and the error can be reproduced on parent commit:

Catalin, any thought? Sounds like those early kmemleak allocations cause som=
e sort of memory corruption?

>=20
> [    0.539811] Memory: 12325340K/12680692K available (10243K kernel code, 2=
414K rwdata, 8188K rodata, 856K init, 14628K bss, 355352K reserved, 0K cma-r=
eserved)
> [    4.133400] BUG: unable to handle page fault for address: ffff88833653e=
000
> [    4.134130] #PF: supervisor write access in kernel mode
> [    4.134694] #PF: error_code(0x0002) - not-present page
> [    4.135177] PGD 3800067 P4D 3800067 PUD f000e6f2f000d445 PMD 0
> [    4.135730] Thread overran stack, or stack corrupted
> [    4.136192] Oops: 0002 [#1] DEBUG_PAGEALLOC PTI
> [    4.136609] CPU: 0 PID: 0 Comm: swapper Not tainted 5.3.0-11792-gc56658=
68183fe #1
> [    4.137300] RIP: 0010:clear_page_orig+0x12/0x40
> [    4.137732] Code: 03 00 00 00 b0 01 5b c3 b9 00 02 00 00 31 c0 f3 48 ab=
 c3 0f 1f 44 00 00 31 c0 b9 40 00 00 00 66 0f 1f 84 00 00 00 00 00 ff c9 <48=
> 89 07 48 89 47 08 48 89 47 10 48 89 47 18 48 89 47 20 48 89 47
> [    4.139453] RSP: 0000:ffffffff8239d8e8 EFLAGS: 00010016
> [    4.139939] RAX: 0000000000000000 RBX: 0000000000000101 RCX: 0000000000=
00003f
> [    4.140602] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff888336=
53e000
> [    4.141261] RBP: ffffea000cd94f80 R08: ffffffff82427800 R09: ffffea000c=
d94f80
> [    4.141956] R10: 0000160000000000 R11: ffff888000000000 R12: 0000000000=
000000
> [    4.142642] R13: 0000000000000001 R14: 0000000000092000 R15: 0000000000=
000046
> [    4.143298] FS:  0000000000000000(0000) GS:ffffffff8243d000(0000) knlGS=
:0000000000000000
> [    4.144076] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.144661] CR2: ffff88833653e000 CR3: 0000000002420000 CR4: 0000000000=
0006b0
> [    4.145382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> [    4.146121] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> [    4.146829] Call Trace:
> [    4.147066] Modules linked in:
> [    4.147359] CR2: ffff88833653e000
> [    4.147757] random: get_random_bytes called from init_oops_id+0x1d/0x2c=
 with crng_init=3D0
>=20
> $ ./scripts/faddr2line vmlinux clear_page_orig+0x12/0x40
> clear_page_orig+0x12/0x40:
> clear_page_orig at arch/x86/lib/clear_page_64.S:31
>=20
>=20
> but I also can reproduced the lookup_address_in_pgd error in v5.9-rc2 with=
 attached config file:
>=20
> [    0.382789] Memory: 12313044K/12680692K available (10242K kernel code, 2=
658K rwdata, 8916K rodata, 800K init, 24540K bss, 367392K reserved, 0K cma-r=
eserved)
> [    4.027977] general protection fault, probably for non-canonical addres=
s 0xf0006f7280000d98: 0000 [#1] DEBUG_PAGEALLOC PTI
> [    4.029094] CPU: 0 PID: 0 Comm: swapper Not tainted 5.9.0-rc2 #1
> [    4.029741] RIP: 0010:lookup_address_in_pgd+0x7c/0xcc
> [    4.030341] Code: 00 00 48 3d 81 00 00 00 74 6c 4c 89 df e8 9d f2 ff ff=
 48 f7 d0 4c 21 d8 a8 01 74 5a 4c 89 d6 4c 89 df e8 fd f5 ff ff 49 89 c0 <48=
> f7 00 9f ff ff ff 74 93 41 c7 01 02 00 00 00 48 8b 08 48 89 cf
> [    4.032205] RSP: 0000:ffffffff82453a08 EFLAGS: 00010082
> [    4.032716] RAX: f0006f7280000d98 RBX: 0000000000000001 RCX: f000e6f280=
000000
> [    4.033569] RDX: ffff888000000000 RSI: ffff888000000d98 RDI: f000e6f2f0=
00d400
> [    4.034474] RBP: ffffffff82453b28 R08: f0006f7280000d98 R09: ffffffff82=
453a48
> [    4.035125] R10: ffff88833664c000 R11: f000e6f2f000d445 R12: ffff888336=
64c000
> [    4.035836] R13: 0000000000000001 R14: ffff888000000000 R15: ffffffff82=
7806b8
> [    4.036575] FS:  0000000000000000(0000) GS:ffffffff82641000(0000) knlGS=
:0000000000000000
> [    4.037389] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.037961] CR2: ffff8883447ff000 CR3: 0000000002622000 CR4: 0000000000=
0006b0
> [    4.038677] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000=
000000
> [    4.039388] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000=
000400
> [    4.040243] Call Trace:
> [    4.040552] Modules linked in:
> [    4.041033] random: get_random_bytes called from init_oops_id+0x1d/0x2c=
 with crng_init=3D0
>=20
> $ ./scripts/faddr2line vmlinux lookup_address_in_pgd+0x7c/0xcc
> lookup_address_in_pgd+0x7c/0xcc:
> lookup_address_in_pgd at arch/x86/mm/pat/set_memory.c:604
> (inlined by) lookup_address_in_pgd at arch/x86/mm/pat/set_memory.c:575
