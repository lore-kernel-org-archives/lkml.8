Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FA8C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7724204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkM8Eb5n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgHaRF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727929AbgHaRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:05:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8859EC061573;
        Mon, 31 Aug 2020 10:05:25 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id n22so1720509edt.4;
        Mon, 31 Aug 2020 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LwLWx+wWl/AZ2D/tMJCStQBmzgZx86Xwly6tLbRchyg=;
        b=ZkM8Eb5nP8wV1FNoszg6lGyr6ZdIRy8xh2ExP+8eZNu2BgvXaKq4+AQRq8qml1QQQ4
         nxMCtRe4bNIGnKVRqE9zngWh/7jAMMEzjHlVJNI1uwCJoBHuwlxRiIOxH1Aarq/pSiec
         wvJuTGiPEiDXt2Fo+dHtI/qq1pu1NtZmU18Xui/3cEeGel6FwQnJj2qpSv77hL/c2gWl
         +AaoknUnMBhxppAOqB3whIMGaLvF69Y3/PvkwA5krdrbolL9OwsF+oKj91sY/ZsdtgAE
         ktYJKGoRJy5fg8tkn+OLi0XSz2bbL6t52dD3ZSAkCg2SHzvpD3fQt8hC7/lWup334Wdj
         LO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LwLWx+wWl/AZ2D/tMJCStQBmzgZx86Xwly6tLbRchyg=;
        b=deHmU4ywGgjgB4IxTkDtASpHl9ohluZ6ZoYSvhGGCwTDS84DF8YZ1jXNuAovQ6Lhei
         EMeV0PRSsa9PLsQ0wZfw49KN64Gjd35RrHmbCmHH4hqSG/JUnn5eVioomwGz5XHOsFAS
         rfbN2+ZJlgknU5hIggJ+f77uvapUSdA9uX5XfMJMtPPM2mAucESC78MrHbxmLBOq6d8Z
         5v+l8lLmhBuKvv4JqGTafD5BhHM8JvIyS4W7TUTC9Z8A6p4EJcg7iszHSvDvF/95Vzfz
         bEUN++k0lqNWHTSxhxcc58TXzuACKain5fDxqIhCwx+tqWrXijPYy2V4iGIYuQSgqVAw
         cUJA==
X-Gm-Message-State: AOAM533Uy/96GSaFEDGKE928+DBh65CNEkyAlTWC2gIPKHXeu58aBlGL
        y5255YaYsS73qhB0okgRCYg=
X-Google-Smtp-Source: ABdhPJzOvYZelVlzmFV7YmaUQpZB/POib8+4LtW9qHCiQXCahsdABNjQ7/ex7xZ5VHIFmoYUa8lLEA==
X-Received: by 2002:aa7:cf19:: with SMTP id a25mr1971977edy.67.1598893524109;
        Mon, 31 Aug 2020 10:05:24 -0700 (PDT)
Received: from BV030612LT ([188.24.159.61])
        by smtp.gmail.com with ESMTPSA id lo25sm5098040ejb.53.2020.08.31.10.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 10:05:22 -0700 (PDT)
Date:   Mon, 31 Aug 2020 20:05:20 +0300
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Korsgaard <peter@korsgaard.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 1/4] arm: dts: owl-s500: Fix incorrect PPI interrupt
 specifiers
Message-ID: <20200831170520.GA2551342@BV030612LT>
References: <cover.1598621459.git.cristian.ciocaltea@gmail.com>
 <43702e492090417a490ba4cd81990a05aeea9f48.1598621459.git.cristian.ciocaltea@gmail.com>
 <20200831091925.GC4154@mani>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831091925.GC4154@mani>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 02:49:25PM +0530, Manivannan Sadhasivam wrote:
> On 0828, Cristian Ciocaltea wrote:
> > The PPI interrupts for cortex-a9 were incorrectly specified, fix them.
> > 
> > Fixes: fdfe7f4f9d85 ("ARM: dts: Add Actions Semi S500 and LeMaker Guitar")
> > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > Reviewed-by: Peter Korsgaard <peter@korsgaard.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Cristi

> Thanks,
> Mani
> 
> > ---
> >  arch/arm/boot/dts/owl-s500.dtsi | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/owl-s500.dtsi b/arch/arm/boot/dts/owl-s500.dtsi
> > index 5ceb6cc4451d..1dbe4e8b38ac 100644
> > --- a/arch/arm/boot/dts/owl-s500.dtsi
> > +++ b/arch/arm/boot/dts/owl-s500.dtsi
> > @@ -84,21 +84,21 @@ scu: scu@b0020000 {
> >  		global_timer: timer@b0020200 {
> >  			compatible = "arm,cortex-a9-global-timer";
> >  			reg = <0xb0020200 0x100>;
> > -			interrupts = <GIC_PPI 0 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> > +			interrupts = <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> >  			status = "disabled";
> >  		};
> >  
> >  		twd_timer: timer@b0020600 {
> >  			compatible = "arm,cortex-a9-twd-timer";
> >  			reg = <0xb0020600 0x20>;
> > -			interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> > +			interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> >  			status = "disabled";
> >  		};
> >  
> >  		twd_wdt: wdt@b0020620 {
> >  			compatible = "arm,cortex-a9-twd-wdt";
> >  			reg = <0xb0020620 0xe0>;
> > -			interrupts = <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> > +			interrupts = <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
> >  			status = "disabled";
> >  		};
> >  
> > -- 
> > 2.28.0
> > 
