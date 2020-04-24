Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D484C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC255206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgDXQfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:35:00 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55531 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDXQe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:34:56 -0400
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03OGYIuD058791;
        Sat, 25 Apr 2020 01:34:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp);
 Sat, 25 Apr 2020 01:34:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav106.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03OGYIWV058787
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Apr 2020 01:34:18 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200424092816.62a61b1d@gandalf.local.home>
 <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
 <20200424103131.7987f890@gandalf.local.home>
 <7ec0b0a3-39ae-0f1c-b8c2-e1e9e60f1223@i-love.sakura.ne.jp>
 <20200424114225.5a3bab7e@gandalf.local.home>
 <d967cd75-f61d-291a-81e9-1da76e4179c2@i-love.sakura.ne.jp>
 <20200424122146.163b1680@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <78c4a174-bc44-8baa-e731-8e36b62df29f@i-love.sakura.ne.jp>
Date:   Sat, 25 Apr 2020 01:34:15 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424122146.163b1680@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/25 1:21, Steven Rostedt wrote:
> On Sat, 25 Apr 2020 01:10:15 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> KERN_NO_CONSOLES is a mechanism for implementing user decided policy. As long as
>> userspace can control whether to use KERN_NO_CONSOLES (e.g. sysctl), there should
>> be no problem with adding KERN_NO_CONSOLES (i.e. this patch) to the kernel side.
> 
> How would you define what gets "KERN_NO_CONSOLES"? Is it going to be a
> sysctl switch?

Yes. See
https://lkml.kernel.org/r/c95dfafb-fe9c-19d7-8d42-bcd7d0946867@i-love.sakura.ne.jp .

> 
> Also, how does one control the log level of prints with KERN_NO_CONSOLES?

I couldn't understand the question.

KERN_NO_CONSOLES is just a flag for not to call call_console_drivers().
Messages printed with printk(KERN_$LOGLEVEL KERN_NO_CONSOLES ...) will be
read by userspace syslog daemon and be filtered based on KERN_$LOGLEVEL.

