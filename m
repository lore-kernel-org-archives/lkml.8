Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25796C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC1DF20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="KEEq6PJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCWVl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:41:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33373 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgCWVl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:41:27 -0400
Received: from [IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372] ([IPv6:2601:646:8600:3281:9577:eff3:b2f7:e372])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 02NLf8Wb2806770
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 23 Mar 2020 14:41:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 02NLf8Wb2806770
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020022001; t=1584999672;
        bh=w2MG91LkaSt9RC2E8wpHZp+JMoQKMaXMR+DC3b8lcSA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=KEEq6PJ9PlveDPHx0+4hNKjPYEWDwNKsITAeZJG/3OY9xlCYXlR2A6ORXPFVmC4IL
         r0JiOMWrWQ7552nIFm/9+e2E3qDsMpnXIkrVbH1euGOGoxoWjB8J8xDesQosRjd+MV
         uA/tUvu1x5WVS5IpLP/JcXjVeTr+yrLFMh4fkgv46MzwycZwxBRwExzNcXEH3Q9uSD
         b+ORvf6NlJScpPyNkhA7zjNRLx363NNvUjPnkENQmRdy87SgTadS2Sw1jw3ne0U5f9
         p0GsFlU2rxFEA7H7HeM0kLneewfbCmorCUoQX4+a+2hAu4/vqPD3hMGsphWcbN8CXZ
         tc13vNSOAkOZw==
Date:   Mon, 23 Mar 2020 14:41:00 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com> <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com> <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com> <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com> <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     ron minnich <rminnich@gmail.com>
CC:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   hpa@zytor.com
Message-ID: <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 23, 2020 12:40:15 PM PDT, ron minnich <rminnich@gmail=2Ecom> wrote=
:
>I'm wondering -- adding initrdmem=3D is easy, do you think we'll ever be
>able to end uses of initrd=3D in the ARM and MIPS world? Is it ok to
>have these two identical command line parameters? I'm guessing just
>changing initrd=3D would be hard=2E
>
>Do we just accept initrd=3D from this day forward, as well as initrdmem=
=3D?
>
>On Mon, Mar 23, 2020 at 12:06 PM <hpa@zytor=2Ecom> wrote:
>>
>> On March 23, 2020 11:54:28 AM PDT, ron minnich <rminnich@gmail=2Ecom>
>wrote:
>> >On Mon, Mar 23, 2020 at 11:19 AM <hpa@zytor=2Ecom> wrote:
>> >> Pointing to any number of memory chunks via setup_data works and
>> >doesn't need to be exposed to the user, but I guess the above is
>> >reasonable=2E
>> >
>> >so, good to go?
>> >
>> >>
>> >> *However*, I would also suggest adding "initrdmem=3D" across
>> >architectures that doesn't have the ambiguity=2E
>> >
>> >agreed=2E I can look at doing that next=2E
>> >
>> >ron
>>
>> I would prefer if we could put both into the same patchset=2E
>> --
>> Sent from my Android device with K-9 Mail=2E Please excuse my brevity=
=2E

Yes, accept both=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
