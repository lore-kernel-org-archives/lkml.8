Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB15C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EC8E24690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2QTmIBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgB0Lgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:36:52 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32876 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbgB0Lgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:36:52 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so1041771plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 03:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W2IExvbOkgyWnvI9r88ADR0c7T8ydJDDE47tp0M5rgQ=;
        b=C2QTmIBHk62oU8Q9c/vwIkm9nMXTPUoGBGsRzpoiuhyEiHOUOYVck4Nt+nNQqaXuLj
         mNavyl07qF6yhZTklzwqQs4guI7KuKWp86oamo4c1jVoWEcEBrB16cN/JRz7iP2WYOiB
         PCILU81QAw+PeNVkuqt061QUorMjFNdpbClLcibVMrYJiAjyRbgEnhxIVdohbXC+z0CL
         ywgdRK6l+xgb6jXMi2zh6tqFfmvfM57IjYTsNiB/+ihg9U828cUn8xePTKkWi4jGsLvM
         aBrBFJM8r0AygAwO/LVAcgpfVUpauPFeAUUvTgJngjcu7G5kUaGnCdNbnQKQZ6ieFSGC
         3oRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W2IExvbOkgyWnvI9r88ADR0c7T8ydJDDE47tp0M5rgQ=;
        b=X56W5WIbV61w5ag3rBEzi4hrqMIagOi4366t1cE7JjSO4tBbwfrqx8aJk3Glw5SZUS
         vRmBV4JPUhi1IE2oaeTtNhPUpPaR2TpwXNieKyRKl1YljM9l2qK0+AqsA+qGGMh7Ld3/
         8NKueY1diXxkNF7N8x4UzH2BlxhCKdQZb+EJpn+TAg7HSqSGrZI74rVb3Gk/FwJzFMfQ
         1tmJxX/G2zEaD7b4zujBQhzr4wkRNewionZq3nXv+2df5+/vJuNhNEalj9hTcNE3lxsO
         qmw5ImX5PnzRCyWpHrYZgsdG9S5MYb84IMu6KygfL1muA2kzl2QqHBjARo9DXKIEFnGF
         a1yA==
X-Gm-Message-State: APjAAAVZ0IxhtS2N7xXBvMBZfI1joe8TYpKYPHGHdE7oTOpBaUt4m5uS
        q+sgeFyvBM1975BFaj6IbUs=
X-Google-Smtp-Source: APXvYqzlUXgKKOWfM57oiRC6ITKvfTyPZJZnoHtPz5Ur104RFbXZ9d8XiRTG+6oHr2bUXsezi1dF5Q==
X-Received: by 2002:a17:902:6907:: with SMTP id j7mr4338741plk.88.1582803411163;
        Thu, 27 Feb 2020 03:36:51 -0800 (PST)
Received: from localhost ([106.51.232.35])
        by smtp.gmail.com with ESMTPSA id u126sm6677368pfu.182.2020.02.27.03.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Feb 2020 03:36:50 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:06:48 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 14/18] x86: Replace setup_irq() by request_irq()
Message-ID: <20200227113648.GA5760@afzalpc>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
 <a3116b3b1a03a943cd89efd57d2db32284c3a574.1581478324.git.afzal.mohd.ma@gmail.com>
 <87v9nsmhjj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9nsmhjj.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Thu, Feb 27, 2020 at 11:49:20AM +0100, Thomas Gleixner wrote:
> afzal mohammed <afzal.mohd.ma@gmail.com> writes:

> > Seldom remove_irq() usage has been observed coupled with setup_irq(),
> > wherever that has been found, it too has been replaced by free_irq().
> 
> Please do not copy the irrelevant parts of your boilerplate text into
> individual changelogs. Changelogs should have the information which is
> relevant to the patch they describe.

Sure, i will change.

> > +		if (request_irq(2, no_action, IRQF_NO_THREAD, "cascade", NULL))
> > +			pr_err("request_irq() on %s failed\n", "cascade");
> 
> What's the purpose of the %s indirection here?

Putting that indirection helped me automate making these kind of changes w/
cocci. As there were >150 instances of setup_irq and since "failed",
"request_irq()" were common, putting a %s indirection with the timer
name that changes in each instance, it was easy to take help of cocci
to automatically create it (though not fully).

Would you be okay to keep that indirection ?, if not , i will make the
changes manually.

> Also that error message is not really helpful:
> 
>      request_irq() on cascade failed
> 
> Something like:
> 
>      Failed to request irq 2 (cascade).

Yes, as i mentioned in m86k patch (6/18) [1], i was uncomfortable w/ that
string, based on Finn's feedback, in v2, it was modified to,

        cascade: request_irq() failed

though still using %s indirection.

> > -	if (setup_irq(0, &irq0))
> > +	if (request_irq(0, timer_interrupt,
> > +			IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER, "timer",
> > +			NULL))
> 
> This is realy ugly.
> 
> 	unsigned long flags = IRQF_NOBALANCING | IRQF_IRQPOLL | IRQF_TIMER;
> 
> 	....
>      	if (request_irq(0, timer_interrupt, flags, "timer", NULL))
>         	....
> 
> takes the same amount of lines, but is readable.

Yeah, i had felt it, the reason i went ahead that way was cocci could
automate that way for me for three-fourth of >150 instances making
things easy for me. Another reason was to reduce manual changes so as
to make it less error prone.

Seems you are against taking the easy route of taking cocci's help, in
that case, i will change as you suggest.

There was discussion on m68k (6/18) patch [2], but v2 series on
similar lines, not w.r.t flags, but mainly  w.r.t return value.

[1] http://lkml.kernel.org/r/20200213020330.GC2684@teres
[2] http://lkml.kernel.org/r/20200227081805.GA5746@afzalpc

Regards
afzal

