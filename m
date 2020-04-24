Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22852C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C412071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbgDXQVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:21:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726908AbgDXQVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:21:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEFC520700;
        Fri, 24 Apr 2020 16:21:47 +0000 (UTC)
Date:   Fri, 24 Apr 2020 12:21:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200424122146.163b1680@gandalf.local.home>
In-Reply-To: <d967cd75-f61d-291a-81e9-1da76e4179c2@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <20200424092816.62a61b1d@gandalf.local.home>
        <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
        <20200424103131.7987f890@gandalf.local.home>
        <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
        <20200424114225.5a3bab7e@gandalf.local.home>
        <d967cd75-f61d-291a-81e9-1da76e4179c2@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 01:10:15 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> KERN_NO_CONSOLES is a mechanism for implementing user decided policy. As long as
> userspace can control whether to use KERN_NO_CONSOLES (e.g. sysctl), there should
> be no problem with adding KERN_NO_CONSOLES (i.e. this patch) to the kernel side.

How would you define what gets "KERN_NO_CONSOLES"? Is it going to be a
sysctl switch?

Also, how does one control the log level of prints with KERN_NO_CONSOLES?

-- Steve
