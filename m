Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF22CC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8891B2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582654693;
	bh=7wTKYKgLd21a59P/h8EhYIzp8jRCp62jS1nZIeNfrCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rfv0m/VXe5MCWD8cu0nIV/MC8e7p2tFrnPeoVvd218+RT8rLVc83LfEUrraTDQ+0w
	 jfAkdg8SbBzff2DHslEdYrbJIgdMRAfUujBiI3V0NCqvns6T1m9Kplo9iBZbQCv5Xu
	 yqU81MrRWTep6znO2OCTitbMMx+8mIKJbmWOrXcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgBYSSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:18:12 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40298 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBYSSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:18:12 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so239756oii.7;
        Tue, 25 Feb 2020 10:18:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiMVySvuuBlNCELv1IEvGZ2avIS4ux6UUmlN6NsgO3k=;
        b=e2WgiWcgZhzr9zbBfq8UPQuZqiLBkpX4zRkeWk40ZVntNWR1YRHXYMdfoI5ih/nGYL
         lJXJpS1qsb8Zfd3Xq/3jRCyzzGF7hmGyftNVRzHTYdbBSBWg21/wQO6l/pa7UN6/PyRZ
         Y1AMIvoYzU/drlaoclpGTZ5aHibF+a0OhiOIqxgpZIHn4VaanEn6++hbUlVndnqKYgF4
         Y1WPPiXU6DISr4vpje45yPsyIBQ7q8LRaYKWvnwrRupWrtYPhqUf11WNr3xWO0lxnFc+
         47Ft5U7vgkURSLLPIv+PoTNfd0WzAp93U4oAp+uovkztpoiIgZx59hh9k6GPr6x1V102
         1n1g==
X-Gm-Message-State: APjAAAWA/5hm0pU69NKQws2e/xPP5uWw4Qorh5XGmcwHfKGY2Ss0m4aE
        jKCAej4b83P/6tJOqTVmmg==
X-Google-Smtp-Source: APXvYqw28xdyGvjSdjDarHW2s0Fb+onlANDW5taKELi+Efvfv9JYUmEAg2FjeRAIn4sbu4cnKvc/jA==
X-Received: by 2002:aca:2803:: with SMTP id 3mr177830oix.162.1582654690275;
        Tue, 25 Feb 2020 10:18:10 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i7sm5569443oib.42.2020.02.25.10.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:18:09 -0800 (PST)
Received: (nullmailer pid 5749 invoked by uid 1000);
        Tue, 25 Feb 2020 18:18:08 -0000
Date:   Tue, 25 Feb 2020 12:18:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Maxime Ripard <maxime@cerno.tech>, devicetree@vger.kernel.org
Subject: Re: [PATCH 31/89] dt-bindings: display: vc4: dsi: Add missing clock
 properties
Message-ID: <20200225181808.GA5699@bogus>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
 <2d7aaa0bdf3f0cb66d14700fb77348453b3cd29a.1582533919.git-series.maxime@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d7aaa0bdf3f0cb66d14700fb77348453b3cd29a.1582533919.git-series.maxime@cerno.tech>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:06:33 +0100, Maxime Ripard wrote:
> While the device tree and the driver expected a clock-names and a
> clock-cells properties, it wasn't explicitly documented in the previous
> binding. Make sure it is now.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  Documentation/devicetree/bindings/display/brcm,bcm2835-dsi0.yaml | 11 +++++++-
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
