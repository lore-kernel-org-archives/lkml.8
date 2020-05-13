Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62524C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DA222258
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589381948;
	bh=da042dvjFglEnCYdXrHWi/dIwv4s5t63dZUnxpJqlls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kosDDWMRAGYeEMkmRUkMcqT11+8o9gj6gbEDtJ+weuIgL2vbDWlzeXNjihipZokNp
	 9ZZxIikzwLJmtkelMi8cH/ehs4dtZpri1T1sqXf0AU18ro7cywey9wcTQHhzPzjNAe
	 jp3bubsji3kuxumSPi+N+/1dUT7GihU84gpX5j5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387759AbgEMO7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:59:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40382 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgEMO7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:59:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id u4so13886415lfm.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 07:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iL+iME11hO6bGtb3yyMWmbiNkWR3O4AnVvbrhS/BUw8=;
        b=fEioLHIPSEFCADAcqq+QK8lnbYD2MU91sb54smy2/h4xGn2Wx0GTwAppbh5DcKwFoP
         2T7YFoNqlq5oaa3w2Vn5fXKCKQoZpwcnO88ea0OHyVQJxIBEcdmQ0HENTznJpDVP2wIv
         f6oJo8TZdgk5hDImgGDR5+evGuxCFaHRl/z5zxAyhlIFs/7+RuVt/JVMbzhSpgFjQW9R
         yci7hDxGNUFt3EKQCy5YwcV7fbNFzokn2GB92758JGIfl6M3KGIMwR0d2oL2d0U3hu9Z
         kFxKxc9E/rEMHNvv7lPJ6a6YgYukZtCdc3DYVWxjpZrUc86hxwxrxg2VBKbzR41BFLJI
         XDuw==
X-Gm-Message-State: AOAM530YJRyrDRDwXJq8c2i8wRRMNYebbBAno81G9YU5E2XTLhi6fttc
        yczM1bxCvEOvmOGwlobilbkVkfpE
X-Google-Smtp-Source: ABdhPJx+wapqIBPAYXfzXq5MdVRRVcYVn4AZlfytE1OpK8dYd0wsYu0B8eTaYQNIS9mUAE0CFPRuuw==
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr18425363lfq.127.1589381943574;
        Wed, 13 May 2020 07:59:03 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id t16sm17549985lff.72.2020.05.13.07.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 07:59:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jYsqf-0003GH-6N; Wed, 13 May 2020 16:59:05 +0200
Date:   Wed, 13 May 2020 16:59:05 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] treewide: Replace zero-length array with flexible-array
Message-ID: <20200513145905.GY25962@localhost>
References: <20200507185313.GA14373@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185313.GA14373@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:53:13PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Applied for -next, thanks.

Johan
