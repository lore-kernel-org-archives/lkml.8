Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E86CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1FD02067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHQLD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:03:56 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:53464 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727062AbgHQLDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:03:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U60T4QO_1597662228;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U60T4QO_1597662228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Aug 2020 19:03:49 +0800
Subject: Re: [PATCH 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200817095821.GA29756@L-31X9LVDL-1304.local>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <301b82e3-4ee1-8b90-a6a6-256fd8885e59@linux.alibaba.com>
Date:   Mon, 17 Aug 2020 19:02:51 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200817095821.GA29756@L-31X9LVDL-1304.local>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/8/17 ÏÂÎç5:58, Wei Yang Ð´µÀ:
> On Sun, Aug 16, 2020 at 11:47:56AM +0800, Alex Shi wrote:
>> pageblock_flags is used as long, since every pageblock_flags is just 4
>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>> flags. It would cause long waiting for sync.
>>
>> If we could change the pageblock_flags variable as char, we could use
>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>> relief much false sharing in cmpxchg.
>>
> 
> If my understanding is correct, CPU reads data in the size of cacheline.
> Define a variable a char or other, doesn't help on false sharing. 
> 
> Correct me, if not.

Right and not,

Cacheline false sharing is right. but after that, cmpxchg still need to compare
the pointed data, if the data is long, it need to compare long word and make sure
nothing changes in the long word. If we narrow the comparsion data to byte, cmpxchg
will just sync up on a byte. So it looks like there are 2 level false sharing here.

Thanks
Alex

        for (;;) {
-               old_word = cmpxchg(&bitmap[word_bitidx], word, (word & ~mask) | flags);
-               if (word == old_word)
+               old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
+               if (byte == old_byte)
                        break;
-               word = old_word;
+               byte = old_byte;
        }
