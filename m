Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37992C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067472051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NbMrO5f5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbgCWSTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:19:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34033 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727141AbgCWSTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:19:54 -0400
Received: from [IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372] ([IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02NIJTwW2743830
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Mar 2020 11:19:32 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02NIJTwW2743830
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1584987572;
        bh=uyvTxOGuIfKng6B6meCMKRv3OcCkrewSTJXqYHGMw+M=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=NbMrO5f5M5qN4EmSOSGBOPN9qCRzxkoBVCW1W9GG3djS3u8bvcrP/IeUhLk1wv6SK
         O40/VwN8uFLLAOAhEzP65zAPHZYmZTq6llHfqbZpggHK8FMH2/eZdEaJA+DtnK/XSs
         +6/QSoLw7m665yGUnvaeXC1Cu9cG3hOjOus4VfoCiDt9b6KNYLL9nDqd6cQDrEzW7B
         OuSCLbarU9E/zGp04so/L6Ee9+kdxcpM9lMvE2E3tBcBKcl1SCRb5Zzj+pVLq/xtKl
         vcJlMmUAQY3b05wXMs1qQ13/Agg6kXe668FA+57Ptxx7tccwesbPG9xRV+sjTRReLc
         9ChipudnVcr1A==
Date:   Mon, 23 Mar 2020 11:19:21 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com> <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     Matthew Garrett <mjg59@google.com>
CC:     ron minnich <rminnich@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 20, 2020 11:19:19 AM PDT, Matthew Garrett <mjg59@google=2Ecom> wro=
te:
>On Thu, Mar 19, 2020 at 5:59 PM <hpa@zytor=2Ecom> wrote:
>
>> It has been designated consumed by the bootloader on x86 since at
>least 1995=2E So ARM broke it=2E
>
>Eh=2E This feels like a matter of semantics - booting the kernel via EFI
>results in it being parsed by the boot stub, so in that case we're
>left arguing that the boot stub isn't the kernel=2E I can just about buy
>that, but it's a stretch=2E For this change to actually break something,
>we'd need the bootloader to be passing something that the kernel
>parses, but not actually populating the initrd fields in bootparams=2E
>That seems unlikely?

You are right as long as this is the very last priority *and* neither boot=
 loaders nor the kernel will croak on unexpected input (I really object to =
Ron calling the non-x86 version "standard", but that's a whole other ball o=
f wax=2E)

Pointing to any number of memory chunks via setup_data works and doesn't n=
eed to be exposed to the user, but I guess the above is reasonable=2E

*However*, I would also suggest adding "initrdmem=3D" across architectures=
 that doesn't have the ambiguity=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
