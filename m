Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1173AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFDB820672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463635;
	bh=1FzB/rHDbLCFiaQrrcup6dDILllaEDSN7udkmW8GdHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S7uk/0qtDxf6YxrIg1sqKDD9SntBu+Ce1PhEMpa6s5VsJW6OQejcO7DzugNeDtEDj
	 L/RgtW9X1mmantlFT9XQ9a0VoYZNxMQPqV4SM/1NPTwKgCW3fWeWRDa51c8fUskKLz
	 sjt4CkISoesla3zLohVNsxBGkh1xLGnUp+aB5uZw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgF2UrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:47:15 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37535 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389751AbgF2Uqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:46:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id g20so13961170edm.4;
        Mon, 29 Jun 2020 13:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fpPGAVi5ST0Msn1ZYb/hxyyJfD9nRccBP2hwCtuMGbQ=;
        b=i7GMMqckeMJNgqcvezDmEvoJHQUY/MZrJ8k2hDVJGSw5KRWzu2RVsOe1O8nIOhOGNv
         GPy0KUcL//XG4ESPqqiGITqL1CB25ar0ClG6kOcorNaKefN+zrJFaJyiB+jSObJ8EjtQ
         bzID+TFgcJU2NAIJSh2dncjw3x74bnPWm61cqUIrd6SXLEHSx7knMwYn1MFWLTz7dpCp
         tK35COpcYgqjACbqIOFvRjIzlg5pq4wT2x5mdTnmdbCupqW3SrJxAxXeSoJiMtDtW94g
         ccgSg1oJ7T0fvB7vV/ISZaRYN9J0a2gNbPxNCuTEo3da8YHw+J6pwucC3ogxGVUr8c0C
         +OzA==
X-Gm-Message-State: AOAM530r9E1IFSGDstTD2J9IYoLlD9/gDYSY92eV0CwLwLR3lNGRLHUS
        D99JI5Gj/Haf23WTs7oS/GQ=
X-Google-Smtp-Source: ABdhPJxKgZqpneEuu5YuIHLp12CmML5exM0XVIJFM5zeSUnLRZQcoWHqnrzGNkURRUuzjRkRJIbIeQ==
X-Received: by 2002:a05:6402:134e:: with SMTP id y14mr19784901edw.4.1593463605392;
        Mon, 29 Jun 2020 13:46:45 -0700 (PDT)
Received: from kozik-lap ([194.230.155.195])
        by smtp.googlemail.com with ESMTPSA id k23sm434660ejo.120.2020.06.29.13.46.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 13:46:44 -0700 (PDT)
Date:   Mon, 29 Jun 2020 22:46:42 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: Re: [PATCH 1/3] ARM: dts: exynos: Fix missing empty reg/ranges
 property regulators on Trats
Message-ID: <20200629204642.GA26060@kozik-lap>
References: <20200629193338.29540-1-krzk@kernel.org>
 <03a23289-1188-db77-6c38-a7dddeac183c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03a23289-1188-db77-6c38-a7dddeac183c@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:50:26PM +0200, Sylwester Nawrocki wrote:
> Hi Krzysztof,
> 
> On 6/29/20 21:33, Krzysztof Kozlowski wrote:
> > Remove the simple-bus compatible from a regulators node because its
> > children do not have any unit addresses.  This fixes DTC warning:
> > 
> >      Warning (simple_bus_reg): /regulators/regulator-0: missing or empty reg/ranges property
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   arch/arm/boot/dts/exynos4210-trats.dts | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
> > index 3d791db6095c..cec413ee4490 100644
> > --- a/arch/arm/boot/dts/exynos4210-trats.dts
> > +++ b/arch/arm/boot/dts/exynos4210-trats.dts
> > @@ -31,8 +31,6 @@
> >   	};
> >   	regulators {
> > -		compatible = "simple-bus";
> 
> I think you would also need to remove the 'regulators' node altogether,
> otherwise with your change the subnodes below won't get parsed and the
> regulators will not get registered.

Good point, I actually did not test this patch. Let me recheck and send
a follow up.

Thanks for review!

Best regards,
Krzysztof

