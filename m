Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FACC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58856207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 22:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578954916;
	bh=MCYl5+iszRacdvCIlul+eosv/qxb+MyzampfLJoxvWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nePrrJ1uArl6YgzdUNsIq+c93XtUaYOn9bo0/ylWVOBVbpY5L3TQ4ppjaGInL7hiw
	 EpwADMz0lOJ05RifRg99wzJe7Ez59d4mw4xoMqbI21Mb7i/bD+X4jQL8DD+xaxww3c
	 ahXExaFDfzoiTkGF/HehKmDrVRRN34tR/9aBhX+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbgAMWfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 17:35:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:39293 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728959AbgAMWfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 17:35:15 -0500
Received: by mail-oi1-f193.google.com with SMTP id a67so9950656oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 14:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2aqbv7Gs5aPw45r0A4Glmj6TozevE0VvRNxou586VsA=;
        b=LbnQDcoO2aAH/ZlMFHVsePsx0c7manGlzDhU9W890FNUGcI5ENy75gyChqWBLEdhIX
         rNRweFbiCxrLQXEGNdaRdXVCZvY+Wfsh4l490X0/Ew53LbtSpI2DaMTHewBqhFKaBrgd
         WDnHeYtG7X7Pnse0BBXqMnpCnNiPNRXyJjLWtafoV+P6Y1Sp8XBqayRcDxhyLD2m+0sP
         QmYVVubXBi3eqMxOARj8X1tjGN6DHxUhDneqQM8VBG/WWfpCKgZFdwyg+ZdVYJ+kI/9s
         LRVwxqX5c/sNJL1Y07uYNDPbBGz90i0NP5Fw5omUV2LLxb+WZ3fHDUHUeMYbirr1ybig
         TOOQ==
X-Gm-Message-State: APjAAAXGS1202Pwpt6Z9ZKy+FmZAAnZSaQX3ycHBFjTEhp6KELlIY1sp
        NW5Zda1v9aN2IkZo/jzth4PKtVo=
X-Google-Smtp-Source: APXvYqyh3yO8jU4yHHvI3ypSP+THsOskUzWt/yuPdzV1uSgRrqdFZlQobxhsCYvuMz8yFHv6j1bg5A==
X-Received: by 2002:aca:4306:: with SMTP id q6mr14859103oia.54.1578954913997;
        Mon, 13 Jan 2020 14:35:13 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j26sm4685590otq.18.2020.01.13.14.35.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:35:13 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 16:30:11 -0600
Date:   Mon, 13 Jan 2020 16:30:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, broonie@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, digetx@gmail.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 06/21] dt-bindings: tegra: Convert Tegra PMC bindings
 to YAML
Message-ID: <20200113223011.GA18406@bogus>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-7-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578457515-3477-7-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020 20:25:00 -0800, Sowjanya Komatineni wrote:
> This patch converts text based Tegra PMC bindings document to YAML
> schema for performing dt validation.
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      | 300 ------------------
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     | 340 +++++++++++++++++++++
>  2 files changed, 340 insertions(+), 300 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
