Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB16C47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22E6C20714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgEFGzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:55:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727984AbgEFGzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:55:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 3042E1C7B49DAE87D5A2;
        Wed,  6 May 2020 14:55:35 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 6 May 2020
 14:55:30 +0800
Subject: Re: [f2fs-dev] [PATCH] f2fs: get parent inode when recovering pino
To:     Eric Biggers <ebiggers@kernel.org>, Gao Xiang <hsiangkao@gmx.com>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, <kernel-team@android.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200505153139.201697-1-jaegeuk@kernel.org>
 <20200505165847.GA98848@gmail.com> <20200505181323.GA55221@google.com>
 <20200505181941.GC98848@gmail.com>
 <20200506001403.GA2101@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20200506012428.GG128280@sol.localdomain>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <5641613f-48e0-171c-cfd0-e799e24d8d11@huawei.com>
Date:   Wed, 6 May 2020 14:55:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200506012428.GG128280@sol.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/6 9:24, Eric Biggers wrote:
> On Wed, May 06, 2020 at 08:14:07AM +0800, Gao Xiang wrote:
>>>
>>> Actually, I think this is wrong because the fsync can be done via a file
>>> descriptor that was opened to a now-deleted link to the file.
>>
>> I'm still confused about this...
>>
>> I don't know what's wrong with this version from my limited knowledge?
>>  inode itself is locked when fsyncing, so
>>
>>    if the fsync inode->i_nlink == 1, this inode has only one hard link
>>    (not deleted yet) and should belong to a single directory; and
>>
>>    the only one parent directory would not go away (not deleted as well)
>>    since there are some dirents in it (not empty).
>>
>> Could kindly explain more so I would learn more about this scenario?
>> Thanks a lot!
> 
> i_nlink == 1 just means that there is one non-deleted link.  There can be links
> that have since been deleted, and file descriptors can still be open to them.
> 
>>
>>>
>>> We need to find the dentry whose parent directory is still exists, i.e. the
>>> parent directory that is counting towards 'inode->i_nlink == 1'.
>>
>> directory counting towards 'inode->i_nlink == 1', what's happening?
> 
> The non-deleted link is the one counted in i_nlink.
> 
>>
>>>
>>> I think d_find_alias() is what we're looking for.
>>
>> It may be simply dentry->d_parent (stable/positive as you said before, and it's
>> not empty). why need to d_find_alias()?
> 
> Because we need to get the dentry that hasn't been deleted yet, which isn't
> necessarily the one associated with the file descriptor being fsync()'ed.
> 
>> And what is the original problem? I could not get some clue from the original
>> patch description (I only saw some extra igrab/iput because of some unknown
>> reasons), it there some backtrace related to the problem?
> 
> The problem is that i_pino gets set incorrectly.  I just noticed this while
> reviewing the code.  It's not hard to reproduce, e.g.:
> 
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/stat.h>
> 
> int main()
> {
>         int fd;
> 
>         mkdir("dir1", 0700);
>         mkdir("dir2", 0700);
>         mknod("dir1/file", S_IFREG|0600, 0);
>         link("dir1/file", "dir2/file");
>         fd = open("dir2/file", O_WRONLY);
>         unlink("dir2/file");
>         write(fd, "X", 1);
>         fsync(fd);
> }
> 
> Then:
> 
> sync
> echo N | dump.f2fs -i $(stat -c %i dir1/file) /dev/vdb | grep 'i_pino'
> echo "dir1 (correct): $(stat -c %i dir1)"
> echo "dir2 (wrong): $(stat -c %i dir2)"
> 
> i_pino will point to dir2 rather than dir1 as expected.

Could you add above testcase into commit message of your patch? it will
be easier to understand the issue we solved with it.

In addition, how about adding this testcase in fstest as a generic one?

> 
> - Eric
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 
