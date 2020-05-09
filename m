Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884C5C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521EA20722
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQfmjXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEIIip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgEIIip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:38:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F051C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 01:38:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f6so2038544pgm.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=hVlYd67HZx/IH8rCOzL+8Ma2GEK3+8rx9KQ4Yr+bbmo=;
        b=NtQfmjXFEx3H6ZsDeXZOhGr6WtymYTpW0Cgudg4/4qt5PVjVLGIKAJY+yH84rbLztq
         h5BrsGRhZR6dseKY+NhPNj8rlUj8pVc32F5AJsyxQ5MaNw/GlbawJBAepOg5qyjhHaJh
         PKgyzX6wHrYnCUQk2uTBXjEKBtUNMMBAhRZyDYIpIBpJYJMgZXiHIAaH053tF2iVs6Zn
         8ODcxL55drT86W75quifucUNYIpn3c5A5TduYjqHVeaEQl1WtxK8IT3TIz5JmPg2vmcg
         CVcoKGa0EXIia+WvCkt5TF1jjtSZ8fRQ6B8TsuIrmjuGhyAwQaSHU4rC2qQuhn5YKjrW
         wjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=hVlYd67HZx/IH8rCOzL+8Ma2GEK3+8rx9KQ4Yr+bbmo=;
        b=AsS13x74tWgiYCoLVJgX/TyCmY3Hjtqq4BwfYFla5eAZaiuHrornde60Fh38/yi8AD
         050hxlCz+/e7lBT7k96sR+xLrLOxe/FB/FnfxMuvWcVmfFos5bHB+Cs3PuR9E1cnu1IQ
         x2KrUGo4C7xEqGQKJf37VbkffCnETZ4kB0/U8R4cDfKDj2JTwd86RdEaSIX0X3UJijvj
         3QfpxeAFOMc9FyzNdXS5NjHJV4wNfZ7o7aZrp0Pa8BQjw3KA3Qs8X0g/g97K/0oHyNT9
         q70iBPC66mvZg3KIBDU+6gYKQDsNDRCNB26RbLj2ACTK5mu/Vq6Yh29rKbDrxcoCuz++
         /rvQ==
X-Gm-Message-State: AGi0PubJ6f4rasEieTzeA9kqc9fKyrlAVN4qpgnsRb+eHdlPIHohMDlw
        0PDm5SrtV3l1px8y5n5nFfY=
X-Google-Smtp-Source: APiQypK1GkS2+Ro1JPeNld8hdexc3IO+EjKZxJBWQEIFE4VjyfzuuCGjCR/c7EyMzaGRbloxNWXO/g==
X-Received: by 2002:a62:8f42:: with SMTP id n63mr4686561pfd.43.1589013522978;
        Sat, 09 May 2020 01:38:42 -0700 (PDT)
Received: from localhost (61-68-214-199.tpgi.com.au. [61.68.214.199])
        by smtp.gmail.com with ESMTPSA id n30sm4000022pfq.88.2020.05.09.01.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 01:38:41 -0700 (PDT)
Date:   Sat, 09 May 2020 18:38:36 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: ioremap() called early from pnv_pci_init_ioda_phb()
To:     Qian Cai <cai@lca.pw>, Christophe Leroy <christophe.leroy@c-s.fr>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <B183CDAA-DA88-4760-9C1B-F73A8F7840E7@lca.pw>
        <229E1896-0C06-418A-B7DE-40AEBFB44F85@lca.pw>
