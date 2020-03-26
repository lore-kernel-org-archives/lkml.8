Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576DEC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231362073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCZVbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:31:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:47718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgCZVby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:31:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B34D420658;
        Thu, 26 Mar 2020 21:31:53 +0000 (UTC)
Date:   Thu, 26 Mar 2020 17:31:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
Message-ID: <20200326173152.06ef57d5@gandalf.local.home>
In-Reply-To: <20200326194652.GA29213@ubuntu-m2-xlarge-x86>
References: <20200220051011.26113-1-natechancellor@gmail.com>
        <20200319020004.GB8292@ubuntu-m2-xlarge-x86>
        <20200319103312.070b4246@gandalf.local.home>
        <20200326194652.GA29213@ubuntu-m2-xlarge-x86>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 12:46:52 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> On Thu, Mar 19, 2020 at 10:33:12AM -0400, Steven Rostedt wrote:
> > On Wed, 18 Mar 2020 19:00:04 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >   
> > > Gentle ping for review/acceptance.  
> > 
> > Hmm, my local patchwork had this patch rejected. I'll go and apply it, run
> > some tests and see if it works. Perhaps I meant to reject v1 and
> > accidentally rejected v2 :-/
> > 
> > Thanks for the ping!
> > 
> > -- Steve  
> 
> Hi Steve,
> 
> Did you ever get around to running any tests? If so, were there any
> issues? This warning is one of two remaining across several different
> configurations so I sent the patch to turn on the warning and I want
> to make sure this gets picked up at some point:
> 
> https://lore.kernel.org/lkml/20200326194155.29107-1-natechancellor@gmail.com/
> 
> If you have not had time, totally fine, I just want to make sure it does
> not fall through the cracks again :)
> 

I have applied it to my queue. But the code I have in with it failed my
tests, and I'm just about to kick off another round (I believe I fixed
everything). And hopefully if it all passes, I can get it out to my
linux-next branch by tomorrow.

-- Steve
