Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDF9C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B2D524684
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 14:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgANONd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 09:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgANONd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 09:13:33 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80D02467A;
        Tue, 14 Jan 2020 14:13:31 +0000 (UTC)
Date:   Tue, 14 Jan 2020 09:13:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <tglx@linutronix.de>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <bobo.shaobowang@huawei.com>
Subject: Re: [PATCH] x86/ftrace: use ftrace_write to simplify code
Message-ID: <20200114091330.0ac1b2c3@gandalf.local.home>
In-Reply-To: <8435b848-f638-978c-bbd5-459657c4b34e@huawei.com>
References: <20200114015217.9246-1-cj.chengjian@huawei.com>
        <20200114081636.GH2827@hirez.programming.kicks-ass.net>
        <8435b848-f638-978c-bbd5-459657c4b34e@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 17:20:13 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:

> On 2020/1/14 16:16, Peter Zijlstra wrote:
> > On Tue, Jan 14, 2020 at 01:52:17AM +0000, Cheng Jian wrote:  
> >> ftrace_write() can be used in ftrace_modify_code_direct(),
> >> that make the code more brief.
> >>
> >> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>  
> > None of the code you're patching still exists. Please see tip/master.
> >
> > .  
> 
> 
> I find these patches in TIP. My patch may not be necessary.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=768ae4406a5cab7e8702550f2446dbeb377b798d
> 
> Thank you, Peter.
> 

I was thinking that Peter's changes made it to mainline already (and I
just rebased my next merge window work on 5.5-rc6).

I should have told you this :-/

-- Steve
