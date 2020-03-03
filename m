Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA0DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0FE2467B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583198908;
	bh=n4apYBCVrZ5g5EQLM4MQiFRZoU/6FZvGRX0yQps0rR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iUs+roVdvzPqJF2B06EXJFcQbHQBaB7d99fha1jI91ie59w6s5FbE9kM32+jAb0Z0
	 GJI4joX1ujzw5zOtHL8GoP5Ddx4UOox3xhFvvg8lEXVpG+hCf0ALXhKnW13yrr98Vy
	 9mxfmYgy7mewN6MFQm0foTS3xj443vSIF7I8N5JU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgCCB21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:28:27 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44380 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgCCB20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:28:26 -0500
Received: by mail-oi1-f193.google.com with SMTP id d62so1301387oia.11;
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+1KyOHwBn/viSAsJSh8AjzAW83mdyjNjKZ1smKP6L5I=;
        b=gowULXKi1t2SA+eZriCLpHwrimvmr4FW+HFillEdE7x1kqJD2VaOom5qKx9Eob0WAP
         UroPv2PWNLU7TsH1GljP8OeHs2LQ6U8nSbhIF6QNus0Z1pZDYylyjIgSI30T3w6DlMFd
         HH0kCZVQeOQDoQBuSlzoWOakxmoG6WIh+kMGEJ+bJ0YbqID6+6tglial1yc1Mfx+ahCt
         /llVDTIb9Gvscmzp4N5ViHWTc6wsmXrY3DeJB3L6hZIlA180IFvQkXu4UTxifB1Sj62S
         2NcalEhmyyR1lSZTq6apg29V4IBsq5UBqJV041qrWrc/HfrlJvsq0If0w9Jq3ezgViLa
         GQpA==
X-Gm-Message-State: ANhLgQ1gsu9M7yvWhknj1GjaqtQK8+8qhI+6+m4nhpJlyZxWuubmBt8f
        zgRBt/yb5aNaTvavzkuqTg==
X-Google-Smtp-Source: ADFU+vuXH/1hxcsxPMVP9wigrFZpla2XwPEdAwOWERbHAnI6m6fNRmH5HugZb8pe9eB5At7zzu07xA==
X-Received: by 2002:aca:1204:: with SMTP id 4mr891001ois.143.1583198904510;
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s23sm1981432oie.0.2020.03.02.17.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 17:28:24 -0800 (PST)
Received: (nullmailer pid 7901 invoked by uid 1000);
        Tue, 03 Mar 2020 01:28:23 -0000
Date:   Mon, 2 Mar 2020 19:28:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: clock: Add binding documentation for
 TI EHRPWM TBCLK
Message-ID: <20200303012823.GA7863@bogus>
References: <20200227053529.16479-1-vigneshr@ti.com>
 <20200227053529.16479-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227053529.16479-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 11:05:28 +0530, Vignesh Raghavendra wrote:
> Add DT bindings for TI EHRPWM's TimeBase clock (TBCLK) on TI's AM654 SoC.
> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>  .../bindings/clock/ti,am654-ehrpwm-tbclk.yaml | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti,am654-ehrpwm-tbclk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
