Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C3EC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAACC2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgCSQBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:01:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgCSQBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:01:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD49920658;
        Thu, 19 Mar 2020 16:01:45 +0000 (UTC)
Date:   Thu, 19 Mar 2020 12:01:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] tracing: Use address-of operator on section symbols
Message-ID: <20200319120143.5ffed518@gandalf.local.home>
In-Reply-To: <CAKwvOdm9notnmKYQqAsTsZN7qqEpNtpQ091wv=rWZ0kzS3OzAA@mail.gmail.com>
References: <20200220051011.26113-1-natechancellor@gmail.com>
        <20200319020004.GB8292@ubuntu-m2-xlarge-x86>
        <20200319103312.070b4246@gandalf.local.home>
        <CAKwvOdm9notnmKYQqAsTsZN7qqEpNtpQ091wv=rWZ0kzS3OzAA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 08:27:11 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> On Thu, Mar 19, 2020 at 7:33 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Wed, 18 Mar 2020 19:00:04 -0700
> > Nathan Chancellor <natechancellor@gmail.com> wrote:
> >  
> > > Gentle ping for review/acceptance.  
> >
> > Hmm, my local patchwork had this patch rejected. I'll go and apply it, run  
> 
> Local patchwork? As in patchwork.kernel.org?  (Is there a client, or
> can you host your own instance?)
>

No, I went into a lot of effort to get it up and running on my own inbox.
I did this because I wasn't able to keep up with all the patches being sent
directly to me. It's a bit fragile, and the workflow mailing list is
working on ways to have this be a more general solution for maintainers.

-- Steve
