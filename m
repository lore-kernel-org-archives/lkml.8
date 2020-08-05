Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EA3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 065FB206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 10:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfeSwzoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgHEK0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgHEKUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 06:20:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA5BC06174A;
        Wed,  5 Aug 2020 03:20:33 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so39132399oik.2;
        Wed, 05 Aug 2020 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJBaD0dmpIwl3OFF62Duu8Al4BAy5YbR6DEHF/xlu64=;
        b=SfeSwzoCi3tpmcruq5SoKeynBD4KRVlFLiv9wybfEAtfk9c8P0v1zCN5l7MGCqUSip
         q9oQ/BdFpc9quum9EZuQ+pX2U2kZqoGNfQYTyn9e7gSlh1OMp2RstL9SS6qEKFi5xXtq
         Uioa3fwSJUl6Rp2jpogbvxltBBg3J1M0ZrbCKxiii45zFf2Fk+ndy9dPdSYTYKGQWVMs
         fBBnY1AUv1um/0l5Uw9CPA0CDlOaG8LLJ3cF+7o8xtV9mKJhABOSwaOqBc5P3nCbNDsV
         H8eB83Y9kOkHyrxpaa6zEUxlYLGt0ITvMtFd5kaHyDmBqRoG2SHc1pvg4727NrPkeERC
         wwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJBaD0dmpIwl3OFF62Duu8Al4BAy5YbR6DEHF/xlu64=;
        b=mGvpZiVEGssmxHCyCzk2UweM9uze7UhZDIxGUGIQ8aCPI4nsoecl6RqLHiiOOpNCS3
         oSEpqk10n3tUbWrk+vddMIRo/gPrgBBNNcVY6aGojKMAd/42mBS84bPjhGdZDhF88JQP
         QsC8Lf5yq5P5uXhax2HotEwHH/9oM/xUjoB9YFXfc4GiUHjVSIG9b0ERTCBrMTXGL+BI
         odED2HXX17UJKwPjWKD3Jqdwkjv3NBHdKe8mwmODoRTB2s9Dzbt/+/ioBAK7VYNYo8Q2
         yA8FvCSjM659VBE490+qlvlpVEAGpyNJoyG1hEWCVCMMiujepQRK8T4Y506HZ3NBv2ZD
         f8GQ==
X-Gm-Message-State: AOAM530itZdQZRmaL9MnVxZphGrJmVpEYsk3u72jChjVo0u7Xr5KiYXr
        VaIV10pVjQYZ2ZOFCHuouc5TF1VT9+RY51Z84XE=
X-Google-Smtp-Source: ABdhPJwlVue2/n0mFUlPdZw6GxjzkQ/SxIheaScbZLj4aaM7XovkgSn7XN9So3WKaM+AMmKtEMGADoKPrTrM3xCyk6I=
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr2184018oij.154.1596622830271;
 Wed, 05 Aug 2020 03:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200805095105.GA483832@mwanda>
In-Reply-To: <20200805095105.GA483832@mwanda>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Wed, 5 Aug 2020 13:20:02 +0300
Message-ID: <CAFCwf12iuz-q8U7_VEJvxKZpzfauKASjMDHOk7HMncuBnAyo4w@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: Fix a loop in gaudi_extract_ecc_info()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 12:51 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> The condition was reversed.  It should have been less than instead of
> greater than.  The result is that we never enter the loop.
>
> Fixes: fcc6a4e60678 ("habanalabs: Extract ECC information from FW")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 00a0a7238d81..de2f81b80ced 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -5215,7 +5215,7 @@ static int gaudi_extract_ecc_info(struct hl_device *hdev,
>         *memory_wrapper_idx = 0xFF;
>
>         /* Iterate through memory wrappers, a single bit must be set */
> -       for (i = 0 ; i > num_mem_regs ; i++) {
> +       for (i = 0 ; i < num_mem_regs ; i++) {
>                 err_addr += i * 4;
>                 err_word = RREG32(err_addr);
>                 if (err_word) {
> --
> 2.27.0
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>

Thanks!
Applied to -fixes
