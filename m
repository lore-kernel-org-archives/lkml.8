Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BF4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 883EE22B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgHEUGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgHEQeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:34:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 181BB23339;
        Wed,  5 Aug 2020 15:11:07 +0000 (UTC)
Date:   Wed, 5 Aug 2020 11:11:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [External] linux-next: build warning after merge of the ftrace
 tree
Message-ID: <20200805111105.081276bb@oasis.local.home>
In-Reply-To: <CAMZfGtX0a3tui_KQfCXLcARVcev9V-HV6HMkXgVXObq8w-4EQg@mail.gmail.com>
References: <20200805142136.0331f7ea@canb.auug.org.au>
        <CAMZfGtX0a3tui_KQfCXLcARVcev9V-HV6HMkXgVXObq8w-4EQg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 12:53:39 +0800
Muchun Song <songmuchun@bytedance.com> wrote:

> On Wed, Aug 5, 2020 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the ftrace tree, today's linux-next build (powerpc
> > ppc64_defconfig) produced this warning:
> >
> > kernel/kprobes.c: In function 'kill_kprobe':
> > kernel/kprobes.c:1116:33: warning: statement with no effect [-Wunused-value]
> >  1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
> >       |                                 ^
> > kernel/kprobes.c:2154:3: note: in expansion of macro 'disarm_kprobe_ftrace'
> >  2154 |   disarm_kprobe_ftrace(p);
> >       |   ^~~~~~~~~~~~~~~~~~~~
> >  
> 
> Sorry, maybe we should rework the macro of disarm_kprobe_ftrace to an
> inline function like below.
> 
> -#define disarm_kprobe_ftrace(p)        (-ENODEV)
> +static inline int disarm_kprobe_ftrace(struct kprobe *p)
> +{
> +       return -ENODEV
> +}
>  #endif

Looks like that would work. Care to send a formal patch. Could you also
change arm_kprobe_ftrace() as well?

Thanks!

-- Steve
