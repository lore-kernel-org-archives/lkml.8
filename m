Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D585A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgHYNyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:54:08 -0400
Received: from goliath.siemens.de ([192.35.17.28]:42198 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHYNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:54:07 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 07PDrBcT024230
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 15:53:12 +0200
Received: from [167.87.131.58] ([167.87.131.58])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07PDr3ue002994;
        Tue, 25 Aug 2020 15:53:05 +0200
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
To:     Petr Mladek <pmladek@suse.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20200814212525.6118-1-john.ogness@linutronix.de>
 <20200821080813.GM4353@alley>
 <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
 <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
 <20200825123542.GU4353@alley>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <24cb943d-bbd2-9a09-1470-e0771d4624ec@siemens.com>
Date:   Tue, 25 Aug 2020 15:53:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825123542.GU4353@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.08.20 14:35, Petr Mladek wrote:
> On Mon 2020-08-24 10:20:53, Kieran Bingham wrote:
>> Hi Petr,
>>
>> On 21/08/2020 09:55, Jan Kiszka wrote:
>>> On 21.08.20 10:08, Petr Mladek wrote:
>>>> On Fri 2020-08-14 23:31:23, John Ogness wrote:
>>>>> Hi,
>>>>>
>>>>> When we brought in the new lockless printk ringbuffer, we overlooked the gdb
>>>>> scripts. Here are a set of patches to implement gdb support for the new
>>>>> ringbuffer.
>>>>>
>>>>> John Ogness (2):
>>>>>   scripts/gdb: add utils.read_ulong()
>>>>>   scripts/gdb: update for lockless printk ringbuffer
>>>>
>>>> I am not fluent in the gdb macros and python so I did not try any
>>>> deep review. But both patches work for me:
>>>>
>>>> Tested-by: Petr Mladek <pmladek@suse.com>
>>>>
>>>> I am going to give it few more days before pushing just in case there is
>>>> another feedback.
>>
>> Before 'pushing' ?
>>
>> What context do you mean here? These patches go through AKPM don't they?
>> Did I miss some update to procedures?
> 
> Both patches should go into mainline together with the lockless printk
> ring buffer. It is already in linux-next via printk/linux.git,
> branch printk-rework.
> 
> The plan is to get it into mainline when pr_cont() handling is solved.
> It is more complicated than we hoped for, see
> https://lore.kernel.org/r/20200824103538.31446-1-john.ogness@linutronix.de
> It is still not clear whether it will be ready for 5.10.
> 
> Andrew, would you mind when I take the three gdb/lockless-printk
> related changes via printk tree to avoid synchronization problems?

From my POV, that would be best in this case - but actually also in
other cases where developers happen to notice the dependency between
their refactorings and gdb scripts.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
