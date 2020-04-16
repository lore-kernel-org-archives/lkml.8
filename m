Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C404C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853A62087E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436718AbgDPG4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:56:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2436700AbgDPG4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:56:04 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B277D564BEBE7EB6F5C3;
        Thu, 16 Apr 2020 14:55:58 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.201) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 16 Apr
 2020 14:55:55 +0800
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add tracepoint for f2fs iostat
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200413161649.38177-1-jaegeuk@kernel.org>
 <20200416034217.GA254838@google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0a821dfb-f2fc-649b-617d-27c1d5ca599b@huawei.com>
Date:   Thu, 16 Apr 2020 14:55:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200416034217.GA254838@google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/16 11:42, Jaegeuk Kim wrote:
> v2:
>  - add sysfs entry to give the time period
>  - keep stat records in sbi
> 
>>From 805015f3f2cec3acf43321359129c5382a1d5db4 Mon Sep 17 00:00:00 2001
> From: Daeho Jeong <daehojeong@google.com>
> Date: Mon, 30 Mar 2020 03:30:59 +0000
> Subject: [PATCH] f2fs: add tracepoint for f2fs iostat
> 
> Added a tracepoint to see iostat of f2fs. Default period of that
> is 3 second. This tracepoint can be used to be monitoring
> I/O statistics periodically.
> 
> Bug: 152162885
> Change-Id: I6fbe010b9cf1a90caa0f4793a6dab77c4cba7da6

Should be removed...

> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Otherwise, it looks good to me.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
