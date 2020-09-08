Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26E022076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="1tRNglgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIHUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIHUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:35:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19063C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:35:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id o68so263219pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Pi5Ot7NAsKXZl3XWiN+smNBToz4aQuIesxq10kCmT3k=;
        b=1tRNglgMOS8BOH6OLOjRYKqh9Ki7qg9E4DucR8BCg3UxGQL3Wkem6udt1zLg6sW2Df
         BFEIxxwePeJpCIuz28a2ntxIXPKUJX/uGyvV0WaNTlloglSqk4ogkDIh9Dxt1Nr4pqdD
         ke6AhF5cb159RvaRumAByzVy8+3XeeXo7we4fxo5H0n9r0a5mviTorEHZrZrnC96qJNF
         uswciVaihsCTKh1+FKIETBYYm+zTA81f7uOqvPsOGmTaNdcA8Uu54kKh2vOhJapBff5Q
         qnaoxBZAl0TmcZEmpy9vLEcMVH/oVXs2U1hcwPZ1qk5o3OafkkbYXBUIn5UOrxYJlN5Q
         0a+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Pi5Ot7NAsKXZl3XWiN+smNBToz4aQuIesxq10kCmT3k=;
        b=Vi+EnbwuxC4feG6eYuFKn2nh4t/mHT/TXa3XEhA9le5rtDsjr9/KnAfgJMr69lGvBH
         e2478MIvuMYTRdAhAlSVzoDh0u+Uc7t0ZryXM0ILp/566TwERzk53tu8+ebI9dLgW0CT
         OQ93c/Gsru9K8ixpMoQv6SZGIOQeotIYiGUFRmgn7Wi1cHRvwontb88OcT5+im8IDRMr
         r29YqqNGHJ/2eO85kycN8irDT9xUVqIdnHxrkH8bsSngxcSFuZXQxFiZ0dgoRr+YwfwV
         CRjnoUktwAAPScMddRHDvojIjAldLZFTDti7nBpg/enMDQPNNQNEPqbgPeosLHp+js4c
         KGVg==
X-Gm-Message-State: AOAM532isnvnfLOPE8s/0pkEyXgrgSro7UEnSOIelozDlnsWuJu8bUw6
        T0DzObiK3NfD8tDT0exvTf3ZKA==
X-Google-Smtp-Source: ABdhPJwQYEmlnAs64gFZWFpozPfFNewZV6zhYPRoKczIf3aI18vRfj3X8a34Tv4SX20Zycek2N7cTg==
X-Received: by 2002:a17:902:be0b:: with SMTP id r11mr427647pls.84.1599597321777;
        Tue, 08 Sep 2020 13:35:21 -0700 (PDT)
Received: from [100.97.122.108] (3.sub-174-194-201.myvzw.com. [174.194.201.3])
        by smtp.gmail.com with ESMTPSA id h15sm116176pjf.54.2020.09.08.13.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2020 13:35:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Date:   Tue, 8 Sep 2020 13:35:18 -0700
Message-Id: <025308CD-6E1A-41E1-8B3D-E9842CE00794@amacapital.net>
References: <20200908193029.GM25236@zn.tnic>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <20200908193029.GM25236@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>, Matthew Garrett <mjg59@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
X-Mailer: iPhone Mail (17H35)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 8, 2020, at 12:30 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Tue, Sep 08, 2020 at 12:18:38PM -0700, Sultan Alsawaf wrote:
>> I'd like to point out that on Intel's recent 14nm parts, undervolting
>> is not so much for squeezing every last drop of performance out of the
>> SoC as it is for necessity.
>=20
> <snip interesting examples>
>=20
> Sounds to me that this undervolting functionality should be part of
> the kernel and happen automatically. I have no clue, though, whether
> people who do it, just get lucky and undervolting doesn't cause any
> other hardware issues, or there's a real reason for this power madness
> and if not done, power-related failures happen only on some boxes so
> they decided to do them on all.
>=20
> Or maybe BIOS is nuts, which is not a stretch.
>=20
> Srinivas, what's the story here?
>=20

I have seriously mixed opinions about this.

First, there are really two separate issues here. One is undervolting these p=
arts, and one is the MSR interface.

In my mind, the MSR part is an easy call. Userspace has no more business pok=
ing some undocumented mailbox MSR than it does poking any other MSR. We shou=
ld not give special dispensation here. It should be allowed if the MSR restr=
ictions are off, and otherwise we should warn or forbid it.

Undervolting is a bit different. It=E2=80=99s a genuinely useful configurati=
on that can affect system stability.  In general, I think it should be allow=
ed, and it should have a real driver in tree.

But this has a tricky interaction with lockdown.  An interface that allows r=
oot to destabilize a system may well allow root to escalate privileges.  But=
 I think that making lockdown=3Dintegrity prevent tuning voltages and such w=
ould be quite obnoxious.

Should there perhaps be a separate lockdown bit for stability?

I assume that Intel XTU and such work on Secure-Booted Windows.=
