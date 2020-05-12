Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F15C47076
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625B320753
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RvG9v0Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgELT7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgELT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:59:15 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2876C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:59:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x13so5118650qvr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G0E+aRa/ZtrphMMA9D9NE7f6TBwYO8PfcdNUKK6vjxM=;
        b=RvG9v0Odg6qBR62ASTwz6eXPTa5d3e3jqj23LRj7mYiCspx8Lhv9J/F9/GU+RSWJQL
         S0KhpwyTD4SiCgCUZexbjIUqlPzB98A4q/sXuskbTx2ffJscPBmP0cZkBCA2y5RDLikg
         aD+zWPSUqEyeqDKtwhDXrB0ww6O9xn5elj19OD526q57VO4JrHUU8wHEr/TiYHz8QZOn
         zN6slqAJXqTj5IrE2+Rl+5b+SR6WrLwx3uGncejjsI6RsKekMylec3MPlvEUSgiFI4eB
         5pBCSr24/IjOGNt03rY6lioDEieojUiD9SLmPGjJxZPeFXk1hhij+bkjvr8LyRx4RMOB
         kRxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G0E+aRa/ZtrphMMA9D9NE7f6TBwYO8PfcdNUKK6vjxM=;
        b=aawIIaD39X1tMfzHSDxK0hypuy/olhfEHh9uI4bnYJpFMtdJsqtXFBCTrz4It2G5yZ
         7mRtq+PD3oVV0Q2VWlOBeVSuFUZhP/6URkjDQQTaBMMb+/htEJo99H3b8vI4wjb9fMLu
         wnsUQBRj+sNqrLjV/WAfKAEb4VndpQoxc5cYgc+uYl6chmiQtxJLjsWHdNEuhAxMBkZs
         qMDpZVxWBJl9gsLFrXthtaFN+uCuUfDvD0FDnICrYy6AFQhKefNIMnCyBB2niM8HTFuJ
         o1WWpcPbBXObci/fDNCdSJhv8BnC93EorxbcK6ETQQ6ezdKQrdTlLr3hr7f2WNeguJTr
         +uSA==
X-Gm-Message-State: AGi0PuYWQd58K79ZcbuJk0Z7JncFwl28nej50EaYaJ9W6EAjtgc5z5uF
        VQkxRP0+e3mkQ8VicP/NNz05tw==
X-Google-Smtp-Source: APiQypI4djh3JsPTXr1ZWOiJGKRTthks1rzNkpnJFW1YgbpflsyktHQNnCWGxvpkoWENatD9+/5s9Q==
X-Received: by 2002:a0c:9002:: with SMTP id o2mr22007639qvo.3.1589313554114;
        Tue, 12 May 2020 12:59:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h18sm5904214qkh.3.2020.05.12.12.59.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 12:59:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYb3X-0002ON-Vr; Tue, 12 May 2020 16:59:11 -0300
Date:   Tue, 12 May 2020 16:59:11 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     jglisse@redhat.com, Ralph Campbell <rcampbell@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mm/hmm/test: fix missing unlock on error in
 dmirror_migrate_finalize_and_map()
Message-ID: <20200512195911.GA9154@ziepe.ca>
References: <20200509030225.14592-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509030225.14592-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 03:02:25AM +0000, Wei Yongjun wrote:
> Add the missing unlock before return from function
> dmirror_migrate_finalize_and_map() in the error
> handling case.
> 
> Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  lib/test_hmm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thank you, I squashed this into the original commit

Jason
