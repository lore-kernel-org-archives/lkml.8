Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F727C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8D220786
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 02:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgHDCgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 22:36:37 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:56346 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbgHDCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:36:37 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0742aB5i081843;
        Tue, 4 Aug 2020 11:36:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Tue, 04 Aug 2020 11:36:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0742aBSv081838
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 4 Aug 2020 11:36:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
 <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
Message-ID: <37b60b14-4eb6-36b3-1195-97c2d27b7ed8@i-love.sakura.ne.jp>
Date:   Tue, 4 Aug 2020 11:36:09 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Peter, Ingo and Will.

(Q1) Can we change the capacity using kernel config?

(Q2) If we can change the capacity, is it OK to specify these constants
     independently? (In other words, is there inter-dependency among
     these constants?)

(Q3) Do you think that we can extend lockdep to be used as a tool for auditing
     locks held in kernel space and rebuilding lock dependency map in user space?

On 2020/07/25 14:23, Tetsuo Handa wrote:
>> Also somebody may use it to _reduce_ size of the table for a smaller kernel.
> 
> Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
> as soon as lockdep warned the possibility of deadlock.
> 
> Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
> checking the same dependency tree. However, the possibility of deadlock can be
> warned for only locks held within each kernel boot, and it is impossible to hold
> all locks with one kernel boot.
> 
> Then, it might be nice if lockdep can audit only "which lock was held from which
> context and what backtrace" and export that log like KCOV data (instead of evaluating
> the possibility of deadlock), and rebuild the whole dependency (and evaluate the
> possibility of deadlock) across multiple kernel boots in userspace.

