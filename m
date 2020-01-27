Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB260C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951CF2467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 19:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0T5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:57:25 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:54063 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgA0T5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 14:57:25 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TocxhF-_1580155041;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TocxhF-_1580155041)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Jan 2020 03:57:22 +0800
Subject: Re: [PATCH] mm: mempolicy: use VM_BUG_ON_VMA in
 queue_pages_test_walk()
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1579068565-110432-1-git-send-email-yang.shi@linux.alibaba.com>
 <1221B3C6-6A3B-4427-92DD-25AD54FF6BB5@lca.pw>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <d6c1a434-8670-97f4-345c-28c8007a25ce@linux.alibaba.com>
Date:   Mon, 27 Jan 2020 11:57:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1221B3C6-6A3B-4427-92DD-25AD54FF6BB5@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/20 10:17 AM, Qian Cai wrote:
>
>> On Jan 15, 2020, at 1:09 AM, Yang Shi <yang.shi@linux.alibaba.com> wrote:
>>
>> The VM_BUG_ON() is already used by queue_pages_test_walk(), it sounds
>> better to dump more debug information by using VM_BUG_ON_VMA() to help
>> debugging.
> What’s the problem this is trying to resolve? Was there an existing bug would trigger this?

Dumping more information to help debugging. I don't run into related bug 
personally.

