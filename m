Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EB1C2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6FF92073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 01:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMmp54q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgC1BKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 21:10:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726212AbgC1BKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 21:10:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id 65so14016370wrl.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IZwh0rI/nQniOux/kPCz0V6nO/1QLQepLdPsTBH6qg8=;
        b=IMmp54q5bl/pYJWTlkEzR0sv0mn7zParNAo/s1j7F+Ucu82vuQw9uK9APRIZXcnQXS
         r327GEdHi3F4+OuEAaAJ7yWBVx2LpVHxVrTbo2QGnaCHI9tzqD8/y5r9vTLyJ0HZkdxW
         a4Zc0ZMZ1l8ZR6jvnMIUt2GTL5me+nP2n+BUmUrm4VHcS4kx3Cxu+zpfo5Blu8JS9vWD
         /Q+BS8j2Moe9haQzLm94k/v/XH7Y1QRMdCu4CuTWS3gUyacUPWWTRY7B/2a+SA3UBqYv
         WRvfjilnKNbo4OW2+t7cr+FyoiSOGDxo01HpGutH3nUfF0h8AyJkDD3CHzXxn4v7oNG/
         3yxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=IZwh0rI/nQniOux/kPCz0V6nO/1QLQepLdPsTBH6qg8=;
        b=alPpLQmuVBy5jHFn0npTjJ32JZeO4n67dkfVEOpH41pgLznCK4aQSUqmzN979AONqG
         iL2BsohrN9NI5qFr0c5euTNmxbu4tgT14lYZJ9PPkOQ6x7KWeshiVVCoPDQ9uirNNlRQ
         0J4WkUFu4kdk4ejgeHVLZWUrhlyH5gc6tVhxUvTmRnJj0Y5zv/Ity08nC7LmsUN/z1E6
         p13KFOW3bQPagAuoINQcRrC6H3xqe3p/2I1otRdFLgqsu9nNFOeHPK/AjKG/rleuCUlA
         63Tn9hSVb+7Mx0y+yjQw70F3oOKcXya/ufBJfdovJQ46DT4S4kVlUdfdlP/GmxhawYJu
         CKJQ==
X-Gm-Message-State: ANhLgQ0/dUSLnJRJiWWTXtjZhIENJ9I4e12hT+xHipsZyYXDZlTQe8ZQ
        kbKv7eHIVJZijSSx9tHHyQU=
X-Google-Smtp-Source: ADFU+vsvlCCyp0a//1PCPP6MAEIq3ai9BAq3N3oH4Vv8ylNurHEJAskkBNkm+Ua2512AdoqngWAETA==
X-Received: by 2002:a5d:420e:: with SMTP id n14mr2427085wrq.10.1585357832415;
        Fri, 27 Mar 2020 18:10:32 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id c18sm10812714wrx.5.2020.03.27.18.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 18:10:31 -0700 (PDT)
Date:   Sat, 28 Mar 2020 01:10:31 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328011031.olsaehwdev2gqdsn@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 05:59:30PM -0700, John Hubbard wrote:
>On 3/27/20 5:26 PM, Wei Yang wrote:
>> On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
>> > On 3/27/20 3:01 PM, Wei Yang wrote:
>> > > Since we always clear node_order before getting it, we can leverage
>> > > compiler to do this instead of at run time.
>> > > 
>> > > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> > > ---
>> > >    mm/page_alloc.c | 3 +--
>> > >    1 file changed, 1 insertion(+), 2 deletions(-)
>> > > 
>> > > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> > > index dfcf2682ed40..49dd1f25c000 100644
>> > > --- a/mm/page_alloc.c
>> > > +++ b/mm/page_alloc.c
>> > > @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>> > >    static void build_zonelists(pg_data_t *pgdat)
>> > >    {
>> > > -	static int node_order[MAX_NUMNODES];
>> > > +	static int node_order[MAX_NUMNODES] = {0};
>> > 
>> > 
>> > Looks wrong: now the single instance of node_order is initialized just once by
>> > the compiler. And that means that only the first caller of this function
>> > gets a zeroed node_order array...
>> > 
>> 
>> What a shame on me. You are right, I miss the static word.
>> 
>> Well, then I am curious about why we want to define it as static. Each time we
>> call this function, node_order would be set to 0 and find_next_best_node()
>> would sort a proper value into it. I don't see the reason to reserve it in a
>> global area and be used next time.
>
>It's not just about preserving the value. Sometimes it's about stack space.
>Here's the trade-offs for static variables within a function:
>
>Advantages of static variables within a function (compared to non-static
>variables, also within a function):
>-----------------------------------
>
>* Doesn't use any of the scarce kernel stack space
>* Preserves values (not always necessarily and advantage)
>
>Disadvantages:
>-----------------------------------
>
>* Removes basic thread safety: multiple threads can no longer independently
>  call the function without getting interaction, and generally that means
>  data corruption.
>
>So here, I suspect that the original motivation was probably to conserve stack
>space, and the author likely observed that there was no concurrency to worry
>about: the function was only being called by one thread at a time.  Given those
>constraints (which I haven't confirmed just yet, btw), a static function variable
>fits well.
>
>> 
>> My suggestion is to remove the static and define it {0} instead of memset
>> every time. Is my understanding correct here?
>
>
>Not completely:
>
>a) First of all, "instead of memset every time" is a misconception, because
>   there is still a memset happening every time with {0}. It's just that the
>   compiler silently writes that code for you, and you don't see it on the
>   screen. But it's still there.
>
>b) Switching away from a static to an on-stack variable requires that you first
>   verify that stack space is not an issue. Or, if you determine that this
>   function needs the per-thread isolation that a non-static variable provides,
>   then you can switch to either an on-stack variable, or a *alloc() function.
>

I think you get some point. While one more question about stack and static. If
one function is thread safe, which factor determines whether we choose on
stack value or static? Any reference size? It looks currently we don't have a
guide line for this.

>
>
>thanks,
>-- 
>John Hubbard
>NVIDIA

-- 
Wei Yang
Help you, Help me
