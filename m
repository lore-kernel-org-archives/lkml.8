Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDB2C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108C820873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgCINXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgCINXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:23:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0861D20727;
        Mon,  9 Mar 2020 13:23:30 +0000 (UTC)
Date:   Mon, 9 Mar 2020 09:23:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
Message-ID: <20200309092329.04962c9c@gandalf.local.home>
In-Reply-To: <3ee9c586-002b-f504-9e3b-5afa8929209b@i-love.sakura.ne.jp>
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com>
        <20200308065258.GE3983392@kroah.com>
        <CAHk-=wjCcCmQig8w8QEfyqyXACLzDc7b4TSW-KzAMzmS-QvJ+Q@mail.gmail.com>
        <3ee9c586-002b-f504-9e3b-5afa8929209b@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Mar 2020 20:22:47 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> I think that locking down individual thing using individual switch is an
> endless game of maintaining list of switches. When someone adds a code
> which should not be fuzzed, the author of that code or the maintainer of
> fuzzers will add a new switch for that code, and the maintainer of fuzzers
> forever has to follow new switches. I think that it is better to keep number
> of switches minimal until we have to split into fine grained switches.

Can't we add a "TESTING" or "FUZZING" lockdown switch, that keeps root from
executing things that shouldn't be fuzzed?

I highly doubt that a kernel developer would even think "this shouldn't be
fuzzed" when adding something. It's going to first be reported by the
fuzz testing anyway. Don't just push the burden to the kernel developers.

-- Steve
