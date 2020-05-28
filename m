Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246B1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B21F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbgE1JZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:25:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728198AbgE1JZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:25:10 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 236CE8628A9E2B396CDF;
        Thu, 28 May 2020 17:25:09 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 17:25:06 +0800
Subject: Re: [PATCH] erofs: suppress false positive last_block warning
To:     Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
References: <20200528084844.23359-1-hsiangkao@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <4bc811ed-f406-1f77-94f7-5e61c4657001@huawei.com>
Date:   Thu, 28 May 2020 17:25:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200528084844.23359-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/28 16:48, Gao Xiang wrote:
> As Andrew mentioned, some rare specific gcc versions could report
> last_block uninitialized warning. Actually last_block doesn't need
> to be uninitialized first from its implementation due to bio == NULL
> condition. After a bio is allocated, last_block will be assigned
> then.
> 
> The detailed analysis is in this thread [1]. So let's silence those
> confusing gccs simply.
> 
> [1] https://lore.kernel.org/r/20200421072839.GA13867@hsiangkao-HP-ZHAN-66-Pro-G1
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
