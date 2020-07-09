Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA76C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8404C20772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 02:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgGICEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 22:04:41 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgGICEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 22:04:40 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6E24292A9D235B4B7F6B;
        Thu,  9 Jul 2020 10:04:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.218) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Jul 2020
 10:04:30 +0800
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     <ericvh@gmail.com>, <lucho@ionkov.net>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
 <20200615102053.GA11026@nautica>
From:   "Zhengbin (OSKernel)" <zhengbin13@huawei.com>
Message-ID: <ae01f0bd-da0a-f01f-cbd0-3af10ccaa4ae@huawei.com>
Date:   Thu, 9 Jul 2020 10:04:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200615102053.GA11026@nautica>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is this OK? I don't see it on linux-next

On 2020/6/15 18:20, Dominique Martinet wrote:
> Zheng Bin wrote on Mon, Jun 15, 2020:
>> v9fs_mount
>>    v9fs_session_init
>>      v9fs_cache_session_get_cookie
>>        v9fs_random_cachetag                     -->alloc cachetag
>>        v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
>>    sb = sget                                    -->fail, goto clunk
>> clunk_fid:
>>    v9fs_session_close
>>      if (v9ses->fscache)                        -->NULL
>>        kfree(v9ses->cachetag)
>>
>> Thus memleak happens.
>>
>> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
> Thanks, will run tests & queue next weekend
>

