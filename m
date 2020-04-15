Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABEAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93E5206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392704AbgDOBnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392682AbgDOBnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:43:04 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B080C206D5;
        Wed, 15 Apr 2020 01:43:02 +0000 (UTC)
Date:   Tue, 14 Apr 2020 21:43:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Jiri Slaby <jslaby@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Add kernel config option for tweaking kernel
 behavior.
Message-ID: <20200414214301.126ada20@oasis.local.home>
In-Reply-To: <CAHk-=wjLfHaF8F-L9axpYcNtECa=Rw_LWJ98GP6ByUB+O98tAQ@mail.gmail.com>
References: <20200413063317.7164-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <CAHk-=wgbMi2+VBN0SCEw9GeoiWgui034AOBwbt_dW9tdCa3Nig@mail.gmail.com>
        <f2b9ef2a-8449-72fc-4f87-8bf65d713800@i-love.sakura.ne.jp>
        <6e3864f5-fdaf-874a-b326-1c79816d7141@i-love.sakura.ne.jp>
        <CAHk-=wjLfHaF8F-L9axpYcNtECa=Rw_LWJ98GP6ByUB+O98tAQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 18:14:51 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> If that WARN_ON() is a problem, then the people behind it should be
> appraised of it, and it should probably be removed. I'm assuming it
> was some kind of "I don't think this can happen, so if it does, I want
> to see how it happened" WARN_ON.

What I do (and feel everyone should too), is I only add a WARN_ON()
when I check something that I believe *can't* happen. If the WARN_ON()
triggers, it either means that there's a bug in the code (and needs a
fix), or the code design changed, in which case the WARN_ON() should be
either removed, or that code updated to handle the new change.

In any case, a WARN_ON() should always be investigated when hit.

The only time I've had issues with people is when I have some hardware
(i915) that triggers a WARN_ON() and I'm told that my hardware is buggy
(or I need a firmware update). In which case, I just manually remove
the WARN_ON() because the machine that triggers it is a test machine I
don't have the time to waste updating firmware on.

-- Steve
