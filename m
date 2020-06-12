Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28180C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F2B2068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgFLJW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:22:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbgFLJW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:22:56 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D606CA52C38657261C74;
        Fri, 12 Jun 2020 17:22:54 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.205) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 12 Jun 2020
 17:22:51 +0800
Subject: Re: [PATCH v2] 9p/trans_fd: Fix concurrency del of req_list in
 p9_fd_cancelled/p9_read_work
To:     Dominique Martinet <asmadeus@codewreck.org>
CC:     <ericvh@gmail.com>, <lucho@ionkov.net>, <davem@davemloft.net>,
        <v9fs-developer@lists.sourceforge.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200612090833.36149-1-wanghai38@huawei.com>
 <20200612091044.GA11129@nautica>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <e59d96eb-9ef6-c6c9-2572-a3f219600130@huawei.com>
Date:   Fri, 12 Jun 2020 17:22:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200612091044.GA11129@nautica>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/6/12 17:10, Dominique Martinet 写道:
> Wang Hai wrote on Fri, Jun 12, 2020:
>> p9_read_work and p9_fd_cancelled may be called concurrently.
>> In some cases, req->req_list may be deleted by both p9_read_work
>> and p9_fd_cancelled.
>>
>> We can fix it by ignoring replies associated with a cancelled
>> request and ignoring cancelled request if message has been received
>> before lock.
>>
>> Fixes: 60ff779c4abb ("9p: client: remove unused code and any reference to "cancelled" function")
>> Reported-by: syzbot+77a25acfa0382e06ab23@syzkaller.appspotmail.com
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> Thanks! looks good to me, I'll queue for 5.9 as well unless you're in a
> hurry.
Ok, thanks.

