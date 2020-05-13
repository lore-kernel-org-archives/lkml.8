Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2299DC2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A71A320659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbgEMOEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:04:04 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55136 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgEMOED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:04:03 -0400
Received: from fsav302.sakura.ne.jp (fsav302.sakura.ne.jp [153.120.85.133])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 04DE3MOo098927;
        Wed, 13 May 2020 23:03:22 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav302.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp);
 Wed, 13 May 2020 23:03:22 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav302.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 04DE3LDg098920
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 13 May 2020 23:03:21 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
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
 <20200513094642.56bf50f7@gandalf.local.home>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <355d1700-4d33-4604-4187-27fd994bf473@i-love.sakura.ne.jp>
Date:   Wed, 13 May 2020 23:03:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513094642.56bf50f7@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/13 22:46, Steven Rostedt wrote:
> On Wed, 13 May 2020 20:03:53 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
>> printing to consoles and the rest messages do not worth printing to consoles.
>> Existing KERN_$LOGLEVEL is too rough-grained.
> 
> And this statement is exactly why I believe you are wrong.
> 
> Because *I* think messages to the console is more important than messages
> to the logs. Several of my servers are only monitored by the console. I
> seldom look at the logs on those machines.

As a technical staff at a support center, I can never monitor the consoles of
customer's servers. I can examine only syslog messages saved as /var/log/messages .

> 
> This is a policy decision, and must be made by user space. Your use case is
> not applicable to everyone else's use case. And should not be set in stone
> by the kernel.

My proposal does not set in stone by the kernel.
My proposal is gives users a chance to control whether to print to consoles.

On 2020/05/13 22:55, Steven Rostedt wrote:
> On Wed, 13 May 2020 20:03:53 +0900
> Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
> 
>> I think that basically only oops (e.g. WARN()/BUG()/panic()) messages worth
>> printing to consoles and the rest messages do not worth printing to consoles.
>> Existing KERN_$LOGLEVEL is too rough-grained.
> 
> Why don't you look into having a "noconsole" command line option that will
> not print anything to the consoles but oops messages.

I can't force customers to use "noconsole" command line option. That's a
too rough-grained boolean.

> 
> Sounds more like what you would like, and something that perhaps would be
> acceptable by the larger community.
