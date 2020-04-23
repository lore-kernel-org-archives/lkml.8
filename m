Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C0820CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgDWPtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:49:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:65396 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgDWPtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:49:16 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03NFmRtv069608;
        Fri, 24 Apr 2020 00:48:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Fri, 24 Apr 2020 00:48:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03NFmLfB069494
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Fri, 24 Apr 2020 00:48:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCHv3 00/50] Add log level to show_stack()
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200418201944.482088-1-dima@arista.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <91d0f39c-2f79-20c0-7c68-f129dfea5e14@i-love.sakura.ne.jp>
Date:   Fri, 24 Apr 2020 00:48:16 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/19 5:18, Dmitry Safonov wrote:
> Add log level argument to show_stack().
> Done in three stages:
> 1. Introducing show_stack_loglvl() for every architecture
> 2. Migrating old users with an explicit log level
> 3. Renaming show_stack_loglvl() into show_stack()

Thank you for proposing this patchset.

Every architecture gets show_stack_loglvl() means that it will become
possible to implement dump_stack_loglvl(const char *loglvl), isn't it?

I'm about to start a proposal for making it possible to suppress printing majority of
OOM-killer messages and memory allocation failure messages to consoles
( https://lkml.kernel.org/r/efc649fc-f838-97ea-44a2-882f068d033c@i-love.sakura.ne.jp ), for
dump_stack() / show_mem() / dump_tasks() etc. can take long time (if printed to consoles) is
an unhappy thing for OOM context and atomic context.
