Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546E8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E0D20936
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 03:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDID0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 23:26:21 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726545AbgDID0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 23:26:21 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 270F7C24F7BE0E0A0033;
        Thu,  9 Apr 2020 11:26:18 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.183) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 11:26:09 +0800
Subject: Re: [PATCH] signal: check sig before setting info in
 kill_pid_usb_asyncio
To:     Christian Brauner <christian.brauner@ubuntu.com>
CC:     <ebiederm@xmission.com>, <oleg@redhat.com>, <tj@kernel.org>,
        <guro@fb.com>, <joel@joelfernandes.org>, <jannh@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mingfangsen <mingfangsen@huawei.com>,
        Yanxiaodan <yanxiaodan@huawei.com>,
        linfeilong <linfeilong@huawei.com>
References: <f525fd08-1cf7-fb09-d20c-4359145eb940@huawei.com>
 <20200330084415.p4v5g6s24innsjrc@wittgenstein>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <2d00096f-94f7-753e-c05f-14860fed2abe@huawei.com>
Date:   Thu, 9 Apr 2020 11:26:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200330084415.p4v5g6s24innsjrc@wittgenstein>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.183]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping...

On 2020/3/30 16:44, Christian Brauner wrote:
> On Mon, Mar 30, 2020 at 10:18:33AM +0800, Zhiqiang Liu wrote:
>>
>> In kill_pid_usb_asyncio, if signal is not valid, we do not need to
>> set info struct.
>>
>> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> I'd have done:
> 
> if (!valid_signal(sig))
> 	return -EINVAL;
> 
> instead of setting ret to EINVAL above but that's mostly a matter of style.
> 
> Picking this up unless someone sees a problem with it.
> 
> Thank you!
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> 
> .
> 

