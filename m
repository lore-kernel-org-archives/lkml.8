Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65214C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42F0B20678
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgAUK2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:28:15 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:53626 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728931AbgAUK2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:28:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0ToHg3hQ_1579602492;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ToHg3hQ_1579602492)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 18:28:13 +0800
Subject: Re: [PATCH] fs/gfs2: remove IS_DINODE
To:     =?UTF-8?Q?Andreas_Gr=c3=bcnbacher?= <andreas.gruenbacher@gmail.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1579596552-257820-1-git-send-email-alex.shi@linux.alibaba.com>
 <CAHpGcMJ6DazJ_rMPB2uUKfH-1oxVy=RoLvt2nMEvcdWWCnWjDw@mail.gmail.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <e29431c1-1dfc-5e65-fa43-829184ed7209@linux.alibaba.com>
Date:   Tue, 21 Jan 2020 18:26:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAHpGcMJ6DazJ_rMPB2uUKfH-1oxVy=RoLvt2nMEvcdWWCnWjDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/1/21 下午6:23, Andreas Grünbacher 写道:
> Alex,
> 
> Am Di., 21. Jan. 2020 um 09:50 Uhr schrieb Alex Shi
> <alex.shi@linux.alibaba.com>:
>> After commit 1579343a73e3 ("GFS2: Remove dirent_first() function"), this
>> macro isn't used any more. so remove it.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
>> Cc: Bob Peterson <rpeterso@redhat.com>
>> Cc: Andreas Gruenbacher <agruenba@redhat.com>
>> Cc: cluster-devel@redhat.com
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>  fs/gfs2/dir.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
>> index eb9c0578978f..636a8d0f3dab 100644
>> --- a/fs/gfs2/dir.c
>> +++ b/fs/gfs2/dir.c
>> @@ -74,7 +74,6 @@
>>  #include "util.h"
>>
>>  #define IS_LEAF     1 /* Hashed (leaf) directory */
>> -#define IS_DINODE   2 /* Linear (stuffed dinode block) directory */
> 
> The same is true for the IS_LEAF macro. I'm adjusting the patch accordingly.
> 

I oversee this. Sorry.

> The other patch removing the LBIT macros looks good as well, so I'm
> applying both.

Thanks a lot!
Alex
