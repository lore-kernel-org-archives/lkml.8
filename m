Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69232C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA24205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 12:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgCPMi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 08:38:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731027AbgCPMi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 08:38:57 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7A402E500B6ABF9507E3;
        Mon, 16 Mar 2020 20:38:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 20:38:38 +0800
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
To:     Marc Zyngier <maz@kernel.org>
CC:     KarimAllah Ahmed <karahmed@amazon.de>,
        <linux-kernel@vger.kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
 <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
 <a8b72d6c0a28e0554050e98d011f32d9@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <a9fd7e22-f46a-fd47-26ee-44d2d36783fd@huawei.com>
Date:   Mon, 16 Mar 2020 20:38:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <a8b72d6c0a28e0554050e98d011f32d9@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/3/16 19:09, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-03-16 10:49, Zenghui Yu wrote:
>> Hi,
>>
>> On 2020/3/16 17:39, KarimAllah Ahmed wrote:
>>> Use the physical timer object when reading the physical timer counter
>>> instead of using the virtual timer object. This is only visible when
>>> reading it from user-space as kvm_arm_timer_get_reg() is only 
>>> executed on
>>> the get register patch from user-space.
>>
>> s/patch/path/
>>
>> I think the physical counter hasn't yet been accessed by the current
>> userspace, wrong?
> 
> I don't think userspace can access it, as the ONE_REG API only exposes 
> the virtual
> timer so far, and userspace is much better off just reading the counter 
> directly
> (it has access to the virtual counter, and the guarantee that cntvoff is 
> 0 in this
> context).

Yeah, I see. The physical timer registers are all ignored in
walk_one_sys_reg() and won't be exposed.

> 
> But as we move towards a situation where we can save/restore the 
> physical timer
> just like the virtual one, we're going to use this path and hit this bug.

Thanks for the explanation.


Zenghui

