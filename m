Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65BB9206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGJTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:19:37 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33745 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbgGGJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:19:37 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2.VupE_1594113573;
Received: from DustLi-Macbook.local(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0U2.VupE_1594113573)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 07 Jul 2020 17:19:34 +0800
Subject: Re: [PATCH] docs: fix incorrent references to DMA APIs
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200628143017.17399-1-dust.li@linux.alibaba.com>
 <20200705143212.446c50f3@lwn.net>
From:   "dust.li" <dust.li@linux.alibaba.com>
Message-ID: <e6a5b7ce-a974-78ec-874e-d5dca167cf2a@linux.alibaba.com>
Date:   Tue, 7 Jul 2020 17:19:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200705143212.446c50f3@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/6/20 4:32 AM, Jonathan Corbet wrote:
> On Sun, 28 Jun 2020 22:30:17 +0800
> Dust Li <dust.li@linux.alibaba.com> wrote:
>
>> dma-api
>> dma-api-howto
>> dma-attributes
>> dma-isa-lpc
>>
>> The above 4 documents have been renamed and moved to
>> Documentation/core-api/, but there are still some old references
>> refer to the old files, this patch tries to correct them.
>>
>> Fixes: 728c1471b544 ("docs: move DMA kAPI to Documentation/core-api")
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> Thanks, but these have already been addressed in the docs tree.
>
> jon


Got it. Thanks for reply, sorry I didn't notice that.

