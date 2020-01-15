Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EEEC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA47B222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgAOJyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:54:31 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:9618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729504AbgAOJya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:54:30 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79DE1587D749E023B9B4;
        Wed, 15 Jan 2020 17:54:29 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.212) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 15 Jan
 2020 17:54:23 +0800
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: remove set but not used variable
 'cs_block'
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yuehaibing <yuehaibing@huawei.com>
CC:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20191224124359.15040-1-yuehaibing@huawei.com>
 <673efe18-d528-2e9b-6d44-a6a7a22086f3@huawei.com>
 <62ce1981-9061-f798-a65d-9599ceceb4b8@huawei.com>
 <20191226082419.ljbhystwkhp2d4gh@shindev.dhcp.fujisawa.hgst.com>
 <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0aea7754-2114-cc78-3453-bc608bacd45a@huawei.com>
Date:   Wed, 15 Jan 2020 17:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200115023328.bummaaa7pdnao5qk@shindev.dhcp.fujisawa.hgst.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/15 10:33, Shinichiro Kawasaki wrote:
> On Dec 26, 2019 / 17:24, Shin'ichiro Kawasaki wrote:
>> On Dec 26, 2019 / 14:05, Yuehaibing wrote:
>>> On 2019/12/26 11:44, Chao Yu wrote:
>>>> On 2019/12/24 20:43, YueHaibing wrote:
>>>>> fs/f2fs/segment.c: In function fix_curseg_write_pointer:
>>>>> fs/f2fs/segment.c:4485:35: warning: variable cs_block set but not used [-Wunused-but-set-variable]
>>>>>
>>>>> It is never used since commit 362d8a920384 ("f2fs: Check
>>>>> write pointer consistency of open zones") , so remove it.
>>>>
>>>> Thanks for the fix!
>>>>
>>>> Do you mind merging this patch to original patch? as it's still
>>>> pending in dev branch.
>>>
>>> It's ok for me.
>>>
>>
>> Thank you for this catch and the fix. Appreciated.
> 
> I have merged YueHaibing's change to the write pointer consistency fix patch
> and sent out as the v6 series. Thanks again for finding out the unused variable.
> 
> I was not sure if I should add Chao Yu's reviewed by tag to the patch from which
> the unused variable was removed. To be strict, I didn't add the tag. Just
> another quick review by Chao will be appreciated.

Thanks for the revision. :)

I guess Jaegeuk can merge that kind of fix into original patch, and
meanwhile keeping old Reviewed-by tag in that patch.

Thanks,

> 
> --
> Best Regards,
> Shin'ichiro Kawasaki.
> 
