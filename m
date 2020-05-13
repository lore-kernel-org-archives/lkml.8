Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4961D207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589382227;
	bh=B98Plu2qyaLo9Z01P8sgYXc8h5CXADLI/KZMyrxijQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R051GyQJSpdWzyDKxWYFrlEaa83+tN0v8xA63lxXTFHGdzDofrP4iVGulyh6VMlMT
	 LKB04I6uUXPUo1MEXWvUSg12LXPOFfem1qbO21ZJvmN5rEmpwmvRp+HsulJFSTg48Q
	 Lcn3DoyiUN4QzPzoBhU4VbL67rhIg/7JALziwh5c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389152AbgEMPDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:03:45 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33463 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729039AbgEMPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:03:44 -0400
Received: by mail-lj1-f194.google.com with SMTP id w10so7457458ljo.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHtiFD5v56mzUK/ohaUZXeJFXEarl7NanKdDOND7Tvg=;
        b=FZi6JIk0h8q6Sho5DlJRk+IaWtgNLqfBXUmbqob0cPaknK62m3cLJFpqz33GyBz3Za
         5Bli2dUuIVpSmV061NdbGTYzZazHpVuTquHVwBij22g+75TtvMVIU0y1rQolzwBM40gC
         oBKmNN4sWCXvr3lJxjqX3YY9p5KWO/+T7LpG7tumwP424b8ohXrPmbI3b3PqfO+mU2Po
         2/u5IjWCcEOeMNr8F6yu717ECx+jpAQpKF/47mXAKXjsVT1l9muAeMLhGQemWK4n2HjY
         Q+bAq4DuIVufTwamUh9lzaIV+mDOPE8ot+qF+cJvJS5gDjwF7vjT787YrEqFOapdbVSO
         fsDw==
X-Gm-Message-State: AOAM531oR1I23TGSN2uxS7nDCIVd6u5r31/AlJ35O+VRb2jIt83WVmx1
        y+SV2FHRrfINwp2uOjrU3KY=
X-Google-Smtp-Source: ABdhPJzEBxUN4whSR6fnt1OXSUxkaw4AZeRwwElMMAMzYZXYPEY7ZwQA6tYJGrWf2jBieosdpSLfyA==
X-Received: by 2002:a2e:b4a5:: with SMTP id q5mr18500430ljm.58.1589382221650;
        Wed, 13 May 2020 08:03:41 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id 134sm16212893lfj.20.2020.05.13.08.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:03:40 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jYsv9-0003I8-6i; Wed, 13 May 2020 17:03:43 +0200
Date:   Wed, 13 May 2020 17:03:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array
Message-ID: <20200513150343.GZ25962@localhost>
References: <20200507185318.GA14393@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507185318.GA14393@embeddedor>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:53:18PM -0500, Gustavo A. R. Silva wrote:
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
> ---
>  drivers/greybus/arpc.h                    |    2 -
>  include/linux/greybus/greybus_protocols.h |   44 +++++++++++++++---------------

I noticed Greg just applied this one to his -testing branch, but do we
really want this in greybus_protocols.h, which is meant to be shared
with the firmware side? Perhaps not an issue, just figured I'd point
this out.

Johan
