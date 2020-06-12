Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6931EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 01:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43FAC20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 01:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLBBP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 21:01:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42732 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbgFLBBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 21:01:15 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E532F75579B3E817CE12;
        Fri, 12 Jun 2020 09:01:11 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.235) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 09:01:04 +0800
Subject: Re: [PATCH V2] bcache: fix potential deadlock problem in
 btree_gc_coalesce
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linux-bcache@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Coly Li <colyli@suse.de>, Feilong Lin <linfeilong@huawei.com>,
        Kent Overstreet <kmo@daterainc.com>, <mingfangsen@huawei.com>,
        <renxudong1@huawei.com>, Wu Bo <wubo40@huawei.com>,
        <yanxiaodan@huawei.com>
References: <80c2a2c6-01b9-8280-34b4-ff6b9cfaf76a@web.de>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <ae980a3c-f41b-caf6-a384-516656b6fa50@huawei.com>
Date:   Fri, 12 Jun 2020 09:01:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <80c2a2c6-01b9-8280-34b4-ff6b9cfaf76a@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.235]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for late reply. I will improve the commit log as your suggestion in v3 patch.
Thanks for your suggestion.

On 2020/4/27 2:16, Markus Elfring wrote:
>> --
>> V1->V2: rewrite commit log (suggested by Coly Li) and rename the patch
> 
> * The patch version description should be placed behind triple dashes.
> 
> * I would find a shorter version identification (without the arrow)
>   also sufficient.
> 
> 
>> Fixes: 2a285686c1 ("bcache: btree locking rework")>
> 
> Will a longer commit identifier be safer for the final change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b2768df24ec400dd4f7fa79542f797e904812053#n183
> 
> Regards,
> Markus
> 

