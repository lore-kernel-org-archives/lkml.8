Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82073C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65EAF206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGPHdM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:33:12 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:33184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgGPHdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:33:11 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id D5162A9454716861D7FB;
        Thu, 16 Jul 2020 15:33:08 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Thu, 16 Jul 2020 15:33:05 +0800
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 16 Jul 2020 15:33:05 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 16 Jul 2020 15:33:05 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Thread-Topic: [PATCH] mm: mmap: Merge vma after call_mmap() if possible
Thread-Index: AdZZkbhDr0LDae6gQR+szjsfPzuWPwBqkbJw
Date:   Thu, 16 Jul 2020 07:33:05 +0000
Message-ID: <3da69bbf7f0d485ca1c8e4a44d5010c6@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.176.109]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> wrote:
>Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 14 Jul 2020 11:07:44 +0800 linmiaohe <linmiaohe@huawei.com> wrote:
>>
>>> The vm_flags may be changed after call_mmap() because drivers may set 
>>> some flags for their own purpose. As a result, we failed to merge the 
>>> adjacent vma due to the different vm_flags as userspace can't pass in the same one.
>>> Try to merge vma after call_mmap() to fix this issue.
>>
>>Which drivers do this?
>
>> I searched the code and I see many drivers change the vm_flags, such as aio_ring_mmap set VM_DONTEXPAND and amdgpu_mmap , binder_mmap also change the vm_flags , and so on...
>>
>>Thanks.
>>

I'am sorry. I offered the VM_DONTEXPAND case to you which belongs to VM_SPECIAL. I found some other cases:
	i810_mmap_buffers:
		set VM_DONTCOPY
	dax_mmap:
	ext4_file_mmap:
	xfs_file_mmap:
		set VM_HUGEPAGE
These vm_flags don't belong to VM_SPECIAL and should be vma mergeable case.

In fact, this problem is found on my own product env. We set VM_DONTCOPY in driver mmap ops, and we got this:
400000000000-400000001000 rw-s 105cee000 00:06 64086                     /dev/...
400000001000-400000002000 rw-s 105cef000 00:06 64086                     /dev/...
400000002000-400000003000 rw-s 105cf0000 00:06 64086                     /dev/...
400000003000-400000004000 rw-s 105cf1000 00:06 64086                     /dev/...
400000004000-400000005000 rw-s 105cf2000 00:06 64086                     /dev/...
400000005000-400000006000 rw-s 105cf3000 00:06 64086                     /dev/...
400000006000-400000007000 rw-s 105cf4000 00:06 64086                     /dev/...
400000007000-400000008000 rw-s 105cf5000 00:06 64086                     /dev/...
400000008000-400000009000 rw-s 105cf6000 00:06 64086                     /dev/...
400000009000-40000000a000 rw-s 105cf7000 00:06 64086                     /dev/...
40000000a000-40000000b000 rw-s 105cf8000 00:06 64086                     /dev/...
40000000b000-40000000c000 rw-s 105cf9000 00:06 64086                     /dev/...
40000000c000-40000000d000 rw-s 105cfa000 00:06 64086                     /dev/...
40000000d000-40000000e000 rw-s 105cfb000 00:06 64086                     /dev/...
40000000e000-40000000f000 rw-s 105cfc000 00:06 64086                     /dev/...
40000000f000-400000010000 rw-s 105cfd000 00:06 64086                     /dev/...
400000010000-400000011000 rw-s 105cfe000 00:06 64086                     /dev/...
400000011000-400000012000 rw-s 105cff000 00:06 64086                     /dev/...
400000012000-400000013000 rw-s 105d00000 00:06 64086                     /dev/...
400000013000-400000014000 rw-s 105d01000 00:06 64086                     /dev/...
400000014000-400000015000 rw-s 105d02000 00:06 64086                     /dev/...
400000015000-400000016000 rw-s 105d03000 00:06 64086                     /dev/...
400000016000-400000017000 rw-s 105d04000 00:06 64086                     /dev/...
400000017000-400000018000 rw-s 105d05000 00:06 64086                     /dev/...
400000018000-400000019000 rw-s 105d06000 00:06 64086                     /dev/...
400000019000-40000001a000 rw-s 105d07000 00:06 64086                     /dev/...
40000001a000-40000001b000 rw-s 105d08000 00:06 64086                     /dev/...
40000001b000-40000001c000 rw-s 105d09000 00:06 64086                     /dev/...
40000001c000-40000001d000 rw-s 105d0a000 00:06 64086                     /dev/...
40000001d000-40000001e000 rw-s 105d0b000 00:06 64086                     /dev/...
40000001e000-40000001f000 rw-s 105d0c000 00:06 64086                     /dev/...

The vma flags are same, vma address are adjacent, belong to same file and so on...
I believe this expose the old uncommon bug. I hope I explain it clearly this time.
Many thanks.
