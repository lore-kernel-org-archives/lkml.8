Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF99C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1800422314
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgATNnE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:43:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:43:04 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1itXJv-0000pm-61; Mon, 20 Jan 2020 14:42:23 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D0FEF105CF0; Mon, 20 Jan 2020 14:42:22 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Krzysztof Piecuch <piecuch@protonmail.com>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     "corbet\@lwn.net" <corbet@lwn.net>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "x86\@kernel.org" <x86@kernel.org>,
        "mchehab+samsung\@kernel.org" <mchehab+samsung@kernel.org>,
        "jpoimboe\@redhat.com" <jpoimboe@redhat.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "pawan.kumar.gupta\@linux.intel.com" 
        <pawan.kumar.gupta@linux.intel.com>,
        "paulmck\@linux.ibm.com" <paulmck@linux.ibm.com>,
        "jgross\@suse.com" <jgross@suse.com>,
        "rafael.j.wysocki\@intel.com" <rafael.j.wysocki@intel.com>,
        "viresh.kumar\@linaro.org" <viresh.kumar@linaro.org>,
        "drake\@endlessm.com" <drake@endlessm.com>,
        "malat\@debian.org" <malat@debian.org>,
        "mzhivich\@akamai.com" <mzhivich@akamai.com>,
        "juri.lelli\@redhat.com" <juri.lelli@redhat.com>,
        "linux-doc\@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/tsc: Add tsc_tuned_baseclk flag disabling CPUID.16h use for tsc calibration
In-Reply-To: <pdsz0EbsOFH8qmBn1Uv20EOOr71rKXljZIItC75EhT9KO4TKEKrt83Es88ZeaAh3MYuk0UM8F6XKfvmmRHgZjF50CXk9sigWEH_SyXp6lZE=@protonmail.com>
References: <9rN6HvBfpUYE7XjHYSTKXKkKOUHQd_skSYGqjXlI0jTIk4nqLoLUloev1jgSayOdvzmkXgRNP8j_mgcikMJy6L_JN_vJhUJn9vD9xm_ueSo=@protonmail.com> <6BFAC54D-65CA-4F8A-9C5B-CEFB108C90FD@amacapital.net> <pdsz0EbsOFH8qmBn1Uv20EOOr71rKXljZIItC75EhT9KO4TKEKrt83Es88ZeaAh3MYuk0UM8F6XKfvmmRHgZjF50CXk9sigWEH_SyXp6lZE=@protonmail.com>
Date:   Mon, 20 Jan 2020 14:42:22 +0100
Message-ID: <871rru4535.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof,

Krzysztof Piecuch <piecuch@protonmail.com> writes:
> On Friday, January 17, 2020 4:37 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>> Wouldn’t it be better to have an option tsc_max_refinement= to increase the 1%?
>
> All that is in the commends about it say that:
>
>  * If there are any calibration anomalies (too many SMIs, etc),
>  * or the refined calibration is off by 1% of the fast early
>  * calibration, we throw out the new calibration and use the
>  * early calibration.
>
> I still don't fully understand why the "1% rule" exists.

Simply because all of this is horribly fragile and if you put virt into
the picture it gets even worse.

The initial calibration via PIT/HPET is halfways accurate in most cases
and we use the 1% as a sanity check.

> Ideally it would be better to get the early calibration right than
> risk getting it wrong because of an "anomaly".

Ideally we would just have a way to read the stupid frequency from some
reliable place, but there is no such thing.

Guess why we have all this code, surely not because we have nothing
better to do than dreaming up a variety of weird ways to figure out that
frequency.

> OTOH if you system doesn't support any of the early calibration
> methods other than CPUID.16h (mine doesn't support either PIT or MSR)
> "tsc_max_refinement" would allow you to control max tsc_hz error.

Widening the error window here is clearly a hack. As you have to supply
a valid number there, then why not just providing the frequency itself
on the command line? That would at least make most sense and would avoid
to use completely wrong data in the early boot stage.

Thanks,

        tglx
