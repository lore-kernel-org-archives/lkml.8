Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B59C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9B920678
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgA2NJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:09:42 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:62046 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2NJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:09:41 -0500
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00TD9egE058776;
        Wed, 29 Jan 2020 22:09:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp);
 Wed, 29 Jan 2020 22:09:40 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav305.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00TD9YDV058726
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 29 Jan 2020 22:09:40 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm/page_counter: fix various data races
To:     Qian Cai <cai@lca.pw>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
 <2D795DB7-66FE-4F01-872F-F8ACAE9505EF@lca.pw>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <d98acf1e-ef0a-035f-2d7c-e22bc4c874bd@i-love.sakura.ne.jp>
Date:   Wed, 29 Jan 2020 22:09:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2D795DB7-66FE-4F01-872F-F8ACAE9505EF@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/29 21:25, Qian Cai wrote:
> 
> 
>> On Jan 29, 2020, at 7:13 AM, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> By the way, can READ_ONCE()/WRITE_ONCE() really solve this warning?
>> The link above says read/write on the same location ( mm/page_counter.c:129 ).
>> I don't know how READ_ONCE()/WRITE_ONCE() can solve the race.
> 
> That looks like a different one where it complains about c->failcnt++. I’ll send a separate patch for that.
> 

Ah, then this patch is meant for mm/page_counter.c:138 versus page_counter.c:139 race which was
closed as invalid at https://syzkaller.appspot.com/bug?id=871391ec080746185a2dd437c54d75fcd1ef0ef8 .
