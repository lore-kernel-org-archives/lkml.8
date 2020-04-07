Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6851FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41FD5206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 02:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDGCQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 22:16:41 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12682 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbgDGCQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 22:16:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4A90F7B786DD6BC6961;
        Tue,  7 Apr 2020 10:16:34 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 7 Apr 2020
 10:16:24 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: introduce sysfs/data_io_flag to attach
 REQ_META/FUA
To:     Jaegeuk Kim <jaegeuk@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <kernel-team@android.com>
References: <20200403161249.68385-1-jaegeuk@kernel.org>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <0e627c29-7fb0-5bd6-c1d9-b96a94df62ae@huawei.com>
Date:   Tue, 7 Apr 2020 10:16:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200403161249.68385-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/4 0:12, Jaegeuk Kim wrote:
> This patch introduces a way to attach REQ_META/FUA explicitly
> to all the data writes given temperature.
> 
> -> attach REQ_FUA to Hot Data writes
> 
> -> attach REQ_FUA to Hot|Warm Data writes
> 
> -> attach REQ_FUA to Hot|Warm|Cold Data writes
> 
> -> attach REQ_FUA to Hot|Warm|Cold Data writes as well as
>           REQ_META to Hot Data writes

Out of curiosity, what scenario it is used for?

Thanks,
