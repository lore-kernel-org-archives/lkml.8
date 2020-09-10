Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319D0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8DC221E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J6v0x4H4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgIJVgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgIJVgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:36:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50D9C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:35:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so10871110ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdtUto+8UVa+utOykTSZtVbT+HAuZQ1RHs3Ji6ziDM4=;
        b=J6v0x4H4AlS7GM1DTSncQeQVHo5LjwGEVBL75InjolvlYUGtT6xNx3thTQr6DuaMag
         hvMHqqsGaDS+Wgewib+ZgUzn1JVPSEgcvR/udk0buWBUATjUrNO3lT6LFPlqY38aJlSI
         5mSssQKop+Zk01z+f+9O8RCG38FSgXlXy7vODJlwioZoxe353iaVptkoHs2fupw7krbX
         rDgV71uRspd5Gl6rsEfYHYC12ilu7s96YIjrRANdkgEPoPYhC6sBd+/I0I897IpolfWm
         pJPEm46EuUvdtcWzKs1Ql1EMLXtB7jpXROwgWbMQW5jg8OBkJY6aq3HErBL8wGGcUArY
         HWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdtUto+8UVa+utOykTSZtVbT+HAuZQ1RHs3Ji6ziDM4=;
        b=QI6eRQfxlzzWNFxw2cwDjdGeO3QUFDTqO899kcx5/FDzISVnUIrSTn9nI7jpYnadJD
         DC5LE8C8SOg/FK/blNhvykrPI6oke7dIkItKU2r6W3vW18afou/csuLOu69X2aJwyWe3
         zWf9VGTGi24eDhrdvoBYc5xOrA4WzG97aFNHkvHszUXnmpKpZBQrz65IXKQfvJRRP/GS
         pKccadt4s3CfQYb7Nn15BAoemEuC/Pz7kOqCUAuQshCis0n6uKS69uYy+hL9LTvXeeW3
         lSMt8NzmYFwNCWE5f7pzwdWTOXXvtfOjZ5B20+VWh3hZITxFHll9gILcu5j1Mw6rYOtA
         SOyw==
X-Gm-Message-State: AOAM531L/R5D48KyPUSoDfFmzij13JUqLJOHZKMuhTdNa0Y6eAUSoFLC
        q5lARG5wqvhNmegWpNeNBIXcxny6urrirpixLUqMZQ==
X-Google-Smtp-Source: ABdhPJy1Ak3QJSIu8NxHxo3J0ITswUZlpAfKZRfg4oOneT5cmIRFzUVld6KFQE599iv5QEcUkm3ey9iJMOG4Q5PIaIY=
X-Received: by 2002:a17:906:b156:: with SMTP id bt22mr10802676ejb.481.1599773754039;
 Thu, 10 Sep 2020 14:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200910151221.751464-1-colin.king@canonical.com>
In-Reply-To: <20200910151221.751464-1-colin.king@canonical.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 10 Sep 2020 14:35:41 -0700
Message-ID: <CAHRSSEzAtyDpR6xRVXyaDzDyBV3CvyiezSSK4hGU9BdbvJYiHQ@mail.gmail.com>
Subject: Re: [PATCH][next] binder: remove redundant assignment to pointer n
To:     Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:12 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The pointer n is being initialized with a value that is
> never read and it is being updated later with a new value. The
> initialization is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 910c53ba2c91..2f846b7ae8b8 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -347,7 +347,7 @@ static void debug_low_async_space_locked(struct binder_alloc *alloc, int pid)
>          * and at some point we'll catch them in the act. This is more efficient
>          * than keeping a map per pid.
>          */
> -       struct rb_node *n = alloc->free_buffers.rb_node;
> +       struct rb_node *n;
>         struct binder_buffer *buffer;
>         size_t total_alloc_size = 0;
>         size_t num_buffers = 0;
> --
> 2.27.0
>
