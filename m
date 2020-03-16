Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDD8C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7AE2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730579AbgCPKFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:05:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50332 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbgCPKFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:05:10 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02GA4og3062365;
        Mon, 16 Mar 2020 19:04:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Mon, 16 Mar 2020 19:04:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02GA4jQd062348
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Mon, 16 Mar 2020 19:04:50 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
To:     Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
 <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
 <20200312153238.c8d25ea6994b54a2c4d5ae1f@linux-foundation.org>
 <20200316093152.GE11482@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <3be371a0-5b1e-7115-8659-186612ad5fb0@i-love.sakura.ne.jp>
Date:   Mon, 16 Mar 2020 19:04:44 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316093152.GE11482@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/16 18:31, Michal Hocko wrote:
>> What happens if the allocator has SCHED_FIFO?
> 
> The same thing as a SCHED_FIFO running in a tight loop in the userspace.
> 
> As long as a high priority context depends on a resource held by a low
> priority task then we have a priority inversion problem and the page
> allocator is no real exception here. But I do not see the allocator
> is much different from any other code in the kernel. We do not add
> random sleeps here and there to push a high priority FIFO or RT tasks
> out of the execution context. We do cond_resched to help !PREEMPT
> kernels but priority related issues are really out of scope of that
> facility.
> 

Spinning with realtime priority in userspace is a userspace's bug.
Spinning with realtime priority in kernelspace until watchdog fires is
a kernel's bug. We are not responsible for userspace's bug, and I'm
asking whether the memory allocator kernel code can give enough CPU
time to other threads even if current thread has realtime priority.
