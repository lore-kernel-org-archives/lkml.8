Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5BFC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48F722075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EB4Lvqc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgGML1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:27:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32776 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729715AbgGML1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594639629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NndF9MqDcvO4KNH3w4Ig8XfoceRFDUTb0+wABisiArU=;
        b=EB4Lvqc6e1NF8IVwya9HpaiiUsY7R84Wbq/hfHZM0+zEPVj4MvEdc2xVOhtvhqwb6pHvkw
        ZnE7HHi4vKdPoYKGid70k+p7m0rDKY41rUsctZewr1EPlsaOLTvVpUk5dcZGD6FtPoUf+k
        CrKW0jYCX5Ep1opgsx7ks2K2REssphg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-nyhzc9MkOkaGmQzc1wpoAg-1; Mon, 13 Jul 2020 07:27:07 -0400
X-MC-Unique: nyhzc9MkOkaGmQzc1wpoAg-1
Received: by mail-wr1-f72.google.com with SMTP id y18so17503159wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 04:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NndF9MqDcvO4KNH3w4Ig8XfoceRFDUTb0+wABisiArU=;
        b=feDMwvpJ0YFiOpuE3dMo9eNfjC3pWdln3Puutya3QjLDtGMLT3v+rdDKvZneMIgft2
         CGv7rX4HnDUNqlk4deZhLPjMMXU1Ntc0leMmnvEaRT0TVY9Wcogz/o5ITVT4SqqWcrJJ
         OKKKh74pJ3nIqBUGTfCE0IeMZajm7cR4KTb5+Kbsw4uSIkvq0vaJcC6b5rkKFxVuOezo
         X1lzkQJRssM6DY+t3O6vDYb7CUBbxJrFrOYrK7cK9awirD0QpYNNmRVXZuVSHm8/lef/
         x6z5F2TIM2sExot6uGXNpM5y04hnbMeXxPL0yHlchdgZoLXTOuAOU8uGtXLVS9DJnu/B
         MY5w==
X-Gm-Message-State: AOAM532YtNMJyDYzOuHa+0SbgfYtUm67I4+qLBeT1p8gGRRa3IBu380g
        NPFC8CG1iYGYMbsOxeiz57vqajCsEQdCJIntHya0Y4ts35Gderzo8bKPX6Dr+xni89bps0eBIwp
        V36USKNxA42ZUEdI92mpEqaWV
X-Received: by 2002:adf:e40e:: with SMTP id g14mr85945111wrm.271.1594639626487;
        Mon, 13 Jul 2020 04:27:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoQoJFGLmA7IKeh1vfhF4LpR1itbcrQH3486CQtGPbzU10VTecZ0k8Yt5A6ZRHstGlY191xQ==
X-Received: by 2002:adf:e40e:: with SMTP id g14mr85945083wrm.271.1594639626252;
        Mon, 13 Jul 2020 04:27:06 -0700 (PDT)
Received: from redhat.com (bzq-79-180-10-140.red.bezeqint.net. [79.180.10.140])
        by smtp.gmail.com with ESMTPSA id z132sm23730810wmb.21.2020.07.13.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 04:27:05 -0700 (PDT)
Date:   Mon, 13 Jul 2020 07:27:01 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel-team@android.com
Subject: Re: [PATCH v3 07/19] vhost: Remove redundant use of
 read_barrier_depends() barrier
Message-ID: <20200713072618-mutt-send-email-mst@kernel.org>
References: <20200710165203.31284-1-will@kernel.org>
 <20200710165203.31284-8-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710165203.31284-8-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 05:51:51PM +0100, Will Deacon wrote:
> Since commit 76ebbe78f739 ("locking/barriers: Add implicit
> smp_read_barrier_depends() to READ_ONCE()"), there is no need to use
> smp_read_barrier_depends() outside of the Alpha architecture code.
> 
> Unfortunately, there is precisely _one_ user in the vhost code, and
> there isn't an obvious READ_ONCE() access making the barrier
> redundant. However, on closer inspection (thanks, Jason), it appears
> that vring synchronisation between the producer and consumer occurs via
> the 'avail_idx' field, which is followed up by an rmb() in
> vhost_get_vq_desc(), making the read_barrier_depends() redundant on
> Alpha.
> 
> Jason says:
> 
>   | I'm also confused about the barrier here, basically in driver side
>   | we did:
>   |
>   | 1) allocate pages
>   | 2) store pages in indirect->addr
>   | 3) smp_wmb()
>   | 4) increase the avail idx (somehow a tail pointer of vring)
>   |
>   | in vhost we did:
>   |
>   | 1) read avail idx
>   | 2) smp_rmb()
>   | 3) read indirect->addr
>   | 4) read from indirect->addr
>   |
>   | It looks to me even the data dependency barrier is not necessary
>   | since we have rmb() which is sufficient for us to the correct
>   | indirect->addr and driver are not expected to do any writing to
>   | indirect->addr after avail idx is increased
> 
> Remove the redundant barrier invocation.
> 
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>


I agree

Acked-by: Michael S. Tsirkin <mst@redhat.com>

Pls merge with the rest of the patchset.

> ---
>  drivers/vhost/vhost.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index d7b8df3edffc..74d135ee7e26 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2092,11 +2092,6 @@ static int get_indirect(struct vhost_virtqueue *vq,
>  		return ret;
>  	}
>  	iov_iter_init(&from, READ, vq->indirect, ret, len);
> -
> -	/* We will use the result as an address to read from, so most
> -	 * architectures only need a compiler barrier here. */
> -	read_barrier_depends();
> -
>  	count = len / sizeof desc;
>  	/* Buffers are chained via a 16 bit next field, so
>  	 * we can have at most 2^16 of these. */
> -- 
> 2.27.0.383.g050319c2ae-goog

