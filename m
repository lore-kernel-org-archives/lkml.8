Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7ED20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731348AbgGaDtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:49:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:51030 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731309AbgGaDtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:49:11 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9FA60129772F42E47FD6;
        Fri, 31 Jul 2020 11:49:09 +0800 (CST)
Received: from [10.164.122.247] (10.164.122.247) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 31 Jul
 2020 11:49:05 +0800
Subject: Re: [PATCH] erofs: fold in used-once helper
 erofs_workgroup_unfreeze_final()
To:     Gao Xiang <hsiangkao@redhat.com>, <linux-erofs@lists.ozlabs.org>
CC:     LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>
References: <20200729180235.25443-1-hsiangkao@redhat.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0ead5f4b-87b6-6fac-9e79-629880dec155@huawei.com>
Date:   Fri, 31 Jul 2020 11:49:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200729180235.25443-1-hsiangkao@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.164.122.247]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/30 2:02, Gao Xiang wrote:
> It's expected that erofs_workgroup_unfreeze_final() won't
> be used in other places. Let's fold it to simplify the code.
> 
> Signed-off-by: Gao Xiang <hsiangkao@redhat.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
