Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03774C54E8C
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53A8206F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="k1C42IHZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbgEJU2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:28:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:41541 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgEJU2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589142506;
        bh=bMZqdNthiSTuJYKFxj2Ewu2TN0qPfKb1X6p0G1ltEbA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=k1C42IHZWDIBziTTxQCJOLoXhmoCfjsU3Q0qwRB1OjNJ1FwPHtdk8psmxqBn/hoeY
         A7bUvqC60g67XvHpSvSAQyEFIsMN+dUM1HJR0Ge1t1cd4V6aPo0yyEVdAflz8I/bXY
         +KLzvglsc2WQrd7N1BXgrKkDesgDMFzRTL6Qmye8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.158.68]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Nv-1iui3n0SPJ-00e2IB; Sun, 10
 May 2020 22:28:26 +0200
Subject: Re: [PATCH] parisc: suppress error messages for 'make clean'
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-parisc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200425054659.814774-1-masahiroy@kernel.org>
 <CAK7LNAQk_fLFCWuFCC0NK3nxVE0bs-n7E+T-dbn14aCZVg_pgQ@mail.gmail.com>
 <20200508214650.GA3482@ls3530.fritz.box>
 <CAK7LNAS0PVA7stUE9nmOuiP=MfPGDp1u-QDzfpk7Juq-JFehVw@mail.gmail.com>
 <20200509173925.GA30635@ls3530.fritz.box>
 <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <11e05a6d-e4bd-e381-7015-2d52e8fdef39@gmx.de>
Date:   Sun, 10 May 2020 22:28:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR+jEzqqFJbCzfEbdnt-H4ZRpfLFA30ODfhhH=QXSk5nQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S3PNbYOHbkcWXQ0JaiJ1nPCR3wEUFjf2eIC5UHJs2KMlMv77GRj
 WB0BEBWZxGxaYE61/1m98nKLuL3p+qYnaKj1bZaExYJKm3UMcgXR+gOJGl4eacJK7XlQTeO
 xAZq/fYs5h2asCieM2BroZq+/vCZkUyCWjw5eiUmppJ//XI7rcB4UBwDKAysFyDDDv2aDEO
 GqPU5685ayjjSMdvgxiTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DT8jbfhE8Yc=:WMO6WY95b4bj23xJTWfBVi
 VOBDN9xa5ADo00SaiIJC4xC7H8zuSzYLK6v6LpeZQ4gw5yeJ2xVGk2f6NElwFeixSp73Fl5D1
 /u/oCWPiMVKGRBIkfsX0MxHLFJMc4nvfKdkY7wR7cfUGIpPg7q/ikLU0xJx08HkAqyDN5z/wo
 4QFW13+AwKGmPwjL5dAhywrl3swuX75g+yiMNMS0DaSBqUWIJnGQWtMu7KzEkAMjh3G4Q/u/D
 tJRCTQ/HA0ipZOZ+jEtxoaBT9NOSEf24NZA/ZG/JuVfAMwExOlWkF+/RA2Vf7MupBEbVdbtTA
 j8KTF9NmqlJUjEA12DhuLlI+u4vqs3Jv5d23/y6S2fT+oRGOA5vyO8hZ6pu6ZEAYbakRHqGZv
 cfY/4qvycy6j/DgFRSN/WHaDEDwB7D9tGqJMDrf5VMc4U6QsUp1xg7zJeYIkN1MkbdW8V194x
 hCbMR4eUzH6bpcWo8nHI9LgBOQAfFfmDpYuV8MrWZBOAsM/XthzuNFLQCNTc78yHBGf2T418V
 GwX808c5oXFoVlzNSYaGXgkRxhveil7t22vMSfnF2MlwQOPkLwNb9lof/ni69df9JiNBTcfIG
 EeZwQvvimqwYYClu47fsqJKrIAwMtiecAVXeC17wfIhetx/nfLmKcjybJEcPOy6pDo+l6xTme
 YLiUtNRmaNEw2VemtoN6sp85CCNYhwsyk+yG2moG3leAYO5IabjaXjN1tx7LFd0ig9ZHJE/62
 RD+Qf9yLezMP/serzRn2xl29s3RiCqIgFzaN+QbZc1RcoQg/Yb61fKLwYcAgagEnjlujdmdXg
 iA7Nx8UIOcOFxYm5v3SVtp1UaIkhcUWMmYcvF7UnLj+HEIv6H8M15a4pPlPLHguVw2nuC1Rez
 umaqlzSBtVSBlvrlcwH69pFuNH2BgCtb7HM6nJbITe/2bWLDdl5ZQG8xOeGb7qbeiNKwD4qha
 PDm7mGS0EVyNAWqeX6/qYe1Sa7b7XKFxu7yL9BNGlL3SXbxHWTx9rovTzQy4SjYHZ0srMXWzd
 ChE1NaeOkZXotdxcDSMnmpW+/2CzN5CQm/vyVz400SmOQpbUIwXDG+JrFs0K9h0btHjQkDzhU
 6kAilFkGKimhl4lVHH+3PJJfgk5LMu7UGekkfz+Ykm9580+NfHumvozpB+mm/hcWV1dDtfyjB
 71i2MTKwXbfHmgHWwT02LXCHHBNd/0Cp3lx0e27Srm6OMAOSyf1HtLBAukJpt7Rw9+7uAmKE0
 JZ0Iu3zxUiU8U32M+
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.05.20 03:19, Masahiro Yamada wrote:
> Hi Helge,
>
> On Sun, May 10, 2020 at 2:39 AM Helge Deller <deller@gmx.de> wrote:
>>
>> * Masahiro Yamada <masahiroy@kernel.org>:
>>> Hi Helge,
>>>
>>> On Sat, May 9, 2020 at 6:46 AM Helge Deller <deller@gmx.de> wrote:
>>>>
>>>> * Masahiro Yamada <masahiroy@kernel.org>:
>>>>> On Sat, Apr 25, 2020 at 2:47 PM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>>>>>>
>>>>>> 'make ARCH=3Dparisc clean' emits a tons of error messages as follow=
s:
>>>>>>
>>>>>>   $ make ARCH=3Dparisc clean
>>>>>>   gcc: error: unrecognized command line option '-mno-space-regs'
>>>>>>   gcc: error: unrecognized command line option '-mfast-indirect-cal=
ls'; did you mean '-mforce-indirect-call'?
>>>>>>   gcc: error: unrecognized command line option '-mdisable-fpregs'
>>>>>>   gcc: error: missing argument to '-Wframe-larger-than=3D'
>>>>>>   gcc: error: unrecognized command line option '-mno-space-regs'
>>>>>>   gcc: error: unrecognized command line option '-mfast-indirect-cal=
ls'; did you mean '-mforce-indirect-call'?
>>>>>>   gcc: error: unrecognized command line option '-mdisable-fpregs'
>>>>>>   gcc: error: missing argument to '-Wframe-larger-than=3D'
>>>>>>     ...
>>>>>>
>>>>>> You can supporess them except '-Wframe-larger-than' by setting corr=
ect
>>>>>> CROSS_COMPILE=3D, but we should not require any compiler for cleani=
ng.
>>>>>>
>>>>>> This $(shell ...) is evaluated so many times because LIBGCC is expo=
rted.
>>>>>> Use the ':=3D' operator to evaluate it just once, and sink the stde=
rr.
>>>>>>
>>>>>
>>>>> Applied to linux-kbuild.
>>>>
>>>> That patch breaks then building the boot loader/compressor:
>>>> ...
>>>>   hppa-linux-gnu-ld    -X -e startup --as-needed -T arch/parisc/boot/=
compressed/vmlinux.lds arch/parisc/boot/compressed/head.o arch/parisc/boot=
/compressed/real2.o arch/parisc/boot/compressed/firmware.o arch/parisc/boo=
t/compressed/misc.o arch/parisc/boot/compressed/piggy.o -o arch/parisc/boo=
t/compressed/vmlinux
>>>> hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `d=
ec_vli':
>>>> (.text+0x104): undefined reference to `__ashldi3'
>>>> hppa-linux-gnu-ld: arch/parisc/boot/compressed/misc.o: in function `l=
zma_len':
>>>> (.text+0x2b0): undefined reference to `$$mulI'
>>>> hppa-linux-gnu-ld: (.text+0x344): undefined reference to `$$mulI'
>>>> hppa-linux-gnu-ld: (.text+0x3f8): undefined reference to `$$mulI'
>>>>
>>>>
>>>> The patch below works, but I wonder if it's possible to avoid
>>>> to examine LIBGCC twice....?
>>>>
>>>> Helge
>>>
>>>
>>> Sorry for the breakage.
>>>
>>> How about moving LIBGCC below ?
>>
>> Good idea.
>> The patch below does work for me.
>> We do not need $KBUILD_CFLAGS to get the libgcc.a filename,
>
>
> I not not sure about this change.
> Generally speaking, the path to libgcc.a is affected
> by compiler flags, especially, bit size flags,
> endian flags, etc.
>
> For example, my distro gcc is biarch for i386/x86_64.
>
> $ gcc -print-libgcc-file-name
> /usr/lib/gcc/x86_64-linux-gnu/9/libgcc.a
> $ gcc -m64 -print-libgcc-file-name
> /usr/lib/gcc/x86_64-linux-gnu/9/libgcc.a
> $ gcc -m32 -print-libgcc-file-name
> /usr/lib/gcc/x86_64-linux-gnu/9/32/libgcc.a
>
> One real example in Linux is arch/arc/Makefile.
> ARC supports both big endian and little endian.
>
> If you drop cflags-y from line 59
> of arch/arc/Makefile, vmlinux fails to link
> due to endian mismatch.
>
>
> I am not familiar with parisc.
> Also, as it turned out,
> this change is not so trivial.
>
> I think the best approach is to leave this up to you
> since you are the parisc maintainer.

