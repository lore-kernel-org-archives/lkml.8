Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A233C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF652071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 23:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HgbSm5wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgC0XSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 19:18:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33470 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbgC0XSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:18:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id c14so10151142qtp.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 16:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MGG7lhxqPUfoX/CdUu5BEJiilH1uyYDaeaayr1A0RMs=;
        b=HgbSm5wkygUE5rRWRF2q6521s/sFd9YNVFUGCQMJ/8Tay/o62ds9J36hBt+CRon0ut
         uHPBdVPCcHCQTvxi8xQc2C6mgBo1pAKkLno8XQ6TLdkRw2Kc8EGqPIuEHjNoUs6r1LIi
         gR58kKbSIphaaM7KzHlAC8JXn1bEQKzJyvf0BAlcGjcXD4IxS5cerQDZg4Ylt29dM7Gr
         GtRCK79wq307EBoGoGqiZgwcClg5J6pLZB73ObW12EEbBUe5Nm950vBMRe/DFGF0+8WL
         x5xBAnCzL/2nT2Qv1LRUZOseMlUjSZP/1KtrzNc7G9ODWgGxq5DDKp1E0bSQYUAZQ+Qv
         coTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MGG7lhxqPUfoX/CdUu5BEJiilH1uyYDaeaayr1A0RMs=;
        b=N2b9KhwFcSLWaXR5Myau4uBKSWKoCYcVL5wkPjysnTb8eSfsgx8hndTmRoS5TFTwxw
         949h5OzeaMrX8sNGExgkM4w+m40S24sstvM4+/oIVxNJl3GfqHfiKEHpXfDzK3Ye7W58
         ryoD1O8L42BU8R2WX4mxYTagy/VzoE5QN7mElbf0hWzRDvQ0oM8CKCfx3U01JAX0J6LR
         MkfxCnzuSsnwS1ej/LpimXQoKH03JyeIyXgRDr9C/uLbfmOjKEwgyfYssXMgn+2nnsl4
         1dXuQBKg7N018FjgbBpPKnwe+PrbqeeluMH7oAK9U2gBRj80STW9Op+Q29rClfrhANBN
         XVGw==
X-Gm-Message-State: ANhLgQ39HeuQiTl8jyzp2N2hSVLGHhQe+jpfhC7z4kFbM6ppRulSEDIn
        VT8xI8bhEpJYEuhuuUtOJha65Q==
X-Google-Smtp-Source: ADFU+vvvdlB3ZSJCZpNywcNWrCvmQSdlvNA+jBBCup/igZfiIspI/k9f3SSaxZC+TocDYVIbxM3xow==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr1755062qtj.243.1585351102025;
        Fri, 27 Mar 2020 16:18:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 2sm5687986qtp.33.2020.03.27.16.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 16:18:21 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHyF2-0002A1-HW; Fri, 27 Mar 2020 20:18:20 -0300
Date:   Fri, 27 Mar 2020 20:18:20 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200327231820.GA20941@ziepe.ca>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
> On 3/27/20 3:01 PM, Wei Yang wrote:
> > Since we always clear node_order before getting it, we can leverage
> > compiler to do this instead of at run time.
> > 
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >   mm/page_alloc.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index dfcf2682ed40..49dd1f25c000 100644
> > +++ b/mm/page_alloc.c
> > @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
> >   static void build_zonelists(pg_data_t *pgdat)
> >   {
> > -	static int node_order[MAX_NUMNODES];
> > +	static int node_order[MAX_NUMNODES] = {0};
> 
> 
> Looks wrong: now the single instance of node_order is initialized just once by
> the compiler. And that means that only the first caller of this function
> gets a zeroed node_order array...

It is also redundant, all static data is 0 initialized in Linux and
should not be explicitly initialized so it can remain in .bss

> > @@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
> >   	load = nr_online_nodes;
> >   	prev_node = local_node;
> > -	memset(node_order, 0, sizeof(node_order));
> 
> ...and all subsequent callers are left with whatever debris is remaining in
> node_order. So this is not good.

Indeed

Jason
