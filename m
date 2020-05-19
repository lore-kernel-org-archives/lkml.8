Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7152C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C8A20709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jGdRfWOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgESXwe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgESXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:52:33 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391CBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:52:33 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i5so1794893qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0w5Q0s8R2YEA3g1NY8XrirtV4Lvn0PXi0qUKfjx3g8I=;
        b=jGdRfWODW/6EjBqooVOhtZrJh6yxWrpPId4S+vwSV/ouSCf853YEfbk7nnJEzfRP9D
         OJYu6vayBWJBkcm1NUWfQMVQDwvSpNUvxcwPnoP3QkpUmF+PSC66htu0+V0HiWLXpWaK
         SvKJ5L7OSkHzBFtpx75tK8HW68Sq6teAhd9XZRxuVrdeFD/0ii9SBeghVb5WBbt3XHyd
         rcDWFEVu8E8INPSLr9llyaqc1LUnAsDvY3Q4LpNhYv3pp268dxKKuC6CY8gM6ha0k5J9
         ivrGgCTKUdreVEsLkKgB5lJSim+9dauzI07OE7lBn6/Zc0WW6ErIHjqVtKDqETcOgaqZ
         gGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0w5Q0s8R2YEA3g1NY8XrirtV4Lvn0PXi0qUKfjx3g8I=;
        b=JadR/gcvaefruwVv/UJMqC/vsJSLLa0fJQ9QqPgRjwktQGYRH6eGb2ULSy0IHRBnle
         g6FEzzdIdEWJUkmQXLn3H7jgWBbUdyWDDSMdTuJjW1UkKEWXOhlvhb+OiKMvGnQZ1H3E
         7wJtVzAAov/uaAu3D21bDXCX16OckcR/jA1fZ05bi7rWPl0PMFwoPEez4Pw/zX1usczh
         MCVJSlAJAAEGYRwbwk5vxtBV0noX8EgWyLwIx8Xzrqucoyetw3DoqyH4cDSOW5PNxJry
         Nl9tn1O8T5TAHJdXhXTm3hZuaa9i05V4H2S+5XP0CZLdsooEIFbt2X6FHRDHpiDkMkVT
         /A5w==
X-Gm-Message-State: AOAM533Gr1/O6jtDp/4WxZFZtmDBC9gNM2cya8CoipJLLs5oVXdrhPnt
        xk2U1pqmTe/k27HpNWbanT+5Yw==
X-Google-Smtp-Source: ABdhPJxEnvKvWp4JmgpC+vWG3nvTDPBBagW65uaps4SG5a24Zu4zPDQ8CAbK/+1jU8D7XBxg+INztQ==
X-Received: by 2002:a37:b144:: with SMTP id a65mr2023826qkf.462.1589932352377;
        Tue, 19 May 2020 16:52:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id y23sm1232277qta.37.2020.05.19.16.52.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 16:52:32 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbC2B-0008Bd-IO; Tue, 19 May 2020 20:52:31 -0300
Date:   Tue, 19 May 2020 20:52:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Bernard Metzler <bmt@zurich.ibm.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] RDMA/siw: Replace one-element array and use
 struct_size() helper
Message-ID: <20200519235231.GA31402@ziepe.ca>
References: <20200519233018.GA6105@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519233018.GA6105@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 06:30:18PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of one-element arrays in the following
> form:
> 
> struct something {
>     int length;
>     u8 data[1];
> };
> 
> struct something *instance;
> 
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
> 
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on. So, replace
> the one-element array with a flexible-array member.
> 
> Also, make use of the new struct_size() helper to properly calculate the
> size of struct siw_pbl.
> 
> This issue was found with the help of Coccinelle and, audited and fixed
> _manually_.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/infiniband/sw/siw/siw.h     | 2 +-
>  drivers/infiniband/sw/siw/siw_mem.c | 5 +----
>  2 files changed, 2 insertions(+), 5 deletions(-)

Applied to for-next, thanks

Jason
