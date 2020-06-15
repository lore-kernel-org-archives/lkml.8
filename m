Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2804C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF27E207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eWlnvOxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731376AbgFOSjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731366AbgFOSjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:39:14 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62762C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:39:14 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g18so13429610qtu.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B8I0m7QO2EsHmHEbaNmg1LU0cMkLA+PHBa4u0Nmnmbo=;
        b=eWlnvOxcru0L75I+4qv/8OYbNlG8YuBT4Gu+sDiUpPwgFyKe1ZeOkJHV6H8XGJRCI9
         UtzRh52j0YKsZExwLa7ZuV1Z96qg2J9jg+lBswWZpnyk5/EBfsZ0OGgBilm9kaaQaACn
         9jiVMzP7Vufkp60RbfNdeiyBiyEXrHGmM80UL3oyVF5k4ATPD3MKU8aCLACL+pGsuWmE
         /WgYJsJsBKhulZ3iCDkj4UXoXt0bX/3rNUc37tLZJY+RPGnEGdfgQDKYlISdgiBQ0nH5
         0PgniI8N9pigckAgx2CJgvZOrzQ1Ai/iOvrtGI8VWVwM0B0Yr6A8HXbkMo4+CYNdMmUo
         9Zcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B8I0m7QO2EsHmHEbaNmg1LU0cMkLA+PHBa4u0Nmnmbo=;
        b=sipm7+bsz+r7+HpXtFvEUQDpvjbukcQs2DinZMzab38cAYLIqiqX2OODj45uEBSGOp
         7iFmloEI3ev4aPckvDv09dI6qq44fdy8Q7lnDMjkn4erQFlgORK7dAFn+RJ2Y4/xcTUc
         Hgw5fpnYNRJHk76HJp0+Q6yt1tBI4TTWKlp1kHphmu7QWMcQGlSmlMBCJr0pIQOse4ma
         2+oIFCJsiYLp5UThodcgdVwhcyrgVDUqn2gmDv0ODn/5fEhXjIPUaY98SO6UHQaMbv+j
         IfmBb86vCiYTW5f1EUDGC0pFEv04+pFjFx0LKCYkqSmNVe5jQ0jdR1izAp/iiK0KZKD8
         5zyw==
X-Gm-Message-State: AOAM532NNT4UMr9MLOzPlrvgxX4gX4Z3oL+JiVPTJcjUltPGFc80z9rK
        8WtFtrr1FyeVqz1h3xCEpceZLA==
X-Google-Smtp-Source: ABdhPJxd0jQCbh7ytNk27pMD5nGFBIEilfvEopkBcZdlLFh/MISEKWXAO1ilvKClc6CkokzphV3Raw==
X-Received: by 2002:aed:21c8:: with SMTP id m8mr17571534qtc.224.1592246353470;
        Mon, 15 Jun 2020 11:39:13 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b26sm13479710qta.84.2020.06.15.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:39:12 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jku0m-008iiI-6H; Mon, 15 Jun 2020 15:39:12 -0300
Date:   Mon, 15 Jun 2020 15:39:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/mlx5: remove duplicated assignment to
 resp.response_length
Message-ID: <20200615183912.GA2078450@ziepe.ca>
References: <20200604143902.56021-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604143902.56021-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:39:02PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The assignment to resp.response_length is never read since it is being
> updated again on the next statement. The assignment is redundant so
> removed it.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-rc, with a fixes line

Thanks,
Jason
