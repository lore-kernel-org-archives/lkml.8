Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE22C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A13E206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595283738;
	bh=qjcQRF/PBQRL2smk1RBqjft2toPLNmBPT7JNPRu03LI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lrXHbURlswPedfF8WeLC1l/2L6FDnFH6uPBUMEHIAcYCryMuKYI/XOmQkSnSU0j0K
	 uEep/s3yNzHd22DYN239rTPEUnrqbrbZjazFWEsZbU3+9+KMlkaacnBc1/fPfA2hPI
	 4hI81j8B1mDrVexRMTNrRV67iEWpP2O/1fAd5guE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgGTWWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:22:16 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34933 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgGTWWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:22:15 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so19331770iox.2;
        Mon, 20 Jul 2020 15:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1TOa/60ANKufyEkSnLRxvVlSHtDFv9RQ3Ysqa0fln/Y=;
        b=P916qdXZzQjHYCcF2vk3DHbdWeHOx7e1Ck87lIIqaVKLyAWAv6NlsINe6A/QYhi0Ps
         gAgVI/6GQFvFncnre8UJrnMSLqU04rEjITvf8+XUBeWQvouDhoDgdaw5geB/W+UgUuft
         yTWvoXQvXHtwy7TlBdNuWn0qEY752suX4RJ2Tiv6OU/TM/rGRxCc5L4SfSryfiFp0IsS
         SsZQsuD82gieIH7+yuz5qiHjQdkuOGA/152OL9hlwj5FBoitkCpF0mSRx+3nM+K93Hem
         G0v0pDAGz2S4GoIOsuSFKI9QRLPzEZ57mzd2o5Kg+G1+NSzvl+K43NnpknRuPtYxPtpo
         iMww==
X-Gm-Message-State: AOAM532+ZmX+hBQPjLkTUQpAKM0GEA8BWT8kaRmNmh3JypQdXk6TKIpM
        JCvPChIWEJ65VgbRxa/6W0YR2Q89cQ==
X-Google-Smtp-Source: ABdhPJyJeCLpbJ6mwgxBthab2PyLawiy90UiXQqSNbmnm+A/l98UNK3qqZcteAfpD7RSr0XceYKj0A==
X-Received: by 2002:a6b:8e56:: with SMTP id q83mr25162174iod.61.1595283734976;
        Mon, 20 Jul 2020 15:22:14 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id u15sm9602118iog.18.2020.07.20.15.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:22:14 -0700 (PDT)
Received: (nullmailer pid 3056611 invoked by uid 1000);
        Mon, 20 Jul 2020 22:22:13 -0000
Date:   Mon, 20 Jul 2020 16:22:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     virtualization@lists.linux-foundation.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        devicetree@vger.kernel.org, jasowang@redhat.com
Subject: Re: [PATCH] VIRTIO CORE AND NET DRIVERS: Replace HTTP links with
 HTTPS ones
Message-ID: <20200720222213.GA3056536@bogus>
References: <20200709064755.24051-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709064755.24051-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020 08:47:55 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
> 
>  Documentation/devicetree/bindings/virtio/mmio.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
