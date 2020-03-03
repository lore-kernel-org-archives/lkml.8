Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A990C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DF3B22B48
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgCCELw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:11:52 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45622 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726956AbgCCELw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:11:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04452;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0TrWPslU_1583208694;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrWPslU_1583208694)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Mar 2020 12:11:35 +0800
Subject: Re: [PATCH v9 07/20] mm/lru: introduce TestClearPageLRU
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, mgorman@techsingularity.net,
        tj@kernel.org, hughd@google.com, khlebnikov@yandex-team.ru,
        daniel.m.jordan@oracle.com, yang.shi@linux.alibaba.com,
        willy@infradead.org, hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <1583146830-169516-8-git-send-email-alex.shi@linux.alibaba.com>
 <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <9cacdc21-9c1f-2a17-05cb-e9cf2959cef5@linux.alibaba.com>
Date:   Tue, 3 Mar 2020 12:11:34 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302141144.b30abe0d89306fd387e13a92@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/3/3 ÉÏÎç6:11, Andrew Morton Ð´µÀ:
>> -		if (PageLRU(page)) {
>> +		if (TestClearPageLRU(page)) {
>>  			lruvec = mem_cgroup_page_lruvec(page, pgdat);
>> -			ClearPageLRU(page);
>>  			del_page_from_lru_list(page, lruvec, page_lru(page));
>>  		} else
> 
> The code will now get exclusive access of the page->flags cacheline and
> will dirty that cacheline, even for !PageLRU() pages.  What is the
> performance impact of this?
> 

Hi Andrew,

Thanks a lot for comments!

I was tested the whole patchset with fengguang's case-lru-file-readtwice
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/
which is most sensitive case on PageLRU I found. There are no clear performance
drop.

On this single patch, I just test the same case again, there is still no perf
drop. some data is here on my 96 threads machine:

		no lock_dep	w lock_dep and few other debug option
w this patch, 	50.96MB/s		32.93MB/s
w/o this patch, 50.50MB/s		33.53MB/s


And also no any warning from Intel 0day yet.

Thanks a lot!
Alex
