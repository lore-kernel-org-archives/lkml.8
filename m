Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69D3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C996B207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 08:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgHUI4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 04:56:11 -0400
Received: from thoth.sbs.de ([192.35.17.2]:56601 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUI4I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 04:56:08 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 07L8t3Ls009097
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 10:55:03 +0200
Received: from [167.87.31.209] ([167.87.31.209])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 07L8t0nk008339;
        Fri, 21 Aug 2020 10:55:00 +0200
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kieran Bingham <kbingham@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
References: <20200814212525.6118-1-john.ogness@linutronix.de>
 <20200821080813.GM4353@alley>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
Date:   Fri, 21 Aug 2020 10:55:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821080813.GM4353@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.08.20 10:08, Petr Mladek wrote:
> On Fri 2020-08-14 23:31:23, John Ogness wrote:
>> Hi,
>>
>> When we brought in the new lockless printk ringbuffer, we overlooked the gdb
>> scripts. Here are a set of patches to implement gdb support for the new
>> ringbuffer.
>>
>> John Ogness (2):
>>   scripts/gdb: add utils.read_ulong()
>>   scripts/gdb: update for lockless printk ringbuffer
> 
> I am not fluent in the gdb macros and python so I did not try any
> deep review. But both patches work for me:
> 
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to give it few more days before pushing just in case there is
> another feedback.
> 

Thanks, perfect!

> Best Regards,
> Petr
> 
> BTW: Are you aware of https://github.com/crash-python/crash-python project?
>      The ambition is to implement "crash" features and even more into
>      gdb using python extensions. It similar approach like
>      scripts/gdb/
> 
>      crash-python is being developed sporadically in waves. It is
>      mostly during a week that is dedicated for such projects
>      at SUSE. It would be great to get more contributors.
> 

The problem with all those out-of-tree kernel debugging projects is that
they are even further away from the changes in upstream they need to
adjust to over and over again. It's already hard for scripts/gdb to keep
up as only few people are aware of the dependencies, and it's always
easy to forget. But it's getting better and better here IMHO. And that
was my idea behind pushing things into upstream.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
