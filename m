Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469A2C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2684E206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599015954;
	bh=291x+wN71PTB8UxMkaQX84IKGcxZWvDmX7SmSZFw4ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1scpp+cfqP3qDBVKBrrIVPm92LHkYOIYSfr/qN/ea6zB7e3YU11xFSpTY1N5Fi5Jg
	 nv1Tg4Ch5DevV9aC56Ql98xaxw7kDXyn7bt09EKGxFnjyUpNSLMC97aUH26NKJHWqT
	 XMsFjPn7VEB/aIMGgpjGb5yNTQ7Iq91CNJtPEqKs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIBDFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 23:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbgIBDFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 23:05:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA68B2068F;
        Wed,  2 Sep 2020 03:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599015950;
        bh=291x+wN71PTB8UxMkaQX84IKGcxZWvDmX7SmSZFw4ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fgw+9GEL1i5I10iEu92hMXJtNfoPdEuSvc4SNsWhHrfO17OGJu5y3mm2x153ZnfjE
         Y10lrTEa03EZwj2h9g9l7GSKcHoeiwn94gB4iShwkX4sVMbz/9OrYD7e5cznqX6fI9
         kr6o4IKMhLoyDt3HLyDPLXSb/qm+73X7DMsMWH5k=
Date:   Wed, 2 Sep 2020 12:05:44 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Muchun Song <songmuchun@bytedance.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, songliubraving@fb.com,
        LKML <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] kprobes: Fix kill kprobe which has been marked as
 gone
Message-Id: <20200902120544.d839e3a9236696978ca87723@kernel.org>
In-Reply-To: <CAMZfGtVTTZ1XZ2sLERpjevGmSO+8ex4PdfPaWLFh7Ro2r5oYYA@mail.gmail.com>
References: <20200822030055.32383-1-songmuchun@bytedance.com>
        <CAMZfGtVTTZ1XZ2sLERpjevGmSO+8ex4PdfPaWLFh7Ro2r5oYYA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you merge this fix to -tip?

I can resend it with other kprobes fixes.

Hi Muchun,

We also need;

Cc: stable@vger.kernel.org

for bugfix so that the patch can be backported correctly after merged to upstream.

Thank you,

On Mon, 31 Aug 2020 10:59:19 +0800
Muchun Song <songmuchun@bytedance.com> wrote:

> Cc Andrew and Steven.
> 
> Any other comments or someone can add this to the queue for the
> merge window? It's worth fixing it.
> 
> On Sat, Aug 22, 2020 at 11:01 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > If a kprobe is marked as gone, we should not kill it again. Otherwise,
> > we can disarm the kprobe more than once. In that case, the statistics
> > of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
> > do not work.
> >
> > Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> > changelogs in v2:
> >  1. Add a WARN_ON_ONCE in the kill_kprobe() to catch incorrect use of it.
> >  2. Update 'Fixes' tag in the commmit log.
> >
> >  kernel/kprobes.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index d36e2b017588..9348b0c36ae0 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2143,6 +2143,9 @@ static void kill_kprobe(struct kprobe *p)
> >
> >         lockdep_assert_held(&kprobe_mutex);
> >
> > +       if (WARN_ON_ONCE(kprobe_gone(p)))
> > +               return;
> > +
> >         p->flags |= KPROBE_FLAG_GONE;
> >         if (kprobe_aggrprobe(p)) {
> >                 /*
> > @@ -2422,7 +2425,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >         mutex_lock(&kprobe_mutex);
> >         for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >                 head = &kprobe_table[i];
> > -               hlist_for_each_entry(p, head, hlist)
> > +               hlist_for_each_entry(p, head, hlist) {
> > +                       if (kprobe_gone(p))
> > +                               continue;
> > +
> >                         if (within_module_init((unsigned long)p->addr, mod) ||
> >                             (checkcore &&
> >                              within_module_core((unsigned long)p->addr, mod))) {
> > @@ -2439,6 +2445,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >                                  */
> >                                 kill_kprobe(p);
> >                         }
> > +               }
> >         }
> >         if (val == MODULE_STATE_GOING)
> >                 remove_module_kprobe_blacklist(mod);
> > --
> > 2.11.0
> >
> 
> 
> --
> Yours,
> Muchun


-- 
Masami Hiramatsu <mhiramat@kernel.org>
