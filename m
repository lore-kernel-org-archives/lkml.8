Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0764FC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CA6206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:12:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgD1NMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:12:15 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52173 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgD1NMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:12:15 -0400
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03SDBVLO084794;
        Tue, 28 Apr 2020 22:11:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Tue, 28 Apr 2020 22:11:31 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03SDBRAQ084782
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Apr 2020 22:11:31 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <20200428121828.GP28637@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <b4d74234-8009-9ffd-011f-bd5d1a4b85f6@i-love.sakura.ne.jp>
Date:   Tue, 28 Apr 2020 22:11:19 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428121828.GP28637@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/28 21:18, Michal Hocko wrote:
> On Tue 28-04-20 20:33:21, Tetsuo Handa wrote:
>> On 2020/04/27 15:21, Sergey Senozhatsky wrote:
>>>> KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
>>>> important but "printed for immediate notification" is not important.
>>>> In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
>>>> immediate notification" is important.
>>>
>>> per-console loglevel is a user configurable parameter.
>>> KERN_NO_CONSOLES is a hard-coded policy.
>>
>> But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
>> KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?
> 
> How do I as a kernel developer know that KERN_NO_CONSOLES should be
> used? In other words, how can I assume what a user will consider
> important on the console?
> 

Existing KERN_$LEVEL allows a user to determine whether he/she wants that message
to be printed on consoles (even if it spams his/her operation doing on consoles), and
at the same time constrains that user whether that message is saved to log files.
KERN_NO_CONSOLES allows a user to control whether he/she wants that message to be
saved to log files (without spamming his/her operation doing on consoles).

Consoles which are limited by "rows" * "columns" size should receive (ideally) up to
a few lines of messages. Printing more lines on such consoles disturbs users using
such consoles. Let alone printing one thousand lines of messages (e.g. dump_tasks())
on such consoles. Printing one thousand lines of messages on read-only consoles (e.g.
netconsole) might be fine, but non-urgent messages can afford waiting for userspace
to do more sophisticated handling (e.g. evaluate and filter).

Even without per-console loglevel feature, we can reduce spam messages for consoles
by using KERN_NO_CONSOLES. For example, send only the summary part of OOM-killer and
allocation failure messages to both consoles and log files (by not using KERN_NO_CONSOLES),
and send the non-summary part to only log files (by using KERN_NO_CONSOLES with 
KERN_$LEVEL used for summary part in order to make sure that userspace daemon will
save both the summary and non-summary parts).
