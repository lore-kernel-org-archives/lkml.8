Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD67C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298AE2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 00:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="krVrVHtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEHAES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 20:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726480AbgEHAER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 20:04:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AA6C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:04:17 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id ck5so3636592qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 17:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2thaB8NuEajRNyAZPfj2ahshuNntoNHnFvdss0W1UZM=;
        b=krVrVHtWCPse14460tvZqXI94GbqW0s1ZjlGaNIV8uuD3N0NDhrRxkCvBWqjQNqLA0
         jCqs/OSu603ANt/nKyfGRwpC73aKWiiqQRWSUrnCZTSYcJxROvp59SUOaK1XOGv1nibj
         qoKZyYKqV8BZQw4hZt21PouoKPldpY4dQXhtxJmbqCZ1kfcgcuMBo3E4fXDMFtI9iIq5
         qjOgQtU5jpp9lmbUdZXhSmvSVXolkYzi8uJ2DxStsVWo2FLQ0n5GkO6eTsbmDykYy099
         3+vNanYafLz59aXcO5q3gIx9wDDuDkc6WH4JEN8vYPLE+hX7JIKuYADwCnHOdTWy7kPa
         u9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2thaB8NuEajRNyAZPfj2ahshuNntoNHnFvdss0W1UZM=;
        b=bB6cHQgzWfSMprcBznxmq9r+8UBCn66OY5ina3F+8oJlPyYuOoMPAYFasayOK/ZyUn
         C0HDdO/dGZgtNFoNJswHdwyjjjTg+5zsMBV35+knOztzYrJIgf+qPt56jxm0/bJFOaWm
         V6vdEaGRsD7Ar1c1CBWhgwZwL7YuVv41ZrpjDiK4zeXNJOidgs2AVFPfNUbC+XB70kvS
         6GeHo35s9Q/vfMHzbNFSq0C00KVmX3XnUtU/q16NjyWB/76DUZoLwIJl5Xb2pp0maMWb
         tRyYX1lP4CreMOHVaVDuf03FUG4Ra9jsiJZbgc9/4VJNg/yJCICMlMCyPQTxmNCYP4UW
         vwGw==
X-Gm-Message-State: AGi0PuaCnm0s8hjC1WjGWRhTpsjpw0HGG3y+38TGVOYpXSnjRU+SO9lA
        EgRHUMVNia5zV0dPfJCHp5LRUA==
X-Google-Smtp-Source: APiQypIOWSUwEdj/qgeHNzM9aQNKP6cGb0OMtCYmu0sroLLZqUodgxtmJH26nuxT1g/GP20i0tP1mw==
X-Received: by 2002:ad4:42c9:: with SMTP id f9mr118700qvr.228.1588896256353;
        Thu, 07 May 2020 17:04:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h188sm5476567qke.82.2020.05.07.17.04.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 May 2020 17:04:15 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jWqUx-0001Ul-Ah; Thu, 07 May 2020 21:04:15 -0300
Date:   Thu, 7 May 2020 21:04:15 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/mlx5: remove duplicated assignment to
 variable rcqe_sz
Message-ID: <20200508000415.GA5704@ziepe.ca>
References: <20200507151610.52636-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507151610.52636-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 04:16:10PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable rcqe_sz is being unnecessarily assigned twice, fix this
> by removing one of the duplicates.
> 
> Addresses-Coverity: ("Evaluation order violation")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/qp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next, thanks

Jason
