Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C70C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8516206BE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGLzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:55:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59996 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725944AbgGGLzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:55:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2DBA98E528D7DC0EAFEE;
        Tue,  7 Jul 2020 19:55:05 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.214) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Jul 2020
 19:54:57 +0800
Subject: Re: [PATCH] ubifs: Fix a potential space leak problem while linking
 tmpfile
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
References: <20200701112643.726986-1-chengzhihao1@huawei.com>
 <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <082f18e0-d6f0-6389-43af-3159edb244cb@huawei.com>
Date:   Tue, 7 Jul 2020 19:54:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvyO_aXGfgoO0mrNsoGP4Bfh3n6CUQxDx=ecH6o2ZDNYDg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/7/7 19:26, Richard Weinberger 写道:
> On Wed, Jul 1, 2020 at 1:28 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>> There is a potential space leak problem while linking tmpfile, in which
>> case, inode node (with nlink=0) is valid in tnc (on flash), which leads
>> to space leak. Meanwhile, the corresponding data nodes won't be released
>> from tnc. For example, (A reproducer can be found in Link):
>>
>> $ mount UBIFS
>>    [process A]            [process B]         [TNC]         [orphan area]
>>
>>   ubifs_tmpfile                          inode_A (nlink=0)     inode_A
>>                            do_commit     inode_A (nlink=0)     inode_A
>>                                 ↑
>>        (comment: It makes sure not replay inode_A in next mount)
>>   ubifs_link                             inode_A (nlink=0)     inode_A
>>     ubifs_delete_orphan                  inode_A (nlink=0)
>>                            do_commit     inode_A (nlink=0)
>>                             ---> POWERCUT <---
>>     (ubifs_jnl_update)
>>
>> $ mount UBIFS
>>    inode_A will neither be replayed in ubifs_replay_journal() nor
>>    ubifs_mount_orphans(). inode_A (nlink=0) with its data nodes will
>>    always on tnc, it occupy space but is non-visable for users.
>>
>> Commit ee1438ce5dc4d ("ubifs: Check link count of inodes when killing
>> orphans.") handles problem in mistakenly deleting relinked tmpfile
>> while replaying orphan area. Since that, tmpfile inode should always
>> live in orphan area even it is linked. Fix it by reverting commit
>> 32fe905c17f001 ("ubifs: Fix O_TMPFILE corner case in ubifs_link()").
> Well, by reverting this commit you re-introduce the issue it fixes. ;-\
>
Perhaps I misunderstood what commit 32fe905c17f001 ("ubifs: Fix 
O_TMPFILE corner case in ubifs_link()") wanted to fix.
I think orphan area is used to remind filesystem don't forget to delete 
inodes (whose nlink is 0) in next unclean rebooting. Generally, the file 
system is not corrupted caused by replaying orphan nodes.
Ralph reported a filesystem corruption in combination with overlayfs. 
Can you tell me the details about that problem? Thanks.


