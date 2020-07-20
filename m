Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E746C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B93720B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0g0o7KT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgGTKcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGTKcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:32:42 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9018C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:32:41 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z127so3080406ooa.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lnX79mYJmyrE/RnvKanwQSfM458bOzNMGnNrsOPIF5w=;
        b=O0g0o7KTTbdJiBqqIjUJrFtc62oziBefAxNOln+ixpMaXwQJuiD3Dh9eRTqNu0Qxe2
         ppsuwKzvISW+r8oXfUl8uMmWcwwW169qGxzSKmowz6DluzALKtIhOw1gMsXrC9jpy9IA
         jmF2QMeE1G0kn+//vRGnLl4eeYPCnwduLhPg78gXcHJKXBq0DMtgJ0J11tycquMaD7WH
         MZLrxwkl3+4ghmylKz7oJKJTMJBsPH5eb15zo1u2zlYVvdTwIdPvLmuWQVtQVLVFQdiL
         prQpAesCHy5u/IKGzkBfHoLZENSUMbg0rrPQKJ/CSImfDT02oL6eJghd4erPW/5ZBuqZ
         uPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lnX79mYJmyrE/RnvKanwQSfM458bOzNMGnNrsOPIF5w=;
        b=JAuXszgC2fhvpuaUHZEz39BRv7nWxS2dadBln1K3c24rWSIRk8U4u1Og+67C/38wiA
         bmCeI9HQTWuwEfIAfhK3oxMQY2W08rczwKC580rME6iUnkvkBmB7OUCDbZTejkRg8Fwf
         GkiFtPR0w6hM56RDGTSLj8XclX8Jj0taNsu1JbzNeDExO5LfJXtVB/xu/JQgucn/gcem
         h3gPq0zd7g0jWuNW9SxPvq7p6yZjUd3fyXcOm5c3yA1TvwUHQuyiYVo4omM85d/PasDp
         5fO0QryFUsvp5asPpCQf+No/r+/zKw7kkfsjHR9HJDBcaB97qHY2Iy4nSG0Rizn1oGE6
         7gcA==
X-Gm-Message-State: AOAM533tR5GceG1Ok3snvn6F7SeIzGJfKwDRrjVKpWMnUEG8b0RQo6+o
        ElN5P8phyxMvl7l45/rKudY/9c7D5z0EjaQyMWR3GQ==
X-Google-Smtp-Source: ABdhPJyElkE2WLDKIVGFvndbGhlz9PvLSjJPWq3V83r0fFHJCdu+r9AtGdU6gWmh5XAvLHzqH/kX2V28WRTNozqSocs=
X-Received: by 2002:a4a:e6c6:: with SMTP id v6mr18863704oot.14.1595241160603;
 Mon, 20 Jul 2020 03:32:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-5-john.ogness@linutronix.de> <20200718121053.GA691245@elver.google.com>
 <87eep6sd1e.fsf@jogness.linutronix.de>
In-Reply-To: <87eep6sd1e.fsf@jogness.linutronix.de>
From:   Marco Elver <elver@google.com>
Date:   Mon, 20 Jul 2020 12:32:29 +0200
Message-ID: <CANpmjNNnu2a3MqCgjieQEOFrXvs21pfxybvPkicLKO4jaBnpgA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 at 12:20, John Ogness <john.ogness@linutronix.de> wrote:
>
> On 2020-07-18, Marco Elver <elver@google.com> wrote:
> > It seems this causes a regression observed at least with newline-only
> > printks.
> > [...]
> > ------ >8 ------
> >
> > --- a/init/main.c
> > +++ b/init/main.c
> > @@ -1039,6 +1039,10 @@ asmlinkage __visible void __init start_kernel(void)
> >       sfi_init_late();
> >       kcsan_init();
> >
> > +     pr_info("EXPECT BLANK LINE --vv\n");
> > +     pr_info("\n");
> > +     pr_info("EXPECT BLANK LINE --^^\n");
> > +
> >       /* Do the rest non-__init'ed, we're now alive */
> >       arch_call_rest_init();
>
> Thanks for the example. This is an unintentional regression in the
> series. I will submit a patch to fix this.
>
> Note that this regression does not exist when the followup series [0]
> (reimplementing LOG_CONT) is applied. All the more reason that the 1st
> series should be fixed before pushing the 2nd series to linux-next.

Great, thank you for clarifying! :-)

-- Marco

> John Ogness
>
> [0] https://lkml.kernel.org/r/20200717234818.8622-1-john.ogness@linutronix.de
