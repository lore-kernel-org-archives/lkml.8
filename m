Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFA3C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1462320719
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFGjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:39:35 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbgDFGjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:39:35 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D4FC3696FF8E108486F8;
        Mon,  6 Apr 2020 14:39:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.203.15) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 14:39:28 +0800
Subject: Re: [PATCH] bcache: remove set but not used variable 'i'
To:     Coly Li <colyli@suse.de>, <kent.overstreet@gmail.com>
CC:     <linux-bcache@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1586259407-23673-1-git-send-email-wanghai38@huawei.com>
 <dee5c875-4b4e-c425-ec8d-35e7599c4f5f@suse.de>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <d26a90e8-075e-52b4-e633-d68f231c14b4@huawei.com>
Date:   Mon, 6 Apr 2020 14:39:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <dee5c875-4b4e-c425-ec8d-35e7599c4f5f@suse.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.133.203.15]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/4/6 12:43, Coly Li 写道:
> On 2020/4/7 7:36 下午, Wang Hai wrote:
>> Fixes gcc '-Wunused-but-set-variable' warning:
>>
>> drivers/md/bcache/btree.c: In function bch_btree_check_thread:
>> drivers/md/bcache/btree.c:1910:6: warning:
>>   variable ‘i’ set but not used [-Wunused-but-set-variable]
>>
>> It's not used since commit 8e7102273f59 ("bcache: make bch_btree_check()
>> to be multithreaded"), so remove it.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Hi Hai,
>
> Colin King already submitted a similar patch on Apr 2 to fix it.
>
> Thanks.
>
> Coly Li

Thanks for reminding, please ignore this patch.


