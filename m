Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F324C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5B0206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596647463;
	bh=bEv1I5kUy8vw/4EQLmasNlul0jYH0UHc1VynpmwLox0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aFWZ4uB5VpY0J1hZ6NNpRHtxU9aSSUnB0j4A2mWA53rRQHHy1BLC9IdZCAjyLlDhi
	 F3GxFW0QQMhpAW4aLMLPKWZd1uUsrmuCjb+7H3xD3s6cVaO+zcd7UvJD9yCoGHmQZu
	 fXjeAl1vqkgnwCtjfFLhPedd5JZ3SdmCLFbmgL8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgHERLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:11:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728460AbgHEREv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:04:51 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E237222D00;
        Wed,  5 Aug 2020 17:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596647090;
        bh=bEv1I5kUy8vw/4EQLmasNlul0jYH0UHc1VynpmwLox0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sZcswPx/xxMgbqCzG02ZGu8ILuUxfbUk5k03bxlx3V8LroEQR8W4RiBXdU1cFEsq/
         OkR2oj/Pr1pQC9YMt4NGJWPTy3IiykKKPzLr/4Fb9WlZNjmRFH/im2VxlMx/jPcbn9
         4EC8ty/EZqmXwj9FEz/UANWHzKjSWxu54eY/9k/w=
Date:   Thu, 6 Aug 2020 02:04:45 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [External] linux-next: build warning after merge of the ftrace
 tree
Message-Id: <20200806020445.649ddaa8b8ec1b91e23508e4@kernel.org>
In-Reply-To: <20200805111105.081276bb@oasis.local.home>
References: <20200805142136.0331f7ea@canb.auug.org.au>
        <CAMZfGtX0a3tui_KQfCXLcARVcev9V-HV6HMkXgVXObq8w-4EQg@mail.gmail.com>
        <20200805111105.081276bb@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 11:11:05 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 5 Aug 2020 12:53:39 +0800
> Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > On Wed, Aug 5, 2020 at 12:21 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > After merging the ftrace tree, today's linux-next build (powerpc
> > > ppc64_defconfig) produced this warning:
> > >
> > > kernel/kprobes.c: In function 'kill_kprobe':
> > > kernel/kprobes.c:1116:33: warning: statement with no effect [-Wunused-value]
> > >  1116 | #define disarm_kprobe_ftrace(p) (-ENODEV)
> > >       |                                 ^
> > > kernel/kprobes.c:2154:3: note: in expansion of macro 'disarm_kprobe_ftrace'
> > >  2154 |   disarm_kprobe_ftrace(p);
> > >       |   ^~~~~~~~~~~~~~~~~~~~
> > >  
> > 
> > Sorry, maybe we should rework the macro of disarm_kprobe_ftrace to an
> > inline function like below.
> > 
> > -#define disarm_kprobe_ftrace(p)        (-ENODEV)
> > +static inline int disarm_kprobe_ftrace(struct kprobe *p)
> > +{
> > +       return -ENODEV
> > +}
> >  #endif
> 
> Looks like that would work. Care to send a formal patch. Could you also
> change arm_kprobe_ftrace() as well?

Looks good to me too as far as updating it to static inline function.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
