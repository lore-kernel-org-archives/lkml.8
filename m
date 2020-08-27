Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49323C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F1E22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgH0I1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:27:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49986 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgH0I1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:27:46 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A50017913B2FB90F1E44;
        Thu, 27 Aug 2020 16:27:44 +0800 (CST)
Received: from [127.0.0.1] (10.67.76.251) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 27 Aug 2020
 16:27:35 +0800
Subject: Re: [PATCH RESEND] fs: Move @f_count to different cacheline with
 @f_mode
To:     Aleksa Sarai <cyphar@cyphar.com>
CC:     Will Deacon <will@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
References: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200821160252.GC21517@willie-the-truck>
 <a75e514c-7e2d-54ed-45d4-327b2a514e67@hisilicon.com>
 <20200826082401.c6j5fwrbhl7vgmhj@yavin.dot.cyphar.com>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <803a5202-6240-b062-b1d9-2aed0e11ebad@hisilicon.com>
Date:   Thu, 27 Aug 2020 16:27:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200826082401.c6j5fwrbhl7vgmhj@yavin.dot.cyphar.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.76.251]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

在 2020/8/26 16:24, Aleksa Sarai 写道:
> On 2020-08-26, Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
>> 在 2020/8/22 0:02, Will Deacon 写道:
>>>   - This thing is tagged with __randomize_layout, so it doesn't help anybody
>>>     using that crazy plugin
>>
>> This patch isolated the @f_count with @f_mode absolutely and we don't care the
>> base address of the structure, or I may miss something what you said.
> 
> __randomize_layout randomises the order of fields in a structure on each
> kernel rebuild (to make attacks against sensitive kernel structures
> theoretically harder because the offset of a field is per-build). It is

My bad, I missed Will's comments for my poor understanding on it.

> separate to ASLR or other base-related randomisation. However it depends
> on having CONFIG_GCC_PLUGIN_RANDSTRUCT=y and I believe (at least for
> distribution kernels) this isn't a widely-used configuration.

Thanks for more explanations about it, in our test, this config is also
disabled. If having CONFIG_GCC_PLUGIN_RANDSTRUCT=y, it seems this patch
will lose its value.
If it isn't widely-used for this config, hopefully we can do something on
the scene.

Thanks,
Shaokun

> 

