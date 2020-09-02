Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D71C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFA42068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="LP1qr1xS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgIBDQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIBDQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:16:03 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2084AC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 20:16:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ls14so1654030pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 20:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLKC7+jaSN5ZBuCD5TIaeGbr36POSkJnb3G6NUVYvBA=;
        b=LP1qr1xSGAO4kCcQ/P0xBe/1/wk7IJYlJb12vHtI4F72pwTNRJX0bN3jgkiyBrPDEH
         gcy/U0Jkn7QVYLwetuH61+z/ki6MaOTJr3IYTkae8KZLr4Y4IiCACsos6tmgmtrCQ1uK
         ULJnmLb+vF9yfmZSSFcmou2PLu1qmw25JaqFAoqdQmonC/I9YbfVWf74NJL/8+NxNCye
         kklP02G3ACt5pD35MG/5TdKCnJoXu4VwGr0npmTC2AhakY0GT68esaGnxO3mon3G6lF4
         Y9LDNE5qLVZN5x4qTkaFOpdrcaXyf59dYK3MXuat+P2FCA5WciiE44V5l4oIGqiEp/2F
         7twA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLKC7+jaSN5ZBuCD5TIaeGbr36POSkJnb3G6NUVYvBA=;
        b=YAoNnzcKJuQp4Sg+ouptepFQ3Pdif2u5vBymM395wX2s33g4PqsdO9/3ZtThWfihMN
         AVtjEe4Hq5mRmh8ilBJ83xLNpilj30ebIW9KDqhvI4h8xBwkSySwhf5cnhM6WN6VRzJE
         ZMuOsyIRzmP7K0l+nGxKE/f7L3dKX16AQ+gObbZrddLSfkaqiit7BjvFCIudJAxlvWsa
         V7pncz9wo5zIVNQe7jtGA6KU07dnHIA69PaJmd7JXWM21t1tvkSXc23M68YiAPPvO3Ym
         icQg0k7tWYEBC02YErrGR6bSKlSlFluToKbARzYF071bjkYUOlwp2d7CofO7OSgzur7g
         ge2w==
X-Gm-Message-State: AOAM5319bdnyZ8L1BymPi1XP28CW25ogps/414/7/L+5ZgKOHCRHu0I4
        LElPGkT2dWx9OeSLAz3q12DXxGyu+pBjyrCG7T9LXQ==
X-Google-Smtp-Source: ABdhPJxU9t2/jRG3bOAX50PgF1H2d4Mis+lVnVhkJX43vr8Td+vQ2wXtBUpPN74e2jKTAQcFq+dWjHTsrygJx6VltQ0=
X-Received: by 2002:a17:90a:fa94:: with SMTP id cu20mr312873pjb.147.1599016562619;
 Tue, 01 Sep 2020 20:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200822030055.32383-1-songmuchun@bytedance.com>
 <CAMZfGtVTTZ1XZ2sLERpjevGmSO+8ex4PdfPaWLFh7Ro2r5oYYA@mail.gmail.com> <20200902120544.d839e3a9236696978ca87723@kernel.org>
In-Reply-To: <20200902120544.d839e3a9236696978ca87723@kernel.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 2 Sep 2020 11:15:26 +0800
Message-ID: <CAMZfGtVZMdNc5uosnzDws=xsYebYdgKqtnBZeLmBRHLPgg04tQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] kprobes: Fix kill kprobe which has been
 marked as gone
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        songliubraving@fb.com, LKML <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Wed, Sep 2, 2020 at 11:05 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Ingo,
>
> Could you merge this fix to -tip?

This patch has been merged into Andrew's mm tree.

>
> I can resend it with other kprobes fixes.
>
> Hi Muchun,
>
> We also need;
>
> Cc: stable@vger.kernel.org
>
> for bugfix so that the patch can be backported correctly after merged to upstream.

Yeah, I got it. Thanks.

>
> Thank you,
>
> On Mon, 31 Aug 2020 10:59:19 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
>
> > Cc Andrew and Steven.
> >
> > Any other comments or someone can add this to the queue for the
> > merge window? It's worth fixing it.
> >
> > On Sat, Aug 22, 2020 at 11:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
> > >
> > > If a kprobe is marked as gone, we should not kill it again. Otherwise,
> > > we can disarm the kprobe more than once. In that case, the statistics
> > > of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
> > > do not work.
> > >
> > > Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")
> > > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > > Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > ---
> > > changelogs in v2:
> > >  1. Add a WARN_ON_ONCE in the kill_kprobe() to catch incorrect use of it.
> > >  2. Update 'Fixes' tag in the commmit log.
> > >
> > >  kernel/kprobes.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > index d36e2b017588..9348b0c36ae0 100644
> > > --- a/kernel/kprobes.c
> > > +++ b/kernel/kprobes.c
> > > @@ -2143,6 +2143,9 @@ static void kill_kprobe(struct kprobe *p)
> > >
> > >         lockdep_assert_held(&kprobe_mutex);
> > >
> > > +       if (WARN_ON_ONCE(kprobe_gone(p)))
> > > +               return;
> > > +
> > >         p->flags |= KPROBE_FLAG_GONE;
> > >         if (kprobe_aggrprobe(p)) {
> > >                 /*
> > > @@ -2422,7 +2425,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
> > >         mutex_lock(&kprobe_mutex);
> > >         for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> > >                 head = &kprobe_table[i];
> > > -               hlist_for_each_entry(p, head, hlist)
> > > +               hlist_for_each_entry(p, head, hlist) {
> > > +                       if (kprobe_gone(p))
> > > +                               continue;
> > > +
> > >                         if (within_module_init((unsigned long)p->addr, mod) ||
> > >                             (checkcore &&
> > >                              within_module_core((unsigned long)p->addr, mod))) {
> > > @@ -2439,6 +2445,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> > >                                  */
> > >                                 kill_kprobe(p);
> > >                         }
> > > +               }
> > >         }
> > >         if (val == MODULE_STATE_GOING)
> > >                 remove_module_kprobe_blacklist(mod);
> > > --
> > > 2.11.0
> > >
> >
> >
> > --
> > Yours,
> > Muchun
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>



-- 
Yours,
Muchun
