Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE0BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4604B20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 18:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595874009;
	bh=bcOVSC6iwGmX4PhBNjaLhYR+tUBENZQVZ3yMoYlloLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cUf6n3UD+Rx59Pfo/blCmaqu/Ztde4UhXMeHBShKX4NiUPjR40IPoD6DVNN9UWVbx
	 30TcdrsN4AS4iKGqN41TNLdTh/YvOQi/ijkFA0fATPVv3RfnvhEL0WngA+KITMeDpg
	 hksAayZAqyOLUaxqCY4lWZ2RMuTbI3fHtqI4zk3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgG0SUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 14:20:08 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43512 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbgG0SUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:20:07 -0400
Received: by mail-il1-f195.google.com with SMTP id y18so5501582ilp.10;
        Mon, 27 Jul 2020 11:20:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hHBgGmP6C/aVsle80stjB2DOBTx6fwthJHeqJ4Q1g+o=;
        b=tuxxJOaVlwfj0E4rKjwNg9N9oa7a0PU2YS2CzOynIWgZLw89T1xkmMiAyYWYC/zdph
         jxtbO+Orr42F4rHxLo+kq2rkj3rvJm8OW/seddvXAp5tNy6whQAdpheHiFXlEvdhRVD1
         2UtJw8druo4rU0ubh6KhhYasVLXr9sPRULbRZB1df9v0GLMO//qTutg2XwKJ5zjq+u7+
         Im3DaiX31M1xesvl5X962jWZwlNAP+VJddKkV00DVke9wtxJYtRTTirCBo0pjqyugVt2
         N3nmkfGAA+CeY6sgsRuw0khM/Qn+KmFXneVBf6LXJgr4I4DcFzBiAUvjkCAOKMDmr+ls
         1e2g==
X-Gm-Message-State: AOAM533Yyiv72mYX7Hm2Q6vXhZOfVQcEs7RBG/E4HTzXZZQd3ctmpJRT
        n6Fqo91tHe0quFye2HaSwA==
X-Google-Smtp-Source: ABdhPJxq32PaoZ9jSiA8/vCo90i5yc8YqkH0UXNfMZI00ZGSughQbvZqqe9FqCxIhQs7xH2up94QLA==
X-Received: by 2002:a92:1d1:: with SMTP id 200mr17557805ilb.71.1595874006899;
        Mon, 27 Jul 2020 11:20:06 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id t14sm5756318ios.18.2020.07.27.11.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 11:20:06 -0700 (PDT)
Received: (nullmailer pid 649107 invoked by uid 1000);
        Mon, 27 Jul 2020 18:20:04 -0000
Date:   Mon, 27 Jul 2020 12:20:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>
Cc:     lkundrak@v3.sk, robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
        heiko.stuebner@theobroma-systems.com, broonie@kernel.org,
        linus.walleij@linaro.org, linux-stm32@st-md-mailman.stormreply.com,
        sam@ravnborg.org, a.fatoum@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, mani@kernel.org,
        allen.chen@ite.com.tw, alexandre.torgue@st.com, stephan@gerhold.net
Subject: Re: [PATCH v5 2/3] dt-bindings: arm: stm32: document Odyssey
 compatible
Message-ID: <20200727182004.GA648872@bogus>
References: <20200724145107.35772-1-marcin.sloniewski@gmail.com>
 <20200724145107.35772-2-marcin.sloniewski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724145107.35772-2-marcin.sloniewski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 16:51:06 +0200, Marcin Sloniewski wrote:
> Document device tree bindings of Seeed SoM and carrier board.
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
