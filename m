Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF059C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7A2F2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583244445;
	bh=/ZtyIp+EXwauF5a0h78doo/0Hng0VchssdppjMrH/0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gMe8NF9eAnvz6FtroQPTEP0UCYFe4EBvgJPEy6MlXVT6Blgeh61PHQv6GRVU83oPz
	 SKg61dbeUWHnDJSEFn9e2Jeiq2wIRpbiN0W/+ipAzgPTdswSy6ZtqbdJRVCP5TYbEC
	 z54e1+mzrWbkAEkjjXaiSLRQUW9klHJtA9U+YO2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgCCOHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:07:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40583 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgCCOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:07:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id j80so3096968oih.7;
        Tue, 03 Mar 2020 06:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zFIsnwQFwh0IBQohYKBmj547QANxUwC+KF2hmGIR0Ow=;
        b=HBMh70Zg6AJR5LkRijxH1qf+HLiCu47sIZ1Dmskkf0J1/f7QkllpIXd6trKT9swfbF
         jG6EyVcQcdyARYjCgAX7d1rG5G3cj4F4dSrah5oQiMYnwoL2PbL7gRqGY+LGb6eGElud
         dswHJsOCYObDg1Hmspu60qOXKx/L0X4JmagbgUFR/6/DF4wZJ3p2qYevV2baklHITJX4
         WvcYTvKkvzRzBpvg84UDBVWtkuVJEW6L/L4m0cUSUAT0fGhPHdVlXnhTdltGStixzZjf
         0PaJVpP/3GUXwIAj27C3kGXY/VigiB2v4HiHVUneIPnZ4BF1dqEzU4z3kzrvVojx2uYJ
         krXQ==
X-Gm-Message-State: ANhLgQ3J5KdH6vC3ZpsDs0SKtU20BXHUjKzqC3FNMVtEh9dfiwxv7e+T
        XrUGcZAAwWnMt+cRPS0uww==
X-Google-Smtp-Source: ADFU+vsVm+4W8shQKXXamje89m5ALBPTBaOj3e+mjiz/h8BntqDjw1US47u3zF3zYwvdiyaccvpHDg==
X-Received: by 2002:a05:6808:218:: with SMTP id l24mr2384100oie.108.1583244442931;
        Tue, 03 Mar 2020 06:07:22 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p24sm3601078oth.21.2020.03.03.06.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:07:21 -0800 (PST)
Received: (nullmailer pid 23694 invoked by uid 1000);
        Tue, 03 Mar 2020 14:07:20 -0000
Date:   Tue, 3 Mar 2020 08:07:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     p.zabel@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH 1/4] dt-bindings: reset: imx7: Add support for i.MX8MN
Message-ID: <20200303140720.GA23633@bogus>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 17:13:48 +0800, Anson Huang wrote:
> i.MX8MN can reuse i.MX8MQ's reset driver, update the compatible
> property and related info to support i.MX8MN.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  4 +-
>  include/dt-bindings/reset/imx8mq-reset.h           | 56 +++++++++++-----------
>  2 files changed, 31 insertions(+), 29 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
