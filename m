Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCCDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD82B20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590779367;
	bh=OSybS1bdQYxysAIMkZfUgLzKA8fRtglHj1x/ukrDWjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NrWKcJhNR8Qa/kGJeZwOp98VsBB5qTNlYtAKqubrGZRrZxY6ShUDnh7NV98fFYwsG
	 adkM/22r1xJm/b367lrs7/xsCdWGMmCYNXqTvR1d2d+4rFDrfJ13M8BV1PR/hoOxET
	 as3TlAJSoZH8qjyCibL3GlE6CyDuWO4AMdsQWrIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgE2TJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:09:26 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:35626 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgE2TJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:09:24 -0400
Received: by mail-io1-f66.google.com with SMTP id s18so528306ioe.2;
        Fri, 29 May 2020 12:09:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rr1goXJK8BMxAGVSV4RpdwFQVhpZLMMrPGCvMyp8M2M=;
        b=GlA5mzJk2pCUd4TiFIavzq2FHAfrJ1qlUsBw+zkB9cEwpjhoyKkAuhMX8J1Aqhgibo
         m/S5guwEQ52UHpdR+zSKL70bUwVqk0soe1bu1gjCw3yyAU67KiygAElZakapBvuPEWJo
         v6i1ATm8+HSvmFgLmED3rGMoGqkcmPpBVC/HR/zhIba8XVVYHeI+tOi/PXUSpjvA5brR
         EoWtEI+Pwf1k/O+5FvriHNBCe8+++Or4dRizP85hmHpm3sFUp3IFH2APAdhLEQyHTP+4
         JOjz9urm8wfJxFH2wOrE+rEal8LzmWOEVD/vbc6ieGLHTO4IVfiEWSDz6fGKjhxoyIN/
         iVyQ==
X-Gm-Message-State: AOAM530U2qem2DKGFi/HdhuiIil5T6W6f1P31/soAod8cL8OhGIjscDO
        yjyz755i67u9KoQL8anXTw==
X-Google-Smtp-Source: ABdhPJwKqVKIdiKJxA/Zb76IXqGFs3RbwY+WvmRL/MwdmRswaz9K1wqJnciiP6ylwbuMEU9HjSjG/g==
X-Received: by 2002:a6b:7841:: with SMTP id h1mr7950694iop.101.1590779363667;
        Fri, 29 May 2020 12:09:23 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id a17sm5134377ild.31.2020.05.29.12.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:09:22 -0700 (PDT)
Received: (nullmailer pid 2770980 invoked by uid 1000);
        Fri, 29 May 2020 19:09:20 -0000
Date:   Fri, 29 May 2020 13:09:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh+dt@kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: thermal: rcar-thermal: Add device tree
 support for r8a7742
Message-ID: <20200529190920.GA2770927@bogus>
References: <1590614320-30160-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1590614320-30160-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590614320-30160-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 22:18:37 +0100, Lad Prabhakar wrote:
> Add thermal sensor support for r8a7742 SoC. The Renesas RZ/G1H
> (r8a7742) thermal sensor module is identical to the R-Car Gen2 family.
> 
> No driver change is needed due to the fallback compatible value
> "renesas,rcar-gen2-thermal".
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/thermal/rcar-thermal.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
