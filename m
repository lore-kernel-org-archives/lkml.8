Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443A7C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B8C206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="fxNGrtl5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgDCU6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:58:21 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43051 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:58:21 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20so4119176pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 13:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=euB/B4+0rz1g16ewCtOVh1utM9zGLetAIJ5oAEnHJAk=;
        b=fxNGrtl5Km3DfTADt+Yy+DFwU8zHRaCVpQdX2uWS2YvtZEM0qDou98LPXyDOkrIO3m
         x9SSAxjueUb1FzM3zvmBbFBKerWzJ7jBvrQgJ2L/OpF/9ZTGSltKPYwtguLoCB15Jn1U
         AEuyBWBk2QP0TOMRGG2ZmrMEOg9DlYs0xERLgUcmxWEAyzDEPVYiDE/AsLeHflw3VwVa
         WrN8sjw0YRrGVSnRAN0Wdm23ep/IQjeRIGaZfN+peGUe6XAyEiDn49c1l/OQXUC5Le68
         IFGLpdNUbnVz4Jb7G0cKPmdNqXM1Sh94PiK3ikxRti43XXLEpnTnHeumvrSz31WW9vuD
         6ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=euB/B4+0rz1g16ewCtOVh1utM9zGLetAIJ5oAEnHJAk=;
        b=esAGQ4Ir8+S5bJCgaHuQ4McmCt6q2ecDBbmrnvoEZSqp4Bdd4YRsosdJup8G73gDwJ
         hPLtRasPp3eRhtmdjEcw2DTR7ouoQEekHQUKVWPebuyyDO5L14n4fKzqScOrOehYeUV1
         pdVMfElbZjKDQX35EqI98Qsi9uVB/MCP9GCwc3XWZJ1ER5OVgI5lzIVA9yKxGjDxzbI8
         wqO5TTNY/4pTVxywQ01dScFmek1ubpeYedpNjO++zTY8jCrrRVYyKamVrj88bYTI2qyc
         3TnSLl+Ia3jSgIEDNgzJzb2NpP00TCmNQzh/u0CO9xOP5+QQQ7OrNZbBqHGZyXNQaKFU
         L1ng==
X-Gm-Message-State: AGi0PubPfl2Xi6EKKmzis4OkffMecOsfBk67NRtGkpFaejNTbEwoGLxO
        XpzXSOOEX0V8IGidaCN2k+1VUw==
X-Google-Smtp-Source: APiQypJQU8fHVywaSnHOahV1SlozAPzrtFt+JAcBSAa6vcYE6EMXj737YShYGcJSbNoT1NXhWK4AGw==
X-Received: by 2002:a63:e610:: with SMTP id g16mr3251810pgh.354.1585947500013;
        Fri, 03 Apr 2020 13:58:20 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:9e1:3559:f61:3bbc? ([2601:646:c200:1ef2:9e1:3559:f61:3bbc])
        by smtp.gmail.com with ESMTPSA id i4sm6411383pjg.4.2020.04.03.13.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2020 13:58:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
Date:   Fri, 3 Apr 2020 13:58:17 -0700
Message-Id: <737F6739-9B8B-4C73-91D3-B873D5780F5E@amacapital.net>
References: <87o8s8l7t3.fsf@nanos.tec.linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org, vbox-dev@virtualbox.org
In-Reply-To: <87o8s8l7t3.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Apr 3, 2020, at 11:54 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> =EF=BB=BFPeter Zijlstra <peterz@infradead.org> writes:
>>> On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
>>> +++ Rasmus Villemoes [03/04/20 01:42 +0200]:
>>>> On 02/04/2020 14.32, Thomas Gleixner wrote:
>>>>> From: Peter Zijlstra <peterz@infradead.org>
>>>>>=20
>>>>> It turns out that with Split-Lock-Detect enabled (default) any VMX
>>>>> hypervisor needs at least a little modification in order to not blindl=
y
>>>>> inject the #AC into the guest without the guest being ready for it.
>>>>>=20
>>>>> Since there is no telling which module implements a hypervisor, scan t=
he
>>>>> module text and look for the VMLAUNCH instruction. If found, the modul=
e is
>>>>> assumed to be a hypervisor of some sort and SLD is disabled.
>>>>=20
>>>> How long does that scan take/add to module load time? Would it make
>>>> sense to exempt in-tree modules?
>>>>=20
>>>> Rasmus
>>>=20
>>> I second Rasmus's question. It seems rather unfortunate that we have
>>> to do this text scan for every module load on x86, when it doesn't
>>> apply to the majority of them, and only to a handful of out-of-tree
>>> hypervisor modules (assuming kvm is taken care of already).
>>>=20
>>> I wonder if it would make sense then to limit the text scans to just
>>> out-of-tree modules (i.e., missing the intree modinfo flag)?
>>=20
>> It would; didn't know there was one.
>=20
> But that still would not make it complete.
>=20
> I was staring at virtualbox today after Jann pointed out that this
> sucker does complete backwards things.
>=20
>  The kernel driver does not contain any VM* instructions at all.
>=20
> The actual hypervisor code is built as a separate binary and somehow
> loaded into the kernel with their own magic fixup of relocations and
> function linking. This "design" probably comes from the original
> virtualbox implementation which circumvented GPL that way.
>=20
> TBH, I don't care if we wreckage virtualbox simply because that thing is
> already a complete and utter trainwreck violating taste and common sense
> in any possible way. Just for illustration:
>=20
>  - It installs preempt notifiers and the first thing in the callback
>    function is to issue 'stac()'!
>=20
>  - There is quite some other horrible code in there which fiddles in
>    the guts of the kernel just because it can.
>=20
>  - Conditionals in release code which check stuff like
>    VBOX_WITH_TEXT_MODMEM_HACK, VBOX_WITH_EFLAGS_AC_SET_IN_VBOXDRV,
>    VBOX_WITH_NON_PROD_HACK_FOR_PERF_STACKS along with the most absurd
>    hacks ever.
>=20
> If you feel the need to look yourself, please use your eyecancer
> protection gear.
>=20
> Can someone at Oracle please make sure, that this monstrosity gets shred
> in pieces?
>=20
> Enough vented, but that still does not solve the SLD problem in any
> sensible way.

Could we unexport set_memory_x perhaps?  And maybe try to make virtualbox br=
eak in as many ways as possible?

>=20
> Thanks,
>=20
>        tglx
