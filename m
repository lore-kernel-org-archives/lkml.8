Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BF0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D1B32067B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c66p9MDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgE2SUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgE2SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:20:40 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA425C08C5C9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:20:38 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b11so2733404qtt.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ChhpnWyJyVmgjoRJH/BNQYkEfM9pIhC10bAvWTPw9XM=;
        b=c66p9MDvjQCkyYqa100k4vINobxzfBj3Y8NAHDbCTmPN2OlFwO9UjZ77O+0kLagv1C
         Md7C4SzY2b7uC2D0Ollg2/GVJ0OjI967BJktCv4ewd205aOc/ZIGMyhTyw19AEcuCO0S
         hZi9xcL3OGY1kMaCrZl5oWir32Fgyskj7wUy1mmuEMs7rI97GVNLZHIQgSqaWq3ElDRQ
         ljsVyrwbs5qw3W7z4DB9+VED2DPnrWttEuNcq5aXlIRM7y2rAYlbGWh5qcjNtWVc+eTf
         uhWW5roqtjd+1dFeF4gEBZk6o7adDpMnH0OIDkbv6TCA1Xt165RTNufO0FULaBbkEQGf
         1ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ChhpnWyJyVmgjoRJH/BNQYkEfM9pIhC10bAvWTPw9XM=;
        b=KGgYSerVK6VWftnB2pC4tw1pK6kTSS07TAQSlhX4qrOh/RyOJmJnjWQrHZmGyJ6e3Z
         nANu+XSHpOyHVbiT223G45ZVS0dlcE49aVM7JTONpLut9+HvCyl/Ii/tAR5yl6vukQ5O
         7qOifQHtClyuyjm5gu3aCkxJHvUIP2gC6rbCLKtXB/rgAwj+HbkKdn/fNj4agUMyrQ3d
         GZv83oYngLRD6jLt8lhVw9nKfegDZtw8kPZhWTWYhOTSuQNpp81Hr1lcifgAxLdsrM5R
         ksjTsTF4v7J1wCPlnW7Ht/tTg4p4W+dZH38J3GMF29EET9EzU2TJMhhQdMslduz/RzmU
         ydjQ==
X-Gm-Message-State: AOAM5304qmnf/HGZb6JATwULRFJX5vPCBuYsH4iwVczNJvKpLmLZPP5F
        eNc2+9B2nWIMkFPRRwaohDIalQ==
X-Google-Smtp-Source: ABdhPJwH+mpV+w1wzbF6SpCDz5Hec20m/pxhmwzvv09S/bv5dTD2l+BeoIE6q4qxus4G05ygIRJ+8A==
X-Received: by 2002:ac8:bc4:: with SMTP id p4mr10318652qti.72.1590776437985;
        Fri, 29 May 2020 11:20:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id v69sm7734321qkb.96.2020.05.29.11.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 May 2020 11:20:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jejcS-0002xt-Uq; Fri, 29 May 2020 15:20:36 -0300
Date:   Fri, 29 May 2020 15:20:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/hns: remove duplicate assignment to pointer
 raq
Message-ID: <20200529182036.GA11361@ziepe.ca>
References: <20200528150427.420624-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528150427.420624-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:04:27PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer raq is being assigned twice. Fix this by removing
> one of the redundant assignments.
> 
> Fixes: 14ba87304bf9 ("RDMA/hns: Remove redundant type cast for general pointers")
> Addressses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
