Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1C2C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CCF7208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgCKOLT convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgCKOLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:11:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77F5B20726;
        Wed, 11 Mar 2020 14:11:17 +0000 (UTC)
Date:   Wed, 11 Mar 2020 10:11:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200311101115.53139149@gandalf.local.home>
In-Reply-To: <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
        <20200308065258.GE3983392@kroah.com>
        <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com>
        <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020 07:30:01 +0100
Dmitry Vyukov <dvyukov@google.com> wrote:

> Steve, I am not sure if by lockdown you mean the existing lockdown
> mechanism, or just something similar in nature. As Tetsuo pointed, the
> possibility of using the existing lockdown mechanism for this was
> discussed here (and rejected):
> https://lore.kernel.org/lkml/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com/

From Matthew's message a couple of emails earlier:

> Simplicity. Based on discussion, we didn't want the lockdown LSM to
> enable arbitrary combinations of lockdown primitives, both because
> that would make it extremely difficult for userland developers and
> because it would make it extremely easy for local admins to
> accidentally configure policies that didn't achieve the desired
> outcome. There's no inherent problem in adding new options, but really
> right now they should fall into cases where they're protecting either
> the integrity of the kernel or preventing leakage of confidential
> information from the kernel.

Now, if you are worried that fuzzing will cause harm, or crash the kernel,
it sounds to me, whatever fuzzing did would satisfy Matthew's "integrity of
the kernel" portion.

In other words, I believe fuzzing folks should be working with the lockdown
folks and letting the lockdown folks how root can crash the system. I would
think from a security point of view, that if there's a known method to take
down the kernel, and I don't want root to be able to do so, we should
either fix the kernel to not be able to do so, or if that interface is "you
should know what you are doing" then it should be something an admin could
lock down to keep other admins who don't know what they are doing from
crashing the system.

Or teach the fuzz tool not to do specific bad things.

Honestly, if you just go with a single config to prevent interfaces from
crashing the system while running a fuzz test, then you just lowered the
usefulness of the fuzz test, as it will never find legitimate cases where
that interface crashed the kernel when it should not have.

We are currently trying to clean up the tracing / probing code to not be
able to crash the kernel with any interface. It's hard, but it is a goal.

-- Steve
