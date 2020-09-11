Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA831C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8690221E7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 03:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LZI6gdr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725772AbgIKDyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgIKDx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 23:53:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F1C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:53:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m5so5635627pgj.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 20:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=er3tHzvhZmVFoY1Ivnz+K1dwvMdQAfXcT7CPtzE9jbQ=;
        b=LZI6gdr1lcNG+T40igoRu0JN4jGfD5sx5a/SyqRrP57AM+ZSAtTuhFo/sOHC5E+o+i
         I2mFM2szh+B4GzS0Ny0UJ6t7GIbuwqP4suWkDgdI1YeTKbwTZ1iW7CGxg11JsnwnhL4y
         WOxFVL5OPv1qox3qHMwWtAD6FqqWoQ6BkUMmpHuAlGrmLeou8qXpeGZdp2cg4TXOVhPM
         7S8BqxJUdC3zjfKFR0I9eX405zgFh31uYhIZS0twoFEHhAjITZwcTaa9Xw/5uiUq4WvY
         eLAg/b9f+tCBQL9t4UK0ChS/RQFf0/I0aOP6CeAOvkqt6UbPcLjXce+V1J63I3dTtjiC
         Fv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=er3tHzvhZmVFoY1Ivnz+K1dwvMdQAfXcT7CPtzE9jbQ=;
        b=gFjSsouzjysjqYx059+CLHoOrSABWJ4SbM/UMW6LogJAycsfDCwfo2UV+NpVJo2ZCY
         Wx9aHBfLpLE0oiJb/7O16yQ3wxzXabIlhJW9DIPBp/HuakTbaHqsuibNl7lbldtcnaXj
         gs0112vFEDxP2rEDNVt4+2VQ8Nk8L4Pf6ThoCGZCIwr8d9dYrqBb0SlO0C4NI4svrWlC
         OYdDfD1vswOkeLdFeiQFwERJ7pz6Teq3q6QgS8tyVDtohDxhfW6lK27AM/gR/Gep9LtX
         ejq1oCUbi6hyaUg2LrJCHeIb6NM37ZdBQltMGNCiCwJCYnORRbhb0NE7ipclPkMj/vol
         e4qw==
X-Gm-Message-State: AOAM531vfLn5ykT3EKDGbhyWuzT/EkfaHqZb0+cVljP7NyNRt5fmYdWU
        FwPxmmk9GpzeOmwU5mjxEnDuuTNjjG8yinmupfa6JA==
X-Google-Smtp-Source: ABdhPJxAQLsWWLTq+Ndedf8vMMByB477wxWCyqpKJ7J71xiP4s0gqwnl2QFRZTCEoi5Qdhqdq6eLUb2CucMLM6qFjC4=
X-Received: by 2002:a63:9041:: with SMTP id a62mr239553pge.273.1599796435635;
 Thu, 10 Sep 2020 20:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com>
 <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com> <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
In-Reply-To: <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 11 Sep 2020 11:53:16 +0800
Message-ID: <CAMZfGtW44zaQYQTG3twx82adZH-MTd=B5zESAeFCz-zYki=EYA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] stackleak: Fix a race between stack
 erasing sysctl handlers
To:     alex.popov@linux.com, Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        miguel.ojeda.sandonis@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping guys. Thanks.

On Mon, Sep 7, 2020 at 9:53 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> On Mon, Sep 7, 2020 at 7:24 PM Alexander Popov <alex.popov@linux.com> wrote:
> >
> > On 07.09.2020 05:54, Muchun Song wrote:
> > > Hi all,
> > >
> > > Any comments or suggestions? Thanks.
> > >
> > > On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >>
> > >> There is a race between the assignment of `table->data` and write value
> > >> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> > >> the other thread.
> > >>
> > >>     CPU0:                                 CPU1:
> > >>                                           proc_sys_write
> > >>     stack_erasing_sysctl                    proc_sys_call_handler
> > >>       table->data = &state;                   stack_erasing_sysctl
> > >>                                                 table->data = &state;
> > >>       proc_doulongvec_minmax
> > >>         do_proc_doulongvec_minmax             sysctl_head_finish
> > >>           __do_proc_doulongvec_minmax           unuse_table
> > >>             i = table->data;
> > >>             *i = val;  // corrupt CPU1's stack
> >
> > Hello everyone!
> >
> > As I remember, I implemented stack_erasing_sysctl() very similar to other sysctl
> > handlers. Is that issue relevant for other handlers as well?
>
> Yeah, it's very similar. But the difference is that others use a
> global variable as the
> `table->data`, but here we use a local variable as the `table->data`.
> The local variable
> is allocated from the stack. So other thread could corrupt the stack
> like the diagram
> above.
>
> >
> > Muchun, could you elaborate how CPU1's stack is corrupted and how you detected
> > that? Thanks!
>
> Why did I find this problem? Because I solve another problem which is
> very similar to
> this issue. You can reference the following fix patch. Thanks.
>
>   https://lkml.org/lkml/2020/8/22/105
>
>
>
>
> >
> > Best regards,
> > Alexander
> >
> > >> Fix this by duplicating the `table`, and only update the duplicate of
> > >> it.
> > >>
> > >> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> > >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > >> ---
> > >> changelogs in v2:
> > >>  1. Add more details about how the race happened to the commit message.
> > >>
> > >>  kernel/stackleak.c | 11 ++++++++---
> > >>  1 file changed, 8 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> > >> index a8fc9ae1d03d..fd95b87478ff 100644
> > >> --- a/kernel/stackleak.c
> > >> +++ b/kernel/stackleak.c
> > >> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
> > >>         int ret = 0;
> > >>         int state = !static_branch_unlikely(&stack_erasing_bypass);
> > >>         int prev_state = state;
> > >> +       struct ctl_table dup_table = *table;
> > >>
> > >> -       table->data = &state;
> > >> -       table->maxlen = sizeof(int);
> > >> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> > >> +       /*
> > >> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> > >> +        * can duplicate the @table and alter the duplicate of it.
> > >> +        */
> > >> +       dup_table.data = &state;
> > >> +       dup_table.maxlen = sizeof(int);
> > >> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
> > >>         state = !!state;
> > >>         if (ret || !write || state == prev_state)
> > >>                 return ret;
> > >> --
> > >> 2.11.0
> > >>
> > >
> > >
> >
>
>
> --
> Yours,
> Muchun



-- 
Yours,
Muchun
