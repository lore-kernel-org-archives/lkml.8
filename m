Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0489C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CBC2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbgCMXdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:33:14 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:52286 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgCMXdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:33:14 -0400
Received: from fsav107.sakura.ne.jp (fsav107.sakura.ne.jp [27.133.134.234])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02DNWvre053999;
        Sat, 14 Mar 2020 08:32:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav107.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp);
 Sat, 14 Mar 2020 08:32:57 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav107.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 02DNWvNF053995
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 14 Mar 2020 08:32:57 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
 <202003130015.02D0F9uT079462@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003131457370.242651@chino.kir.corp.google.com>
 <fa5d7060-4e6e-16d5-2c37-fec6019b4d62@i-love.sakura.ne.jp>
Message-ID: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp>
Date:   Sat, 14 Mar 2020 08:32:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fa5d7060-4e6e-16d5-2c37-fec6019b4d62@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/03/14 8:15, Tetsuo Handa wrote:
> If current thread is
> an OOM victim, schedule_timeout_killable(1) will give other threads (including
> the OOM reaper kernel thread) CPU time to run.

If current thread is an OOM victim, schedule_timeout_killable(1) will give other
threads (including the OOM reaper kernel thread) CPU time to run, by leaving
try_charge() path due to should_force_charge() == true and reaching do_exit() path
instead of returning to userspace code doing "for (;;);".

Unless the problem is that current thread cannot reach should_force_charge() check,
schedule_timeout_killable(1) should work.
