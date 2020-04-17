Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD422087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgDQHZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:25:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728419AbgDQHZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:25:02 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CC62B250C67C28D8866C;
        Fri, 17 Apr 2020 15:25:00 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.203) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Apr
 2020 15:24:56 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix quota_sync failure due to
 f2fs_lock_op
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200409173056.229855-1-jaegeuk@kernel.org>
 <77e9f2e6-f3f3-8ca9-e6b5-3d57c4d2acc5@huawei.com>
 <20200416213946.GA196168@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <db515284-9815-0ce2-becc-dcfe074f4bdb@huawei.com>
Date:   Fri, 17 Apr 2020 15:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200416213946.GA196168@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/17 5:39, Jaegeuk Kim wrote:
> f2fs_quota_sync() uses f2fs_lock_op() before flushing dirty pages, but
> f2fs_write_data_page() returns EAGAIN.
> Likewise dentry blocks, we can just bypass getting the lock, since quota
> blocks are also maintained by checkpoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