In-Reply-To: <229E1896-0C06-418A-B7DE-40AEBFB44F85@lca.pw>
MIME-Version: 1.0
Message-Id: <1589013450.02gfmpktnp.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Qian Cai's message of May 9, 2020 3:41 am:
>=20
>=20
>> On May 8, 2020, at 10:39 AM, Qian Cai <cai@lca.pw> wrote:
>>=20
>> Booting POWER9 PowerNV has this message,
>>=20
>> "ioremap() called early from pnv_pci_init_ioda_phb+0x420/0xdfc. Use earl=
y_ioremap() instead=E2=80=9D
>>=20
>> but use the patch below will result in leaks because it will never call =
early_iounmap() anywhere. However, it looks me it was by design that phb->r=
egs mapping would be there forever where it would be used in pnv_ioda_get_i=
nval_reg(), so is just that check_early_ioremap_leak() initcall too strong?
>>=20
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -36,6 +36,7 @@
>> #include <asm/firmware.h>
>> #include <asm/pnv-pci.h>
>> #include <asm/mmzone.h>
>> +#include <asm/early_ioremap.h>
>>=20
>> #include <misc/cxl-base.h>
>>=20
>> @@ -3827,7 +3828,7 @@ static void __init pnv_pci_init_ioda_phb(struct de=
vice_node *np,
>>        /* Get registers */
>>        if (!of_address_to_resource(np, 0, &r)) {
>>                phb->regs_phys =3D r.start;
>> -               phb->regs =3D ioremap(r.start, resource_size(&r));
>> +               phb->regs =3D early_ioremap(r.start, resource_size(&r));
>>                if (phb->regs =3D=3D NULL)
>>                        pr_err("  Failed to map registers !\n=E2=80=9D);
>=20
> This will also trigger a panic with debugfs reads, so isn=E2=80=99t that =
this commit bogus at least for powerpc64?

Your patch to use early_ioremap is faulting? I wonder why?

Thanks,
Nick

>=20
> d538aadc2718 (=E2=80=9Cpowerpc/ioremap: warn on early use of ioremap()")
>=20
> 11017.617022][T122068] Faulting instruction address: 0xc0000000000db564
> [11017.617257][T122066] Faulting instruction address: 0xc0000000000db564
> [11017.617950][T122073] Faulting instruction address: 0xc0000000000db564
> [11017.618888][T122064] BUG: Unable to handle kernel data access on read =
at 0xffffffffffe20e10
> [11017.618935][T122064] Faulting instruction address: 0xc0000000000db564
> [11017.737996][T122072]=20
> [11017.738010][T122073] Oops: Kernel access of bad area, sig: 11 [#2]
> [11017.738024][T122073] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256 =
DEBUG_PAGEALLOC NUMA PowerNV
> [11017.738051][T122073] Modules linked in: brd ext4 crc16 mbcache jbd2 lo=
op kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci tg3 mdio lib=
ata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [11017.738110][T122073] CPU: 108 PID: 122073 Comm: read_all Tainted: G   =
   D W         5.7.0-rc4-next-20200508+ #4
> [11017.738138][T122073] NIP:  c0000000000db564 LR: c00000000056f660 CTR: =
c0000000000db550
> [11017.738173][T122073] REGS: c000000374f6f980 TRAP: 0380   Tainted: G   =
   D W          (5.7.0-rc4-next-20200508+)
> [11017.738234][T122073] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE> =
 CR: 22002282  XER: 20040000
> [11017.738278][T122073] CFAR: c00000000056f65c IRQMASK: 0=20
> [11017.738278][T122073] GPR00: c00000000056f660 c000000374f6fc10 c0000000=
01689400 c000201ffc41aa00=20
> [11017.738278][T122073] GPR04: c000000374f6fc70 0000000000000000 00000000=
00000000 0000000000000001=20
> [11017.738278][T122073] GPR08: 0000000000000000 ffffffffffe20000 00000000=
00000000 c0000008ee380080=20
> [11017.738278][T122073] GPR12: c0000000000db550 c000201fff671280 00000000=
00000000 0000000000000000=20
> [11017.738278][T122073] GPR16: 0000000000000002 0000000010040800 00000000=
1001ccd8 000000001001cc80=20
> [11017.738278][T122073] GPR20: 000000001001cc98 000000001001ccc8 00000000=
1001cca8 000000001001cb48=20
> [11017.738278][T122073] GPR24: 0000000000000000 0000000000000000 00000000=
000003ff 00007fffebb67390=20
> [11017.738278][T122073] GPR28: c000000374f6fd90 c000200c0c6a7550 00000000=
00000000 c000200c0c6a7500=20
> [11017.738542][T122073] NIP [c0000000000db564] pnv_eeh_dbgfs_get_inbB+0x1=
4/0x30
> [11017.738579][T122073] LR [c00000000056f660] simple_attr_read+0xa0/0x180
> [11017.738613][T122073] Call Trace:
> [11017.738645][T122073] [c000000374f6fc10] [c00000000056f630] simple_attr=
_read+0x70/0x180 (unreliable)
> [11017.738672][T122073] [c000000374f6fcb0] [c00000000064a2e0] full_proxy_=
read+0x90/0xe0
> [11017.738686][T122073] [c000000374f6fd00] [c00000000051fe0c] __vfs_read+=
0x3c/0x70
> [11017.738722][T122073] [c000000374f6fd20] [c00000000051feec] vfs_read+0x=
ac/0x170
> [11017.738757][T122073] [c000000374f6fd70] [c00000000052034c] ksys_read+0=
x7c/0x140
> [11017.738818][T122073] [c000000374f6fdc0] [c000000000038af4] system_call=
_exception+0x114/0x1e0
> [11017.738867][T122073] [c000000374f6fe20] [c00000000000c8f0] system_call=
_common+0xf0/0x278
> [11017.738916][T122073] Instruction dump:
> [11017.738948][T122073] 7c0004ac f9490d10 a14d0c78 38600000 b14d0c7a 4e80=
0020 60000000 7c0802a6=20
> [11017.739001][T122073] 60000000 e9230278 e9290028 7c0004ac <e9290e10> 0c=
090000 4c00012c 38600000=20
