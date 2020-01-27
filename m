Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933A3C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5E920716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580139411;
	bh=qOmFQse3YDT7AegCOOevb54/i8g7qJFVom2ZFY7rBpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=El01PCOJ9N3Am6mZNLOdxcnqFoZGPc8rlsFX5fShplDd9OueA+YLCZxTi0U/Zbata
	 G0kqz/BYh6hRJbu2JFy4dTVTwmnkxcvOzv8nC7X3ennkbImmST74RuWt+gnuFt1N8n
	 yKKlbl/EYObyNAw7KPHtiADzXKELLdDWbA5+LDZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgA0Pgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:36:50 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39929 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729133AbgA0Pgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:36:50 -0500
Received: by mail-oi1-f195.google.com with SMTP id z2so7027830oih.6;
        Mon, 27 Jan 2020 07:36:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2tMp6J7RhsN6lAcTje3kjguQsBuUD423RsgoOzLk7mU=;
        b=G64wPx5LgQFvxTwjeYRDNz0H/CusgSjEInT+u69yuj/afm/rRC7L26otLoi/7ab0iR
         4W2ljS41ZZ8rTLouE8dYx70lQ8JuI/F6itShRRoC7WEF2BzD62AdphLkQqS1MEoyW87N
         3kQuExG7YbQZc26vDPqEQjb1GpuufzErjwm+0aLqd5SM5B1sPQrBGiBCcn7FGArVzUyh
         5Ju+FiRbnp1hfzpte6/iVN3eGPfKnhUhwBMUzMpwHaTRs7e1XB3QD3ui9WRNC9ybKCQc
         j0HrisEnmKioWuo4hgJTqNH2ZcGr6LWdoKy+gFTb54fYAUAAm72GEWFSUkvDmO+kS/gL
         M/sg==
X-Gm-Message-State: APjAAAUigJztJBXxMqtVDZTFL0+z9uD/VUqAryiGzHTauPjsQ7d6q6jb
        BIDmR8PfTYTMrZFy22oQbg==
X-Google-Smtp-Source: APXvYqzGekj/ZFmSdDOyY4AAWBk440EzsKOKyc1gewORI8sKL5QW+luY/btzprKvUk099ZEBhUGrkQ==
X-Received: by 2002:aca:1c0d:: with SMTP id c13mr7487529oic.44.1580139409565;
        Mon, 27 Jan 2020 07:36:49 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm5637408otq.26.2020.01.27.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:36:48 -0800 (PST)
Received: (nullmailer pid 32549 invoked by uid 1000);
        Mon, 27 Jan 2020 15:36:47 -0000
Date:   Mon, 27 Jan 2020 09:36:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Akash Gajjar <akash@openedev.com>
Cc:     heiko@sntech.de, jagan@openedev.com,
        Akash Gajjar <akash@openedev.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Vivek Unune <npcomplete13@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4, 1/1] arm64: dts: rockchip: add ROCK Pi S DTS support
Message-ID: <20200127153647.GA32343@bogus>
References: <20200125063153.2720-1-akash@openedev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200125063153.2720-1-akash@openedev.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020 12:01:37 +0530, Akash Gajjar wrote:
> ROCK Pi S is RK3308 based SBC from radxa.com. ROCK Pi S has a,
> - 256MB/512MB DDR3 RAM
> - SD, NAND flash (optional on board 1/2/4/8Gb)
> - 100MB ethernet, PoE (optional)
> - Onboard 802.11 b/g/n wifi + Bluetooth 4.0 Module
> - USB2.0 Type-A HOST x1
> - USB3.0 Type-C OTG x1
> - 26-pin expansion header
> - USB Type-C DC 5V Power Supply
> 
> This patch enables
> - Console
> - NAND Flash
> - SD Card
> 
> Signed-off-by: Akash Gajjar <akash@openedev.com>
> ---
> Changes in v4
> - remove supports-sd/sdio, nums-slots property
> - use vmmc-supply for emmc node
> 
> Changes in v3
> - Use small S on dts file name
> - Add missing semicolon
> - Remove USB2.0 node support
> 
> Changes in v2
> - Use pwm-supply for vdd_core node instead of vi-supply
> - Add USB2.0 node support
>  
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3308-rock-pi-s.dts    | 216 ++++++++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3308-rock-pi-s.dts
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
