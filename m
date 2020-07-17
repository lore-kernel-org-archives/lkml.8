Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204472071A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 08:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgGQIAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 04:00:45 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:45354 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbgGQIAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 04:00:44 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A1E10D976030469F0894;
        Fri, 17 Jul 2020 16:00:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Fri, 17 Jul 2020
 16:00:36 +0800
Subject: Re: [PATCH -next] drm/komeda: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Daniel Vetter <daniel@ffwll.ch>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
CC:     Mihail Atanassov <mihail.atanassov@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
References: <20200716090333.13334-1-miaoqinglang@huawei.com>
 <20200717064017.GA76612@jamwan02-TSP300>
 <CAKMK7uEpmhKok9Q3Rrg0v=1p7pv-wpV0Y3-k9GVav+Ad5Z4AkQ@mail.gmail.com>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <7264de7e-6da4-288d-855d-410b2e05458b@huawei.com>
Date:   Fri, 17 Jul 2020 16:00:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAKMK7uEpmhKok9Q3Rrg0v=1p7pv-wpV0Y3-k9GVav+Ad5Z4AkQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/7/17 15:06, Daniel Vetter 写道:
> On Fri, Jul 17, 2020 at 8:40 AM james qian wang (Arm Technology China)
> <james.qian.wang@arm.com> wrote:
>>
>> On Thu, Jul 16, 2020 at 05:03:33PM +0800, Qinglang Miao wrote:
>>> From: Liu Shixin <liushixin2@huawei.com>
>>>
>>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>>
>>> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
>>> ---
>>>   drivers/gpu/drm/arm/display/komeda/komeda_dev.c | 13 +------------
>>>   1 file changed, 1 insertion(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>> index 0246b2e94..4a10e6b9e 100644
>>> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
>>> @@ -41,18 +41,7 @@ static int komeda_register_show(struct seq_file *sf, void *x)
>>>        return 0;
>>>   }
>>>
>>> -static int komeda_register_open(struct inode *inode, struct file *filp)
>>> -{
>>> -     return single_open(filp, komeda_register_show, inode->i_private);
>>> -}
>>> -
>>> -static const struct file_operations komeda_register_fops = {
>>> -     .owner          = THIS_MODULE,
>>> -     .open           = komeda_register_open,
>>> -     .read_iter              = seq_read_iter,
>>> -     .llseek         = seq_lseek,
>>> -     .release        = single_release,
>>> -};
>>> +DEFINE_SHOW_ATTRIBUTE(komeda_register);
>>>
>>
>> Hi Shixin & Qinglang
>>
>> Thanks for your patch.
>>
>> Reviewed-by: James Qian Wang <james.qian.wang@arm.com>
>>
>> Since your patch is not for drm-misc-next, so seems better
>> to leave it to you to merge it. :)
> 
> I do think it's for drm-misc-next, what other tree would it be for?
> Some people put -next in their patch tag to differentiate from -fixes,
> so maintainers know what to do with the patch. It's also not part of a
> series, hence I think this is on you to apply it.
 >
Hi James & Daniel,

​Sorry I didn't make it clear in commit log, but it do based on linux-next.

​I think the reason why James think it's not for drm-misc-next
is conflicts exists when this patch being applied. There's conflicts 
because commit <4d4901c6d7> which switched over direct seq_read method 
calls to seq_read_iter should applied before this clean-up patch(linkage 
listed as below).

https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/4d4901c6d748efab8aab6e7d2405dadaed0bea50

I can send a new patch based on mainline if needed.

​Thanks.

Qinglang

.
	
 >
> Cheers, Daniel
> 
>>
>> Thanks
>> James
>>
>>>   #ifdef CONFIG_DEBUG_FS
>>>   static void komeda_debugfs_init(struct komeda_dev *mdev)
>>> --
>>> 2.17.1
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 

