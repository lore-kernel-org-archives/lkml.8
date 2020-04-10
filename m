Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FB6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967592082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586540329;
	bh=NXV5bFS0Dft6YrOE3HGyIN8IvUmKNAAQqELpAtiICXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1k5hWRxz3Fi5SqFITXnwkwUGgc5RMnqJ+9KN0SNGQr1i/nv3pFln6xfo92lV/5uSh
	 LMXgPW6CVfkOxxT5x5/A6WxnbuMUwH58J+jTncdt3RivoxRwfkOsq5X1N8++IVE90M
	 2L7UgsPf12n4XxPDvsd5y8UfNBQCIP4C8isshnFQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgDJRir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 13:38:47 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40130 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:38:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id q2so2494602otk.7;
        Fri, 10 Apr 2020 10:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9kJ/4bqOothyJINtYliXhvkgGKhScBfb24HzHK/susg=;
        b=XsNrY+qA4Enm20j2Au/Yo8BBbSubeB8iWkcU6LvZJxOf6OoQADcuDi7Qud3nN9C0zO
         qu2EYpXWuR/Y/VaSdmZY/1kWIFn+x3jdXuViPntmeoCc8aIKL16WYq3yfeaWtsxtMTOr
         eD7s69C/lOI/srhjq0dqfRLHoY+1rPGKu9PE23ihMOg2ofOjVXNM/+Nfp6+KasNUD7Sg
         wdn1I3Ke/9WiXy3W9H6H5IKoSXkjKmF2yIlD6QyR+39E9QIg58M4OXJd/edQEN9Hn1qO
         9hAW+SEN0eDgdVCsP5FR2HLxqTmD0uEO0mYTrNYVJ6yp65mHgyZaH5MiVqObJkAZ6y2k
         jBDQ==
X-Gm-Message-State: AGi0PuaTqaZBg5wZiM69y4+WpY7u+30QIdLbF+SOcU1Dieyb1LeqFHT/
        eNhLaLQmwiW4JnKmrNuulA==
X-Google-Smtp-Source: APiQypJLRA24dC6fj0jyElHsMsWyYYupxpMAYWtCyrVRSdcApa1ygjgH11eqZ351d+hxbqJBJsp/QQ==
X-Received: by 2002:a05:6830:3150:: with SMTP id c16mr4700252ots.251.1586540326712;
        Fri, 10 Apr 2020 10:38:46 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id 26sm1679809oot.25.2020.04.10.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:38:46 -0700 (PDT)
Received: (nullmailer pid 20532 invoked by uid 1000);
        Fri, 10 Apr 2020 17:20:14 -0000
Date:   Fri, 10 Apr 2020 12:20:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 3/5] ARM: dts: add Protonic WD2 board
Message-ID: <20200410172014.GA20454@bogus>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
 <20200330120640.9810-4-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330120640.9810-4-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:06:38 +0200, Oleksij Rempel wrote:
> Add support for the Protonic WD2 board, which is an internal development
> platform for low-cost agricultural Virtual Terminals based on COTS tablets
> and web applications.
> It inherits from the PRTI6Q base class.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6q-prtwd2.dts            | 188 ++++++++++++++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6q-prtwd2.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
