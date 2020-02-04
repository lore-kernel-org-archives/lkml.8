Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B561C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0542A227BF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgBDLem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 06:34:42 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44674 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbgBDLel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 06:34:41 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Tp87BdY_1580816045;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tp87BdY_1580816045)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 04 Feb 2020 19:34:09 +0800
Subject: Re: [PATCH] OCFS2: remove useless err
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        ChenGang <cg.chen@huawei.com>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <1579577836-251879-1-git-send-email-alex.shi@linux.alibaba.com>
 <5aa17eac-60ee-5360-81f9-7bff2cb76eb3@linux.alibaba.com>
 <f5c1b5cd-6fd2-f198-97e3-a4f34e990ba8@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <2550e871-f930-92d1-4c75-fcd84fc20021@linux.alibaba.com>
Date:   Tue, 4 Feb 2020 19:34:05 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <f5c1b5cd-6fd2-f198-97e3-a4f34e990ba8@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/2/4 18:59, Alex Shi wrote:
> 
> 
> 在 2020/1/26 上午9:52, Joseph Qi 写道:
>>
> 
>>>  
>>> @@ -708,7 +708,7 @@ static struct buffer_head *ocfs2_find_entry_el(const char *name, int namelen,
>>>  				num++;
>>>  
>>>  				bh = NULL;
>>> -				err = ocfs2_read_dir_block(dir, b++, &bh,
>>> +				ocfs2_read_dir_block(dir, b++, &bh,
>>>  							   OCFS2_BH_READAHEAD);
>>
>> Umm... missing error checking here?
> 
> 
> /*
>  * This function forces all errors to -EIO for consistency with its
>  * predecessor, ocfs2_bread().  We haven't audited what returning the
>  * real error codes would do to callers.  We log the real codes with
>  * mlog_errno() before we squash them.
>  */
> static int ocfs2_read_dir_block(struct inode *inode, u64 v_block,
>                                 struct buffer_head **bh, int flags)
> 
> According to ocfs2_read_dir_block comments, caller don't care the err value, func will log it.
> 
> So is this patch ok? :)
> 
If we got error here, it means the buffer head is invalid.
So how about mark it as NULL and skip it?

Thanks,
Joseph
