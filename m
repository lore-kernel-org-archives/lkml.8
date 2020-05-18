Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD420C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66EA207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 08:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="qqCr/U7Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T9C0di6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgERIK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 04:10:58 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41913 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgERIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 04:10:57 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BB0805C0135;
        Mon, 18 May 2020 04:10:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Mon, 18 May 2020 04:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm2; bh=0VCyxFvAMhgusgpYr5rZXUJVhIUn8Js
        Ts3zpGGtk/U0=; b=qqCr/U7ZsqicykMchNolnowqKvxzNY/evSBODVQQ7E0w/oB
        d/qF7NUTRhCbO/ZX8y3WxrsdPhJ+mA46E3n/C0RhbrrEfU/akHwmt+Jj1+QiuXVi
        J8w1vh3af7RD1euv7ZD/seRCYYDudB/9P8UOydCt6XxynGzH0YtPWAZ1XqU8KrXb
        hl9J0gn/iG/wbWXgZOJRnVlzF9zgYS+HnmDzPrX3U3BLlmZlIz0QISWPFCEdzhzi
        CAkD5/41cS0oAu5oLU8mCrr2p0D0bIDTXFXv/UBYv8w8HDOPuKiONS0gbK+c9LrV
        r5B8N1+OnJ2QtIzAipWiTPIeZnMEVGZEUuSRWcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=0VCyxF
        vAMhgusgpYr5rZXUJVhIUn8JsTs3zpGGtk/U0=; b=T9C0di6fpbvAhkF2JLufwu
        fYCXmSMEM+NSdwzWW2JnJKDNTD3rHRiwGVwCGxxegyu/g0m3qXrRJa7ppJioeMOq
        ku4lbGzoVn9zfs5f0OupupdyOl5sUr+1qPqowvGj1iRHy3JL769SgO9ZpneHeMe2
        0a4U9m8uwI72TSw/OUNGW++XAYO/U7eMpM+RqkHNPQPKisZiU/G/Sw9iutelNIxJ
        LBSRnfbi+hZJ+8Befupo5Kiyec0t2KxoGzSUMw9Fu6yaFG9q5EB6vqcqZlw1m9IA
        bfWIs5Dgv76MLPsadpY1VOPBzjtSzmqoRrI7iMj8IVo+fcqhKgr/8cBgU57D1YfA
        ==
X-ME-Sender: <xms:DUPCXqjCTbbGhrZ3bGJBN7-MW1nPOL8J7dCfifvDJWZdP6yNHZM7lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddthedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreerjeenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepuddttdekueeggedvtddtueekiedutdfguedutdefieeuteefieelteet
    vddthfeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghnughrvgifsegrjhdrihgurdgruh
X-ME-Proxy: <xmx:DUPCXrDt1OZLn0weyuVs_63PfANhJRqOctaWv6-1wQuHZvShsS4SCA>
    <xmx:DUPCXiGs1UsRn-tIOlMXqGPSlZ6JKi0HG4NyuiscNNMlu0T3Zs4sjw>
    <xmx:DUPCXjRc79OBZYouM7Pb9zXXZgKzJqpEqY4lnauiI6BVANrMl1rWvg>
    <xmx:EEPCXn8KxaReefRybqzM0YKLIVqJVW9XuX_gW20J4X8mlq-07XWQvQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 231EAE00B3; Mon, 18 May 2020 04:10:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-464-g810d66a-fmstable-20200518v1
Mime-Version: 1.0
Message-Id: <bc674840-0789-4055-a228-d092f52f1ec6@www.fastmail.com>
In-Reply-To: <20200517160227.GU1551@shell.armlinux.org.uk>
References: <20200517153959.293224-1-andrew@aj.id.au>
 <20200517160227.GU1551@shell.armlinux.org.uk>
Date:   Mon, 18 May 2020 17:40:31 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Russell King" <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Kees Cook" <keescook@chromium.org>,
        "Masami Hiramatsu" <mhiramat@kernel.org>, labbott@redhat.com,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH]_ARM:_kprobes:_Avoid_fortify=5Fpanic()_when_copying?=
 =?UTF-8?Q?_optprobe_template?=
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 May 2020, at 01:32, Russell King - ARM Linux admin wrote:
> On Mon, May 18, 2020 at 01:09:59AM +0930, Andrew Jeffery wrote:
> > Setting both CONFIG_KPROBES=y and CONFIG_FORTIFY_SOURCE=y on ARM leads
> > to a panic in memcpy() when injecting a kprobe despite the fixes found
> > in commit e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with
> > FORTIFY_SOURCE") and commit 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes:
> > optimized kprobes illegal instruction").
> > 
> > arch/arm/include/asm/kprobes.h effectively declares
> > the target type of the optprobe_template_entry assembly label as a u32,
> > which leads memcpy()'s __builtin_object_size() call to determine that
> > the pointed-to object is of size four. In practical terms the symbol is
> > used as a handle for the optimised probe assembly template that is at
> > least 96 bytes in size. The symbol's use despite its type blows up the
> > memcpy() in ARM's arch_prepare_optimized_kprobe() with a false-positive
> > fortify_panic() when it should instead copy the optimised probe template
> > into place.
> > 
> > As mentioned, a couple of attempts have been made to address the issue
> > by casting a pointer to optprobe_template_entry before providing it to
> > memcpy(), however gccs such as Ubuntu 20.04's arm-linux-gnueabi-gcc
> > 9.3.0 (Ubuntu 9.3.0-10ubuntu1) see through these efforts.
> > 
> > Squash the false-positive by aliasing the template assembly with a new
> > symbol 'arm_optprobe_template'; declare it as a function object and
> > pass the function object as the argument to memcpy() such that
> > __builtin_object_size() cannot immediately determine the object size.
> > 
> > Fixes: e46daee53bb5 ("ARM: 8806/1: kprobes: Fix false positive with FORTIFY_SOURCE")
> > Fixes: 0ac569bf6a79 ("ARM: 8834/1: Fix: kprobes: optimized kprobes illegal instruction")
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > ---
> >  arch/arm/include/asm/kprobes.h    | 7 +++++++
> >  arch/arm/probes/kprobes/opt-arm.c | 4 +++-
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/include/asm/kprobes.h b/arch/arm/include/asm/kprobes.h
> > index 213607a1f45c..94db8bf25f9c 100644
> > --- a/arch/arm/include/asm/kprobes.h
> > +++ b/arch/arm/include/asm/kprobes.h
> > @@ -43,6 +43,13 @@ int kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr);
> >  int kprobe_exceptions_notify(struct notifier_block *self,
> >  			     unsigned long val, void *data);
> >  
> > +/*
> > + * The optprobe template buffer is not anything that should be called directly,
> > + * however describe it as a function to give ourselves a handle to it that
> > + * bypasses CONFIG_FORTIFY_SOURCE=y sanity checks in memcpy().
> > + */
> > +extern __visible void arm_optprobe_template(void);
> 
> Does this really need to be globally visible to anything that happens
> to include this header?
> 
> While we may abhor "extern" declarations and prototypes in .c files, it
> seems to me to be entirely reasonable for this to live in opt-arm.c and
> remove the .global for this symbol, thereby making this symbol local to
> opt-arm.c

You are right, exposing it globally was unnecessary, I got caught up poking
at the other symbols. But I think we should go with Kees' patch instead.

Thanks for the quick feedback.

Andrew
