Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE4DC2BB84
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E33F8207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 06:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgIJG0z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:26:55 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3511 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726534AbgIJG0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 02:26:47 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 885AF6857F474B3979AB;
        Thu, 10 Sep 2020 14:26:45 +0800 (CST)
Received: from dggeme753-chm.china.huawei.com (10.3.19.99) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Thu, 10 Sep 2020 14:26:45 +0800
Received: from dggeme753-chm.china.huawei.com ([10.7.64.70]) by
 dggeme753-chm.china.huawei.com ([10.7.64.70]) with mapi id 15.01.1913.007;
 Thu, 10 Sep 2020 14:26:45 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        syzbot <syzbot+c5d5a51dcbb558ca0cb5@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in unlink_file_vma
Thread-Topic: general protection fault in unlink_file_vma
Thread-Index: AdaHOf7o7TdygKeMkk6oouf0he4T3A==
Date:   Thu, 10 Sep 2020 06:26:45 +0000
Message-ID: <bc09fdb2ce24487b821bccc856c4c23b@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.174.178.74]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hillf Danton wrote:
>> On Thu, 10 Sep 2020 07:43:41 +0530 Souptick Joarder wrote:
>> On Wed, Sep 9, 2020 at 9:45 AM Hillf Danton wrote:
>> > Tue, 08 Sep 2020 17:19:17 -0700
>> > > syzbot found the following issue on:
>> > >
>> > > HEAD commit:    59126901 Merge tag 'perf-tools-fixes-for-v5.9-2020-09-03' ..
>> >
>> > Looks like d70cec898324 ("mm: mmap: merge vma after call_mmap() if 
>> > possible") added an extra fput.
>> 
>> Can you please help me to understand how do you figure out this commit ?
>
>Feel free to correct Hillf if I missed any thing.
>Failing to reproduce the gpf without the commit may tell us more about it than I could.
>> >
>> > --- a/mm/mmap.c
>> > +++ b/mm/mmap.c
>> > @@ -1781,7 +1781,6 @@ unsigned long mmap_region(struct file *f
>> >                         merge = vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
>> >                                 NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX);
>> >                         if (merge) {
>> > -                               fput(file);
>> >                                 vm_area_free(vma);
>> >                                 vma = merge;
>> >                                 /* Update vm_flags and possible addr 
>> > to pick up the change. We don't

Yes, It seems vma_merge() could fput the vm_file via remove_next case in __vma_adjust(). So the fput vm_file here do the
extra one.

But we may not remove the fput here directly as vma_merge() do not always fput the vm_file. I'am not really familiar with
the vma merge yet, but I would try my best to fix this as soon as possible.

Many thanks for point this out. And sorry for my careless.

