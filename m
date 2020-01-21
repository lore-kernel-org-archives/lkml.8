Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53F4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D7D22522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUIBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:01:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726920AbgAUIBS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:01:18 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0EEFC3FAE20A2F252500;
        Tue, 21 Jan 2020 16:01:16 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 21 Jan
 2020 16:01:09 +0800
Subject: Re: [PATCH v2 1/2] erofs: fold in postsubmit_is_all_bypassed()
To:     Gao Xiang <gaoxiang25@huawei.com>, <linux-erofs@lists.ozlabs.org>
CC:     <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>
References: <20200120085709.10320-1-hsiangkao@aol.com>
 <20200121064747.138987-1-gaoxiang25@huawei.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <b785e844-7120-09b0-6b21-14bd5d878034@huawei.com>
Date:   Tue, 21 Jan 2020 16:01:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200121064747.138987-1-gaoxiang25@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/21 14:47, Gao Xiang wrote:
> No need to introduce such separated helper since
> cache strategy compile configs were changed into
> runtime options instead in v5.4. No logic changes.
> 
> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
