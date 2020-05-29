Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EFFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7410208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgE2IRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:17:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2IRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:17:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DA554AB5C;
        Fri, 29 May 2020 08:17:49 +0000 (UTC)
Date:   Fri, 29 May 2020 10:17:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
Message-ID: <20200529081748.GC27273@linux-b0ei>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200528110646.GC11286@linux-b0ei>
 <e0d6c04f-7601-51e7-c969-300e938dedc0@i-love.sakura.ne.jp>
 <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgz=7MGxxX-tmMmdCsKyYJkuyxNc-4uLP=e_eEV=OzUaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 12:50:35, Linus Torvalds wrote:
> On Thu, May 28, 2020 at 8:17 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > CONFIG_TWIST_FOR_SYZKALLER_TESTING is meant for linux-next only.
> > But CONFIG_TWIST_KERNEL_BEHAVIOR is meant for Linus's tree.
> 
> I really absolutely still detest this all. I don't see the point. The
> naming is completely random (both "twist" and then options like
> "TWIST_FOR_SYZKALLER_TESTING" that have no conceptual meaning.
>
> I still don't understand why this small set of random options couldn't
> just be kernel options that get set on the command line, and that have
> independent and sane and explainable behavior? Why this odd mentality
> of "syzkaller is special"?

I am afraid that many of them could not be normal options. They change or
break some behavior that is necessary by seriously used system.


> I've complained about this whole thing before. I'm getting really fed
> up with this whole concept of "magic crazy config options".

Just to make my role clear in this saga.

I am focused on the change of pr_debug() behavior. I do _not_ believe
that it is worth it. But I wanted to give fuzzer guys a chance to get
some data.

This is why I offered to push hacky patch into linux-next via printk
tree to get fuzzers fed. Such a patch would change the behavior only
for the fuzzer (with the crazy config enabled) and it would be there
only for a limited time.

I personally do _not_ have a good feeling about having such hacks in
upstream kernel. But I do not feel in position to decide about it.
I wanted to solve this question later if there would have been
anything to upstream.

I am _not_ going to push any twists, in the current form,
upstream via printk tree.

Best Regards,
Petr
