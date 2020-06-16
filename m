Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E011C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7D6207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFPLEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:04:46 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6340 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgFPLEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:04:38 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4FF21990F3B21C913701;
        Tue, 16 Jun 2020 19:04:33 +0800 (CST)
Received: from [10.166.212.221] (10.166.212.221) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 16 Jun
 2020 19:04:28 +0800
Subject: Re: [PATCH 1/2] drm/amdgpu/debugfs: fix memory leak when
 pm_runtime_get_sync failed
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <alexander.deucher@amd.com>, <David1.Zhou@amd.com>,
        <tom.stdenis@amd.com>, <Jack.Xiao@amd.com>, <yttao@amd.com>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
References: <20200616063039.260990-1-chentao107@huawei.com>
 <a8fb3d27-d0f5-d28a-d24b-63be866ef76f@amd.com>
From:   "chentao (AS)" <chentao107@huawei.com>
Message-ID: <882dba73-8384-919d-671c-a300db4ef0cf@huawei.com>
Date:   Tue, 16 Jun 2020 19:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <a8fb3d27-d0f5-d28a-d24b-63be866ef76f@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.212.221]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, i will modify it in v2 patch.

On 2020/6/16 14:50, Christian König wrote:
> Probably better to remove the duplication of result and r here and 
> then use "goto err".
