Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9067CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385B1206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 14:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zjm0yel2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbgC2OKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:10:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37202 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgC2OKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 10:10:50 -0400
Received: by mail-qt1-f196.google.com with SMTP id z24so11636137qtu.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 07:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qAXQ/HiQQJ85V+1nD9jJqaE130Ux/3hBzkOcCll//2M=;
        b=Zjm0yel2Jw7jTKU3bc4UNvsjMN2aQPu2SlOdDUOt+SVb+avFdFgyIqswyY5/bJEGk2
         /+EK8LWWJudSJZ4XdVd7EonvXeRhxFL5kT4mKP7YzoRUbDhBnr8db/0r8Fxc544ijQsl
         f7NztMRGkOvhk2HnIGBbi6kLU7jwzw9pFjrVjCP26z8iYY14pjrg/j+rTWRnEj6AEVFF
         DGXzm4NlNzNWY9N81q5TbZsWoY/ZYslc69qYGAHWqw1YImbih41hWRfT84YF4zHkpN2i
         rksrGt5kMFSwaRCD6TVy/v52hdUuXlIYd80d14B18UgQmIV3+rBJMj67SUfx65BSrIA9
         jnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qAXQ/HiQQJ85V+1nD9jJqaE130Ux/3hBzkOcCll//2M=;
        b=O0mSw+45JLRiZtl669KT/DdGfGOlQEO99cKBlyBakdCLdcHPCdjcjTH10zKvarbGTM
         AM5CGOTIXbdoN39FlwiuFKB/CpHQ0SseoC5Ne+itwWr0h4ygkttpSqTX+V7S7CPmPhaR
         GIBv6YQJZe7megUGUKLR9SlZCz0OnStbhK+3Zl3xaHkxLf6S0hPTtJ0rmAgkBKBD45sr
         5bzplT0W0si37JpMqtmpTCZDPHufplIjh8DYUZyZ08T6ZOMyR0ZW0jiT7H2Gikb1fd5P
         5GGkCcMWdm45qDVLumzOKr0VThs1wSrBBtQ8+ZJIRhC0i6smqvSZt8zHDTlfgJdnMf+C
         6bKA==
X-Gm-Message-State: ANhLgQ0YAsEmWJ2ePfJR4t9+Nc+CtXC+WbHo1gEQvnSvHxv16idDjKUB
        HXudTg2hYPY8cF/tc5DCbCWnZg==
X-Google-Smtp-Source: ADFU+vv0q2VIaCAxj4AYUaHfb1fkd5WxnrWbtBWIvG4n74kX54qUxphTwUJ4W0FWXpjg+1BdOcz/JA==
X-Received: by 2002:ac8:39a1:: with SMTP id v30mr8004872qte.112.1585491049551;
        Sun, 29 Mar 2020 07:10:49 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c40sm8985301qtk.18.2020.03.29.07.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Mar 2020 07:10:49 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIYeG-0007EQ-IG; Sun, 29 Mar 2020 11:10:48 -0300
Date:   Sun, 29 Mar 2020 11:10:48 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Xi Wang <wangxi11@huawei.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/hns: Fix uninitialized variable bug
Message-ID: <20200329141048.GA27740@ziepe.ca>
References: <20200328023539.GA32016@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328023539.GA32016@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:35:39PM -0500, Gustavo A. R. Silva wrote:
> There is a potential execution path in which variable *ret* is returned
> without being properly initialized, previously.
> 
> Fix this by initializing variable *ret* to 0.
> 
> Addresses-Coverity-ID: 1491917 ("Uninitialized scalar variable")
> Fixes: 2f49de21f3e9 ("RDMA/hns: Optimize mhop get flow for multi-hop addressing")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Weihang Li <liweihang@huawei.com>
> ---
> Changes in v2:
>  - Set ret to 0 instead of -ENODEV. Thanks Weihang Li, for the feedback.
> 
>  drivers/infiniband/hw/hns/hns_roce_hem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
