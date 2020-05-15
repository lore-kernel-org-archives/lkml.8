Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07663C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7CCD206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QVbQZPOq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgEOQwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgEOQwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:52:30 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:52:30 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id y13so1637740vsk.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=//QUXJb2hfEP5KSpFr1jCZS2lxtzuUgoxlZm2dmFvFY=;
        b=QVbQZPOqP3I4QaDmNr61NBvJ2m4f0FA0qcnvxdFVkElx5ChUuXTVkiqBWPo1Lc9Svp
         gfslahjg2HvG56kqiAX8dTsXZpoCex+FFddG1M9rgY2zxl3BsjVqUNAAccrlXYZYnbeU
         c4XsdUEEqV52JxZSsm03Nz8rVclM6Q6jWWzWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//QUXJb2hfEP5KSpFr1jCZS2lxtzuUgoxlZm2dmFvFY=;
        b=aOxJuqBVoSLUDwL02h8C0Er6PFzrfWgHrsJVai2TE1JFaeGkUtbRlm/BqhBgyXHQQy
         ziU9yRiMqqtLV4Z7wULc9QMVXX7WE0vKN5RtiT1LqwO6e9ABNw6vlRZ59IR9jm22wGuJ
         S/JzID8HytvNdfOVk2k4+fPcdr586FjU6co5hwtQwHHHg70YGP0EBeu2liZtS6/ex3kh
         0PqVEHuwPXOtDbTsidjW3tEwXBUL87Mm1IOa5CMydSwljeeULRdDzqA5G9tE8RTyZLYJ
         BTPqMKLLhTHLH/5C5kMcJ0rNBEw7yuAj9IbwDuhvpZo+VRYRktcGHYYxnkAGBSne8paF
         2MJg==
X-Gm-Message-State: AOAM532Jup6AlYVTC83O9SrzwuUyehh0La8uuSjPgaAaG12WaVemN8RB
        4W7uG9thx1DrigMDNZ3M2ydZusW49pU=
X-Google-Smtp-Source: ABdhPJzguSJv+eHQdbvxIvO3IXMqnkHpe2Nh7uJgB0TqNgMsz/1XC95bDX+faPpKVYT/T5TpLvTRIw==
X-Received: by 2002:a67:f9d0:: with SMTP id c16mr3388262vsq.53.1589561549338;
        Fri, 15 May 2020 09:52:29 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id u63sm591149vsc.13.2020.05.15.09.52.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 09:52:28 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id k3so1027040ual.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:52:28 -0700 (PDT)
X-Received: by 2002:ab0:69cc:: with SMTP id u12mr268225uaq.22.1589561548021;
 Fri, 15 May 2020 09:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan> <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei> <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei> <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com> <20200515163638.GI42471@jagdpanzerIV.localdomain>
In-Reply-To: <20200515163638.GI42471@jagdpanzerIV.localdomain>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 15 May 2020 09:52:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XohG8ErL=_fyuA+MXEmfp55aW+SxSunb6YPRYj77bOxQ@mail.gmail.com>
Message-ID: <CAD=FV=XohG8ErL=_fyuA+MXEmfp55aW+SxSunb6YPRYj77bOxQ@mail.gmail.com>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any context
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 15, 2020 at 9:36 AM Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
>
> On (20/05/15 17:32), Sumit Garg wrote:
> > > Can I please have some context what problem does this solve?
> >
> > You can find the problem description here [1] which leads to this fix.
>
> [..]
>
> > [1] https://lkml.org/lkml/2020/5/12/213
>
> Thanks for the link. I'm slightly surprised it took so many years
> to notice the addition of printk_nmi/printk_safe :)

I haven't looked at all the details, but IIUC we don't normally enter
kgdb on the primary CPU through a NMI context, but the secondary ones
(on x86) always do.  Most things are run on the primary CPU and I
think it's relatively unlikely for people to change the primary CPU
(though it is possible).

Probably things got worse when I changed the way "btc" worked to make
it common between all architectures.  See commit 9ef50a686b53
("UPSTREAM: kdb: Fix stack crawling on 'running' CPUs that aren't the
master").  Though theoretically someone could have changed masters and
reproduced the problem with a simple "bt" before my patch, now a
relatively normal command "btc" would tickle the problem.  I didn't
notice it because I work almost totally on arm/arm64 machines and they
don't have NMI (yet).

In general I've always wondered about why (historically) kgdb bugs
have sometimes gone unnoticed for a period of time.  That does seem to
be changing, though, and I've seen a few longstanding bugs getting
fixed recently.  :-)


-Doug
