Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1700C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFAED2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cQ+NRduO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504865AbgDNTf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504805AbgDNTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:35:26 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CBDC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:35:26 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 71so11230072qtc.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OXJFZbYBpiO58VUw07gYc4E/OSY8mUkuPUysvFQz2V0=;
        b=cQ+NRduOwAzvm2yDJN6zTbfsK8uOlb1aGIZE4Rc/HmJs9v1y/Y+g6AiQBmU5IUy32c
         RYMD7+e+H1X/23KXbEUYmLDfQGeRzDjoxcCCk08Y6ZbY4+g5OhQvPZEeWE6rJ+KctOoU
         hrOYCozcPd7hx7RgvBIF5nNkhWVOu36xMhQwa/68+sEu9iyeobI2HRYNM+PHxruCZ7dU
         z87qZOb7q2rYKTt4kqErEnVH2ySKdULeHkv/q88foeBc4Y92zQCUkNG0XH8LNqY/s3dl
         gvXnLkr2yryNImzCFGmFYhZtUKDmzpypX0wEoFa2pKEN80h4oWvdRVmeSdMgreqns+Rt
         /+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OXJFZbYBpiO58VUw07gYc4E/OSY8mUkuPUysvFQz2V0=;
        b=UB2FPcdpsT7/y/XjYMGGqD0AMw2jveaVQ3nxRV6091CtY4KG2cQ3ETlyw6FwLeMj5I
         WvRZ8lYnWglw5V7R+YtBxvwGG16AlLBXSJba7JT9zYln/N1n3W//5wi26VqnIf2Nm+J3
         OUnSFIrwcxV8j4lR0kQVqnuUH0CoCyLujdk3BioES05/86RI1w+i9gt09luI4GEEfnrs
         y2eqdvlNdOEaRGbGF8Gofzvase5z/UZscUtsPgff0/L7ie/e8FAf0nZUVk1nHYXyU6Rx
         3qojGdZj4DwOhFKjXKvKU+f7XIelNC5vwJ3K9FrsVbK0C3psRMdTD58l2P/CjzfUt7C8
         PM2g==
X-Gm-Message-State: AGi0PuaYRvacSorTy/ahpH7+3a2sP654Y6Weqx1T2Pq/eNKsM8XafUpX
        Q16Z24UU0bXL8dDh5NV8EAGr5Q==
X-Google-Smtp-Source: APiQypLS//lWANiI1tO5rY6sUH89pCMuYW1DdkcAUQi3ikXObHpKKCSfGooh8Lyi/XQAWLm9n1+W+Q==
X-Received: by 2002:ac8:1a8a:: with SMTP id x10mr17535588qtj.154.1586892925288;
        Tue, 14 Apr 2020 12:35:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id 28sm764089qkp.10.2020.04.14.12.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Apr 2020 12:35:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jORLA-0006rU-Ew; Tue, 14 Apr 2020 16:35:24 -0300
Date:   Tue, 14 Apr 2020 16:35:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
        dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] IB/qib: remove unused variable ret
Message-ID: <20200414193524.GA26198@ziepe.ca>
References: <1586745724-107477-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586745724-107477-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:42:04AM +0800, Zou Wei wrote:
> This patch fixes below warnings reported by coccicheck
> 
> drivers/infiniband/hw/qib/qib_iba7322.c:6878:8-11:
> Unneeded variable: "ret". Return "0" on line 6907
> drivers/infiniband/hw/qib/qib_iba7322.c:2378:5-8:
> Unneeded variable: "ret". Return "0" on line 2513
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/infiniband/hw/qib/qib_iba7322.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
