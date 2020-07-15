Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54866C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AFB8206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849556;
	bh=mVnkBfAhJ6FomVjxHOY1OyCTNAIYT/5UonrMuIScsJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HpeCwy1vmWQ2xSSOkdkQQSK1c9jBKfF72cRjebE3JRpqisy2mogSBeNzDro0KwiKa
	 9sTlThwrSp8zMfr43DkuRAgJdwd2RiKaopKDXhzbVKob7VlITh8radY81OiwEwWPMs
	 UeLv8HdJoezh5tIsIVhv/kZM/t/CzVm2rsDbN1Uw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgGOVpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:45:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33654 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOVpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:45:54 -0400
Received: by mail-io1-f68.google.com with SMTP id d18so3910271ion.0;
        Wed, 15 Jul 2020 14:45:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uTCKNrA40szb/yJmrWq3ey+AdiQAjiCsW6MNjx/ks4E=;
        b=G9Xf4tlySs3Ti6ixUYzhG491yUDxWJ+X3pczJOGHuL88TUMrCT3p8+0PC/i0NBID9C
         0ZLH0xoZcQI1uf15Yur5ECNwTSwh7r9CukHCe8P2HNfo7ifqWWJeQ3ZnlZPItoOjOK8i
         uq46gryBRdRzzNx08xnuHl8BckdQnn4ssGOCYcTV9bam2DsO0SLLDouOcOfZR4Ht2TZE
         k+wfDnD1aExiZTXoX+kY5MGxaBENYZ2I6d50Mv89Mixr6PAZMX+CH2F4uaDXUjHehuID
         5ILFqOdaGawhDGU91fCbozr5nl/kXnvh6FBlebhmFa1cgHtJKOgxelGgNxXsheKpSq4s
         FPXg==
X-Gm-Message-State: AOAM533yhC8EZmAb93lWuDLjJmng//Cy9YFcr1eT2GXkqlWAgAB49PTj
        Z1xoKYpok/abiDRJriLs/KpHUjVtxQ==
X-Google-Smtp-Source: ABdhPJyYNTJmcV2ZHEBtk6f0cCrE4qIzXSpkaMVmF4GV38KcS7lBiv8NNFpiUn4/cWzdpLNPDyHODg==
X-Received: by 2002:a5e:dc03:: with SMTP id b3mr1281748iok.97.1594849553618;
        Wed, 15 Jul 2020 14:45:53 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id d18sm1638866ils.34.2020.07.15.14.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:45:53 -0700 (PDT)
Received: (nullmailer pid 871406 invoked by uid 1000);
        Wed, 15 Jul 2020 21:45:52 -0000
Date:   Wed, 15 Jul 2020 15:45:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     lee.jones@linaro.org, devicetree@vger.kernel.org,
        support.opensource@diasemi.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Dialog Semiconductor
 drivers
Message-ID: <20200715214552.GA871311@bogus>
References: <20200705075542.22728-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705075542.22728-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Jul 2020 09:55:42 +0200, Alexander A. Klimov wrote:
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
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
> 
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See https://lkml.org/lkml/2020/6/26/837
> 
>  Documentation/devicetree/bindings/mfd/da9062.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
