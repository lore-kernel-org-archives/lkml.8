Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FECCC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6E2063A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgEDPoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:44:23 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50870 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEDPoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:44:23 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 044Fi1hv055060;
        Tue, 5 May 2020 00:44:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Tue, 05 May 2020 00:44:01 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 044Fi0RI055015
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 5 May 2020 00:44:01 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <939b6744-6556-2733-b83e-bf14e848dabd@I-love.SAKURA.ne.jp>
 <CALvZod5T9pYG1xVHqNM=c68jgKPVXtKjuvV0DSAR+Ld_Mm1c4A@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3c24ef6a-f1f4-38e6-2d0f-1eac18dc15bb@i-love.sakura.ne.jp>
Date:   Tue, 5 May 2020 00:44:00 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CALvZod5T9pYG1xVHqNM=c68jgKPVXtKjuvV0DSAR+Ld_Mm1c4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/05/04 23:57, Shakeel Butt wrote:
> On Mon, May 4, 2020 at 7:20 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> On 2020/05/04 22:54, Shakeel Butt wrote:
>>> It may not be a problem for an individual or small scale deployment
>>> but when "sweep before tear down" is the part of the workflow for
>>> thousands of machines cycling through hundreds of thousands of cgroups
>>> then we can potentially flood the logs with not useful dumps and may
>>> hide (or overflow) any useful information in the logs.
>>
>> I'm proposing a patch which allows configuring which OOM-related messages
>> should be sent to consoles at
>> https://lkml.kernel.org/r/20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp .
>> Will that approach help you?
> 
>>From what I understand, that patch is specifically for controlling
> messages to consoles. The messages will still be in logs, right?
> 

Right.

If you want to control which OOM-related messages should be sent to syslog,
we could use similar approach.
