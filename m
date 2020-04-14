Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351C8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1087C20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586872544;
	bh=+J2f9KdDNgTVZtbleTkNmcNiPRwoBR610Xf6hemYWzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kL08AfU6Pq+cIKcHmk0Cote34l7z2SoWOm+P/csNO/Ei1dVsfAyjpy2XqGqW0MIfz
	 X08TwjwYN8TVHMU2AmQvsObsD+1WSmsaE7MDpQR59h/sXX+12RdOwf1k0U8xmQQC8q
	 bt7bDod3vqSbMI8JgB+cc2vrgX8tnkbq4gDXHPVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388384AbgDNNzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 09:55:42 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33315 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgDNNzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 09:55:38 -0400
Received: by mail-ot1-f68.google.com with SMTP id 103so12854949otv.0;
        Tue, 14 Apr 2020 06:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MPnBVuMb9gERNtPk1qaCs0pkeSDmOcTJZhbSPaMIInQ=;
        b=tHTCJMkPAo3bZ09ydcX/+1SDvg8rD64QpQQJBbbO0Dp2Bqb5y1RiYUB9VROWj+nrGo
         TWeohppU7mOB9OZ6XrNdbltPLKZO0mYmsIcYutoY5/gtOy5pcif9pQi02H8171FhdYSp
         Fj7dDuH1eAwNFOH5R1+FS/1mlJ7i90BUGJ20ZVO/jlxLzKXUl48/oLrNZoh6kgvE4bGh
         nkU7/HUAoH6UC+26/J0V61PfAikebw/QUMLV6ThYe0lj6bg0p2xY0FvIi+JCJ1jBhBwH
         y8z7KhGa8So6cLvxJWyjRg6H6TwX/PCRfv3vQQ2D88oWGt7iwY5bQKKOb+oOytJw4i2f
         64Gg==
X-Gm-Message-State: AGi0PuYcFiyYeRABKYf7iiJGcty9IbPWXVBnscQ2z7sdYo1qMIHe/ouk
        Q7Awd3/dgvkHpk77HsboMg==
X-Google-Smtp-Source: APiQypJyEmmSmrZw1imbtJEg7HOnNBo7KdO2HJ4aRVczpnTT3rEGdeMvfO3dmGmCaFLZv459u6BWYg==
X-Received: by 2002:a9d:c61:: with SMTP id 88mr19218457otr.144.1586872537121;
        Tue, 14 Apr 2020 06:55:37 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f26sm4128832otp.28.2020.04.14.06.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 06:55:36 -0700 (PDT)
Received: (nullmailer pid 29325 invoked by uid 1000);
        Tue, 14 Apr 2020 13:55:35 -0000
Date:   Tue, 14 Apr 2020 08:55:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Lad Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v5 1/5] media: dt-bindings: media: i2c: Deprecate usage
 of the clock-frequency property
Message-ID: <20200414135535.GA29221@bogus>
References: <1586191361-16598-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1586191361-16598-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586191361-16598-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Apr 2020 17:42:37 +0100, Lad Prabhakar wrote:
> OV5645 sensor supports input clock frequency ranging from 6MHz to 27MHz
> but the driver strictly expects this to be 24MHz (with tolerance of 1%)
> with this restrictions let the driver enforce the clock frequency
> internally to 24MHz rather then being passed as dt-property.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/ov5645.txt | 2 --
>  1 file changed, 2 deletions(-)
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
