Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100A4C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89F92075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KaI0znSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDVSf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgDVSf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:35:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:35:29 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id l13so2542053qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KFMe5jf+SqPXjS3cNqNcR09qpXqrclNV90ZAafesRSo=;
        b=KaI0znSONlZTM4MnVQRVAgwdU4JrTu5gksDg8TF2yfqWKur+6Xa3A31T6yr5BwvBq5
         tW4Gfch5qwVIzHPLGg5Kbff3iQa8ly/KttYyHhLVhVrhOB845nUBKJ17rnbPt/ic1hax
         a/nvgqGxzphqWXsNR6f0CxEsQdvszX5tRVl3PvJQLPcg+bjaa16e3ciaZsXSKS3zWxnG
         EZJyeqKB+JkJlMIMnv3p7z+/AkF0n4oC3m1XxMT11o64imkE9iHTcdoZ9MSxIxeiyqT6
         RzoYxPsCgCgONaqBIo0IrdDqMFToyi44tuIu2pa9Sfg0zsQloFeSNmtuXbhzGV4HQclB
         VQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KFMe5jf+SqPXjS3cNqNcR09qpXqrclNV90ZAafesRSo=;
        b=ZmEKoeBByj9I1IopffsC29GRM/VA4Q3hpJe2dsaI5+Atz0522oGE8FhnJWd569sShY
         Du8g7sqcGCjL62vGHcvmFPsCHYhfO8bMGNfItizsWaax3kdB1ZGriZXJY7XtuZI47NLj
         aG2SERT69rON9rEty0Akm+6kODaq3dpJj8azjcqut6pvajDxCpBEP1agbBeXe8xmakbD
         2YMaqEME+Bpw/rmfDBENBt8Azj6zhC2W7SjtM6EwhSD9NtqzmB1vShvWNWAS/SCgyvP1
         8i2QSmZQckmaqN1tJxEEu6Cio9ezn/La7xU2sa9n2KoJ28vU6hfkE7M2NjZd5oca5S/e
         1N2g==
X-Gm-Message-State: AGi0PuZSNmM+RxpiFpkmFGeTnC9f3NBoWEMUwbXIlM9/AbBIYh/MRZfp
        jQrD4Xfuala7W7J22YF1Ozc1ya3fCiIilA==
X-Google-Smtp-Source: APiQypJBA0YpuslWKZwFn1SkG+EoOe7WxxB7EHh//k/n6eSkavz/dCh+F57Cl4zVLJpPB82+kQ02nA==
X-Received: by 2002:ac8:35e2:: with SMTP id l31mr28306687qtb.104.1587580528321;
        Wed, 22 Apr 2020 11:35:28 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x55sm33045qtk.3.2020.04.22.11.35.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 11:35:27 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200422170116.GA28345@lst.de>
Date:   Wed, 22 Apr 2020 14:35:26 -0400
Cc:     Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <10D18276-0485-4368-BFDE-4EC13E42AE22@lca.pw>
References: <1ED37D02-125F-4919-861A-371981581D9E@lca.pw>
 <20200422170116.GA28345@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2020, at 1:01 PM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> On Wed, Apr 22, 2020 at 11:55:54AM -0400, Qian Cai wrote:
