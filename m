Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F094AC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B615624685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="DwCb2jHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgBZLlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:41:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41438 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZLlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:41:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id b1so980755pgm.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 03:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=NeBw3VBM+IhvwK7nQS2pIV0wLar2ew+Dn3ZrifxSb3w=;
        b=DwCb2jHiIF6k9rytrB2L53ZjX8KjqTutzOYWiNUhgbS0VTaokDm8wEk2vZYslWLuF6
         4BPHH5gozmIu+JoxS6QvbPgYZ8KV15LiFSpdbRDejExHH37i1VfhOSrF9tCtYtKnHGCI
         w0R+/1azZ3zL74apPsEHQEScw6LjX9rFo+OuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=NeBw3VBM+IhvwK7nQS2pIV0wLar2ew+Dn3ZrifxSb3w=;
        b=WcBcam8UbbvFTESxwiexWInQhU/nVYVeX0KP4DS5KC7bzSoirwTOJiYmpIxpHjdRde
         SiQr4iVUnFlVCMrAas+ZpPIErwBAfjFHmVaSVf0cEVKVPyyiiBcQi89m5P2nYBoQtL3F
         KDoZU0nW2mo0VrWAzFs8jhmUmymQLeMfhpOgdEAtwAMa4DKfBXgk9LPrxFvetj+qw/qQ
         NgzBcpdpu3f9iql8/RZt1+g7SX7Slp0MBBqxZrRNGbFgnE8iiZ770w5mYhA+J7Hv368y
         SPI/uAJho0rBD0EU7sv3qLZgISvR32c2l3vW/PEAYenj2HidAv1aDe4Uzuk20JCPznwA
         Uj1g==
X-Gm-Message-State: APjAAAVFM5sttvxX/H/rIsLMeQ6h5QGE6jgKXsQ7YDhfhX0Vnswnsmll
        x0JFPaQ9wkodKZ/ZPJcfw1PvAA==
X-Google-Smtp-Source: APXvYqyZDXGi8Jx0vIO+r7pha7ZqjrJpvwulRNLLFa5vUudgiuyp7On5VUItqhPPtPOC3IEZTojfFQ==
X-Received: by 2002:a63:790f:: with SMTP id u15mr3433708pgc.172.1582717310865;
        Wed, 26 Feb 2020 03:41:50 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-5952-947b-051c-ea5f.static.ipv6.internode.on.net. [2001:44b8:1113:6700:5952:947b:51c:ea5f])
        by smtp.gmail.com with ESMTPSA id a9sm2666805pfo.35.2020.02.26.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:41:49 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Jason Yan <yanaijie@huawei.com>, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, diana.craciun@nxp.com,
        christophe.leroy@c-s.fr, benh@kernel.crashing.org,
        paulus@samba.org, npiggin@gmail.com, keescook@chromium.org,
        kernel-hardening@lists.openwall.com, oss@buserror.net
Cc:     linux-kernel@vger.kernel.org, zhaohongjiang@huawei.com
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
In-Reply-To: <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
References: <20200206025825.22934-1-yanaijie@huawei.com> <87tv3drf79.fsf@dja-thinkpad.axtens.net> <8171d326-5138-4f5c-cff6-ad3ee606f0c2@huawei.com>
Date:   Wed, 26 Feb 2020 22:41:46 +1100
Message-ID: <87r1yhr2x1.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Yan <yanaijie@huawei.com> writes:

