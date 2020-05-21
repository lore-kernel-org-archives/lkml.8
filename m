Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AB8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D95207C4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="2KSJPMRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgEUBQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbgEUBQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:16:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E2DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:16:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so2125622plr.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EVFFF/bswX1dtLD0llaLbD03GaNzVbidLthiJ37pib4=;
        b=2KSJPMRLzKeaFRSb4zohK0PbG1LziLZ6mpRxNDY8/xtWJbT6uO7sQ/+3ZzBxszojQ/
         WDDmGBxsEx9UQKWKmbDjFUpNBnFSPdFlrNoL2PM3RNPvsP+YSQURfvBf7UuVutYRLrtY
         +h4jmXZAffUmtU+huNrhoXQgwHPQOqgsGMyJBKSFFGj5qxoOwQYm2HztrEafOSOAhrlv
         f6cvTLU1P4yOS29KlxU7iP4GYPYN8Ah0032VF6K7inlpSrQajXVEgCNYlfMM0G92k3Jw
         hO2Pv11zF9n6wM54WvIcm1y1f9eSNIfFiisEqX/FtpZVoyn91Wj+HzEJWa7X3mfsOoJw
         gA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EVFFF/bswX1dtLD0llaLbD03GaNzVbidLthiJ37pib4=;
        b=HWZUXx1pxib3eZrltQlKdWH/9fSlkXs7PEthG/P4SX8jREK4gS3ijYxJ7q2Po/lELw
         xFKjaCz5o/Cfa569tvw05Gn7krp5mAESLRk4YuTOzr4HgZYN6C+PX98jY0VnRVviJ1AY
         bB2Vj/oBknW0jH+77F0tCREh12hRAr1+aelkpKLuXUVuSSJByJJ0LGzvILx8SE47MSjb
         vA9gP5PTw+uc5vqcGAD/ZJM/ToxRT5RO+bjPlFBJJI4binpIntt9VJ7r/1M2PRQ/hHQ1
         ZFTWPfYhMjZz4WdVwd+HnfEUIN31FuBTFuNYT8/EHmaliY3BTnaf/QPpjju5XCivXntA
         dMww==
X-Gm-Message-State: AOAM533o+sLB+pv4VusG3tGD6PwPaFV7SGxlrs8YHwztQgXZC0vBlila
        vWxW5xdlteeIOnz3cndxXz2pLg==
X-Google-Smtp-Source: ABdhPJyrA5+SaXUoITBnBo72QN3fz+ziHjE7zpdv6AnnDNYKgxx/LdRRY27sSi8qf3ZEIbuMQPw1fA==
X-Received: by 2002:a17:90a:4809:: with SMTP id a9mr8365942pjh.196.1590023800870;
        Wed, 20 May 2020 18:16:40 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ec8d:3be0:a144:9382? ([2601:646:c200:1ef2:ec8d:3be0:a144:9382])
        by smtp.gmail.com with ESMTPSA id d126sm3085886pfc.81.2020.05.20.18.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 18:16:40 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT instruction
Date:   Wed, 20 May 2020 18:16:37 -0700
Message-Id: <AD88C928-85A9-482C-9EE9-19A82343075A@amacapital.net>
References: <20200521005605.GA11955@ranerica-svr.sc.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Brendan Shanks <bshanks@codeweavers.com>,
        Andreas Rammhold <andi@notmuch.email>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521005605.GA11955@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On May 20, 2020, at 5:55 PM, Ricardo Neri <ricardo.neri-calderon@linux.int=
el.com> wrote:
>=20
> =EF=BB=BFOn Tue, May 19, 2020 at 05:54:53PM -0700, Andy Lutomirski wrote:
>>> On Tue, May 19, 2020 at 12:43 PM Ricardo Neri
>>> <ricardo.neri-calderon@linux.intel.com> wrote:
>>>=20
>>> On Tue, May 19, 2020 at 11:56:40AM -0700, Brendan Shanks wrote:
>>>>=20
>>>>> On May 19, 2020, at 7:38 AM, Andreas Rammhold <andi@notmuch.email> wro=
te:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> I've been running into a weird problem with UMIP on a current Ryzen
>>>>> 3900x with kernel 5.6.11 where a process receives a page fault after t=
he
>>>>> kernel handled the SLDT (or SIDT) instruction (emulation).
>>>>>=20
>>>>> The program I am running is run through WINE in 32bit mode and tries t=
o
>>>>> figure out if it is running in a VMWare machine by comparing the resul=
ts
>>>>> of SLDT against well known constants (basically as shown in the
>>>>> [example] linked below).
>>>>>=20
>>>>> In dmesg I see the following log lines:
>>>>>> [99970.004756] umip: Program.exe[3080] ip:4373fb sp:32f3e0: SIDT inst=
ruction cannot be used by applications.
>>>>>> [99970.004757] umip: Program.exe[3080] ip:4373fb sp:32f3e0: For now, e=
xpensive software emulation returns the result.
>>>>>> [99970.004758] umip: Program.exe[3080] ip:437415 sp:32f3e0: SLDT inst=
ruction cannot be used by applications.
>>>>>=20
>>>>> Following that the process terminates with a page fault:
>>>>>> Unhandled exception: page fault on read access to 0xffffffff in 32-bi=
t code (0x0000000000437415).
>>>>>=20
>>>>> Assembly at that address:
>>>>>> 0x0000000000437415: sldt    0xffffffe8(%ebp)
>>>>>=20
>>>>> Running the same executable on the exact same kernel (and userland) bu=
t
>>>>> on a Intel i7-8565U doesn't crash at this point. I am guessing the
>>>>> emulation is supposed to do something different on AMD CPUs?
>>>=20
>>> I am surprised you don't see it on the Intel processor. Maybe it does
>>> not have UMIP. Do you see umip when you do
>>>=20
>>> $ grep umip /proc/cpuinfo
>>>=20
>>> ?
>>>>>=20
>>>>> On the Ryzen the code executes successfully after setting CONFIG_X86_U=
MIP=3Dn.
>>>>=20
>>>> Hi Andreas,
>>>>=20
>>>> The problem is that the kernel does not emulate/spoof the SLDT instruct=
ion, only SGDT, SIDT, and SMSW.
>>>> SLDT and STR weren't thought to be commonly used, so emulation/spoofing=
 wasn=E2=80=99t added.
>>>> In the last few months I have seen reports of one or two (32-bit) Windo=
ws games that use SLDT though.
>>>> Can you share more information about the application you=E2=80=99re run=
ning?
>>>>=20
>>>> Maybe the best path is to add kernel emulation/spoofing for SLDT and ST=
R on 32 and 64-bit, just to cover all the cases. It should be a pretty simpl=
e patch, I=E2=80=99ll start working on it.
>>>=20
>>> I have a patch for this already that I wrote for testing purposes:
>>>=20
>>> https://github.com/ricardon/tip/commit/1692889cb3f8accb523d44b682458e234=
b93be50
>>>=20
>>> Perhaps it can be used as a starting point? Not sure what the spoofing
>>> value should be, though. Perhaps 0?
>>=20
>> Possibly SLDT should return nonzero if there's an LDT.
>=20
> I guess the value should be in the same hole of the x86_64 memory map,
> right? Currently sgdt and sidt return 0xfffffffffffe0000 and
> 0xffffffffffff0000, respectively.

As far as I=E2=80=99m concerned, it makes no difference whether it=E2=80=99s=
 a hole in the memory map.  But sure.

>=20
> Thanks and BR,
> Ricardo
