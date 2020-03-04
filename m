Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B301C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49720214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:19:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgCDHTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:19:54 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33076 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgCDHTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:19:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TrcXp76_1583306386;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrcXp76_1583306386)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 Mar 2020 15:19:46 +0800
Subject: Re: [PATCH v9 02/20] mm/memcg: fold lock_page_lru into commit_charge
To:     Hillf Danton <hdanton@sina.com>
Cc:     cgroups@vger.kernel.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1583146830-169516-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200304031335.9784-1-hdanton@sina.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <4131e7d9-acad-4372-73b1-6fa1b0b251ef@linux.alibaba.com>
Date:   Wed, 4 Mar 2020 15:19:46 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304031335.9784-1-hdanton@sina.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/3/4 ÉÏÎç11:13, Hillf Danton Ð´µÀ:
>>  	 * Nobody should be changing or seriously looking at
>>  	 * page->mem_cgroup at this point:
>> @@ -2633,8 +2611,13 @@ static void commit_charge(struct page *page, struct mem_cgroup *memcg,
>>  	 */
>>  	page->mem_cgroup = memcg;
>>  
> Well it is likely to update memcg for page without lru_lock held even if
> more care is required, which is a change added in the current semantic and
> worth a line of words in log.
> 

the lru_lock is guard for lru list, not for page->mem_cgroup, seem no need to highlight this point. Do we?

Thanks
Alex
