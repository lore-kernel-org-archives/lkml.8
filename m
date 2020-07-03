Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF25C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF10920747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 02:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGCCC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 22:02:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58862 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726032AbgGCCC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 22:02:28 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BA02E231593B7C3B0C58;
        Fri,  3 Jul 2020 10:02:26 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.204) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 3 Jul 2020
 10:02:26 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: add symbolic link to kobject in sysfs
To:     Daeho Jeong <daeho43@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <kernel-team@android.com>, Daeho Jeong <daehojeong@google.com>
References: <20200630005625.2405062-1-daeho43@gmail.com>
 <961072bb-4c8f-b01e-666d-1f5e35a8b76d@huawei.com>
 <CACOAw_wQx5wjdWDX_WFebNS42t=wBuSh_k7oQ4v7abBv80SZXw@mail.gmail.com>
 <9d1afacc-6033-2bae-d55d-909d50f1904b@huawei.com>
 <CACOAw_zFLgeoomdHhRmzYMtCocTugW5AVxb2wZnoRAC9+hR9Gw@mail.gmail.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <ee97fa6e-33df-04f9-ec37-6b7d7b495acb@huawei.com>
Date:   Fri, 3 Jul 2020 10:02:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACOAw_zFLgeoomdHhRmzYMtCocTugW5AVxb2wZnoRAC9+hR9Gw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/7/1 20:12, Daeho Jeong wrote:
>> On 2020/7/1 15:04, Daeho Jeong wrote:
>>> Actually, I want to keep the mount number remaining to the same
>>> number, even if it's re-mounted.
>>
>> Then once there is f2fs umounter, the order will be incorrect...
> 
> Actually, we prepared this patch for a strictly controlled system like
> Android to easily access the sysfs node for a specific partition like
> userdata partition using a specific number.

I'm not against Android defined interfaces, just be confused about the
behavior that does not fully documented (at least, we should add this
into f2fs doc, and specify this is android specified interface), something
like once one mount point was umounted, that sequential number @x in
'mount_@x" could be reused by later newly mounted point, it breaks the
description: "in the order of mounting filesystem".

> In this system, we don't worry about another unexpected f2fs umounter
> interfering in between unmounting and mounting a partition.
> 
> When we are under the condition that we can keep track of how many
> times the userdata partition has been re-mounted, we might as well use
> the original partition name like "/sys/fs/f2fs/dm-9".
> This is for when we couldn't do that.
> .
> 
