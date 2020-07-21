Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C865FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D12820734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgGUDHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:07:54 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:33774 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgGUDHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:07:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R481e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0U3Ml0pk_1595300870;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U3Ml0pk_1595300870)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jul 2020 11:07:50 +0800
Subject: Re: [PATCH] mm/vmstat: don't do count if no needs
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200720052348.428564-1-alex.shi@linux.alibaba.com>
 <1ef9baa0-9788-5917-2590-a8c3fc593b81@linux.alibaba.com>
 <20200720161404.bd0c24560114bf48d6acbaff@linux-foundation.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <757accf7-81bf-442c-f144-4cad52fea4a5@linux.alibaba.com>
Date:   Tue, 21 Jul 2020 11:07:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200720161404.bd0c24560114bf48d6acbaff@linux-foundation.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/7/21 ÉÏÎç7:14, Andrew Morton Ð´µÀ:
>> --- a/mm/vmstat.c
>> +++ b/mm/vmstat.c
>> @@ -321,6 +321,9 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>>  	long x;
>>  	long t;
>>  
>> +	if (unlikely(!delta))
>> +		return;
>> +
> Do we know that delta==0 is frequent enough to make the change a net
> benefit?

Uh,I check again. it seems no much place delta==0, forget this patch.

Thanks
Alex
