Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2472AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE99A2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgIDQGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 12:06:16 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50688 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727990AbgIDQGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 12:06:10 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 084G5WXk049502;
        Sat, 5 Sep 2020 01:05:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Sat, 05 Sep 2020 01:05:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 084G5Wjj049498
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 5 Sep 2020 01:05:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] lockdep: Allow tuning tracing capacity constants.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
Message-ID: <0f7233f7-a04a-e9c9-7920-3a170cc97e4b@i-love.sakura.ne.jp>
Date:   Sat, 5 Sep 2020 01:05:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello. Can we apply this patch?

This patch addresses top crashers for syzbot, and applying this patch
will help utilizing syzbot's resource for finding other bugs.

On 2020/08/28 0:20, Tetsuo Handa wrote:
> Since syzkaller continues various test cases until the kernel crashes,
> syzkaller tends to examine more locking dependencies than normal systems.
> As a result, syzbot is reporting that the fuzz testing was terminated
> due to hitting upper limits lockdep can track [1] [2] [3].
> 
> Let's allow individually tuning upper limits via kernel config options
> (based on an assumption that there is no inter-dependency among these
> constants).
> 
> [1] https://syzkaller.appspot.com/bug?id=3d97ba93fb3566000c1c59691ea427370d33ea1b
> [2] https://syzkaller.appspot.com/bug?id=381cb436fe60dc03d7fd2a092b46d7f09542a72a
> [3] https://syzkaller.appspot.com/bug?id=a588183ac34c1437fc0785e8f220e88282e5a29f
> 
> Reported-by: syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>
> Reported-by: syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  kernel/locking/lockdep.c           |  2 +-
>  kernel/locking/lockdep_internals.h |  8 +++---
>  lib/Kconfig.debug                  | 40 ++++++++++++++++++++++++++++++
>  3 files changed, 45 insertions(+), 5 deletions(-)
> 
