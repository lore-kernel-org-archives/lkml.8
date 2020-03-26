Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D7BC2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F286A2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V3sdbZ6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCZWgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:36:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41892 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZWgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:36:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id i3so7036739qtv.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jcJBwUc87Jwe+9cOfSIvE+QFlU+cxqdBx8XRklms6k8=;
        b=V3sdbZ6CxWcM8nunlXYfN3PzwezVfPUPS8L7pO57bgPnlAU91nvRWM8XK+3SPNwiON
         tnUSf1pbWCI6eUfj02DGKhVs5M/0eK+Jsch78es8S4Jgcwc8DznGYN+VjyIXR6+eionk
         6/DDDlO0MLkmCm4mJUJN53NtmX7DTVvEReJ0gZhMbvli1NiAbVknnX/q8JG3uP6RQ6OR
         x3sK/AeBmf7KIOd/QoO8C5gA4IbLUx/Qq177dfBqTcGhnGey8X3wuC2TH/US4TTkER4S
         RroXw0XSM5PCgtMg7jesVPWuljoNrMM06/Wr5Y+H/LCdkTBVSsd7EGkDfkKMcn+FJzxA
         zwqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jcJBwUc87Jwe+9cOfSIvE+QFlU+cxqdBx8XRklms6k8=;
        b=QltEpbGAh0TcmotMHhHJVper+sKOMP9fl++Zrul+6rJVOesmSKF8RUFjPTGI5pjPCr
         2OzVarV77gimKaCpI+29OXW6/BPbLWMyBDBqGzJApCa3z2pY5Lz1tmykbLpdpIF3vVtn
         FFeiNW8HihMUB1uJP0btewk+yxCmSjTlMQR/G/w1h4VWLZxoW1Wt7ecfIr54rNlhKPHZ
         RPB0OgRrVSUy5Qye9EXWLuAQEDlXMnmYbKIGZioekT2KUr5Xh6mzPV1WIlWOjWB2D9Qp
         ZIK5lnHpDUEi2yq3fwuQUiLTNThRphGHYxj1wyPlaMyCj5sjSony+8E0d/H9nKsUAwSz
         X4rg==
X-Gm-Message-State: ANhLgQ0XBguyOaQGuKum3gXSe1JFWC1c5mM6Sh7kIiBrs7z392wplaDN
        fWGkrrqa3ax7oWhQLjzoq083hw==
X-Google-Smtp-Source: ADFU+vvN1aO/CdBkNZbFR64XEwxbdEc/AQl3mOpROijPvKW0dCXxErokR05tF2hQt4ClPkC3tqfHPw==
X-Received: by 2002:ac8:6697:: with SMTP id d23mr10956191qtp.8.1585262165441;
        Thu, 26 Mar 2020 15:36:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m1sm2571690qtm.22.2020.03.26.15.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 15:36:04 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHb6a-0003Z0-7r; Thu, 26 Mar 2020 19:36:04 -0300
Date:   Thu, 26 Mar 2020 19:36:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc.c: leverage compiler to zero out
 used_mask
Message-ID: <20200326223604.GP20941@ziepe.ca>
References: <20200326222445.18781-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326222445.18781-1-richard.weiyang@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 10:24:44PM +0000, Wei Yang wrote:
> Since we always clear used_mask before getting node order, we can
> leverage compiler to do this instead of at run time.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>  mm/page_alloc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 0e823bca3f2f..2144b6ceb119 100644
> +++ b/mm/page_alloc.c
> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>  {
>  	static int node_order[MAX_NUMNODES];
>  	int node, load, nr_nodes = 0;
> -	nodemask_t used_mask;
> +	nodemask_t used_mask = {.bits = {0}};

If this style is to be done it should just be '= {}';

This case demonstrates why the popular '= {0}' idiom is not such a
good idea, as it only works if the first member is an integral type.

Jason
