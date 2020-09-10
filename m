Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F25DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CC9206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNJNiyH7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIJICR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIJIBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:01:54 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D6FC061573;
        Thu, 10 Sep 2020 01:01:53 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so5641694wrr.4;
        Thu, 10 Sep 2020 01:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1ZKReFd/s/odi3eL/MqUhA7bsdxdwk/Ji4Nwo/5s7U=;
        b=nNJNiyH7Je1hC/GSL9wFaKn21YAQ/RJMOL03AdrBX+VNkPAQC1p2g6KZTonSxVXmx0
         k4ixOs2/RCQNyRmnJGPQCfIj2zSy2H0rg25WSsZFptIr3fFkTwXZetsK5ZwzfVuNcvNu
         9ZLRgERinvCJ9XxWECSypcIj+c4dH4PrIfoe4dJ5651/pPL38bowWBBdr6fRqn7i3R2J
         wQMb4WIypRArUpia92ORy0t/nF0nbrgAvxSe6AlGWl6w/I1ES2x7hggRlaRcYY6VVLMi
         wYkvq/hZug8OB/yCSWurfEyNVsORUuOLYXjXGUUxYuTln267lWlWlu0VbZZ3/XZfWvHq
         T3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1ZKReFd/s/odi3eL/MqUhA7bsdxdwk/Ji4Nwo/5s7U=;
        b=GPR3UR++2f6i0bT7mEQOe5r71yWRcHqMpu7ay50LPnnreIqAc2RKCBWnB9wzzJR3sX
         1ziPbL74T4/tuKrIAafDlWcFWaoFHG8qlXk4LE6ygJcT8pS2rwQ+XpdVgNNC9q//h6jE
         atw21nQFmWYlEHo+x/eX23YlWUkdi0DPn5dUf7TOjGp4OegMTZve9BNrV8Goopz3IVg7
         wZi4BG1a2xnHmAKcgDwRxXFakDcMEHNiJ3XlJtKLzRBPkYETe5CQazVOj7rVw7jT2OWI
         5cTKf1yNBoPEYngquEptKOp2N5P2CqOuhQ+GbkuhZI3m8/pzFCDBd+3kwTjOqG17CbOC
         VEsQ==
X-Gm-Message-State: AOAM533fdCVYnXr4y86fRSkS1ZAh1znZWyjpHt+a1TgXJRbWQM4b67Te
        TYgRaX70gtxdnh3luEiQl+p6KfmNrWA93t1rYMbHo4/usu5tzA==
X-Google-Smtp-Source: ABdhPJyopEghGwH/opOyv9jt888kuhF5bybS5/T/Z/PAig8cUn0Qu1vsdG33nEcABEatcjfsxKiNrfB6uzHlmrj6NEI=
X-Received: by 2002:adf:d4c1:: with SMTP id w1mr7750640wrk.108.1599724912460;
 Thu, 10 Sep 2020 01:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <1599706954.10822.3.camel@suse.de> <a1161f77-5b37-39ea-eb91-7b0b59278960@gmail.com>
 <CADvTj4q+b6nLBV6LEdd6K-daNbhTf6rUMOYnj+p0FO6+NTCg7A@mail.gmail.com>
In-Reply-To: <CADvTj4q+b6nLBV6LEdd6K-daNbhTf6rUMOYnj+p0FO6+NTCg7A@mail.gmail.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 10 Sep 2020 02:01:39 -0600
Message-ID: <CADvTj4qSPU17BPrH0UO5XQxbtX8d2nY8WDEtEnT0VPyVK=N-yQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Lars Melin <larsm17@gmail.com>
Cc:     Oliver Neukum <oneukum@suse.de>, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>,
        Hector Martin <hector@marcansoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 12:48 AM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> On Wed, Sep 9, 2020 at 11:34 PM Lars Melin <larsm17@gmail.com> wrote:
> >
> > On 9/10/2020 10:02, Oliver Neukum wrote:
> > > Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
> > >> This patch detects and reverses the effects of the malicious FTDI
> > >> Windows driver version 2.12.00(FTDIgate).
> > >
> > > Hi,
> > >
> > > this raises questions.
> > > Should we do this unconditionally without asking?
> > > Does this belong into kernel space?
> > >
> >
> > My answer to both of those question is a strong NO.
> >
> > The patch author tries to justify the patch with egoistical arguments
> > (easier for him and his customers) without thinking of all other users
> > of memory constrained embedded hardware that doesn't need the patch code
> > but have to carry it.
> If that's a concern it would not be difficult to add a kconfig option to allow
> disabling it.
I should maybe add that the reason I'm trying to upstream this is because
I have been repeatedly bitten by this issue for years over many totally
unrelated projects, as have many people I know. If this was a one-off
issue I would not have spent the time writing a kernel patch to fix
it. The supply
chains must be heavily contaminated with counterfeits with how often I've
personally run into this problem.

The damage done by FTDI with their malicious drivers really is hard to quantify,
both in terms of wasted man hours working around this issue and in the
inevitable mountains of e-waste they create by bricking end user hardware.
Most of these customers have likely never even heard of FTDI, they even
intentionally designed their malicious drivers to make it non-obvious that
the failures are due to counterfeits, completely unethical behavior IMO.

FTDI may very well be one of the least environmentally friendly companies
in terms of environmental damage per dollar of revenue.
> >
> > The bricked PID is btw already supported by the linux ftdi driver so
> > there is no functionality gain in the patch.
> By the kernel driver sure, but userspace is where things get messed up
> without something like this.
> >
> > br
> > Lars
> >
> >
> >
