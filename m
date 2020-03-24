Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD76C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D602051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCXJrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:47:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51826 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgCXJrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:47:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 534E12E87DCB9A5B1249;
        Tue, 24 Mar 2020 17:47:10 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 17:47:04 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix long latency due to discard during
 umount
From:   Chao Yu <yuchao0@huawei.com>
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1584506689-5041-1-git-send-email-stummala@codeaurora.org>
 <54ae330b-ac9b-7968-fa0a-95db6737e3ea@huawei.com>
Message-ID: <7804a289-ee55-930c-8b6a-52697d3db679@huawei.com>
Date:   Tue, 24 Mar 2020 17:47:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <54ae330b-ac9b-7968-fa0a-95db6737e3ea@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/24 17:08, Chao Yu wrote:
> On 2020/3/18 12:44, Sahitya Tummala wrote:
>> F2FS already has a default timeout of 5 secs for discards that
>> can be issued during umount, but it can take more than the 5 sec
>> timeout if the underlying UFS device queue is already full and there
>> are no more available free tags to be used. In that case, submit_bio()
>> will wait for the already queued discard requests to complete to get
>> a free tag, which can potentially take way more than 5 sec.
>>
>> Fix this by submitting the discard requests with REQ_NOWAIT
>> flags during umount. This will return -EAGAIN for UFS queue/tag full
>> scenario without waiting in the context of submit_bio(). The FS can
>> then handle these requests by retrying again within the stipulated
>> discard timeout period to avoid long latencies.

BTW, I guess later we can add nowait logic as a sub policy of
discard_policy, then DPOLICY_BG would be more configurable with
this nowait policy support.

Thanks,

>>
>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
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
