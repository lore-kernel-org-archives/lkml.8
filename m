Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F754C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AC22173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="vnImVihw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgD3KGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:06:50 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37802 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726766AbgD3KGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:06:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588241209; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=J1aAaLwfymtTSJ5DCuryIxkiQKiJb3MkkpGzHGgV1tA=; b=vnImVihw6O//LQf4X33MEdiC+8CMX5Mk9MOWrlqjpZAQzRjwX4eGF39G4/pnydfHo/LN0E4h
 0w1cjpQFK6Cz4ZUsvDpmJTMIas/e2mgCfcD6P6RcRopzfTT+65SOoHE57M+HVRmUIXEkuekX
 t9YF9YOo3e7E/J6ca5K65aUm3/I=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaaa339.7efc2a3f38b8-smtp-out-n04;
 Thu, 30 Apr 2020 10:06:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 25DBBC43637; Thu, 30 Apr 2020 10:06:48 +0000 (UTC)
Received: from [192.168.0.103] (unknown [183.83.143.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37D3CC433D2;
        Thu, 30 Apr 2020 10:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37D3CC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V3] f2fs: Avoid double lock for cp_rwsem during checkpoint
To:     Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     stummala@codeaurora.org, linux-kernel@vger.kernel.org
References: <1588179630-22819-1-git-send-email-sayalil@codeaurora.org>
 <7c68cd6d-d858-f80c-f258-e5e1340b9aa3@huawei.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <4a601e70-8738-df5b-c642-7fd1800026cc@codeaurora.org>
Date:   Thu, 30 Apr 2020 15:36:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7c68cd6d-d858-f80c-f258-e5e1340b9aa3@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/30/2020 6:41 AM, Chao Yu wrote:
> On 2020/4/30 1:00, Sayali Lokhande wrote:
>> There could be a scenario where f2fs_sync_node_pages gets
>> called during checkpoint, which in turn tries to flush
>> inline data and calls iput(). This results in deadlock as
>> iput() tries to hold cp_rwsem, which is already held at the
>> beginning by checkpoint->block_operations().
>>
>> Call stack :
>>
>> Thread A		Thread B
>> f2fs_write_checkpoint()
>> - block_operations(sbi)
>>   - f2fs_lock_all(sbi);
>>    - down_write(&sbi->cp_rwsem);
>>
>>                          - open()
>>                           - igrab()
>>                          - write() write inline data
>>                          - unlink()
>> - f2fs_sync_node_pages()
>>   - if (is_inline_node(page))
>>    - flush_inline_data()
>>     - ilookup()
>>       page = f2fs_pagecache_get_page()
>>       if (!page)
>>        goto iput_out;
>>       iput_out:
>> 			-close()
>> 			-iput()
>>         iput(inode);
>>         - f2fs_evict_inode()
>>          - f2fs_truncate_blocks()
>>           - f2fs_lock_op()
>>             - down_read(&sbi->cp_rwsem);
>>
>> Fixes: 399368372ed9 ("f2fs: introduce a new global lock scheme")
> IMO, it should be
>
> 2049d4fcb057 ("f2fs: avoid multiple node page writes due to inline_data")
>
> It brings iput() to checkpoint process for the first time.
>
> Thanks,
Agreed. will update it.
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
>>   fs/f2fs/checkpoint.c | 10 ++++------
>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>> index 5ba649e..97b6378 100644
>> --- a/fs/f2fs/checkpoint.c
>> +++ b/fs/f2fs/checkpoint.c
>> @@ -1219,21 +1219,19 @@ static int block_operations(struct f2fs_sb_info *sbi)
>>   		goto retry_flush_quotas;
>>   	}
>>   
>> -retry_flush_nodes:
>>   	down_write(&sbi->node_write);
>>   
>>   	if (get_pages(sbi, F2FS_DIRTY_NODES)) {
>>   		up_write(&sbi->node_write);
>> +		up_write(&sbi->node_change);
>> +		f2fs_unlock_all(sbi);
>>   		atomic_inc(&sbi->wb_sync_req[NODE]);
>>   		err = f2fs_sync_node_pages(sbi, &wbc, false, FS_CP_NODE_IO);
>>   		atomic_dec(&sbi->wb_sync_req[NODE]);
>> -		if (err) {
>> -			up_write(&sbi->node_change);
>> -			f2fs_unlock_all(sbi);
>> +		if (err)
>>   			goto out;
>> -		}
>>   		cond_resched();
>> -		goto retry_flush_nodes;
>> +		goto retry_flush_quotas;
>>   	}
>>   
>>   	/*
>>
