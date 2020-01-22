Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B40C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1F8721835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAVDq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:46:29 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51782 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728900AbgAVDq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:46:29 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6BF011888F5AB7914759;
        Wed, 22 Jan 2020 11:46:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.31) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 11:46:18 +0800
Subject: Re: [PATCH] arm64: mm: support setting page attributes for debug
 situation
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <ard.biesheuvel@arm.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <linfeilong@huawei.com>
References: <5a3ab728-b895-0930-9540-5e9c586e8858@huawei.com>
 <20200116110914.GA16345@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <cc61e0d5-b1cb-51b4-8d33-5a339fe59f1b@huawei.com>
Date:   Wed, 22 Jan 2020 11:46:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200116110914.GA16345@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/16 19:09, Will Deacon wrote:
> On Fri, Jan 10, 2020 at 03:47:41PM +0800, yeyunfeng wrote:
>> When rodata_full is set or pagealloc debug is enabled, block mappings or
>> contiguou hints are no longer used for linear address area. Therefore,
>> support setting page attributes in this case is useful for debugging
>> memory corruption problems.
>>
>> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>> ---
>>  arch/arm64/mm/pageattr.c | 18 ++++++++++++++----
>>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> Although I can kind of see what you're getting at, I'm not keen on merging
> this without a user. If you're just referring to random debug hacks, then I
> think this change could be part of those too.
> 
Ok, thanks, I think when pagealloc debug is enabled, it is better not limited
to the vmap area only. and when kernel memory corruption problems happen, it's
useful to call set_memory_ro() function to debug these problem.

> Will
> 
> .
> 

