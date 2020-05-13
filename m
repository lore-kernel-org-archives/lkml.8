Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6726CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43E920657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgEMNqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgEMNqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:46:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA549204EA;
        Wed, 13 May 2020 13:46:43 +0000 (UTC)
Date:   Wed, 13 May 2020 09:46:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200513094642.56bf50f7@gandalf.local.home>
In-Reply-To: <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
References: <20200427062117.GC486@jagdpanzerIV.localdomain>
        <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
        <20200428121828.GP28637@dhcp22.suse.cz>
        <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
        <20200428154532.GU28637@dhcp22.suse.cz>
        <b1d507b1-dae7-f526-c74a-d465ddecea6a@i-love.sakura.ne.jp>
        <20200429142106.GG28637@dhcp22.suse.cz>
        <a59271f1-b3fc-26d1-f0a2-5ec351d0095e@i-love.sakura.ne.jp>
        <20200513062652.GM413@jagdpanzerIV.localdomain>
        <a75d6560-ad99-5b02-3648-247c27c3a398@i-love.sakura.ne.jp>
        <20200513100413.GH17734@linux-b0ei>
        <20564555-7b84-f716-5dcd-978f76ad459a@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 20:03:53 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
> printing to consoles and the rest messages do not worth printing to consoles.
> Existing KERN_$LOGLEVEL is too rough-grained.

And this statement is exactly why I believe you are wrong.

Because *I* think messages to the console is more important than messages
to the logs. Several of my servers are only monitored by the console. I
seldom look at the logs on those machines.

This is a policy decision, and must be made by user space. Your use case is
not applicable to everyone else's use case. And should not be set in stone
by the kernel.

-- Steve
