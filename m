Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC915C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C5A206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgAMQF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:05:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33395 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMQF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:05:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so4923281pgk.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aEeCpWwviwIRvJF8GSSSNrsZUv5cSc10vbu3m/zOYRg=;
        b=m5lxnNfW3PYEUg9Cnl3CMIFk41gmcA2mZS7w09jaloBomauzSMZFTVzdpQ96DxnumK
         OwC74zXjuYoAoUA00TZcl+poZoKNO/YUwgMjjNCW0yjuKeh6Fcc5XLhvHm/P9oJcLksQ
         vJp9n1+wfxdeMxnbaAFmcqqcmh9xqEPxt0TRNG3tTZsmvDrXY1B1oxY/Ltz+xCpIxZDF
         MKb/ykmPzUHVUXCTb+tR847SSmeifIGOrj792bO03BBLVs7qd6RJ54UgPY5OXS/kvsQf
         Y7qpUBr9vFitWjigzQt8FqiEkK8I/UGduxbLLUyBtHa0mcPfcLsd4qqlMvuRYuOosZ6w
         9TVQ==
X-Gm-Message-State: APjAAAWpTdufBAVNFpgWqBA4C7Hu50HBU0N76GE9MKQiIDNtxWVvXBwW
        usLvJwDrIaPsnLDWh+DyfbDdWprf
X-Google-Smtp-Source: APXvYqyqFgcg1x4Hu00x5gvetPIPmoZKU2sdYj7U1D4pEjVk1Qof1drPL35HKq7J+Ta9niEffQ2iuQ==
X-Received: by 2002:a63:3245:: with SMTP id y66mr21368254pgy.234.1578931525631;
        Mon, 13 Jan 2020 08:05:25 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 68sm13948043pge.14.2020.01.13.08.05.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 08:05:24 -0800 (PST)
Subject: Re: [PATCH v2 2/6] locking/lockdep: Throw away all lock chains with
 zapped class
To:     Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-3-longman@redhat.com>
 <20200113151806.GW2844@hirez.programming.kicks-ass.net>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8bf44cb0-81fa-1056-0158-7c14ee424044@acm.org>
Date:   Mon, 13 Jan 2020 08:05:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113151806.GW2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 7:18 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:13AM -0500, Waiman Long wrote:
>> If a lock chain contains a class that is zapped, the whole lock chain is
>> now invalid.
> 
> Possibly. But I'm thinking that argument can/should be made mode elaborate.
> 
> Suppose we have A->B->C, and we're about to remove B.
> 
> Now, I suppose the trivial argument goes that if we remove the text that
> causes A->B, then so B->C will no longer happen. However, that doesn't
> mean A->C won't still occur.
> 
> OTOH, we might already have A->C and so our resulting chain would be a
> duplicate. Conversely, if we didn't already have A->C and it does indeed
> still occur (say it was omitted due to the redundant logic), then we
> will create this dependency the next time we'll encounter it.
> 
> Bart, do you see a problem with this reasoning?
> 
> In short, yes, I think you're right and we can remove the whole thing.
> But please, expand the Changelog a bit, possibly add some of this
> reasoning into a comment.

I think unconditionally dropping lock chains is wrong. If a lock class 
is zapped the rest of the lock chain remains valid and hence should be 
retained unless it duplicates another lock chain or if the length of the 
lock chain is reduced to a single element.

Bart.


