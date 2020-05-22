Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D49C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CE520723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 21:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgEVVZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 17:25:04 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45927 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgEVVZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 17:25:03 -0400
Received: by mail-il1-f193.google.com with SMTP id b15so12097803ilq.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTkSYFeyEICq4BQf/4yKxmOZ5ACYCOJzi1wgxve1pBQ=;
        b=dBj8Wm2yGF16aXN2JfhkbOds1j3w8eFtTpO4vZ8kTR+tL3b0KvZPsWqw/sYkVdZhSg
         sagO3u5uBi3vKxR0dRr0xlxJJEXtFlmRcBNMqR85v43Cy4mx7CQgmManiA2jiMlK2XwY
         cUXWhzg6Ixa1qp+lrSj1H2UEHohbOAWKMZQVAxWvEEeDpZcwp0nHOUZfNNr7gzOGJCDG
         0+kakvPqvWpyuFEzQvRvAdc4G69nVFF6UAvH6tp2WBIt/pwriRoKnFHz1HfJJoUiu9UB
         dp3dyORGgsJQCafCe2r9o6PGrWXQUaTh9xktkeu3IBf7Fu/+8RQbbLlOdyxnMn/6ghSv
         KMEg==
X-Gm-Message-State: AOAM5309bTrFXdSxAoYja08f5VQjWd3iE481sAYr4CtYM+iPFeucdMKR
        mWCZUy0w5vBrl/F7fELx9l13n9o8
X-Google-Smtp-Source: ABdhPJyRblSRaDcvhjtXm0c1XfBEfConje3POtUZgsj8+Z+wnLOjcljYkjJDwMjggId+Vs4HXacI7w==
X-Received: by 2002:a05:6e02:788:: with SMTP id q8mr15055071ils.56.1590182701163;
        Fri, 22 May 2020 14:25:01 -0700 (PDT)
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com. [209.85.166.178])
        by smtp.gmail.com with ESMTPSA id j14sm4121104ioj.26.2020.05.22.14.25.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 14:25:00 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id 18so12159245iln.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 14:25:00 -0700 (PDT)
X-Received: by 2002:a05:6e02:54b:: with SMTP id i11mr7075081ils.50.1590182700558;
 Fri, 22 May 2020 14:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200507185301.GA14333@embeddedor>
In-Reply-To: <20200507185301.GA14333@embeddedor>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 22 May 2020 16:24:37 -0500
X-Gmail-Original-Message-ID: <CADRPPNQy5PE8vDLCu+XeZpXDab=OnrLcUjWG5F0=uy00QXOQnw@mail.gmail.com>
Message-ID: <CADRPPNQy5PE8vDLCu+XeZpXDab=OnrLcUjWG5F0=uy00QXOQnw@mail.gmail.com>
Subject: Re: [PATCH] treewide: Replace zero-length array with flexible-array
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 1:49 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
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
>  include/linux/fsl/bestcomm/bestcomm.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied for next.  Thanks.

Regards,
Leo

>
> diff --git a/include/linux/fsl/bestcomm/bestcomm.h b/include/linux/fsl/bestcomm/bestcomm.h
> index a0e2e6b19b57..154e541ce57e 100644
> --- a/include/linux/fsl/bestcomm/bestcomm.h
> +++ b/include/linux/fsl/bestcomm/bestcomm.h
> @@ -27,7 +27,7 @@
>   */
>  struct bcom_bd {
>         u32     status;
> -       u32     data[0];        /* variable payload size */
> +       u32     data[]; /* variable payload size */
>  };
>
>  /* ======================================================================== */
>
