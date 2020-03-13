Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDA6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7804320767
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgCMXP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:15:57 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:55895 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgCMXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:15:57 -0400
Received: from fsav405.sakura.ne.jp (fsav405.sakura.ne.jp [133.242.250.104])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02DNFZl8040143;
        Sat, 14 Mar 2020 08:15:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav405.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp);
 Sat, 14 Mar 2020 08:15:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav405.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02DNFZr8040140
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Mar 2020 08:15:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
 <202003130015.02D0F9uT079462@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003131457370.242651@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <fa5d7060-4e6e-16d5-2c37-fec6019b4d62@i-love.sakura.ne.jp>
Date:   Sat, 14 Mar 2020 08:15:32 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003131457370.242651@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/14 7:01, David Rientjes wrote:
> The entire issue is that the victim never gets a chance to run because the 
> allocator doesn't give it a chance to run on an UP system.  Your patch is 
> broken because if the victim is current, you've lost your golden 
> opportunity to actually exit and ceded control to the allocator that will 
> now starve the victim.
> 

I still cannot understand. There is no need to give CPU time to OOM victims.
We just need to give CPU time to the OOM reaper kernel thread till the OOM
reaper kernel thread sets MMF_OOM_SKIP to OOM victims. If current thread is
an OOM victim, schedule_timeout_killable(1) will give other threads (including
the OOM reaper kernel thread) CPU time to run. That is similar with your
cond_resched() patch (except that cond_resched() might fail to give other
threads CPU time to run if current thread has realtime priority), isn't it?

So, please explain the mechanism why cond_resched() works but
schedule_timeout_killable(1) cannot work.
