Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF230C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D0C207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 02:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgF1CgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 22:36:10 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:47026 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725880AbgF1CgJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 22:36:09 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2F3D3E5B1BB10A3D258D;
        Sun, 28 Jun 2020 10:36:08 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.487.0; Sun, 28 Jun
 2020 10:36:04 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix typo in comment of f2fs_do_add_link
To:     Liu Song <fishland@aliyun.com>, <jaegeuk@kernel.org>,
        <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200625124011.8072-1-fishland@aliyun.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <e94a9a7c-a2b0-92d2-601e-a0ce6f2ebc84@huawei.com>
Date:   Sun, 28 Jun 2020 10:36:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200625124011.8072-1-fishland@aliyun.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/25 20:40, Liu Song via Linux-f2fs-devel wrote:
> stakable/stackable
> 
> Signed-off-by: Liu Song <fishland@aliyun.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
