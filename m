Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1473F206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 07:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbgIDHLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 03:11:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37460 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726811AbgIDHLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 03:11:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F775E2F219C921F5B33;
        Fri,  4 Sep 2020 15:11:28 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 4 Sep 2020
 15:11:27 +0800
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: change virtual mapping way for
 compression pages
From:   Chao Yu <yuchao0@huawei.com>
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200812051711.2147716-1-daeho43@gmail.com>
 <b201452d-b1dd-146c-3a1a-c199d9a5974c@huawei.com>
Message-ID: <f7de60a9-c1bc-1c45-1d1e-e6c79406a387@huawei.com>
Date:   Fri, 4 Sep 2020 15:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b201452d-b1dd-146c-3a1a-c199d9a5974c@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daeho,

Could you please clean up a bit on this patch, we can wrap vm_map_ram
loop logic into f2fs_vmap() as below:

f2fs_vmap()
{
	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
		cc->cbuf = vm_map_ram(cc->cpages, cc->nr_cpages, -1);
		if (cc->cbuf)
			break;
		vm_unmap_aliases();
	}
}

How do you think of this?

Thanks,

On 2020/8/13 17:09, Chao Yu wrote:
> On 2020/8/12 13:17, Daeho Jeong wrote:
>> From: Daeho Jeong <daehojeong@google.com>
>>
>> By profiling f2fs compression works, I've found vmap() callings have
>> unexpected hikes in the execution time in our test environment and
>> those are bottlenecks of f2fs decompression path. Changing these with
>> vm_map_ram(), we can enhance f2fs decompression speed pretty much.
>>
>> [Verification]
>> Android Pixel 3(ARM64, 6GB RAM, 128GB UFS)
>> Turned on only 0-3 little cores(at 1.785GHz)
>>
>> dd if=/dev/zero of=dummy bs=1m count=1000
>> echo 3 > /proc/sys/vm/drop_caches
>> dd if=dummy of=/dev/zero bs=512k
>>
>> - w/o compression -
>> 1048576000 bytes (0.9 G) copied, 2.082554 s, 480 M/s
>> 1048576000 bytes (0.9 G) copied, 2.081634 s, 480 M/s
>> 1048576000 bytes (0.9 G) copied, 2.090861 s, 478 M/s
>>
>> - before patch -
>> 1048576000 bytes (0.9 G) copied, 7.407527 s, 135 M/s
>> 1048576000 bytes (0.9 G) copied, 7.283734 s, 137 M/s
>> 1048576000 bytes (0.9 G) copied, 7.291508 s, 137 M/s
>>
>> - after patch -
>> 1048576000 bytes (0.9 G) copied, 1.998959 s, 500 M/s
>> 1048576000 bytes (0.9 G) copied, 1.987554 s, 503 M/s
>> 1048576000 bytes (0.9 G) copied, 1.986380 s, 503 M/s
>>
>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
