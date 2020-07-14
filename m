Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83237C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E794224B0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JwMXQp6K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgGNNMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:12:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53068 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727975AbgGNNMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594732372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tcXLN2aOM5HyVPvW2nX/ENf3RMB6pm0tLQoN1DTr1NI=;
        b=JwMXQp6K5DrdVCVg3cKYHS0SvxmOveUmSRlyqRSP4zYPIL8jm5Fo2tOc+kaD6SHiFwd5jJ
        8lv3B/Z693dp4QtrxbQNvFy5nviQNThYfE3N3VODAnYemLoSmZ215KBir9HpOONgC7nQqZ
        GXHnCdfkuxrQ/Lv/WYQq4sOJS400824=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-rtI98Ls7NHGfFYlomvuigg-1; Tue, 14 Jul 2020 09:12:51 -0400
X-MC-Unique: rtI98Ls7NHGfFYlomvuigg-1
Received: by mail-qt1-f197.google.com with SMTP id e6so12509655qtb.19
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=tcXLN2aOM5HyVPvW2nX/ENf3RMB6pm0tLQoN1DTr1NI=;
        b=DJvk+gxnrE6TYVMb9fHduG8HVzvp/hZBrAnkCdRm3+HIwoyLxeu5KucpfESNHDArYM
         TDVXHGUdPY0wE2VrLsRnIWI1RZtd47h6SD62kc24mIueSp8Wq2a8VfSHdZRALIiwwC27
         2w2kA/Qn2A3XkYQW41IAX4eHOyZe0Ut98cSKBZ+8f1wfcVdDqOv+p9HPhPYvHBLQNhHJ
         J7565goTrtwFMzEaHkICgDpJ9NtJnbksfu4jTvqPsg6vWnGeKnus5ubK6CRQLzCTjn7n
         v++hM+J3VumLjUnCp7fXXJTAmxACDB+SDDGTW/EsB+qVMBC+EHVZ+jdDXo2/08evEqOv
         VQ2g==
X-Gm-Message-State: AOAM5314U3wTO9m51vl8q17wXKpio9sMY6FbFJWyD+iE5LkRM0nnR1hs
        mDV8hh2JjPsvhjr/Cli8xPApmEwP1M4tx5rZDywDIaSsAFyS2y2TE9gTX9kkFXiMBdopGW5sb7T
        K45MLD1U8oczxVA3cY754x2GM
X-Received: by 2002:ae9:eb0a:: with SMTP id b10mr4469347qkg.198.1594732370432;
        Tue, 14 Jul 2020 06:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxh7X3vh+e+aHk60ZVCRSIpZ+BjjvNryuzMuxMW7pfPiWEymFwrJuXp8EZHHg1lea0OTP2jpQ==
X-Received: by 2002:ae9:eb0a:: with SMTP id b10mr4469327qkg.198.1594732370187;
        Tue, 14 Jul 2020 06:12:50 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x36sm23396153qtb.78.2020.07.14.06.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:12:49 -0700 (PDT)
Subject: Re: [PATCH] reiserfs : fix improper free in reiserfs_get_block
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jack@suse.cz, william.kucharski@oracle.com, jeffm@suse.com,
        joseph.qi@linux.alibaba.com, liao.pingfang@zte.com.cn,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714130509.11791-1-trix@redhat.com>
 <20200714131043.GB12769@casper.infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <bc5a13bd-54c4-509d-7202-20c93f43e2f6@redhat.com>
Date:   Tue, 14 Jul 2020 06:12:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200714131043.GB12769@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/20 6:10 AM, Matthew Wilcox wrote:
> On Tue, Jul 14, 2020 at 06:05:09AM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> clang static analysis flags this error
>>
>> inode.c:1083:5: warning: Argument to kfree() is the address of the
>>   local variable 'unf_single', which is not memory allocated by
>>   malloc() [unix.Malloc]
>>                                 kfree(un);
>>                                 ^~~~~~~~~
>> Assignment of 'un'
>>
>> 	/*
>> 	 * We use this in case we need to allocate
>> 	 * only one block which is a fastpath
>> 	 */
>> 	unp_t unf_single = 0;
>>
>> 	...
>>
>> 	if (blocks_needed == 1) {
>> 		un = &unf_single;
>> 	} else {
>> 		un = kcalloc(min(blocks_needed, max_to_insert),
>> 			     UNFM_P_SIZE, GFP_NOFS);
>> 		if (!un) {
>> 			un = &unf_single;
>> 			blocks_needed = 1;
>> 			max_to_insert = 0;
>> 		}
>> 	}
>>
>> The logic to free 'un'
>>
>> 	if (blocks_needed != 1)
>> 		kfree(un);
>>
>> Because the kcalloc failure falls back to using unf_single,
>> the if-check for the free is wrong.
> I think you mean "Because clang's static analysis is limited, it
> warns incorrectly about this".  There's no path to get to the
> kfree with blocks_needed != 1 and un being equal to &unf_single.

Ok.


>> So improve the check.
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>  fs/reiserfs/inode.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/reiserfs/inode.c b/fs/reiserfs/inode.c
>> index 1509775da040..4d62148e43e6 100644
>> --- a/fs/reiserfs/inode.c
>> +++ b/fs/reiserfs/inode.c
>> @@ -1079,7 +1079,7 @@ int reiserfs_get_block(struct inode *inode, sector_t block,
>>  						     UNFM_P_SIZE *
>>  						     blocks_needed);
>>  
>> -			if (blocks_needed != 1)
>> +			if (un != &unf_single)
>>  				kfree(un);
> I don't actually object to this patch, but your analysis of clang's
> analysis is wrong.
>

