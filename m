Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB32C3B187
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 817952173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TLfPcGpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729380AbgBMBIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:08:31 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:35022 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgBMBIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:08:31 -0500
Received: by mail-qv1-f66.google.com with SMTP id u10so1882831qvi.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 17:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rPWtbPOf+zmqKHmFEjWSKMEjXX3MzzpX+LfgxnXJm0I=;
        b=TLfPcGpUd2v+Y0tPsIikeMxHkiCw5oLj7YW7L+1AWa89gQp0B/Nx1sjSbeWxOa6l7+
         50mhUFM32bSd76ZdlHchNCrfrLpX+987aoEfzKOKRwNwscE7hCMAyMg1U7aPqqLoUsAt
         8vIIlHLiOEj3LV1nTrkVU42sntMdrkBEoe1ewMQr3KfVbigwrY/6vY1ANVCKAmM6U0Hx
         DHI6AfbTIV6tDA+CaD1UrhH6dg+avvFNlTXXla1Zot7Z4g73i3FbKs+i1yWBbRy5USN2
         t3aKP5w/pmtQKAw2H4IMsTrr41a4DZNuBpMF3r748iNjscOs5x46On+N9AogDGgL2+p6
         A77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rPWtbPOf+zmqKHmFEjWSKMEjXX3MzzpX+LfgxnXJm0I=;
        b=fl6csqXex+zGq62RjQU3CSc/Q49o8oMi3hU0X6XykphEg4nC0jUKQIhu2LswpIWSzd
         VPL+tpHnywauNVAqQriWOcuQcchc7dl27Vsg1BJROWJTdcMHTTaRaaIs72yJLd6cRyy2
         kuZnONWt9oofiIS/kF8QOvcO8huJq1w8r8AZuHKYJMPbhDJswSy+x3nBZGD0rOU3TT2N
         ar0Forh2ggfDIoG9P4BxAQDtCZRawxXga0FGR6cUs+Tf+lyS0wPzaWGIHMglcgXs+KxL
         NtPTUcFvyUzRpKaZX2W86rpTRYwDwNVQ4SGw0VzwClcAafgapq2Y+U4HCYHZQPHQ73IB
         xzgQ==
X-Gm-Message-State: APjAAAVXRH27azOy72ynghZdMb+hfkg5RvwS5C+4G76aVxoHCeJ6JtGb
        JSWLqofMbkQ/kUGfAstn93MYww==
X-Google-Smtp-Source: APXvYqw48p3Myf2u/dNCKpQus1lPsVUmB4/5Rgp+Kw/YAKwIdSQ3Ojng4RWLxZHu6NPXKSW+rS2Vzw==
X-Received: by 2002:a0c:c542:: with SMTP id y2mr9419698qvi.225.1581556110111;
        Wed, 12 Feb 2020 17:08:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w2sm542335qtd.97.2020.02.12.17.08.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 17:08:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1j22zT-0000fU-2P; Wed, 12 Feb 2020 21:08:27 -0400
Date:   Wed, 12 Feb 2020 21:08:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core, cache: Replace zero-length array with
 flexible-array member
Message-ID: <20200213010827.GG31668@ziepe.ca>
References: <20200213010425.GA13068@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213010425.GA13068@embeddedor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 07:04:25PM -0600, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There are many more of these under core/* care to fix them all in one
patch?

Jason
