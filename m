Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6B8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48136208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgE1CRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:17:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbgE1CRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:17:47 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C900EC4ADDF2B4F880D7;
        Thu, 28 May 2020 10:17:44 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 28 May
 2020 10:17:42 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: protect new segment allocation in
 expand_inode_data
To:     Daeho Jeong <daeho43@gmail.com>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
CC:     Daeho Jeong <daehojeong@google.com>
References: <20200527040231.70891-1-daeho43@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e2ecd025-96aa-7f9d-49f7-a821ea18f9dd@huawei.com>
Date:   Thu, 28 May 2020 10:17:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200527040231.70891-1-daeho43@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/27 12:02, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Found a new segemnt allocation without f2fs_lock_op() in
> expand_inode_data(). So, when we do fallocate() for a pinned file
> and trigger checkpoint very frequently and simultaneously. F2FS gets
> stuck in the below code of do_checkpoint() forever.
> 
>   f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
>   /* Wait for all dirty meta pages to be submitted for IO */
>                                                 <= if fallocate() here,
>   f2fs_wait_on_all_pages(sbi, F2FS_DIRTY_META); <= it'll wait forever.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