>> Reverted the linux-next commit and its dependency,
>>=20
>> a85573f7e741 ("x86/mm: Unexport __cachemode2pte_tbl=E2=80=9D)
>> 9e294786c89a (=E2=80=9Cx86/mm: Cleanup pgprot_4k_2_large() and =
pgprot_large_2_4k()=E2=80=9D)
>>=20
>> fixed crashes or hard reset on AMD machines during boot that have =
been flagged by
>> KASAN in different forms indicating some sort of memory corruption =
with this config,
>=20
> Interesting.  Your config seems to boot fine in my VM until the point
> where the lack of virtio-blk support stops it from mounting the root
> file system.
>=20
> Looking at the patch I found one bug, although that should not affect
> your config (it should use the pgprotval_t type), and one difference
> that could affect code generation, although I prefer the new version
> (use of __pgprot vs a local variable + pgprot_val()).
>=20
> Two patches attached, can you try them?
> =
<0001-x86-Use-pgprotval_t-in-protval_4k_2_large-and-pgprot.patch><0002-foo=
.patch>

Yes, but both patches do not help here. This time flagged by UBSAN,

static void dump_pagetable(unsigned long address)
{
        pgd_t *base =3D __va(read_cr3_pa());
        pgd_t *pgd =3D base + pgd_index(address); <=E2=80=94=E2=80=94 =
shift-out-of-bounds here

[    4.452663][    T0] ACPI: LAPIC_NMI (acpi_id[0x73] high level =
lint[0x1])
[    4.459391][    T0] ACPI: LAPIC_NMI (acpi_id[0x74] high level =
lint[0x1])
[    4.466115][    T0] ACPI: LAPIC_NMI (acpi_id[0x75] high level =
lint[0x1])
[    4.472842][    T0] ACPI: LAPIC_NMI (acpi_id[0x76] high level =
lint[0x1])
[    4.479567][    T0] ACPI: LAPIC_NMI (acpi_id[0x77] high level =
lint[0x1])
[    4.486294][    T0] ACPI: LAPIC_NMI (acpi_id[0x78] high level =
lint[0x1])
[    4.493021][    T0] ACPI: LAPIC_NMI (acpi_id[0x79] high level =
lint[0x1])
[    4.499745][    T0] ACPI: LAPIC_NMI (acpi_id[0x7a] high level =
lint[0x1])
[    4.506471][    T0] ACPI: LAPIC_NMI (acpi_id[0x7b] high level liad =
access in kernel mode
[    4.901030][    T0] #PF: error_code(0x0000) - not-present page
[    4.906884][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    4.914483][    T0] #PF: supervisor read access in kernel mode
[    4.920334][    T0] #PF: error_code(0x0000) - not-present page
[    4.926189][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    4.933786][    T0] #PF: supervisor read access in kernel mode
[    4.939640][    T0] #PF: error_code(0x0000) - not-present page
[    4.945492][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    4.953091][    T0] #PF: supervisor read access in kernel mode
[    4.958943][    T0] #PF: error_code(0x0000) - not-present page
[    4.964797][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    4.972395][    T0] #PF: supervisor read access in kernel mode
[    4.978247][    T0] #PF: error_code(0x0000) - not-present page
[    4.984102][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    4.9917age fault for address: ffffed11509c29da
[    5.481007][    T0] #PF: supervisor read access in kernel mode
[    5.486862][    T0] #PF: error_code(0x0000) - not-present page
[    5.492713][    T0] BUG: unable to handle page fault for address: =
ffffed11509c29da
[    5.500314][    T0] #PF: supervisor read access in kernel mode
[    5.506165][    T0] #PF: error_code(0x0000) - not-present page
[    5.512020][    T0] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[    5.521193][    T0] UBSAN: shift-out-of-bounds in =
arch/x86/mm/fault.c:450:22
[    5.528268][    T0] shift exponent 4294967295 is too large for 64-bit =
type 'long unsigned int'
[    5.536916][    T0] CPU: 0 PID: 0 Comm: swapper Tainted: G    B       =
      5.7.0-rc2-next-20200422+ #10
[    5.546434][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[    5.555692][    T0] Call Trace:
[    5.558837][    T0] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
[    5.568012][T0] BUG: unable to handle page fault for address: =
0000000a2b84dda8
[    5.961699][    T0] #PF: supervisor read access in kernel mode
[    5.967550][    T0] #PF: error_code(0x0000) - not-present page
[    5.973405][    T0] BUG: unable to handle page fault for address: =
0000000a2b84dda8
[    5.981005][    T0] #PF: supervisor read access in kernel mode
[    5.986856][    T0] #PF: error_code(0x0000) - not-present page
[    5.992708][    T0] BUG: unable to handle page fault for address: =
0000000a2b84dda8
[    6.000308][    T0] #PF: supervisor read access in kernel mode
[    6.006159][    T0] #PF: error_code(0x0000) - not-present page
[    6.012013][    T0] BUG: unable to handle page fault for address: =
0000000a2b84dda8
[    6.019612][    T0] #PF: supervisor read access in kernel mode

