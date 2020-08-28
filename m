Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B6C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BD4720872
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PioKAFn8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgH1LkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729257AbgH1Lgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:36:41 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E561BC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so415702qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7gQIGUiMIeeIo12Il7bUrjYk58mhEZJndN/EWd9XYIE=;
        b=PioKAFn8fdNLwzxhcOWCr/lhW22EBcVyqYD2T6CTGQZkstnAaUdV1g6cmo/nDhzkFv
         8ivLGloms6Xx44/b/6rT4bCjJUK9+S0HHoMjMfHKpd9eyjbJ3KeKeiPMfDPweuUxJA4U
         N88wCwKGRIP24st+U/LnJWxvhuHvfLGiYqCrmiSaZJAmQZMxoTvUg4h5I9fNFX1Ta3pH
         QkfARA7GGBGCUF9YijF7xzszb2J62whoTNOleglB/edmTYLCnvEV2NtlX9JRvXrOEXsM
         H516mXmB8M2kkvhVWOZLpShcQV3/oUrbrp4eLw3zvTIDO7jL0TPtW8zA/y2UGZZjwRg/
         LUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gQIGUiMIeeIo12Il7bUrjYk58mhEZJndN/EWd9XYIE=;
        b=B+4EwUgJJ34YQ+GUIm62tlx+L6YHGdryMDxbiT5PNFarqazNxUOb9Yjwbql+C9N+GW
         c+QtAJKoRiMZtq1EfJHp4cvMuSCm+nU0q0/mApVCN4GXwk91hwY3LablJ/xcEpJuwGHU
         Isz2KNIsYPWt5ZVVYq30PqujDPm9bTyTeFoQQgm0R4M2wbkVzM+W7zHC9ZRr8Tcv6pLh
         9uofTiEiyoEUkz/0pchoI3sbxyqB8aEniUTkwq2XyBjUs0yBRvZr/TnN2f0ZuYLBFmeS
         eMIVoUrzmIRPFg5TOZjOtngsWTy6TNxjm9qxN6r6GdxM9eqbmyOZ/4B9udxwNbUVzqFl
         6MIw==
X-Gm-Message-State: AOAM530imw/K3wH6kNjAjDnrrWEDodZKpSFvrGMiDzDePwoHUK3vwaWD
        x4V3SLY7aVwXUIWAJAU+6X7YYg==
X-Google-Smtp-Source: ABdhPJzGPBju0yAnoEhn5EAXcBFDqYwo7FFOY5QZTG0TPwuwKj933CaIS8c3I9oJh+7hCv3p9iYf+A==
X-Received: by 2002:ac8:6052:: with SMTP id k18mr1060677qtm.60.1598613206205;
        Fri, 28 Aug 2020 04:13:26 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id i1sm447103qkd.58.2020.08.28.04.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 04:13:25 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kBcJw-000OQc-IU; Fri, 28 Aug 2020 08:13:24 -0300
Date:   Fri, 28 Aug 2020 08:13:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/test: use the new SKIP() macro
Message-ID: <20200828111324.GU24045@ziepe.ca>
References: <20200827190400.12608-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827190400.12608-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:04:00PM -0700, Ralph Campbell wrote:
> Some tests might not be able to be run if resources like huge pages are
> not available. Mark these tests as skipped instead of simply passing.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
> 
> This applies to linux-mm and is for Andrew Morton's tree.
> 
>  tools/testing/selftests/vm/hmm-tests.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
