Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B1BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C96832065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595538532;
	bh=1QNGktzzDXW7iA21OjAPWe03EvWmJ49t19nWTtuo9Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vJVvbFt2i/bvtH1AYM5o/eaw2fnAZoXTM9LrDtiWB1bD4CjLEqz9cFciK6bFMjeE5
	 cXLiBEOel8+zl+nzpl9nElU4DSeVXMkdPd9ArAfSFCrVDpOLIsf6nwArhWcc+kAZw6
	 8UvMKA8a78e6GgJMkoWO7/gQUPy2h1edCu9IFh2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgGWVIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:08:51 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:45561 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGWVIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:08:51 -0400
Received: by mail-il1-f193.google.com with SMTP id b18so359983ilo.12;
        Thu, 23 Jul 2020 14:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2VZH35DZAxRu1oS4+i4xalpCsqsecoySSiZlMELJnnM=;
        b=P/fXSffMV1K3XObAUuAJJgfX2n7eWW8ZU+zPLwigkg6z3V/frB75DJK2A+AgxyMWu3
         1n+UtQFMJJOyRJZnm5hBGTxwuSqCVarZ97fPdfhtK5nPd+feDN74My8YzTkuoB9Yf6Tm
         rtHcqyGlcbS3XuoRCmxr0sSceF+rrau1+eot6owUZzskSi1KpYceofl23fOd1emj2P/4
         xFAricn99ZPuHCA2Y+/JgFgv6Tij+vcp0TEP5NySWMHs6ePdN0DdB0GGwDOmZwx0eUcm
         2dlJb+RtFB13aB1nfLFbuTza6IhIPo85NRxDnpsPiHL6hjQ71/o1Ko3qFpKYBnGVuMVu
         acfQ==
X-Gm-Message-State: AOAM530CkXpipQwEVNxJes4W65j7qIrA10DlDgFySSkT4iA5uvy4zzsm
        0zKBCEZEQNlFauFG5NQMC7EsIg6eHw==
X-Google-Smtp-Source: ABdhPJxZpIl6pBTL4WHNxrGxU8jZXWQ7Qf3Cvu5wBnHX10cKpBPsvdeQ/EcD+6EbXUrJP4UxylInSA==
X-Received: by 2002:a92:d186:: with SMTP id z6mr7241487ilz.227.1595538530445;
        Thu, 23 Jul 2020 14:08:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v15sm2146214ili.28.2020.07.23.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:08:49 -0700 (PDT)
Received: (nullmailer pid 862353 invoked by uid 1000);
        Thu, 23 Jul 2020 21:08:48 -0000
Date:   Thu, 23 Jul 2020 15:08:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH] dt-bindings: mux: mux.h: drop a duplicated word
Message-ID: <20200723210848.GA862323@bogus>
References: <20200719002816.20263-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719002816.20263-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 17:28:16 -0700, Randy Dunlap wrote:
> Drop the repeated word "the" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Rosin <peda@axentia.se>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> ---
>  include/dt-bindings/mux/mux.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/include/dt-bindings/mux/mux.h
> +++ linux-next-20200717/include/dt-bindings/mux/mux.h
> @@ -3,7 +3,7 @@
>   * This header provides constants for most Multiplexer bindings.
>   *
>   * Most Multiplexer bindings specify an idle state. In most cases, the
> - * the multiplexer can be left as is when idle, and in some cases it can
> + * multiplexer can be left as is when idle, and in some cases it can
>   * disconnect the input/output and leave the multiplexer in a high
>   * impedance state.
>   */
> 
> 

Applied, thanks!
