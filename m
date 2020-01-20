Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F74C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48EA122314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TCR5hUsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgATOUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:20:13 -0500
Received: from mail4.protonmail.ch ([185.70.40.27]:32249 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727285AbgATOUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:20:13 -0500
Date:   Mon, 20 Jan 2020 14:20:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1579530011;
        bh=F6zq9nm/Ri9Wc3JAzDzqc/NsBZlXQNstVWMJ+FiUD2Q=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=TCR5hUsb/JnJc7uM8oxBC3I6eBvwEg/FoIUMNWIeHnlCgpRePl2SfSTFz80zqlASn
         6rKu+yfYy1x6o5WPBkXVuHEsNIcUjgn75L6LhZBTNCMbBIX0ggE9oNfjLAumZro3Xb
         iBytV4Ecp7y7Z83BtkHWlAyM4Rgn6jw8aJe5MIgQ=
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        "corbet\\@lwn.net" <corbet@lwn.net>,
        "mingo\\@redhat.com" <mingo@redhat.com>,
        "bp\\@alien8.de" <bp@alien8.de>, "hpa\\@zytor.com" <hpa@zytor.com>,
        "x86\\@kernel.org" <x86@kernel.org>,
        "mchehab+samsung\\@kernel.org" <mchehab+samsung@kernel.org>,
        "jpoimboe\\@redhat.com" <jpoimboe@redhat.com>,
        "gregkh\\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawan.kumar.gupta\\@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paulmck\\@linux.ibm.com" <paulmck@linux.ibm.com>,
        "jgross\\@suse.com" <jgross@suse.com>,
        "rafael.j.wysocki\\@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar\\@linaro.org" <viresh.kumar@linaro.org>,
        "drake\\@endlessm.com" <drake@endlessm.com>,
        "malat\\@debian.org" <malat@debian.org>,
        "mzhivich\\@akamai.com" <mzhivich@akamai.com>,
        "juri.lelli\\@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc\\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_tuned_baseclk flag disabling CPUID.16h use for tsc calibration
Message-ID: <ap4FOrto78iOuRRggmgRTphowIopQYqbTDWXbRr82-Ipk_351W6863FJjJHWjrGFsZanu7_C3YrIXCdmCVziB1V4E-Rsn4Tp698EBJPR0C4=@protonmail.com>
In-Reply-To: <871rru4535.fsf@nanos.tec.linutronix.de>
References: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com>
 <6BFAC54D-65CA-4F8A-9C5B-CEFB108C90FD@amacapital.net>
 <pdsz0EbsOFH8qmBn1Uv20EOOr71rKXljZIItC75EhT9KO4TKEKrt83Es88ZeaAh3MYuk0UM8F6XKfvmmRHgZjF50CXk9sigWEH_SyXp6lZE=@protonmail.com>
 <871rru4535.fsf@nanos.tec.linutronix.de>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, January 20, 2020 1:42 PM, Thomas Gleixner <tglx@linutronix.de> w=
rote:
>
> Simply because all of this is horribly fragile and if you put virt into
> the picture it gets even worse.
>
> The initial calibration via PIT/HPET is halfways accurate in most cases
> and we use the 1% as a sanity check.
>
> > Ideally it would be better to get the early calibration right than
> > risk getting it wrong because of an "anomaly".
>
> Ideally we would just have a way to read the stupid frequency from some
> reliable place, but there is no such thing.
>
> Guess why we have all this code, surely not because we have nothing
> better to do than dreaming up a variety of weird ways to figure out that
> frequency.

Thank you for the explanation.

> Widening the error window here is clearly a hack. As you have to supply
> a valid number there, then why not just providing the frequency itself
> on the command line? That would at least make most sense and would avoid
> to use completely wrong data in the early boot stage.

That sounds good.
I'll assume that the user will be supposed to provide a flag tsc_early_hz=
=3D
so that refine_calibration_work can get better numbers while still doing
the 1% sanity check.

I'll send a patch this week.
