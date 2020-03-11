Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422AFC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FF732146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgCKKvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:51:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11627 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgCKKva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:51:30 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B3A2A3473D4233BDE244;
        Wed, 11 Mar 2020 18:51:24 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 11 Mar
 2020 18:51:24 +0800
Subject: Re: [f2fs-dev] Writes stoped working on f2fs after the compression
 support was added
To:     =?UTF-8?Q?Ond=c5=99ej_Jirman?= <megi@xff.cz>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200224143149.au6hvmmfw4ajsq2g@core.my.home>
 <39712bf4-210b-d7b6-cbb1-eb57585d991a@huawei.com>
 <20200225120814.gjm4dby24cs22lux@core.my.home>
 <20200225122706.d6pngz62iwyowhym@core.my.home>
 <72d28eba-53b9-b6f4-01a5-45b2352f4285@huawei.com>
 <20200226121143.uag224cqzqossvlv@core.my.home>
 <20200226180557.le2fr66fyuvrqker@core.my.home>
 <7b62f506-f737-9fb2-6e8e-4b1c454f03b2@huawei.com>
 <20200306120203.2p34ezryzxb2jeuk@core.my.home>
 <0ce08d13-ca00-2823-94eb-8274c332a8ef@huawei.com>
 <20200311103309.m52hdut7mt7crt7g@core.my.home>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c3d53657-7c2a-9d2f-9111-048db6e30a7e@huawei.com>
Date:   Wed, 11 Mar 2020 18:51:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200311103309.m52hdut7mt7crt7g@core.my.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/3/11 18:33, Ondřej Jirman wrote:
> Hello,
> 
> On Wed, Mar 11, 2020 at 05:02:10PM +0800, Chao Yu wrote:
>> Hi,
>>
>> Sorry for the delay.
>>
>> On 2020/3/6 20:02, Ondřej Jirman wrote:
>>> Hello,
>>>
>>> On Thu, Feb 27, 2020 at 10:01:50AM +0800, Chao Yu wrote:
>>>> On 2020/2/27 2:05, Ondřej Jirman wrote:
>>>>>
>>>>> No issue after 7h uptime either. So I guess this patch solved it for some
>>>>> reason.
>>>>
>>>> I hope so as well, I will send a formal patch for this.
>>>
>>> So I had it happen again, even with the patches. This time in f2fs_rename2:
>>
>> Oops, it looks previous fix patch just cover the root cause... :(
>>
>> Did this issue still happen frequently? If it is, would you please apply patch
>> that prints log during down/up semaphore.
> 
> Not frequently. Just once. I couldn't afford FS corruption during update,

Alright.

> so I reverted the compression support shortly after.

What I can see is that filesystem was just stuck, rather than image became
corrupted, I guess the condition is not such bad, anyway, it's okay to just
revert compression support for now to keep fs stable.

> 
> But I wasn't stressing the system much with FS activity after applying the
> initial fix.
> 
>> And once we revert compression support patch, this issue will disappear, right?
> 
> Yes, AFAIK. I reverted it and run a few cycles of install 500MiB worth of
> packages, uninstall the packages with pacman. And it didn't re-occur. I never
> saw any issues with compression support patch reverted.

Okay, compression support may increase stack usage during page writeback, it
shouldn't overflow the stack, otherwise it could cause panic in somewhere else,
but still can find any clue why this is related to compression support patch...

> 
>> Btw, did you try other hardware which is not Arm v7?
> 
> Yes, but I didn't ever see it on anything else. Just on two 8 core cortexes A7.
> (2 clusters)

Not sure, maybe this issue is related to arm v7 architecture.

Thanks,

> 
> regards,
> 	o.
> .
> 
