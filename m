Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EFAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5BC4206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="b0fhpks8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgESS4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:56:52 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:43440 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgESS4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4sA6AxHh/ziYHSgQrSVViGoQNOC/5kTIcBK+ywm7WM8=; b=b0fhpks8c2xrL3LgleivySapX
        xvZB69j32yfrQ77ghvImYfV90a7n9tsyLPhtCRxsw+wkepPVmNTFHIdDzcuD8ax98f2jFBAcYDGPg
        1AWW45r0sKxIyEmQ7kOM9RtsKbgrhUsQR7wrTlPzCQrQLEdJWgkyTiP5dQ290FM9wvDzQ=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.117])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jb7Pu-0007Ru-Pf; Tue, 19 May 2020 13:56:45 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <20200519143815.cpsd2xfx2kl3khsq@wrt>
Date:   Tue, 19 May 2020 11:56:40 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2330FAB4-A6CE-49E7-921C-B7D55763BDED@codeweavers.com>
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
To:     Andreas Rammhold <andi@notmuch.email>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 19, 2020, at 7:38 AM, Andreas Rammhold <andi@notmuch.email> =
wrote:
>=20
> Hi,
>=20
> I've been running into a weird problem with UMIP on a current Ryzen
> 3900x with kernel 5.6.11 where a process receives a page fault after =
the
> kernel handled the SLDT (or SIDT) instruction (emulation).
>=20
> The program I am running is run through WINE in 32bit mode and tries =
to
> figure out if it is running in a VMWare machine by comparing the =
results
> of SLDT against well known constants (basically as shown in the
> [example] linked below).
>=20
> In dmesg I see the following log lines:
>> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT =
instruction cannot be used by applications.
>> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now, =
expensive software emulation returns the result.
>> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT =
instruction cannot be used by applications.
>=20
> Following that the process terminates with a page fault:
>> Unhandled exception: page fault on read access to 0xffffffff in =
32-bit code (0x0000000000437415).
>=20
> Assembly at that address:
>> 0x0000000000437415: sldt    0xffffffe8(%ebp)
>=20
> Running the same executable on the exact same kernel (and userland) =
but
> on a Intel i7-8565U doesn't crash at this point. I am guessing the
> emulation is supposed to do something different on AMD CPUs?
>=20
> On the Ryzen the code executes successfully after setting =
CONFIG_X86_UMIP=3Dn.

Hi Andreas,

The problem is that the kernel does not emulate/spoof the SLDT =
instruction, only SGDT, SIDT, and SMSW.
SLDT and STR weren't thought to be commonly used, so emulation/spoofing =
wasn=E2=80=99t added.
In the last few months I have seen reports of one or two (32-bit) =
Windows games that use SLDT though.
Can you share more information about the application you=E2=80=99re =
running?

Maybe the best path is to add kernel emulation/spoofing for SLDT and STR =
on 32 and 64-bit, just to cover all the cases. It should be a pretty =
simple patch, I=E2=80=99ll start working on it.

Alternately, I did work on a Wine patch to emulate the UMIP instructions =
in user-space, but it adds a lot of code and I don=E2=80=99t think =
there=E2=80=99s much appetite for it in upstream Wine (especially since =
the kernel emulation is sufficient for almost all cases).
https://www.winehq.org/pipermail/wine-devel/2020-February/160027.html

In the meantime, an easy way to disable UMIP without rebuilding the =
kernel is to pass 'clearcpuid=3D514=E2=80=99 on the kernel command line.

Brendan Shanks
CodeWeavers

