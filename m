Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95EC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6C920578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584240547;
	bh=gnI3uxG2MjcP5dcmf2YwXbK59YkgPYCt3bzD1i2Vj6Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mkon82v38QVzSq883EI3AqaAy2VxSYxxUYYa87h0HI52o11UVfiZh2RoaT68WaK5E
	 eOLqQVMc12GJHhvyTy2dgYbupXlx7hP74hWAMlLZrcA0/3SVWAzE5wTfjzj2+PkDi1
	 FzO9u/O/LxG2a0sBDcADU4RfnLEa2xoHRm7C9mAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgCOCtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:49:06 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37333 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:49:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id b23so17427398edx.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 19:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YPgN4l93OeEWMDSYtyHK2xEec1H49aBedq26BrSDmkA=;
        b=eAS3kn7vfdKKx02/krekDoFV619IUUiDr+1OClPUae5Ij8mqsEA+MjuC5/3521kbs7
         dxE5vpUPD0EmtOE4s6uxCLkrZDRvo36YV0uzX/AMD4xWRqc6VgorbY3sI9ARwyAXHRcr
         7ixd9w7pQfxwxGBFVI6FnfuMgRvvfwKxQgyx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YPgN4l93OeEWMDSYtyHK2xEec1H49aBedq26BrSDmkA=;
        b=K88v4iC9+VZGh13qYPs4+gsUtXREnl9muHdXtVX4mYKQfrJYksxN11B4z7GPmnxEuq
         IdEZd00Zqgtzt1UREG2ZlFPmE2PNR5FtbrfbwcFSuztAnNtyiFGatVi0VViY0aJjzTpx
         Yt6PWcDca6txfUrj+Eglhfu1vyPn5vS/WnJG8HOhvAgio1H5SaXAUcKo0msf0rHW5K9/
         69dycFsX8Dy58O2+0+69CNRWgnnK/N75+V6FtmS3KzOK68SwtxxMDXs9o52x7qDsTDPU
         0AQDHrPaosTDNNvwINSHdGnOk0BouG4o/xxtSygeDpWRqREkIj7txeDHSWd/2Nc+XFgf
         7Kyg==
X-Gm-Message-State: ANhLgQ0ynfglMLID2/akBfAsVQ0pDIRQkCNosqqj2PeL3vp0Vc2dJmry
        RjhJ716dp8vtP2VKVLxnv5xirSaplaU=
X-Google-Smtp-Source: ADFU+vtD+aoGapK2USi68QzXp6dP2USYVZwF0NIn0sNn9e5wumkzLIbgjrdYfVyPVczxsHAluWigIQ==
X-Received: by 2002:ac2:53b8:: with SMTP id j24mr11718626lfh.79.1584200426093;
        Sat, 14 Mar 2020 08:40:26 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h10sm3451859ljg.38.2020.03.14.08.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 08:40:25 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id u12so13883656ljo.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 08:40:24 -0700 (PDT)
X-Received: by 2002:a05:651c:555:: with SMTP id q21mr11396356ljp.241.1584200424436;
 Sat, 14 Mar 2020 08:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200313174701.148376-1-bigeasy@linutronix.de> <20200313174701.148376-6-bigeasy@linutronix.de>
In-Reply-To: <20200313174701.148376-6-bigeasy@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 14 Mar 2020 08:40:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgO1Fn88+1K9V7=mfBNOttkGkFakGxp_QEsokZU2ywUvg@mail.gmail.com>
Message-ID: <CAHk-=wgO1Fn88+1K9V7=mfBNOttkGkFakGxp_QEsokZU2ywUvg@mail.gmail.com>
Subject: Re: [PATCH 5/9] completion: Use simple wait queues
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 10:47 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> Replace the wait queue in the completion with a simple wait queue (swait),

This is almost certainly completely and utterly wrong.

Every time somebody uses those horrible swait queues, the end result is buggy.

Don't do it.

And most definitely, don't do it like this, which seems to be entirely
mindlessly just randomly changing things by some brute force in
multiple places.

The swait semantics are completely different from the normal
wait-queue semantics, and generally not in good ways.

There's a *REASON* why the comment at the top of <linux/swait.h> starts with

 * BROKEN wait-queues.
 *
 * These "simple" wait-queues are broken garbage, and should never be
 * used. The comments below claim that they are "similar" to regular
 * wait-queues, but the semantics are actually completely different, and
 * every single user we have ever had has been buggy (or pointless).

and before you do a conversion, you need to spend a _lot_ of time
thinking about why that is the case.

And _after_ you do the conversion, you damn well need to explain why
it's safe. Not just state that it's a good idea.

For example, this patch just randomly changes wait events to the swait
event _exclusive_ waits. With not a single explanation of why that
would be ok.

I want an explanation for EVERY SINGLE CASE. Because people have done
this kind of conversion before, and it's been buggy garbage before. I
want to see that people actually thought about what the semantic
differences were, and _documented_ that thinking process.

            Linus
