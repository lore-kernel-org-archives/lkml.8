Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B824CC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9783A2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 04:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgD3EbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 00:31:14 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbgD3EbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:31:13 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5FFAD95BDE18E57DB1F3;
        Thu, 30 Apr 2020 12:31:10 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 30 Apr 2020
 12:31:01 +0800
Subject: Re: [PATCH V2] fs/ceph:fix double unlock in handle_cap_export()
To:     "Yan, Zheng" <ukernel@gmail.com>
CC:     Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>,
        "Ilya Dryomov" <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <1588079622-423774-1-git-send-email-wubo40@huawei.com>
 <e89bd817c69422c85f1945041dd83fbe8d534805.camel@kernel.org>
 <6c99072a-f92b-b7e8-9aef-509d1a9ee985@huawei.com>
 <CAAM7YA=OU2jJ9F_p1fAknaxZCDWMY7w9yiRE0z0uqxDNYPG5Mg@mail.gmail.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <3fb139b0-062a-9f17-1855-66dacf5d6825@huawei.com>
Date:   Thu, 30 Apr 2020 12:31:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAAM7YA=OU2jJ9F_p1fAknaxZCDWMY7w9yiRE0z0uqxDNYPG5Mg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/30 10:50, Yan, Zheng wrote:
> On Wed, Apr 29, 2020 at 8:49 AM Wu Bo <wubo40@huawei.com> wrote:
>>
>> On 2020/4/28 22:48, Jeff Layton wrote:
>>> On Tue, 2020-04-28 at 21:13 +0800, Wu Bo wrote:
>>>> if the ceph_mdsc_open_export_target_session() return fails,
>>>> should add a lock to avoid twice unlocking.
>>>> Because the lock will be released at the retry or out_unlock tag.
>>>>
>>>
>>> The problem looks real, but...
>>>
>>>> --
>>>> v1 -> v2:
>>>> add spin_lock(&ci->i_ceph_lock) before goto out_unlock tag.
>>>>
>>>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>>>> ---
>>>>    fs/ceph/caps.c | 27 +++++++++++++++------------
>>>>    1 file changed, 15 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
>>>> index 185db76..414c0e2 100644
>>>> --- a/fs/ceph/caps.c
>>>> +++ b/fs/ceph/caps.c
>>>> @@ -3731,22 +3731,25 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>>>>
>>>>       /* open target session */
>>>>       tsession = ceph_mdsc_open_export_target_session(mdsc, target);
>>>> -    if (!IS_ERR(tsession)) {
>>>> -            if (mds > target) {
>>>> -                    mutex_lock(&session->s_mutex);
>>>> -                    mutex_lock_nested(&tsession->s_mutex,
>>>> -                                      SINGLE_DEPTH_NESTING);
>>>> -            } else {
>>>> -                    mutex_lock(&tsession->s_mutex);
>>>> -                    mutex_lock_nested(&session->s_mutex,
>>>> -                                      SINGLE_DEPTH_NESTING);
>>>> -            }
>>>> -            new_cap = ceph_get_cap(mdsc, NULL);
>>>> -    } else {
>>>> +    if (IS_ERR(tsession)) {
>>>>               WARN_ON(1);
>>>>               tsession = NULL;
>>>>               target = -1;
>>>> +            mutex_lock(&session->s_mutex);
>>>> +            spin_lock(&ci->i_ceph_lock);
>>>> +            goto out_unlock;
>>>
>>> Why did you make this case goto out_unlock instead of retrying as it did
>>> before?
>>>
>>
>> If the problem occurs, target = -1, and goto retry lable, you need to
>> call __get_cap_for_mds() or even call __ceph_remove_cap(), and then jump
>> to out_unlock lable. All I think is unnecessary, goto out_unlock instead
>> of retrying directly.
>>
> 
> __ceph_remove_cap() must be called even if opening target session
> failed. I think adding a mutex_lock(&session->s_mutex) to the
> IS_ERR(tsession) block should be enough.
> 

Yes，I will send the V3 patch later.

> 
>> Thanks.
>> Wu Bo
>>
>>>> +    }
>>>> +
>>>> +    if (mds > target) {
>>>> +            mutex_lock(&session->s_mutex);
>>>> +            mutex_lock_nested(&tsession->s_mutex,
>>>> +                                    SINGLE_DEPTH_NESTING);
>>>> +    } else {
>>>> +            mutex_lock(&tsession->s_mutex);
>>>> +            mutex_lock_nested(&session->s_mutex,
>>>> +                                    SINGLE_DEPTH_NESTING);
>>>>       }
>>>> +    new_cap = ceph_get_cap(mdsc, NULL);
>>>>       goto retry;
>>>>
>>>>    out_unlock:
>>>
>>
>>
> 
> .
> 


