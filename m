Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1FDC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A51D206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 02:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlqhpasY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgC1C4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 22:56:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34886 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgC1C4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 22:56:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id f74so3895591wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 19:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZtEvNjpln4ORM2p45tfUuN3WjyJ390+vYelXRedBehY=;
        b=OlqhpasYqO12u3f1CNhykVEkyBwd/9NdjNjZOCCc6zz2kBJcYUi8AHVKyLGxjfVo0+
         a1URseFx/zmG/c8QQhiK+xoltfUTAZ4kIptJaOJWFTYYYuX3POGgpyOw22IB8rKldg+h
         Q0tkqIlRTBmqTy6jQ67h2qotJ9h3vRtce2TB8QrdbjQM96qs+8/pIYl8PYpUqywc74sh
         4gKBCxsDRLecKIerY+fJDSz8gRQsNsG6QO4PeR99yZdz95C87ks59hbkbWvwFDRq72qN
         pERGeh9ZPGL0sNphcsc8R5CFEM0nm4Elw23ZJn9QknGS1Vsavji1RJn2/YhsfaRQmF9V
         Iezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZtEvNjpln4ORM2p45tfUuN3WjyJ390+vYelXRedBehY=;
        b=YdunEYkBZ+pF0qAlaRLFcT7FCIOUVmsC9JOQfN+7hzqkR1SLf3rBV/m4easMDz0AKE
         3clR84xtpIMRgi2uWomA/X9Ro9JTrxgykTOFfs8x4lhmACVufUJzzIVTSYfurfKTWgo9
         To+hSpFOAsF8XEDcu7G2Z37b3EG4u1mXsnVV/Ixs8wbAsJ96MUqHXkRUImpifgnmRfdQ
         xZjayhdjlrP0KjnYHqRIG9Vi6C4CEXmbfvI4q/NJC0WAwEqvlcfHtAjxIhkXVOwReU48
         CKRFyvRLoznv6nWtWQfnru2aig/zrMzBmVHiFYR3E8YIdS0FcAJXXgn3i7WIAb1+ALFI
         g5Hw==
X-Gm-Message-State: ANhLgQ1icE9Uq5EZETolu807bJxary4k92tBv8Dg6Ge/yVCGDtwgsz/m
        hIlzN8ortbSXVJFnm2lrYK8=
X-Google-Smtp-Source: ADFU+vsoe26Zu2+g296FpXaN9yZnaNizDQJVFea+gwg0Pg/xM7ohnt8e5fIJ5/Cky9nAOkvXVBfkig==
X-Received: by 2002:a1c:a757:: with SMTP id q84mr1698667wme.146.1585364166459;
        Fri, 27 Mar 2020 19:56:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a186sm10352904wmh.33.2020.03.27.19.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 19:56:05 -0700 (PDT)
Date:   Sat, 28 Mar 2020 02:56:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328025605.cpnbnavl27pphr7g@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
 <20200328011031.olsaehwdev2gqdsn@master>
 <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 06:28:36PM -0700, John Hubbard wrote:
>On 3/27/20 6:10 PM, Wei Yang wrote:
>...
>> > It's not just about preserving the value. Sometimes it's about stack space.
>> > Here's the trade-offs for static variables within a function:
>> > 
>> > Advantages of static variables within a function (compared to non-static
>> > variables, also within a function):
>> > -----------------------------------
>> > 
>> > * Doesn't use any of the scarce kernel stack space
>> > * Preserves values (not always necessarily and advantage)
>> > 
>> > Disadvantages:
>> > -----------------------------------
>> > 
>> > * Removes basic thread safety: multiple threads can no longer independently
>> >   call the function without getting interaction, and generally that means
>> >   data corruption.
>> > 
>> > So here, I suspect that the original motivation was probably to conserve stack
>> > space, and the author likely observed that there was no concurrency to worry
>> > about: the function was only being called by one thread at a time.  Given those
>> > constraints (which I haven't confirmed just yet, btw), a static function variable
>> > fits well.
>> > 
>> > > 
>> > > My suggestion is to remove the static and define it {0} instead of memset
>> > > every time. Is my understanding correct here?
>> > 
>> > 
>> > Not completely:
>> > 
>> > a) First of all, "instead of memset every time" is a misconception, because
>> >    there is still a memset happening every time with {0}. It's just that the
>> >    compiler silently writes that code for you, and you don't see it on the
>> >    screen. But it's still there.
>> > 
>> > b) Switching away from a static to an on-stack variable requires that you first
>> >    verify that stack space is not an issue. Or, if you determine that this
>> >    function needs the per-thread isolation that a non-static variable provides,
>> >    then you can switch to either an on-stack variable, or a *alloc() function.
>> > 
>> 
>> I think you get some point. While one more question about stack and static. If
>> one function is thread safe, which factor determines whether we choose on
>> stack value or static? Any reference size? It looks currently we don't have a
>> guide line for this.
>> 
>
>
>There's not really any general guideline, but applying the points above (plus keeping
>in mind that kernel stack space is quite small) to each case, you'll come to a good
>answer.
>
>In this case, if we really are only ever calling this function in one thread at a time,
>then it's probably best to let the "conserve stack space" point win. Which leads to
>just leaving the code nearly as-is. The only thing left to do would be to (optionally,
>because this is an exceedingly minor point) delete the arguably misleading "= {0}" part.
>And as Jason points out, doing so also moves node_order into .bss :
>
>diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>index 4bd35eb83d34..cb4b07458249 100644
>--- a/mm/page_alloc.c
>+++ b/mm/page_alloc.c
>@@ -5607,7 +5607,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
> static void build_zonelists(pg_data_t *pgdat)
> {
>-       static int node_order[MAX_NUMNODES] = {0};

This is what I added, so I would drop this one.

>+       static int node_order[MAX_NUMNODES];
>        int node, load, nr_nodes = 0;
>        nodemask_t used_mask = NODE_MASK_NONE;
>        int local_node, prev_node;
>
>
>
>Further note: On my current testing .config, I've got MAX_NUMNODES set to 64, which makes
>256 bytes required for node_order array. 256 bytes on a 16KB stack is a little bit above
>my mental watermark for "that's too much in today's kernels".
>

Thanks for your explanation. I would keep this in mind.

Now I have one more question, hope it won't sound silly. (16KB / 256) = 64,
this means if each function call takes 256 space on stack, the max call depth
is 64. So how deep a kernel function call would be? or expected to be?

Also because of the limit space on stack, recursive function is not welcome in
kernel neither. Am I right?

>
>thanks,
>-- 
>John Hubbard
>NVIDIA
>

-- 
Wei Yang
Help you, Help me