Yes, I knew about the possible biarch options.
On parisc that's not relevant yet.


> I will drop this patch from my kbuild tree,
> then you will apply what you think is best
> to your tree.
>
> What do you think?

Sure, I'll take it through the parisc tree.

Thanks!
Helge



>> so we do not need to pipe the output to /dev/null either.
>> Can you try if that works, and if yes, can you apply it?
>>
>> Helge
>>
>>
>> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
>> index 628cd8bb7ad8..fadbbd010337 100644
>> --- a/arch/parisc/Makefile
>> +++ b/arch/parisc/Makefile
>> @@ -21,8 +21,6 @@ KBUILD_IMAGE :=3D vmlinuz
>>
>>  NM             =3D sh $(srctree)/arch/parisc/nm
>>  CHECKFLAGS     +=3D -D__hppa__=3D1
>> -LIBGCC         =3D $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-n=
ame)
>> -export LIBGCC
>>
>>  ifdef CONFIG_64BIT
>>  UTS_MACHINE    :=3D parisc64
>> @@ -110,6 +108,8 @@ cflags-$(CONFIG_PA8X00)             +=3D -march=3D2=
.0 -mschedule=3D8000
>>  head-y                 :=3D arch/parisc/kernel/head.o
>>
>>  KBUILD_CFLAGS  +=3D $(cflags-y)
>> +LIBGCC         :=3D $(shell $(CC) -print-libgcc-file-name)
>> +export LIBGCC
>>
>>  kernel-y                       :=3D mm/ kernel/ math-emu/
>>
>
>

