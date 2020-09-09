Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ECF421919
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIIHNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:13:50 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11275 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbgIIHNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:13:50 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5E817F02400258A90C6E;
        Wed,  9 Sep 2020 15:13:46 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 9 Sep 2020
 15:13:45 +0800
Subject: Re: [f2fs-dev] Question about STEP_DECOMPRESS_NOWQ
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <220b1cb4-9c2e-c9db-5590-6dcd43b9aaed@huawei.com>
Date:   Wed, 9 Sep 2020 15:13:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_wHONVJL438_Akvo3wZewJeVKiT_8LqW0EXULxAscpGjA@mail.gmail.com>
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

On 2020/9/9 12:43, Daeho Jeong wrote:
> Hi Chao,
> 
> I have a question about the below flag for decompression.
> 
> STEP_DECOMPRESS_NOWQ,           /* handle normal cluster data inplace */
> 
> According to the comment, you added this for using inplace

I added this for the condition that: in compressed inode, partial clusters are
written as normal (non-compressed) one due to bad compress ratio, during reading
data in normal cluster, we don't need to queue them in workqueue, instead, we
can just handle them in IRQ context (end_io()).

That says, if all pages in bio are non-compressed, we tag step w/ STEP_DECOMPRESS_NOWQ,
once there is at least one page is compressed, we change step to
STEP_DECOMPRESS.

> decompression but inplace decompression mode is not being activated

'inplace decompression' means decompress in
a. reader thread or
b. IRQ context ?

Thanks

> now, since we are setting STEP_DECOMPRESS right after bio_add_page().
> 
>                  if (bio_add_page(bio, page, blocksize, 0) < blocksize)
>                          goto submit_and_realloc;
> 
>                  /* tag STEP_DECOMPRESS to handle IO in wq */
>                  ctx = bio->bi_private;
>                  if (!(ctx->enabled_steps & (1 << STEP_DECOMPRESS)))
>                          ctx->enabled_steps |= 1 << STEP_DECOMPRESS;
> 
> Did you mean to deactivate inplace decompression mode on purpose,
> since it had an issue? I am a little bit confused about this.
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
