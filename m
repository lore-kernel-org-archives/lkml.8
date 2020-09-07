Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C1FC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED6C21741
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="ICxs3B8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgIGOBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729664AbgIGNyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:54:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACEC061757
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 06:54:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so8094399pgm.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o/MU6LekjsaqUPMHLvSGn4qT2Aidzx+zWyzeNtI6Aco=;
        b=ICxs3B8OAbtbOLbp+251XaXRr0iyGaw3eqK8J4FmveMJZkALbMNg1m+VVl1Sxtzzy0
         ft3UvY9HZkITHw2LLwHYNCEHe32aHO6fNIviyEPwIaVy9+X9remMsv1JrpsVPyV1p93Q
         6Epxt4o1Az96XmxrQQn1c5csKJqg1oTjsJMm1RdOBp3Ous0F7vKiZH9ZI9VRFpmzbwSB
         g04Gqcy7a0+2u2q1GoL41sWeCNfnOgNIX34V85uambamouh+S8ZrKpzJK7gMIHTQcIsC
         3HAjf3Sbxgm1wsKes8aDu9UxYgaXqGC44lRUEiGudO+L+fwWnUISb2Ktk8zdEekb4jDH
         ImNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/MU6LekjsaqUPMHLvSGn4qT2Aidzx+zWyzeNtI6Aco=;
        b=qdZ9ivCU20zSObDHrrHlYFEiO+PC3tJRcY0nn5sCAnuEt7PTKsBXv/cY4I0zPKyFpW
         a45kFucTV3uEspq81dXP4xuCQByzYl7tfQiTM5xp6BERDwIyZccmGefMGNXhWSXG3nU9
         FjPUmsVPqFkBx3r9Jt8BWuac/eL/SvRiSvqaekcuSdeOerEvvz6MU7U/1c1CMrmx9u93
         rMPZgDOF8H5o++cgBfQIi4BIqqeJ3WYPr/Jf8fi8mWVJJiakItNgBBLGjRjO1k4d2cWy
         IZlfRIDX3S+Sh8dHE4llFptKB9Wjilxob2Srk8SO+9X1THULE9v/Zc5U2CuPUABPrbvX
         fNAw==
X-Gm-Message-State: AOAM533lZ9ruMZy9ez5taDcST5l7cEPSrqahp0f+U+0IGMM8SzQhIr5L
        2EmUd7fp3C+9l3xeHqcRtKQJE84/Gm6HMUf8796Q+w==
X-Google-Smtp-Source: ABdhPJw5HFroQbN6x1lmzzZm0XKRGWGqA+4I1GwaHZjP37oDlTlEbnX0pT3bC07doSkFZFpFxFTV5AUo95lBvLD6UjY=
X-Received: by 2002:a63:5515:: with SMTP id j21mr16351063pgb.31.1599486847735;
 Mon, 07 Sep 2020 06:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200828031928.43584-1-songmuchun@bytedance.com>
 <CAMZfGtWtAYNexRq1xf=5At1+YJ+_TtN=F6bVnm9EPuqRnMuroA@mail.gmail.com> <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com>
In-Reply-To: <8c288fd4-2ef7-ca47-1f3b-e4167944b235@linux.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 7 Sep 2020 21:53:31 +0800
Message-ID: <CAMZfGtXsXWtHh_G0TWm=DxG_5xT6kN_BbfqNgoQvTRu89FJihA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] stackleak: Fix a race between stack
 erasing sysctl handlers
To:     alex.popov@linux.com
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        miguel.ojeda.sandonis@gmail.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 7:24 PM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 07.09.2020 05:54, Muchun Song wrote:
> > Hi all,
> >
> > Any comments or suggestions? Thanks.
> >
> > On Fri, Aug 28, 2020 at 11:19 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >>
> >> There is a race between the assignment of `table->data` and write value
> >> to the pointer of `table->data` in the __do_proc_doulongvec_minmax() on
> >> the other thread.
> >>
> >>     CPU0:                                 CPU1:
> >>                                           proc_sys_write
> >>     stack_erasing_sysctl                    proc_sys_call_handler
> >>       table->data = &state;                   stack_erasing_sysctl
> >>                                                 table->data = &state;
> >>       proc_doulongvec_minmax
> >>         do_proc_doulongvec_minmax             sysctl_head_finish
> >>           __do_proc_doulongvec_minmax           unuse_table
> >>             i = table->data;
> >>             *i = val;  // corrupt CPU1's stack
>
> Hello everyone!
>
> As I remember, I implemented stack_erasing_sysctl() very similar to other sysctl
> handlers. Is that issue relevant for other handlers as well?

Yeah, it's very similar. But the difference is that others use a
global variable as the
`table->data`, but here we use a local variable as the `table->data`.
The local variable
is allocated from the stack. So other thread could corrupt the stack
like the diagram
above.

>
> Muchun, could you elaborate how CPU1's stack is corrupted and how you detected
> that? Thanks!

Why did I find this problem? Because I solve another problem which is
very similar to
this issue. You can reference the following fix patch. Thanks.

  https://lkml.org/lkml/2020/8/22/105




>
> Best regards,
> Alexander
>
> >> Fix this by duplicating the `table`, and only update the duplicate of
> >> it.
> >>
> >> Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> changelogs in v2:
> >>  1. Add more details about how the race happened to the commit message.
> >>
> >>  kernel/stackleak.c | 11 ++++++++---
> >>  1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/stackleak.c b/kernel/stackleak.c
> >> index a8fc9ae1d03d..fd95b87478ff 100644
> >> --- a/kernel/stackleak.c
> >> +++ b/kernel/stackleak.c
> >> @@ -25,10 +25,15 @@ int stack_erasing_sysctl(struct ctl_table *table, int write,
> >>         int ret = 0;
> >>         int state = !static_branch_unlikely(&stack_erasing_bypass);
> >>         int prev_state = state;
> >> +       struct ctl_table dup_table = *table;
> >>
> >> -       table->data = &state;
> >> -       table->maxlen = sizeof(int);
> >> -       ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> >> +       /*
> >> +        * In order to avoid races with __do_proc_doulongvec_minmax(), we
> >> +        * can duplicate the @table and alter the duplicate of it.
> >> +        */
> >> +       dup_table.data = &state;
> >> +       dup_table.maxlen = sizeof(int);
> >> +       ret = proc_dointvec_minmax(&dup_table, write, buffer, lenp, ppos);
> >>         state = !!state;
> >>         if (ret || !write || state == prev_state)
> >>                 return ret;
> >> --
> >> 2.11.0
> >>
> >
> >
>


--
Yours,
Muchun
