Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947C1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AA4A204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598307627;
	bh=TspMQruQND82zkmLrx37GWo9wSohTYrMU30iWv32dVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8ckUgdE16qFRHcr5A+fPHmqNNhxVtb6WLEHRZGpO8jD2QYJtij11Di9+xF+bMHPJ
	 rx+mZfcynbf6Zp5rtxNvcKt+J+j2Wj8FFWlRTvyeDytsFaYP3zYIGb5qNq0wSFWIdl
	 5M+Wcmn/J0I21sT3vgvNoqIhqr4c5m1VOjFZN5QE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgHXWU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:20:26 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:44906 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgHXWUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:20:25 -0400
Received: by mail-il1-f196.google.com with SMTP id j9so8705136ilc.11;
        Mon, 24 Aug 2020 15:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0w69xLXRX2cuqy8PwcvPK4rswz8AxstRYcdWsnyCdmA=;
        b=dzve84Ej/WOJP8NRX7wjKEoLh5yWdESIApoNj/cB6JkmrebDVx3mYM53Z+qQALxH7R
         Ja/GRfPpX0X+UrdIOMPZEpAjw7riIBKqusJzQSISFaxxtZriCZw2xrvi1dzqSZ5NZzO2
         +sPUO63wEbEWOuH7mS+VyxxpR2V8DCHi6JYZFYmNR2N6jlyUPgYApJH9RwHkBB453oMt
         tT4L5yerfBLXaQOtKHVMuu0k5Hb+hV/k2Rqq5ErE/aCv0qMbfLchJJ6it3I+jfAkQ4bf
         yrgR20r/dZ62NGH5EJ86o8Zoh2PqRJNa3skOA+qJKGM9Fp80Zh4Wm4YfiZQxcbYUSfgq
         vSGA==
X-Gm-Message-State: AOAM531EEEI3lf0YB3B5e3Fh1MV3hlsJVWRPHh1avR1qXgTY+gbZhXMU
        Vx2SedShDNXy3cwnyOynBc8Ik214Ag==
X-Google-Smtp-Source: ABdhPJxzMDMMF6nPOlKvaw2WTcX5LkAjXE1Yqq4HUP/4S6BqQ3nLU632NSDshEZNOcpbstiGcm3pIg==
X-Received: by 2002:a92:b503:: with SMTP id f3mr6137211ile.222.1598307624686;
        Mon, 24 Aug 2020 15:20:24 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y8sm7204300iom.26.2020.08.24.15.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:20:23 -0700 (PDT)
Received: (nullmailer pid 3420535 invoked by uid 1000);
        Mon, 24 Aug 2020 22:20:20 -0000
Date:   Mon, 24 Aug 2020 16:20:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-renesas-soc@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH 1/7] dt-bindings: display: renesas, du: Document the
 r8a7742 bindings
Message-ID: <20200824222020.GA3420392@bogus>
References: <20200807174954.14448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200807174954.14448-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807174954.14448-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 18:49:48 +0100, Lad Prabhakar wrote:
> Document the RZ/G1H (R8A7742) SoC in the R-Car DU bindings.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
