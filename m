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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE81EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5122071B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhLwhXOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgC1A1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:27:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35028 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgC1A1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:27:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id f74so3718648wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LHi7DWQnn+e9a15gIK55uU0ddOdIii2CVkZfDdCDGw=;
        b=VhLwhXOBsuch1bQqvoTgNmV2RgWwgAOiNSPKmjAaqrtJMcSe9NnQE1w4AhXKOoGVBR
         dX6TP1+ZI17vPScGA2Pwb0GxgVJhC/wpDvI3r/z/uMRnMIj8wTC8cCR0y5mN4X0/kHf4
         TEUlKk1xsNssCKrUiQe4p1Uj7VlltSleAeY3SbwkkjC47ZbM1bDPAGT4ReHdqOgzW6Vn
         325KKR3X1Er7sMrNq1IVfSVpWKNhVA15Q7MCdUFDP0xkAWFEBE1XEpBLpVUHsnqS36MD
         b0BsKpWaNn0hlA0iFU0FB5SUMaF71xJKcGcUKL7voeDiIJmkZetcOzKRZFepPjewklA6
         n55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LHi7DWQnn+e9a15gIK55uU0ddOdIii2CVkZfDdCDGw=;
        b=KOhFFQiVZ27coEZiDpYJr1CP0SLDRj8SQe3/JI8Gc5GUW5thOy9S+bnJRMzGT3mawq
         VQFUl8FNp8mrZ8sa2CRr0X91Mgx5Jfflshp8h4rl55Sf+UNMd9Xx/a6TgEWPVt2yO5MB
         H4CXXx9sPROaimtV7PS6KM23n4OkFohXofsv+qnDNEaCRsNZpNMCAjh2XbnM4bbx9Pov
         aftkTej8p5U5QHWOMS/4SQ1nyfKCGn1omcvbJIHUQC8JVoE3686+9r23sL7TMXbsDoy3
         GAAjxM14IcjOR0lrAoxEHzKz4a/k62ifh67Nr6lPSWEnfFVOlVbAW7NfA+YFPhhU8f7G
         Yv/w==
X-Gm-Message-State: ANhLgQ2peoIGPXGsEsiwjj/FREmzL7A19mvzRJBbcC7UhNZTAzXx3lLM
        OckmDyF29cGd+275SYNt4JE=
X-Google-Smtp-Source: ADFU+vtIG7Lc9lszQ0dy68T428hPdPwxI+HkbxJRRrAs84A6Tgz/onIC2eYUhG3xQ14RpiNpkqvQyQ==
X-Received: by 2002:a05:600c:2101:: with SMTP id u1mr1339464wml.136.1585355227084;
        Fri, 27 Mar 2020 17:27:07 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id e5sm10019240wru.92.2020.03.27.17.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 17:27:06 -0700 (PDT)
Date:   Sat, 28 Mar 2020 00:27:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328002705.hmo4tikax66o7zo3@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200327231820.GA20941@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327231820.GA20941@ziepe.ca>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 08:18:20PM -0300, Jason Gunthorpe wrote:
>On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
>> On 3/27/20 3:01 PM, Wei Yang wrote:
>> > Since we always clear node_order before getting it, we can leverage
>> > compiler to do this instead of at run time.
>> > 
>> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> >   mm/page_alloc.c | 3 +--
>> >   1 file changed, 1 insertion(+), 2 deletions(-)
>> > 
>> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> > index dfcf2682ed40..49dd1f25c000 100644
>> > +++ b/mm/page_alloc.c
>> > @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>> >   static void build_zonelists(pg_data_t *pgdat)
>> >   {
>> > -	static int node_order[MAX_NUMNODES];
>> > +	static int node_order[MAX_NUMNODES] = {0};
>> 
>> 
>> Looks wrong: now the single instance of node_order is initialized just once by
>> the compiler. And that means that only the first caller of this function
>> gets a zeroed node_order array...
>
>It is also redundant, all static data is 0 initialized in Linux and
>should not be explicitly initialized so it can remain in .bss
>

Yeah, you are right. I missed the static word.

>> > @@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
>> >   	load = nr_online_nodes;
>> >   	prev_node = local_node;
>> > -	memset(node_order, 0, sizeof(node_order));
>> 
>> ...and all subsequent callers are left with whatever debris is remaining in
>> node_order. So this is not good.
>
>Indeed
>
>Jason

-- 
Wei Yang
Help you, Help me
