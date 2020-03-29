Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444F1C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ABEE20717
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHJaMHR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgC2CbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:31:08 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37242 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgC2CbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:31:07 -0400
Received: by mail-wm1-f67.google.com with SMTP id d1so17298460wmb.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 19:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KGKn+Q4xDiKGmT4lj04RdnzRCL/EzsbA8clai2nCpw8=;
        b=iHJaMHR9ndxOg01T8AVnpg7OQ0tbXwruaQDEAkpVPEr6b53m64OnolQw86/Q6leK7W
         QpAPda3+UbqrDTHxAnMv15ufW42zSOy+6xChZLAoCSuDgCxDDJSo4oPlWtD1DcfUigkU
         zA/RSUQl2bkftsGtL1r3DM9Rml/cBMtFb8yT7r+9Hp7ksQHwBjyamodm9d4JqnJgFS8Z
         HfBGKj+sbmO5poMnVJ5RCWQfvHqTsV1zzMjEydhovEllHch+J4NiEZElNnZQPEfBGJTl
         gDdoyfkKrBFHiGDbcd445kz6clhvHmlo1FxROn70TGqnJu5Si0YZ4HVC8PZYp6HOahR/
         Uc1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=KGKn+Q4xDiKGmT4lj04RdnzRCL/EzsbA8clai2nCpw8=;
        b=rtjL0nsQU3KfihtgT8ZunoGCNInwWaiLLFljCf6iR6J6SvWYp5hgoK6RC+w1OXeNNK
         GW31aTWQieB68q+CVyFo+1nA8FwyOZLmH6F88l5svv1h7GPIGsJOcv6h3pYeaFujdAIB
         83flsNBUDEqN0UWcjniZSWywg4U72FV7cG5kFcM+L+0hXr3L2F8bo3A53iFtitL5IVnL
         tsYSht3RlUvy9xXq4/jY2WzmGz27P9mcgYJbLCaIChJYZkMi68ZVY4V61pg8k8bAHUJW
         MIavLdcX3zlbh3fPy2Vz59bM5Pi0i5mjamrXtFiX0Taoi3WEThF0VI2JhWIdhz1iv4kN
         +3Nw==
X-Gm-Message-State: ANhLgQ29xSNXIZY6h9ZoNv8qGy9mBwmSA3VnUYT04wA56+ZKLplyGWYx
        0ZN2CioK3HD3je2qUNbRFIE=
X-Google-Smtp-Source: ADFU+vt/63IWxJc8HIOV7cz6SgVp+UHGwZuJDfKA1qvo0awOQLPcjuxRq0v9Aq/nmcier0m5C198Xw==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr6671747wmj.91.1585449065619;
        Sat, 28 Mar 2020 19:31:05 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id p21sm15985630wma.0.2020.03.28.19.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 19:31:04 -0700 (PDT)
Date:   Sun, 29 Mar 2020 02:31:04 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200329023104.6vvklsudemh5vjh4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
 <20200328011031.olsaehwdev2gqdsn@master>
 <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
 <20200328025605.cpnbnavl27pphr7g@master>
 <b1b41da1-2ced-8bb8-7162-e5c820543244@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1b41da1-2ced-8bb8-7162-e5c820543244@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 06:30:00PM -0700, John Hubbard wrote:
>On 3/27/20 7:56 PM, Wei Yang wrote:
>...
>> > Further note: On my current testing .config, I've got MAX_NUMNODES set to 64, which makes
>> > 256 bytes required for node_order array. 256 bytes on a 16KB stack is a little bit above
>> > my mental watermark for "that's too much in today's kernels".
>> > 
>> 
>> Thanks for your explanation. I would keep this in mind.
>> 
>> Now I have one more question, hope it won't sound silly. (16KB / 256) = 64,
>> this means if each function call takes 256 space on stack, the max call depth
>> is 64. So how deep a kernel function call would be? or expected to be?
>> 
>
>64 is quite a bit deeper call depth than we expect to see. So 256 bytes on the stack
>is not completely indefensible, but it's getting close. But worse, that's just an
>example based on my .config choices. And (as Baoquan just pointed out) it can be much
>bigger. (And the .config variable is an exponent, not linear, so it gets exciting fast.)
>In fact, you could overrun the stack directly, with say CONFIG_NODES_SHIFT = 14.
>

Thanks :-)

This is better not to use "big" structure on stack.

>> Also because of the limit space on stack, recursive function is not welcome in
>> kernel neither. Am I right?
>> 
>Yes, that is correct.
>
>thanks,
>-- 
>John Hubbard
>NVIDIA

-- 
Wei Yang
Help you, Help me
