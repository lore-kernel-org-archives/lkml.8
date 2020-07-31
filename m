Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CC3721744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731338AbgGaDsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:48:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8863 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731317AbgGaDsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:48:31 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9D921B21CA41E6BF6D25;
        Fri, 31 Jul 2020 11:48:28 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 31 Jul
 2020 11:48:27 +0800
Subject: Re: [PATCH] erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's
To:     Gao Xiang <hsiangkao@aol.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
References: <20200731024049.16495-1-hsiangkao.ref@aol.com>
 <20200731024049.16495-1-hsiangkao@aol.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0445e583-f9d6-782e-971c-a5a52dcdc6dc@huawei.com>
Date:   Fri, 31 Jul 2020 11:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200731024049.16495-1-hsiangkao@aol.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/31 10:40, Gao Xiang via Linux-erofs wrote:
> From: Gao Xiang <hsiangkao@redhat.com>
> 
> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> unbound wq. I remove this flag from places where unbound queue is
> allocated. This is supposed to improve code readability.
> 
> [1] https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> [Gao Xiang: since the original treewide patch [2] hasn't been merged
>              yet, handling the EROFS part only for the next cycle. ]
> [2] https://lore.kernel.org/r/20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
