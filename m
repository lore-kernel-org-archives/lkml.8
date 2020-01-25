Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA5C35244
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F592075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 19:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FYEqJiUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgAYTg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 14:36:58 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:35413 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgAYTg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 14:36:57 -0500
Received: by mail-yb1-f195.google.com with SMTP id q190so2861389ybq.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 11:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/jkLNv4P9QzsHvGacFj4paH67im03/BWQoVxLJL/l4k=;
        b=FYEqJiULsKV3rEyEmrBwJcJE+3Vaqqm6p0vO+jVSnT9LAeMG/c2SYbklbCnv3W0AA3
         fHGiFR71TW7rL6EenkNOGJubHSUzMWGr8H0hXiyJHWHxiBBsWhqCJjItr7aRmZDVWkUH
         eda5M71knTAVAjkNeJeW0fSogSiPEtEqBgKiz8wIcAU1N88gvcYaU/8hQBSRLd7LYgXA
         Ga2lR5YUMCrnqp6FjBUruin3YrLcWKwSgyvzik9HfKUVs8DqmqU1LWnGL7OLFQJB7ITr
         QGgkzBgewa3A9JeLWoNYncVD+bgadUCnVHalhGc/bMW/zx0CCSyX2P3ydh+PpZnVFxMt
         fYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/jkLNv4P9QzsHvGacFj4paH67im03/BWQoVxLJL/l4k=;
        b=sKdLRcRm09Efparg2INGZ+pYq9R8jiu24YoeJQApYA25W8h8C498GkQC+IBf2A5EZO
         66b3yXPYW6om87GTGNWljCCEakyB+QiI1F6vcbnVz0c1LvOmm8OWExtaCeW4tzg3skei
         Utc537s3B9rgvpBqjV8ugfiJ9eCV1jRxNd+YD+h2JX1yzxaTLyZYsfhgvXZXr317SfpA
         +oLjjFZFTtQQPzurn9uq0lr3gWEBZW5kbZhgNXX10WXjWLk38/zldrnh1zaymIUyoiFv
         Zi6/FI8pLsHhtoeWnDj4Q0EG95Iv3IT9B4/aYqWdTGF+MmoksxqXTzeZezYtpHiOnGc1
         uITQ==
X-Gm-Message-State: APjAAAUUwuuhEaZluENRuc8As342WLFxAXxqE3/OS1XXQGMfHCd2KH8r
        uffX+yGIwtPC/nj9TlJlUBecCzuEQI/Bnw==
X-Google-Smtp-Source: APXvYqwxNUIOOcm3QO0hrnxz+PMfU5VyAecAS0T8mroEGU6CHKYRBISgpz3GeZHwzJ8mh3eHX6guJw==
X-Received: by 2002:a25:aa43:: with SMTP id s61mr7054535ybi.407.1579981016669;
        Sat, 25 Jan 2020 11:36:56 -0800 (PST)
Received: from ziepe.ca ([199.167.24.140])
        by smtp.gmail.com with ESMTPSA id g5sm4455303ywk.46.2020.01.25.11.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 11:36:56 -0800 (PST)
Received: from jgg by jggl.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ivREi-00080O-F8; Sat, 25 Jan 2020 15:36:52 -0400
Date:   Sat, 25 Jan 2020 15:36:52 -0400
From:   Jason <jgg@ziepe.ca>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] IB/hfi1: Fix logical condition in msix_request_irq
Message-ID: <20200125193652.GA30707@jggl>
References: <20200116222658.5285-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116222658.5285-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:26:58PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> drivers/infiniband/hw/hfi1/msix.c:136:22: warning: overlapping
> comparisons always evaluate to false [-Wtautological-overlap-compare]
>         if (type < IRQ_SDMA && type >= IRQ_OTHER)
>             ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
> 
> It is impossible for something to be less than 0 (IRQ_SDMA) and greater
> than or equal to 3 (IRQ_OTHER) at the same time. A logical OR should
> have been used to keep the same logic as before.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/841
> Fixes: 13d2a8384bd9 ("IB/hfi1: Decouple IRQ name from type")
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/hfi1/msix.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
