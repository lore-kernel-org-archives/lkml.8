Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 812D920724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598016536;
	bh=oxNoRlZu8fZm0t7Eoh9NrCABbyRY5otstXAZMBFkHuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qh+0KTN5m/VN6g0kwVhyiLMlbJtEzSPP+MZGnlmLvOoPOAwTAQF9j1cjl5nO73vXG
	 bxXIjiz+1bDorbHr1mvH7he2RQpm0zchhidA5BDWlhZsmUy4vs+rRJh0J7zn1p4LJ8
	 pSp3rut08+SSNr0aUYe6xBcMk4w17Y2qkVDKoXHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgHUN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:28:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbgHUN2v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:28:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D471520724;
        Fri, 21 Aug 2020 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598016530;
        bh=oxNoRlZu8fZm0t7Eoh9NrCABbyRY5otstXAZMBFkHuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nY+/7A1g+pTS23xZF44/+fWTVyTXsI3EAZKbgRhdtEnJGYzrn0CBivv5PsodixTux
         rtG+Pn2N9g/CnzwWmGObvdUKrMi1s64BJb5wob40mgkgj8IkjPNjhBmbJkcFFfOThf
         WRmcFHpiLIdnfOmzgKY1O6CyTb/Vep1M8jFiYYuc=
Date:   Fri, 21 Aug 2020 22:28:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        songliubraving@fb.com, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] kprobes: Fix kill kprobe which has been marked as gone
Message-Id: <20200821222847.7d0730e4b193c3ea8da6bae2@kernel.org>
In-Reply-To: <20200821212843.180dc6f2f417e60cff2b886c@kernel.org>
References: <20200820031933.46025-1-songmuchun@bytedance.com>
        <20200821212843.180dc6f2f417e60cff2b886c@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 21:28:43 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi Muchun,
> 
> On Thu, 20 Aug 2020 11:19:33 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > If a kprobe is marked as gone, we should not kill it again. Otherwise,
> > we can disarm the kprobe more than once. In that case, the statistics
> > of kprobe_ftrace_enabled can unbalance which can lead to that kprobe
> > do not work.
> > 
> 
> Good catch! Hmm, I think we also need an assertion in
> kill_kprobe() so that p is already gone. Anyway, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Thanks!
> 
> > Fixes: 0cb2f1372baa ("kprobes: Fix NULL pointer dereference at kprobe_ftrace_handler")

BTW, this fixes older bug than this commit.

Fixes: e8386a0cb22f ("kprobes: support probing module __exit function")

Thank you,

> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
> > Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> > ---
> >  kernel/kprobes.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index d36e2b017588..7bac3ea44ff4 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -2422,7 +2422,10 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >  	mutex_lock(&kprobe_mutex);
> >  	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> >  		head = &kprobe_table[i];
> > -		hlist_for_each_entry(p, head, hlist)
> > +		hlist_for_each_entry(p, head, hlist) {
> > +			if (kprobe_gone(p))
> > +				continue;
> > +
> >  			if (within_module_init((unsigned long)p->addr, mod) ||
> >  			    (checkcore &&
> >  			     within_module_core((unsigned long)p->addr, mod))) {
> > @@ -2439,6 +2442,7 @@ static int kprobes_module_callback(struct notifier_block *nb,
> >  				 */
> >  				kill_kprobe(p);
> >  			}
> > +		}
> >  	}
> >  	if (val == MODULE_STATE_GOING)
> >  		remove_module_kprobe_blacklist(mod);
> > -- 
> > 2.11.0
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
