Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE493C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663A5207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfqKe+gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgGPNsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:48:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46724 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728093AbgGPNsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594907324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GfvtRZl6XjjqgsUho+mp1mDesIN25Q1M46CfrAHyf5E=;
        b=SfqKe+gNMqaMKgHfybf+ieUujVXBmxQ/gBRrVTTN8McUsJqsb+7ADFiOrBJs5M6Xhfh7vu
        /5n1z4KNRfm+UPnpkH5rJx7Yl2NtZe1Chd67Oui4ccPEJkfwC+jDpGwUbxF9uGc717vbya
        HSsDULINrxLwQg6xK2YFH2qai5OWw8k=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-BmnPp_yuP-uniWIoy0c9zQ-1; Thu, 16 Jul 2020 09:48:43 -0400
X-MC-Unique: BmnPp_yuP-uniWIoy0c9zQ-1
Received: by mail-qv1-f69.google.com with SMTP id u10so3428108qvj.23
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GfvtRZl6XjjqgsUho+mp1mDesIN25Q1M46CfrAHyf5E=;
        b=G8kIezbQT9lJxRO4ZT4Rr9WgWUDpOjFykGG1g3Gv9oyJ+nAAcQFJAQJmGaVUK6jd/G
         hxJob4NQ4TphFvQ3oz/eRHI1jOTaAu8u8eku56TAn2sUrhPkXZdek6NdXIwRM3k6zJem
         kY4B7efS7SRwpOGGYJZGTxCtJQ7caKP4EDv49Ot9+KYZjOSP6f5lxqkWY4oK8NgM15wj
         Q69TPBPIo6MtqqVn5UzFqh2RvtGKkYor5FZ5mAyrYiuMAoUD4WiVkq3uqHkUOobl6qSo
         WbcVGp6oU7iRtYQSCA+ZSjUFxemsLUSJCp9qojgxTKQdbPbGPDn/2fkQb8OnAcJ6Lz8i
         xcPw==
X-Gm-Message-State: AOAM533p7O3b8iBsUkFvC+GzkufQmfrK1RTLCDDA5Dl7DXDUZxh1xGMd
        GQRPnXexzK2Lt1dEt4kjczRUILA4E7WIb9g7W2XXEdDm1JoRWi/c/6rSYRjBRPEV0PmCzmk7SGC
        Pk0Gwk1cmOWLvbfjH7VzhIm68
X-Received: by 2002:a05:6214:a72:: with SMTP id ef18mr4342615qvb.166.1594907322451;
        Thu, 16 Jul 2020 06:48:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0Oubl/AqRtyIxgKrCGuB+yjKyn9Gpk897PmC3Xhvn7arTCjRXwWZ17enUl/Seg7/aLuCVeA==
X-Received: by 2002:a05:6214:a72:: with SMTP id ef18mr4342587qvb.166.1594907322139;
        Thu, 16 Jul 2020 06:48:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k197sm7161963qke.133.2020.07.16.06.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 06:48:41 -0700 (PDT)
Subject: Re: [PATCH] reiserfs : fix improper free in reiserfs_get_block
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, william.kucharski@oracle.com,
        jeffm@suse.com, joseph.qi@linux.alibaba.com,
        liao.pingfang@zte.com.cn, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200714130509.11791-1-trix@redhat.com>
 <20200714131043.GB12769@casper.infradead.org>
 <bc5a13bd-54c4-509d-7202-20c93f43e2f6@redhat.com>
 <20200715080451.GK23073@quack2.suse.cz>
From:   Tom Rix <trix@redhat.com>
Message-ID: <41a5b57f-2bea-04a6-3510-6d76bd5098d5@redhat.com>
Date:   Thu, 16 Jul 2020 06:48:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200715080451.GK23073@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/20 1:04 AM, Jan Kara wrote:
> On Tue 14-07-20 06:12:47, Tom Rix wrote:
>> On 7/14/20 6:10 AM, Matthew Wilcox wrote:
>>> On Tue, Jul 14, 2020 at 06:05:09AM -0700, trix@redhat.com wrote:
>>>> From: Tom Rix <trix@redhat.com>
>>>>
>>>> clang static analysis flags this error
>>>>
>>>> inode.c:1083:5: warning: Argument to kfree() is the address of the
>>>>   local variable 'unf_single', which is not memory allocated by
>>>>   malloc() [unix.Malloc]
>>>>                                 kfree(un);
>>>>                                 ^~~~~~~~~
>>>> Assignment of 'un'
>>>>
>>>> 	/*
>>>> 	 * We use this in case we need to allocate
>>>> 	 * only one block which is a fastpath
>>>> 	 */
>>>> 	unp_t unf_single = 0;
>>>>
>>>> 	...
>>>>
>>>> 	if (blocks_needed == 1) {
>>>> 		un = &unf_single;
>>>> 	} else {
>>>> 		un = kcalloc(min(blocks_needed, max_to_insert),
>>>> 			     UNFM_P_SIZE, GFP_NOFS);
>>>> 		if (!un) {
>>>> 			un = &unf_single;
>>>> 			blocks_needed = 1;
>>>> 			max_to_insert = 0;
>>>> 		}
>>>> 	}
>>>>
>>>> The logic to free 'un'
>>>>
>>>> 	if (blocks_needed != 1)
>>>> 		kfree(un);
>>>>
>>>> Because the kcalloc failure falls back to using unf_single,
>>>> the if-check for the free is wrong.
>>> I think you mean "Because clang's static analysis is limited, it
>>> warns incorrectly about this".  There's no path to get to the
>>> kfree with blocks_needed != 1 and un being equal to &unf_single.
>> Ok.
> I agree with Matthew the patch will make the code more obviously correct so
> it's a sensible cleanup. But the changelog needs to redone to reflect this
> is just a cleanup before the patch can be merged.
>
> 									Honza

I am going to look into the problem with the analyzer because that is where the fix should go.

If the problem isn't resolvable, i will loop back to this clean up.

Tom

