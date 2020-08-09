Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C233C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DEC2068F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 16:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3lzJKXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHIQVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 12:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgHIQVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 12:21:43 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5899C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 09:21:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so6000032wrl.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 09:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jHV6OhKt48hYF6FxQcO0dLBp5ejwa9xYFmpiLnqQtTw=;
        b=D3lzJKXG9rIlSNON7M+tAWCvMBSzj+kgtIM/KNk+UFIEWGd8dgVk5y/ch6y3T9R+g0
         keBSpQtUhIy18oyLIlFqSMwxBsWlJ11iivvs1Wkbm15wlZDpHfQ6gHJn5NPh7QddvWf1
         SZrdNJsXSxg1rHmEdjD/4ok1esaNYp16vpQpLqw4UxtUh0q0k0GkIkcdty9LFvEV5/CU
         ykqsfT1cBoFu+O/h8+fwScP2kp+hINuezS67r8WhlqxZF6oB7QRgt0ePzW33Q3zZYhKf
         SLbGZEfr7h6+g5luud93M6mOfpUECc1l/Bv2UE+WHPZ2LxJYhS390+3iln0iGLZIVZ4D
         TwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jHV6OhKt48hYF6FxQcO0dLBp5ejwa9xYFmpiLnqQtTw=;
        b=louA6Eyz92fz+kdMISMN/Ikq7tOcSNyqdngTBbGmPIOSbqW+YPdg41ollMDRxdzLHl
         dWaHFUvHFfUdjwjITLK0dwYmGaFJLWLrexxIysV0ryqygWRp45Yx0UmN2STkUZE/uAZG
         SjWUXc1tpdgxpdYpGCIqry1hVY9NgsWtWS1R5hFYtOeTOG8uMIItle7KCvzQgXk8FCbs
         CP183utZiD/Usmz/epzMa9UwIjS38hnZGpVPkdpzMsD2BaKU4yO9a1NKqXoR6WVdFc0n
         8KnW5lhTiwCcxJ6lAXhQsbc47co9Asyv08jGa2Z8VrNs6diqIGvtFx5ebpmMInQoYxNv
         hdfw==
X-Gm-Message-State: AOAM531NTw8uGx3FdOXhtAoSHRQZCI4ajbwFAJ1aFI+VT0HW30mv5ZEs
        xXVhRlw1MDkjDCKESELTx/w=
X-Google-Smtp-Source: ABdhPJwavq5PhZcSyOfTNFiy2BSGyFjpevIB/6h60ovJuuKChkG+2GnAtjMRsJLQnomqBZgM4Ei4yg==
X-Received: by 2002:adf:f64a:: with SMTP id x10mr19632176wrp.99.1596990100654;
        Sun, 09 Aug 2020 09:21:40 -0700 (PDT)
Received: from lenovo-laptop (cpc83647-brig20-2-0-cust926.3-3.cable.virginm.net. [82.19.195.159])
        by smtp.gmail.com with ESMTPSA id g3sm19839858wrb.59.2020.08.09.09.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 09:21:40 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Sun, 9 Aug 2020 17:21:38 +0100
To:     Eli Cohen <eli@mellanox.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
Message-ID: <20200809162138.xypkq76n37choxxr@lenovo-laptop>
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
 <20200809055237.GB48080@mtl-vdi-166.wap.labs.mlnx>
 <AM0PR05MB4786937640988E59BBB453CBC5470@AM0PR05MB4786.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB4786937640988E59BBB453CBC5470@AM0PR05MB4786.eurprd05.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 09, 2020 at 06:03:00AM +0000, Eli Cohen wrote:
> After all this patch is not fixing it all. If we get to default of the switch statement we will free invalid pointer so removing ack-ed by me.
> 
> The previous patch by Colin King fixes it.

Good point, sounds sensible. Thanks for looking my patch over :-)

Alex

> 
> 
> -----Original Message-----
> From: Eli Cohen <eli@mellanox.com> 
> Sent: Sunday, August 9, 2020 8:53 AM
> To: Alex Dewar <alex.dewar90@gmail.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; Parav Pandit <parav@mellanox.com>; virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
> 
> Acked-by: Eli Cohen <eli@mellanox.com>
> On Thu, Aug 06, 2020 at 08:18:39PM +0100, Alex Dewar wrote:
> > In alloc_inout() in net/mlx5_vnet.c, there are a few places where 
> > memory is allocated to *in and *out, but only the values of in and out 
> > are null-checked (i.e. there is a missing dereference). Fix this.
> > 
> > Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 
> > devices")
> > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > ---
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
> > b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 3ec44a4f0e45..bcb6600c2839 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -867,7 +867,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
> >  		*outlen = MLX5_ST_SZ_BYTES(qp_2rst_out);
> >  		*in = kzalloc(*inlen, GFP_KERNEL);
> >  		*out = kzalloc(*outlen, GFP_KERNEL);
> > -		if (!in || !out)
> > +		if (!*in || !*out)
> >  			goto outerr;
> >  
> >  		MLX5_SET(qp_2rst_in, *in, opcode, cmd); @@ -879,7 +879,7 @@ static 
> > void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
> >  		*outlen = MLX5_ST_SZ_BYTES(rst2init_qp_out);
> >  		*in = kzalloc(*inlen, GFP_KERNEL);
> >  		*out = kzalloc(MLX5_ST_SZ_BYTES(rst2init_qp_out), GFP_KERNEL);
> > -		if (!in || !out)
> > +		if (!*in || !*out)
> >  			goto outerr;
> >  
> >  		MLX5_SET(rst2init_qp_in, *in, opcode, cmd); @@ -896,7 +896,7 @@ 
> > static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
> >  		*outlen = MLX5_ST_SZ_BYTES(init2rtr_qp_out);
> >  		*in = kzalloc(*inlen, GFP_KERNEL);
> >  		*out = kzalloc(MLX5_ST_SZ_BYTES(init2rtr_qp_out), GFP_KERNEL);
> > -		if (!in || !out)
> > +		if (!*in || !*out)
> >  			goto outerr;
> >  
> >  		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd); @@ -914,7 +914,7 @@ 
> > static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
> >  		*outlen = MLX5_ST_SZ_BYTES(rtr2rts_qp_out);
> >  		*in = kzalloc(*inlen, GFP_KERNEL);
> >  		*out = kzalloc(MLX5_ST_SZ_BYTES(rtr2rts_qp_out), GFP_KERNEL);
> > -		if (!in || !out)
> > +		if (!*in || !*out)
> >  			goto outerr;
> >  
> >  		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
> > --
> > 2.28.0
> > 
