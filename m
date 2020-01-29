Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EEDC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF7E32071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 12:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgA2MNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 07:13:47 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57699 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgA2MNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 07:13:45 -0500
Received: from fsav103.sakura.ne.jp (fsav103.sakura.ne.jp [27.133.134.230])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 00TCDiuQ097067;
        Wed, 29 Jan 2020 21:13:44 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav103.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp);
 Wed, 29 Jan 2020 21:13:44 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav103.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040062084.bbtec.net [126.40.62.84])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 00TCDdNl097023
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 29 Jan 2020 21:13:43 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [PATCH] mm/page_counter: fix various data races
To:     Qian Cai <cai@lca.pw>, Dmitry Vyukov <dvyukov@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200129105224.4016-1-cai@lca.pw>
 <20200129120302.GJ24244@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <59f892d0-5fc4-ae32-ce65-5a688d9180c8@I-love.SAKURA.ne.jp>
Date:   Wed, 29 Jan 2020 21:13:37 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200129120302.GJ24244@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/01/29 21:03, Michal Hocko wrote:
>> Fixes: 3e32cb2e0a12 ("mm: memcontrol: lockless page counters")
>> Signed-off-by: Qian Cai <cai@lca.pw>
> 
> Acked-by: Michal Hocko <mhocko@suse.com>

Please include

Reported-by: syzbot+f36cfe60b1006a94f9dc@syzkaller.appspotmail.com

for https://syzkaller.appspot.com/bug?id=744097b8b91cecd8b035a6f746bb12e4efc7669f .

By the way, can READ_ONCE()/WRITE_ONCE() really solve this warning?
The link above says read/write on the same location ( mm/page_counter.c:129 ).
I don't know how READ_ONCE()/WRITE_ONCE() can solve the race.

> 
>> ---
>>  mm/page_counter.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/page_counter.c b/mm/page_counter.c
>> index de31470655f6..a17841150906 100644
>> --- a/mm/page_counter.c
>> +++ b/mm/page_counter.c
>> @@ -82,8 +82,8 @@ void page_counter_charge(struct page_counter *counter, unsigned long nr_pages)
>>  		 * This is indeed racy, but we can live with some
>>  		 * inaccuracy in the watermark.
>>  		 */
>> -		if (new > c->watermark)
>> -			c->watermark = new;
>> +		if (new > READ_ONCE(c->watermark))
>> +			WRITE_ONCE(c->watermark, new);
>>  	}
>>  }
>>  
>> @@ -135,8 +135,8 @@ bool page_counter_try_charge(struct page_counter *counter,
>>  		 * Just like with failcnt, we can live with some
>>  		 * inaccuracy in the watermark.
>>  		 */
>> -		if (new > c->watermark)
>> -			c->watermark = new;
>> +		if (new > READ_ONCE(c->watermark))
>> +			WRITE_ONCE(c->watermark, new);
>>  	}
>>  	return true;
>>  
>> -- 
>> 2.21.0 (Apple Git-122.2)
> 

