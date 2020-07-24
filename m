Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB62C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57269206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGXRg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:47670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgGXRg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:36:58 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03EC92067D;
        Fri, 24 Jul 2020 17:36:57 +0000 (UTC)
Date:   Fri, 24 Jul 2020 13:36:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Carter <oscar.carter@gmx.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 2/2] kernel/trace: Remove function callback casts
Message-ID: <20200724133656.76c75629@oasis.local.home>
In-Reply-To: <20200724171418.GB3123@ubuntu>
References: <20200719155033.24201-1-oscar.carter@gmx.com>
        <20200719155033.24201-3-oscar.carter@gmx.com>
        <20200721140545.445f0258@oasis.local.home>
        <20200724161921.GA3123@ubuntu>
        <20200724123528.36ea9c9e@oasis.local.home>
        <20200724171418.GB3123@ubuntu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 19:14:18 +0200
Oscar Carter <oscar.carter@gmx.com> wrote:

> > The linker trick should only affect architectures that don't implement
> > the needed features. I can make it so the linker trick is only applied
> > to those archs, and other archs that want more protection only need to
> > add these features to their architectures.
> 
> > It's much less intrusive than this patch.  
> 
> Sorry, but I don't understand your proposal. What features an arch need to
> add if want the CFI protection?

The better question is, what features should an arch add to not need
the linker trick ;-)

That is, they need to change it so that they add the two parameters
that is expected by the ftrace core code. Once they do that, then they
don't need to use the linker trick, and no function typecast is needed.

In other-words, if they support the ftrace_ops and regs passing, they
can define ARCH_SUPPORTS_FTRACE_OPS. Note, they don't even really need
to support the regs, (can just send NULL), if they don't have
HAVE_DYNAMIC_FTRACE_WITH_REGS.

Which BTW, is supported by the following architectures:

  arm
  arm64
  csky
  parisc
  powerpc
  riscv
  s390
  x86

All of the above architectures should not even be hitting the code that
does the function cast. What architecture are you doing all this for?

-- Steve