> Hi Daniel,
>
> =E5=9C=A8 2020/2/26 15:16, Daniel Axtens =E5=86=99=E9=81=93:
>> Hi Jason,
>>=20
>>> This is a try to implement KASLR for Freescale BookE64 which is based on
>>> my earlier implementation for Freescale BookE32:
>>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D131718
>>>
>>> The implementation for Freescale BookE64 is similar as BookE32. One
>>> difference is that Freescale BookE64 set up a TLB mapping of 1G during
>>> booting. Another difference is that ppc64 needs the kernel to be
>>> 64K-aligned. So we can randomize the kernel in this 1G mapping and make
>>> it 64K-aligned. This can save some code to creat another TLB map at
>>> early boot. The disadvantage is that we only have about 1G/64K =3D 16384
>>> slots to put the kernel in.
>>>
>>>      KERNELBASE
>>>
>>>            64K                     |--> kernel <--|
>>>             |                      |              |
>>>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>>>          |  |  |  |....|  |  |  |  |  |  |  |  |  |....|  |  |
>>>          +--+--+--+    +--+--+--+--+--+--+--+--+--+    +--+--+
>>>          |                         |                        1G
>>>          |----->   offset    <-----|
>>>
>>>                                kernstart_virt_addr
>>>
>>> I'm not sure if the slot numbers is enough or the design has any
>>> defects. If you have some better ideas, I would be happy to hear that.
>>>
>>> Thank you all.
>>>
>>=20
>> Are you making any attempt to hide kernel address leaks in this series?
>
> Yes.
>
>> I've just been looking at the stackdump code just now, and it directly
>> prints link registers and stack pointers, which is probably enough to
>> determine the kernel base address:
>>=20
>>                    SPs:               LRs:             %pS pointer
>> [    0.424506] [c0000000de403970] [c000000001fc0458] dump_stack+0xfc/0x1=
54 (unreliable)
>> [    0.424593] [c0000000de4039c0] [c000000000267eec] panic+0x258/0x5ac
>> [    0.424659] [c0000000de403a60] [c0000000024d7a00] mount_block_root+0x=
634/0x7c0
>> [    0.424734] [c0000000de403be0] [c0000000024d8100] prepare_namespace+0=
x1ec/0x23c
>> [    0.424811] [c0000000de403c60] [c0000000024d7010] kernel_init_freeabl=
e+0x804/0x880
>>=20
>> git grep \\\"REG\\\" arch/powerpc shows a few other uses like this, all
>> in process.c or in xmon.
>>=20
>
> Thanks for reminding this.
>
>> Maybe replacing the REG format string in KASLR mode would be sufficient?
>>=20
>
> Most archs have removed the address printing when dumping stack. Do we=20
> really have to print this?
>
> If we have to do this, maybe we can use "%pK" so that they will be=20
> hidden from unprivileged users.

I suspect that you will find it easier to convince people to accept a
change to %pK than removal :)

BTW, I have a T4240RDB so I might be able to test this series at some
point - do I need an updated bootloader to pass in a random seed, or is
the kernel able to get enough randomness by itself? (Sorry if this is
explained elsewhere in the series, I have only skimmed it lightly!)

Regards,
Daniel
>
> Thanks,
> Jason
>
>> Regards,
>> Daniel
>>=20
>>=20
>>> v2->v3:
>>>    Fix build error when KASLR is disabled.
>>> v1->v2:
>>>    Add __kaslr_offset for the secondary cpu boot up.
>>>
>>> Jason Yan (6):
>>>    powerpc/fsl_booke/kaslr: refactor kaslr_legal_offset() and
>>>      kaslr_early_init()
>>>    powerpc/fsl_booke/64: introduce reloc_kernel_entry() helper
>>>    powerpc/fsl_booke/64: implement KASLR for fsl_booke64
>>>    powerpc/fsl_booke/64: do not clear the BSS for the second pass
>>>    powerpc/fsl_booke/64: clear the original kernel if randomized
>>>    powerpc/fsl_booke/kaslr: rename kaslr-booke32.rst to kaslr-booke.rst
>>>      and add 64bit part
>>>
>>>   .../{kaslr-booke32.rst =3D> kaslr-booke.rst}    | 35 +++++++--
>>>   arch/powerpc/Kconfig                          |  2 +-
>>>   arch/powerpc/kernel/exceptions-64e.S          | 23 ++++++
>>>   arch/powerpc/kernel/head_64.S                 | 14 ++++
>>>   arch/powerpc/kernel/setup_64.c                |  4 +-
>>>   arch/powerpc/mm/mmu_decl.h                    | 19 ++---
>>>   arch/powerpc/mm/nohash/kaslr_booke.c          | 71 +++++++++++++------
>>>   7 files changed, 132 insertions(+), 36 deletions(-)
>>>   rename Documentation/powerpc/{kaslr-booke32.rst =3D> kaslr-booke.rst}=
 (59%)
>>>
>>> --=20
>>> 2.17.2
>>=20
>> .
>>=20
