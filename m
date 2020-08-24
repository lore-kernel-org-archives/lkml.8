Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D58C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F11204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 22:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598307819;
	bh=yL8U6KMIyD+ubsTyIO4N/4k6tkPDXpBzxB3qaT1tFSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N6oF6n9y+IWB42enDvejld9uXfSGP/s02rYao6fOTRIFfVX8Nt8VrvD4T/ilfT5Gp
	 8/0aRfKAHFIovxJGl4DPB60PJLXSOnG1Z3+Q2h5B+k6hC1BdX5CjtbPfE0DpTpjkOV
	 DDyHkZXRZ4kPk0M3rR814CTixOOH6oQDbxPpnqOc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHXWXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 18:23:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33207 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHXWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 18:23:37 -0400
Received: by mail-il1-f196.google.com with SMTP id r13so8745131iln.0;
        Mon, 24 Aug 2020 15:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sxWoSiXfyNxC7RpNkWsYKNGkllX1hPdgCddbI6UFMS8=;
        b=CeHJeEtTcxpGTTy2e54I4FLE5vSCWulpbEDVU8HPhuwhTKLGMyLk3tdpoTRcXkYTsB
         Zo8kF4s6xZmdSO1wXubrRn3QMqc+5PIl1K1rbbsUsqkeSSLw4IYAEq1+/dIZxULeaDlR
         5P6ML+ckDp1FAFNfUorqQlRfhzUrYK8xBeXiSir2MiKpDlXqFWgGy7fdvLBAFTqcYOIM
         Ja8oLUGrNQF/3VSHWxTVFxY+IImASiFo0dtCRKtGZ8TmM3xLQ5dTkPyE3cAAj7mzYjDi
         6jSH9IzTP6X54NMd7CbQCg7G+698zVXitGj48315ZClsctAgk+eY+L9CeDPNtVlAcg4Q
         ucYg==
X-Gm-Message-State: AOAM5319UYGTgeDvvvvOFGhn99nsYBj0UsN8JKS+kV/qOysBIZ53Qc8p
        e6NLDJYorQDuh/KXSKC5ogIdHkCPkw==
X-Google-Smtp-Source: ABdhPJznOKZdKvAaryVXsQIpvkIsmCU7LK5fBX41NJ1Qm07XPJOu1Tb2fW0OF5VP6XC4w7/K9fuXIw==
X-Received: by 2002:a92:89c8:: with SMTP id w69mr6996316ilk.139.1598307816294;
        Mon, 24 Aug 2020 15:23:36 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id f186sm3428221ioa.42.2020.08.24.15.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 15:23:35 -0700 (PDT)
Received: (nullmailer pid 3425801 invoked by uid 1000);
        Mon, 24 Aug 2020 22:23:30 -0000
Date:   Mon, 24 Aug 2020 16:23:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iommu: renesas,ipmmu-vmsa: Sort compatible
 string in increasing number of the SoC
Message-ID: <20200824222330.GA3425741@bogus>
References: <20200809193527.19659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809193527.19659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Aug 2020 20:35:27 +0100, Lad Prabhakar wrote:
> Sort the items in the compatible string list in increasing number of SoC.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
