Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8404CC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6246B20661
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgAMI4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:56:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727325AbgAMI4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:56:32 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 12CE9F26DD09C2D7CF29;
        Mon, 13 Jan 2020 16:56:30 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.439.0; Mon, 13 Jan
 2020 16:56:27 +0800
Subject: Re: [f2fs-dev][PATCH V2] resize.f2fs: add option for large_nat_bitmap
 feature
To:     ping xiong <xp1982.06.06@gmail.com>
CC:     <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, xiongping1 <xiongping1@xiaomi.com>
References: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <6304784c-69f3-6542-a660-8513c3895b07@huawei.com>
Date:   Mon, 13 Jan 2020 16:56:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1578898350-29607-1-git-send-email-xp1982.06.06@gmail.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/1/13 14:52, ping xiong wrote:
> From: xiongping1 <xiongping1@xiaomi.com>
> 
> resize.f2fs has already supported large_nat_bitmap feature, but has no
> option to turn on it.
> 
> This change add a new '-i' option to control turning on it.
> 
> Signed-off-by: xiongping1 <xiongping1@xiaomi.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
