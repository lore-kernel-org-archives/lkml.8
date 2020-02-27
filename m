Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA537C4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8335A21556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgB0NaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:30:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34289 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729110AbgB0NaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:30:06 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j7JEh-0001eE-KQ; Thu, 27 Feb 2020 14:29:55 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C0FEE1040A9; Thu, 27 Feb 2020 14:29:54 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 14/18] x86: Replace setup_irq() by request_irq()
In-Reply-To: <20200227113648.GA5760@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com> <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com> <87v9nsmhjj.fsf@nanos.tec.linutronix.de> <20200227113648.GA5760@afzalpc>
Date:   Thu, 27 Feb 2020 14:29:54 +0100
Message-ID: <87sgiwma3x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Afzal,

afzal mohammed <afzal.mohd.ma@gmail.com> writes:
> On Thu, Feb 27, 2020 at 11:49:20AM +0100, Thomas Gleixner wrote:
>> afzal mohammed <afzal.mohd.ma@gmail.com> writes:
>
>> > Seldom remove_irq() usage has been observed coupled with setup_irq(),
>> > wherever that has been found, it too has been replaced by free_irq().
>> 
>> Please do not copy the irrelevant parts of your boilerplate text into
>> individual changelogs. Changelogs should have the information which is
>> relevant to the patch they describe.
>
> Sure, i will change.
>
>> > +		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
>> > +			pr_err("request_irq() on %s failed\n", "cascade");
>> 
>> What's the purpose of the %s indirection here?
>
> Putting that indirection helped me automate making these kind of changes w/
> cocci. As there were >150 instances of setup_irq and since "failed",
> "request_irq()" were common, putting a %s indirection with the timer
> name that changes in each instance, it was easy to take help of cocci
> to automatically create it (though not fully).
>
> Would you be okay to keep that indirection ?, if not , i will make the
> changes manually.
>
>> Also that error message is not really helpful:
>> 
>>      request_irq() on cascade failed
>> 
>> Something like:
>> 
>>      Failed to request irq 2 (cascade).
>
> Yes, as i mentioned in m86k patch (6/18) [1], i was uncomfortable w/ that
> string, based on Finn's feedback, in v2, it was modified to,
>
>         cascade: request_irq() failed
>
> though still using %s indirection.

Using scripting to find the spots and automatically convert them to
something which is functionally and semantically correct is perfectly
fine. But scripts neither have taste nor common sense.

So going over a scripted conversion and fixing non-sensical stuff up
manually is a good thing.

> Yeah, i had felt it, the reason i went ahead that way was cocci could
> automate that way for me for three-fourth of >150 instances making
> things easy for me. Another reason was to reduce manual changes so as
> to make it less error prone.
>
> Seems you are against taking the easy route of taking cocci's help, in
> that case, i will change as you suggest.

The easy route is fine for the initial step. See above.

Thanks,

        tglx
