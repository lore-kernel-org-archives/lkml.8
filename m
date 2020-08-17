Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D446FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E800205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="BeiUDh51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbgHQPBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgHQPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:01:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4224C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:01:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so7645901plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KOIciDO+61GyVuge1NCwmbAu83r395tnqwvCIrTeovc=;
        b=BeiUDh51c342VXyWX+k+aExsUP/587QINOjBOYAZWim2+YEOJDM29M/iQo72ijK25a
         5EurgMogHoTC/F4f0ppHedjtfocbNh/PpbeufU9Loue1r3VLl6gY1y38IacHzedwyYo/
         rHwmGIvDfmhbclhQdWUDLAiuoXxBNcq5dYqN5KpXyqkLcN+1xwhR6E4xJIlr0oOMA4nh
         0XNMy1iphLtcTaRFeUKr7/PXuonBNGLyMxEZ+n6f9MmayGsMRO8olL4Gv+RiTPj38f3a
         2S835096g8hrlDZ0UvXhcddboXPSymUjEPHRsqiegzLwa+kLHicw0YDdwuKfuqlhXImA
         BSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KOIciDO+61GyVuge1NCwmbAu83r395tnqwvCIrTeovc=;
        b=r+/Cbz3GAbPkMx8zuTgNQbNz0p6zkOoKnhd8nNE4VKZxLIEddYbHic/EuF+yiL7Pj0
         qu4WIH21EbdUFXLxoEPXnkoC6bQVricAnxMtW2k9CxZ6XRb/rXcnR5zX67hlcExPTYME
         SDnHkufhVTcG2h06ykKZtIPy9+8yLGbn/yc0E1waqwHidoIvBli2U92YTvOgQdVfz+zN
         twav8Z3q9tlIs5F5i816sqdctg6UZDKu+4wGp/5/8+0w1IPv5b7Vv+9vWacY8pojS7a9
         H23dUvDkILMXJiBcLr1ctpcrYxt4hErS/5AJU3mQ/gzs7a5vXBiQt71HLkCtAq3+/x5g
         4uWQ==
X-Gm-Message-State: AOAM531b21vKy/qYoHefz4Q5wfBVvqrkJcfFmzrxGClDKzh0OL20tMEf
        VITg2+YdaoOM5uDuDMBy6ot8DQ==
X-Google-Smtp-Source: ABdhPJwE7Y7/EYBW/tDd7UI/ntfVhIWEYHXXwlWBt1nrw+LsDdjjKWBaIiAVjAhVv6GxQlQFYvXzZQ==
X-Received: by 2002:a17:902:8648:: with SMTP id y8mr11382279plt.91.1597676471151;
        Mon, 17 Aug 2020 08:01:11 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:acdf:ddf6:398a:d610? ([2601:646:c200:1ef2:acdf:ddf6:398a:d610])
        by smtp.gmail.com with ESMTPSA id d81sm20127227pfd.174.2020.08.17.08.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 08:01:09 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v36 21/24] x86/vdso: Implement a vDSO for Intel SGX enclave call
Date:   Mon, 17 Aug 2020 08:01:04 -0700
Message-Id: <2125C4DB-FB1C-4049-8020-99ED0AB2DEE3@amacapital.net>
References: <CAOASepOFh-vOrNZEVDFrDSuHs+9GEzzpXUTG-fZMuyjWAkpRWw@mail.gmail.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>, linux-sgx@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Cedric Xing <cedric.xing@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        asapek@google.com, Borislav Petkov <bp@alien8.de>,
        chenalexchen@google.com, Conrad Parker <conradparker@google.com>,
        cyhanish@google.com, Dave Hansen <dave.hansen@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Keith Moyer <kmoy@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Neil Horman <nhorman@redhat.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, yaozhangx@google.com
In-Reply-To: <CAOASepOFh-vOrNZEVDFrDSuHs+9GEzzpXUTG-fZMuyjWAkpRWw@mail.gmail.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Aug 17, 2020, at 6:12 AM, Nathaniel McCallum <npmccallum@redhat.com> wr=
ote:
>=20
> =EF=BB=BFOn Mon, Aug 10, 2020 at 7:09 PM Andy Lutomirski <luto@kernel.org>=
 wrote:
>>=20
>>> On Thu, Aug 6, 2020 at 7:55 AM Nathaniel McCallum <npmccallum@redhat.com=
> wrote:
>>>=20
>>> In a past revision of this patch, I had requested a void *misc
>>> parameter that could be passed through vdso_sgx_enter_enclave_t into
>>> sgx_enclave_exit_handler_t. This request encountered some push back
>>> and I dropped the issue. However, I'd like to revisit it or something
>>> similar.
>>=20
>> Why do you need an exit handler at all?  IIRC way back when I
>> suggested that we simply not support it at all.  If you want to
>> call__vdso_sgx_enter_enclave() in a loop, call it in a loop.  If you
>> want to wrap it intelligently in Rust, you don't want a callback
>> anyway -- that forces you have an FFI (or non-Rust, anyway) frame on
>> the stack, which interacts poorly with panic handling and prevents you
>> from using await in your Rust callback handler.  If, on the other
>> hand, you just call __vdso_sg_enter_enclave() in a loop, all these
>> problems go away and, if you really want, you can pass in a callback
>> in Rust and call the callback from Rust.
>>=20
>> What am I missing?  I still don't really understand why we are
>> supporting this mechanism at all.  Just the asm code to invoke the
>> callback seems to be about half of the entire function.
>=20
> There are three ways to pass state between the enclave and the outside wor=
ld:
> 1. A pre-allocated memory block at enclave creation time.
> 2. A contract for pushing values onto the stack during entry/exit.
> 3. All registers and flags besides rax, rbx, and rcx.
>=20
> Under the current vDSO function:
>=20
> #1 is completely possible without a handler. The challenge is how to
> communicate the address of this memory to the enclave. This can be
> accomplished by a parameter in a measured block or by convention.
> Otherwise, it needs to use #2 or #3 to communicate the address of the
> block.
>=20
> #2 requires a handler written in assembly. The semantics are well known.

No one seems particularly interested in my suggestion that the RSP exposed t=
o the enclave be different from the actual untrusted stack. Oh well.

That being said, if I were writing a Rust wrapper for SGX (or Python or any l=
anguage with a reasonable form of async/await), I would want the vDSO code t=
o support swapping RSP before ENCLU because I would want to have first-class=
 support for invoking an enclave from an async function and suspending insid=
e the handler. Allocating a real stack (and shadow stack once CET shows up) f=
or this is disgusting.  If the vDSO supported this natively, it could (in pr=
inciple) interact with signal delivery such that signals would not see the a=
lternative stack.

I do admit that the implementation would not be pretty. Honestly, I think In=
tel messed up by exposing USER_RSP to enclaves in the first place.

>=20
> #3 is possible without a handler, but only for the subset of the
> registers allowed by the calling convention. However, with a handler
> written in assembly you can pass both in and out the full range of
> registers. To do this, the assembly handler needs a pointer to a
> buffer to save the registers into. How does it get said pointer?
> Currently: offsetof, which Rust doesn't support.

I find this justification a bit silly. Binutils asm (gas) doesn=E2=80=99t su=
pport offsetof for C structs either, and Linux works just fine. We=E2=80=99r=
e talking about hardcoding one number along with an assertion somewhere that=
 the number is correct, right?  Couldn=E2=80=99t sizeof be used, too?

To be clear, I think that passing around a misc pointer seems entirely reaso=
nable, but I see it as a nice feature, not as a requirement for correct usag=
e of the function.=
