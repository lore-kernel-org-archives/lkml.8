Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BE0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25A820776
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 01:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgDYBIa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 21:08:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57122 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgDYBI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 21:08:29 -0400
Received: from fsav104.sakura.ne.jp (fsav104.sakura.ne.jp [27.133.134.231])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03P17mZV083687;
        Sat, 25 Apr 2020 10:07:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav104.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp);
 Sat, 25 Apr 2020 10:07:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav104.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03P17mu8083684
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Apr 2020 10:07:48 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
Date:   Sat, 25 Apr 2020 10:07:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425004609.GE8982@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/25 9:46, Sergey Senozhatsky wrote:
> On (20/04/24 11:42), Tetsuo Handa wrote:
> [..]
>> @@ -19,6 +19,7 @@ static inline int printk_get_level(const char *buffer)
>>  		switch (buffer[1]) {
>>  		case '0' ... '7':
>>  		case 'c':	/* KERN_CONT */
>> +		case 'S':       /* KERN_NO_CONSOLES */
>>  			return buffer[1];
>>  		}
>>  	}
> 
> So this means NO_CONSOLES_AT_ALL, slow + fast ones.

Right.

>                                                     I wonder if this
> wants to be NO_SLOW_CONSOLES instead. Which then brings us to the
> next question - can this be done with per-console loglevel setting?

It is difficult to define what is slow consoles. While netconsole will be
a fast console, we can forward kernel messages via syslog daemon if desired.

NO_SLOW_CONSOLES might be useful for immediate notification like panic().
But KERN_NO_CONSOLES is not for immediate notification like panic().

KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
important but "printed for immediate notification" is not important.
In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
immediate notification" is important.

