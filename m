Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C0C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194712070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgBCIQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:16:28 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:49894 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727240AbgBCIQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:16:28 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tp19xdv_1580717712;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Tp19xdv_1580717712)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 03 Feb 2020 16:15:12 +0800
Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file
To:     Gang He <GHe@suse.com>, "mark@fasheh.com" <mark@fasheh.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "gechangwei@live.cn" <gechangwei@live.cn>,
        Shuning Zhang <sunny.s.zhang@oracle.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200121050153.13290-1-ghe@suse.com>
 <CH2PR18MB3206F418382332EB25130477CF000@CH2PR18MB3206.namprd18.prod.outlook.com>
 <de23176f-5b84-a785-80a2-0bdc8e3a0fab@linux.alibaba.com>
 <CH2PR18MB3206844EE94EC90A2CBFF85CCF000@CH2PR18MB3206.namprd18.prod.outlook.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <9dfcde60-f8da-6458-4992-ae1d5dcc1ec1@linux.alibaba.com>
Date:   Mon, 3 Feb 2020 16:15:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <CH2PR18MB3206844EE94EC90A2CBFF85CCF000@CH2PR18MB3206.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/2/3 13:32, Gang He wrote:
> Hi Joseph,
> 
> before calling ocfs2_refcount_cow() in the function ocfs2_prepare_inode_for_write(), we do not use inode buffer_head.
> So, we can let buffer_head is NULL.
> But, when we invoke ocfs2_refcount_cow() function, we have to pass inode buffer_head without NULL pointer.
> That is why writing clone file will cause oops and kill the user-space process.
> 
Okay, so before commit e74540b28556, we will always get a valid buffer
head in ocfs2_prepare_inode_for_refcount().
You can feel free to add:
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

BTW, you'd better resend the patch in a single thread, for the
convenience of merging by akpm.

> 
> ________________________________________
> From: Joseph Qi <joseph.qi@linux.alibaba.com>
> Sent: Monday, February 3, 2020 1:15 PM
> To: Gang He; mark@fasheh.com; jlbec@evilplan.org; gechangwei@live.cn; Shuning Zhang
> Cc: linux-kernel@vger.kernel.org; ocfs2-devel@oss.oracle.com; akpm@linux-foundation.org
> Subject: Re: [PATCH] ocfs2: fix the oops problem when write cloned file
> 
> 
> 
> On 20/2/3 10:17, Gang He wrote:
>> Hello Joseph, Changwei, Sunny and all,
>>
>> Could you help to review this patch?
>> This patch will fix the oops problem caused by write ocfs2 clone files.
>> The root cause is inode buffer head is NULL when calling ocfs2_refcount_cow.
>> Secondly, we should use EX meta lock when calling ocfs2_refcount_cow.
>>
> Before commit e74540b28556, we may also use NULL buffer head in case of
> overwrite, so why there is no such issue before?
> 
> Thanks,
> Joseph
> 
