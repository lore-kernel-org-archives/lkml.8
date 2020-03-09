Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335FAC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0952D20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBKY5ixc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCIEP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 00:15:57 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43132 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIEP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:15:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id u12so4097757pgb.10;
        Sun, 08 Mar 2020 21:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jAoReLNBniwrpa0uZH66RQ2ZZJ/sNHlyqQJ+mmk89mc=;
        b=sBKY5ixcRQOrBOp/pyft+S4zvUPqjKpmc1HKbQidmstpOHLfoLeJUB1bAXwWgVi69/
         pj8YKammOpCOOeWyV1Xxbdv/T3MXi30h8eRzLa2mPwqNTAJb+gLZaopAGcW3uUeLI812
         dMdtMcbJQ8HRq2UZj1N1Zi+t69UXv6EIX8g1b7sTXNHHrmRvJ2kgfR5MqM/9Y1q8UNof
         uYQIYzxhqeBGzDigDR6Wn8ClhubyphvMXYhQIXuwUuo4ZO7FrS6xBMn+oQsK1fNrtVtE
         XddnpDf4RfwwEI/eLAd43eEaVqe2VOWsY1xL8HM6rHNTAq4TaJFBfX8Ext1Sr/dfMQDw
         xv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jAoReLNBniwrpa0uZH66RQ2ZZJ/sNHlyqQJ+mmk89mc=;
        b=ekDaYCDTwLis9hGBx0GI1oZB3anFtM2rY0IZtVQFQwPVBmwCSiJSY7IuBSbrktndc6
         bvbTZtMgMIJhW+G9KmJpo9h52oSYwRuGVOON6fY+RYCph17MfHof9Mo9sasI/BeRe0pF
         Y7gAmhwAFDVNzyYjZ/6EpA5QrNrPDbfXj5mH63w9aDQ6t6CABAQSkfZAilDTq8CsX5/9
         S2b0A4ekKwcW2rdUk1rv1eRajV9A7kS+JWfSl32O4ctRWrDQkUbrlGEu5K0J8nfYIP9O
         KLrtv8uPJ0xqovhyr7o/TtlpvnTlSYYy08Swwjo6pD/TQY0la4LMiAuepAuGwvZpart4
         duMg==
X-Gm-Message-State: ANhLgQ3E2T7ja8HMHbYfcBkHLvvQcinsnkksZkp8sCZFaFHt9q7CPGJY
        N2Kf3dpzRhWrJlJxr46UJ6o=
X-Google-Smtp-Source: ADFU+vthYSO4whGtyJkvhi5ehKTwuNj8TmTNW7ywtWsnfm7afsf05M5urNVmcZjEuJEY90+DirFWAQ==
X-Received: by 2002:a63:2701:: with SMTP id n1mr14600491pgn.332.1583727355102;
        Sun, 08 Mar 2020 21:15:55 -0700 (PDT)
Received: from localhost ([2a00:79e1:abc:f604:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id cq15sm16910709pjb.31.2020.03.08.21.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 21:15:54 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 9 Mar 2020 13:15:51 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Subject: Re: [PATCH] mm: Use fallthrough;
Message-ID: <20200309041551.GA1765@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
 <20200308031825.GB1125@jagdpanzerIV.localdomain>
 <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/07 19:54), Joe Perches wrote:
> On Sun, 2020-03-08 at 12:18 +0900, Sergey Senozhatsky wrote:
> > On (20/03/06 23:58), Joe Perches wrote:
> > [..]
> > > --- a/mm/mempolicy.c
> > > +++ b/mm/mempolicy.c
> > > @@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
> > >  
> > >  	switch (p->mode) {
> > >  	case MPOL_BIND:
> > > -		/* Fall through */
> > >  	case MPOL_INTERLEAVE:
> 
> Consecutive case labels do not need an interleaving fallthrough;
> 
> ie: ditto

I see. Shall this be mentioned in the commit message, maybe?

	-ss
