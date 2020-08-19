Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5A5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E8E6208DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 01:36:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgHSBf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 21:35:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41844 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726367AbgHSBf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 21:35:58 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D0006D65640004EEF6EB;
        Wed, 19 Aug 2020 09:35:54 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 19 Aug
 2020 09:35:53 +0800
Subject: Re: [PATCH v2] f2fs: fix indefinite loop scanning for free nid
To:     Sahitya Tummala <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-kernel@vger.kernel.org>
References: <1597745414-13135-1-git-send-email-stummala@codeaurora.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <f0504d96-6972-a6db-ec52-aa59bd354d98@huawei.com>
Date:   Wed, 19 Aug 2020 09:35:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1597745414-13135-1-git-send-email-stummala@codeaurora.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/18 18:10, Sahitya Tummala wrote:
> If the sbi->ckpt->next_free_nid is not NAT block aligned and if there
> are free nids in that NAT block between the start of the block and
> next_free_nid, then those free nids will not be scanned in scan_nat_page().
> This results into mismatch between nm_i->available_nids and the sum of
> nm_i->free_nid_count of all NAT blocks scanned. And nm_i->available_nids
> will always be greater than the sum of free nids in all the blocks.
> Under this condition, if we use all the currently scanned free nids,
> then it will loop forever in f2fs_alloc_nid() as nm_i->available_nids
> is still not zero but nm_i->free_nid_count of that partially scanned
> NAT block is zero.
> 
> Fix this to align the nm_i->next_scan_nid to the first nid of the
> corresponding NAT block.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

 > During CP we update only ckpt->next_free_nid but not
 > the nm_i->next_free_nid, which is done only once during boot up.

Oops, thanks for correcting that...

Thanks,
