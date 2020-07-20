Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED25CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2B8206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272839;
	bh=CvrVi4nqNockb5V+r8JbCa/vHzztUcee3pDZ5LiLPkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1nl+BK73aKnv3x1gh1C0ExTW4e1LV2etTrSsZaDTt7GVVuhU8lP6QPzQyz69snU+n
	 F3wXkVmTgWJexX4s3PTcSo81GGwCqsiqyyva1h/EhHXOjWULUAVjPhxS3fL8dtBWme
	 91APMPfkP5ysn3db2NpWS74mMNyY5NyP1SYsKLQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730674AbgGTTUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:20:38 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:45416 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729208AbgGTTUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:20:37 -0400
Received: by mail-il1-f196.google.com with SMTP id o3so14266329ilo.12;
        Mon, 20 Jul 2020 12:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqYKQMOuIVj5pOBGgBVd/pxUW1b2laun76RvBjVHCKI=;
        b=XRRaBu/Q6Mxv74zgLqtPqkS26t+fsIw3+DxB6e/fWLojoQwdAoQO4kjgACtsIJRBK0
         Y5EyW0E3O7DD34mBlheDaBiApcG86eoxPrOV23LOdYz4iU9bgNVQtzlnuYQNE1NVQut0
         Jh54fk0/AZS4v8hKYu0OiIS+gcu3FJ9aEKLgGG7p1OtKc6E7WwAPUHBxt54i98WVHd/C
         Gam3cU4oG6N65Bdg/oUh3F6XNKn481xbKg6Id++QCZzrL7KXBy0X3NtDZZuquO9PQvkk
         QzeWtneI+bmh/q7h0MrjQDRZMhvnNdkofq29xkcIWEJWU4ZWkXmBNSU0oDIkRFf9yfIZ
         9yxA==
X-Gm-Message-State: AOAM530/gZYb1lCkF04ySq0PAkpDc3v8jGYLZmFAGdp3+moQBmqg0SPF
        gfASWTXN25//VSGL/+Z9RQ==
X-Google-Smtp-Source: ABdhPJyOtWoGboV2RT+nQRU1hdrDUTfTCdxNq4fZL2j703qm+oxtWTv25fMik8fIblO96Il829N4cA==
X-Received: by 2002:a92:9fcb:: with SMTP id z72mr24719165ilk.195.1595272836797;
        Mon, 20 Jul 2020 12:20:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e1sm9292477ilr.23.2020.07.20.12.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 12:20:35 -0700 (PDT)
Received: (nullmailer pid 2851198 invoked by uid 1000);
        Mon, 20 Jul 2020 19:20:34 -0000
Date:   Mon, 20 Jul 2020 13:20:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     miquel.raynal@bootlin.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        richard@nod.at, linux-mtd@lists.infradead.org, vigneshr@ti.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20200720192034.GA2851152@bogus>
References: <20200717092420.19798-1-yifeng.zhao@rock-chips.com>
 <20200717092420.19798-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717092420.19798-2-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 17:24:17 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v8:
> - Fix make dt_binding_check error
> 
> Changes in v7:
> - Fix some wrong define
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> 
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> 
> Changes in v3:
> - Change the title for the dt-bindings.
> 
> Changes in v2: None
> 
>  .../mtd/rockchip,nand-controller.yaml         | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
