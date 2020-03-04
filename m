Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA970C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B315E20637
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2VeURZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgCDQsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:48:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729573AbgCDQsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583340495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iwh6ArBhNlC/QzZYMfW6WQM30EkgNyAS0AeU4Ro9sDY=;
        b=g2VeURZW/M7CI/argwAv1Gf7LbMF+2h7wGRLMVsIppHFNlfIN3Cc1GHiMzGmdTdHJ3CRd8
        00R7E1Cn3THrbyx7ntozKOkhNm9irzpFl9DYTqbvQ01MIr1/0SBcliSg1SeNHzHNvqES+/
        eTAJBw3cxDeC0EYM+Nir6Dyv0l7yyfU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-t2owdTvEM_eMOjjjGl684g-1; Wed, 04 Mar 2020 11:48:11 -0500
X-MC-Unique: t2owdTvEM_eMOjjjGl684g-1
Received: by mail-wm1-f69.google.com with SMTP id w12so770559wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 08:48:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iwh6ArBhNlC/QzZYMfW6WQM30EkgNyAS0AeU4Ro9sDY=;
        b=Y96sej24UV7hrr+9ESHaHTzCutoW5+NtrOnZz6gwk/J+GGEcdcXoNlvTMSxnf+C2Bn
         UIA8g4ZZvUvqjSlYISLBQ/qxkRZqB7bxj54Co82WJT4+jiDV9YDV/3pczg1EKmBPtach
         TsbB2EWGDEve5FjQM0UupZDdnr5IC5Ehf0m/am1//p0todaPSlfBP5WxFJVg4Jd5GBpj
         T7puYseLb3CE088InUmH6tLUmEz2YMNjhDPWk8YVS3BC/clTWOAGeMdvcwkQ8imY0ism
         uDG5L1K39dLl3d8BSiHFa1V6JCIkXpdpXGYIyqw5BT+LXgEjjQVmpGuJrfzR5TqYm4Tn
         cOyw==
X-Gm-Message-State: ANhLgQ1aRvoahZRCRoE51svLkCwAAzbXQwBbBHP8m0h1Pi0sYw2qfq8Z
        yN8nJF8Elmic3WoXT1YIAHPGNN+Ew2F0bHjOJGfYaBCs7myiVS/rUw36F52QVdDQZc9s6yytCHu
        ONu8kS3B64cYm2aiq5JIAu+T+
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr4326638wmi.108.1583340489629;
        Wed, 04 Mar 2020 08:48:09 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsNyLWu0uFAuo01q9LkN1pw0Tdrpz/UjV74a4G/Kr0JlmOeAm6griIqJdEVFCpIlrxATT+Wuw==
X-Received: by 2002:a05:600c:20e:: with SMTP id 14mr4326621wmi.108.1583340489391;
        Wed, 04 Mar 2020 08:48:09 -0800 (PST)
Received: from steredhat (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id n11sm6627994wrw.11.2020.03.04.08.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:48:08 -0800 (PST)
Date:   Wed, 4 Mar 2020 17:48:06 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] io_uring: Fix unused function warnings
Message-ID: <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
References: <20200304075352.31132-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304075352.31132-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:53:52PM +0800, YueHaibing wrote:
> If CONFIG_NET is not set, gcc warns:
> 
> fs/io_uring.c:3110:12: warning: io_setup_async_msg defined but not used [-Wunused-function]
>  static int io_setup_async_msg(struct io_kiocb *req,
>             ^~~~~~~~~~~~~~~~~~
> 
> There are many funcions wraped by CONFIG_NET, move them
> together to simplify code, also fix this warning.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 57 insertions(+), 41 deletions(-)
> 

Since the code under the ifdef/else/endif blocks now are huge, would it make
sense to add some comments for better readability?

I mean something like this:

#if defined(CONFIG_NET)
...
#else /* !CONFIG_NET */
...
#endif /* CONFIG_NET */


Thanks,
Stefano

