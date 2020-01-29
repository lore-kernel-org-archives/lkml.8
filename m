Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E8FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5830820716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA2Nrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:47:53 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:60830 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgA2Nrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:47:53 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00TDlpWv007890;
        Wed, 29 Jan 2020 22:47:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp);
 Wed, 29 Jan 2020 22:47:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav110.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00TDlp73007874
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 29 Jan 2020 22:47:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] mm/page_counter: fix various data races
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Dmitry Vyukov <dvyukov@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200129105224.4016-1-cai@lca.pw>
 <20200129120302.GJ24244@dhcp22.suse.cz>
 <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
 <CANpmjNOdFsU9gg7FSv7Pue0L2eAQ+5UHHaz9bgZ83r94prA4vQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <9575c1cc-1669-9492-d657-ad4ba6494e88@i-love.sakura.ne.jp>
Date:   Wed, 29 Jan 2020 22:47:45 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CANpmjNOdFsU9gg7FSv7Pue0L2eAQ+5UHHaz9bgZ83r94prA4vQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/29 21:21, Marco Elver wrote:
>> By the way, can READ_ONCE()/WRITE_ONCE() really solve this warning?
>> The link above says read/write on the same location ( mm/page_counter.c:129 ).
>> I don't know how READ_ONCE()/WRITE_ONCE() can solve the race.
> 
> It avoids the *data* race, with *_ONCE telling the compiler to not
> optimize the accesses in concurrency-unfriendly ways.  Since *_ONCE is
> used, it conveys clear intent that the code here is meant to be
> concurrent, and KCSAN stops complaining (and assumes that the *logic*
> is correct).

I see. Unlike c->failcnt++ which involves read-modify-write, *_ONCE() can be used for
simple read (like c->watermark) or simple write (like c->watermark = new) case.
