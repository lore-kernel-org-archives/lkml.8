Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7D4C28CBC
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F18820708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 00:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgEGAua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 20:50:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54202 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEGAua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 20:50:30 -0400
Received: from fsav108.sakura.ne.jp (fsav108.sakura.ne.jp [27.133.134.235])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0470oSn8075002;
        Thu, 7 May 2020 09:50:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav108.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp);
 Thu, 07 May 2020 09:50:28 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav108.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0470oS9h074998
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 7 May 2020 09:50:28 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200425004609.GE8982@jagdpanzerIV.localdomain>
 <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
 <20200427062117.GC486@jagdpanzerIV.localdomain>
 <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
 <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
 <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <0d513c80-8c8e-17b6-5b9c-73c7bca77252@i-love.sakura.ne.jp>
Date:   Thu, 7 May 2020 09:50:21 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/07 0:26, Joe Perches wrote:
> On Wed, 2020-05-06 at 18:45 +0900, Tetsuo Handa wrote:
>> On 2020/04/28 20:33, Tetsuo Handa wrote:
>>> On 2020/04/27 15:21, Sergey Senozhatsky wrote:
>>>>> KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
>>>>> important but "printed for immediate notification" is not important.
>>>>> In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
>>>>> immediate notification" is important.
>>>>
>>>> per-console loglevel is a user configurable parameter.
>>>> KERN_NO_CONSOLES is a hard-coded policy.
>>>
>>> But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
>>> KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?
>>>
>>
>> Any problems remaining?
> 
> printk_get_level / printk_skip_level and the various
> uses of %pV using printk_get_level
> 

Excuse me, but what do you mean?

I wish printk() accepts "loglevel" argument detached from "fmt" argument (e.g.

  int printkl(int loglevel, const char *fmt_without_loglevel, ...);
  int vprintkl(int loglevel, const char *fmt_without_loglevel, va_list args);

) so that users of KERN_NO_CONSOLES need not to do like

  if (sysctl_no_console_for_XX)
    printk(KERN_INFO KERN_NO_CONSOLES pr_fmt(fmt) "%s\n", "hello");
  else
    printk(KERN_INFO pr_fmt(fmt) "%s\n", "hello");

or

  printk("%s" pr_fmt(fmt) "%s\n", sysctl_no_console_for_XX ? KERN_INFO KERN_NO_CONSOLES : KERN_INFO, "hello");

in order to conditionally embed KERN_NO_CONSOLES into

  pr_info("%s\n", "hello");

. But this patch is about whether KERN_NO_CONSOLES is acceptable. How to
pass KERN_NO_CONSOLES (if KERN_NO_CONSOLES is acceptable) is a future patch.
