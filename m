Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2655FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1CD22077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595296872;
	bh=GCHx7aaCeX12znzok8B9ybip6FlJy9YysSOo+9egTr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bbdc3rV1nEK7mO7OfP5eHqSZ4MkVvxAgVszmA3BxIBaKp225r/BP5gc71ep1WRvh+
	 0raeADMYwwlbzc0TzcScEwHjBzNw7L/45Ah1WssntLteZeQXjJ5EWrjMMSEzpzLUzL
	 IGV6eEPe00WiUf+xsHjne1aukq3y/r49agY/VxCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGUCBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:01:10 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:42730 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUCBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:01:10 -0400
Received: by mail-il1-f194.google.com with SMTP id t27so15042385ill.9;
        Mon, 20 Jul 2020 19:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4coWlWluVBZIU2YwRK6iRmx4Qe40biSfC4r+y33fdQQ=;
        b=CLkDAhJOCF0znkEpWPXe7/XUWrluKnlmyncvPMLhQb5ZgGTgRXsO5fQgDQTlXCY1xY
         49w/ScSz1KBg01PTzR8OPNIg9BCIY3TUzsU3Z2kbqqE9Q9GuTlJR+DznE1M8h1NsRrF9
         bIb9zp1diS5O7hr8p5PQTOxzLcHse7QtqZGjyPl4LOjWkV3Rwyh1+Is6+QIQtm/ULk5B
         2mUVt0DHRrrddDavKWLgK5LHAzllVJQsNsA+AuRtK3S3IbKR6oo0Hvw4gPrrJb0BUagy
         WApOnKN975p8OECBzrYgRVMWqSDrd6AR2OSh7axxD4dKsK+bPO4GiU+sneNq86V8Vy9v
         itEA==
X-Gm-Message-State: AOAM533f1tmCUIrOCS5LB1Wd9M+O/NrepY2eMB3zi/ydTOD1DuFioFxI
        8LEauKf4NS6N0wDcuYE4/g==
X-Google-Smtp-Source: ABdhPJw6yirC6GJsGZXSwAWpBSfNz67bs5OsZemqLf1ded7njYlxVrGNsox3/tosI8RW8daPCRfMEg==
X-Received: by 2002:a92:db44:: with SMTP id w4mr24935691ilq.306.1595296868945;
        Mon, 20 Jul 2020 19:01:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id y2sm10001176iox.22.2020.07.20.19.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:01:07 -0700 (PDT)
Received: (nullmailer pid 3373185 invoked by uid 1000);
        Tue, 21 Jul 2020 02:01:06 -0000
Date:   Mon, 20 Jul 2020 20:01:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Joerg Roedel <joro@8bytes.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, iommu@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: renesas: r8a774e1: Add IPMMU device nodes
Message-ID: <20200721020106.GA3372559@bogus>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594676120-5862-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:35:14PM +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Add RZ/G2H (R8A774E1) IPMMU nodes.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 121 ++++++++++++++++++++++
>  1 file changed, 121 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
