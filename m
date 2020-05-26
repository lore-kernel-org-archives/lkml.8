Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ACAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5628B20899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590532269;
	bh=1AooPdG544VI7U0HuHeNtQYRagThHz46xJh/gWwizUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y8FHkUXCLSnB42Znjt/6pUJCy2dHBtz9RZ7X+V/DBhRQB9sknqWD0Q9X+eo27IuD/
	 wSpnAgoz2KPTGnqyySlXuiG6RYxNXhhakIpXYh6MA4C41NOoDS02adnvZA99uSjF0A
	 Q66bVGpchPwhYRKs59ED8cYMFwvWxoMmucvwj9cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392073AbgEZWbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:31:08 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40089 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:31:08 -0400
Received: by mail-il1-f195.google.com with SMTP id a18so4882442ilp.7;
        Tue, 26 May 2020 15:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jno/kep3oj5YBZPFODsYD/SXlYW3A5CDDo6z2CWVUzQ=;
        b=LbZAMMflRsuLMaQsTO1Iy3LCF5rsTZx7TSv45qKtoupY/B40Vm7R5RsNkZ6E5GNxHN
         /WsQHzaaSOaLlaf2k0oDtRlQGMEXu275UrXi1vlIVOxePlFiySDYuY3VXUGUoJxkIWZ2
         DlK00b1kLucYFPvO17puQeEilmZddmizpUx93k+6iLUyifcBNtIyGm3inzsk0mNu39HX
         C5xfPYFOz+BocYW4VRvAiVutsvMhZgs7HOsWEIcA8PlG/TL4vxUY1Z3jI7sp1JuJEUdX
         AnvOSvSCA/scretAWo47mFfJDb7MfI/0v0BI4IyPXk+iewNsvJa4mBHrnIswiZl74klK
         4/Bg==
X-Gm-Message-State: AOAM533Xj2aISgqTiBwsWJNnkjUj5hffye2rc0lX+psJ8VGfPSWDivxI
        nBGfK9gN1ohLTfJo/pULpw==
X-Google-Smtp-Source: ABdhPJzDTOGPYvP95JmznCqzCC8Rq/MnIJTDBgJBFtlwvWZI6SwWtDqToRLT+YSL15TAz3aexFJW0Q==
X-Received: by 2002:a92:de10:: with SMTP id x16mr384552ilm.6.1590532267362;
        Tue, 26 May 2020 15:31:07 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id j90sm655477ilg.70.2020.05.26.15.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:31:06 -0700 (PDT)
Received: (nullmailer pid 503474 invoked by uid 1000);
        Tue, 26 May 2020 22:31:05 -0000
Date:   Tue, 26 May 2020 16:31:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, Linux-imx@nxp.com,
        linux-clk@vger.kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        s.hauer@pengutronix.de, sboyd@kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH V5 3/5] dt-bindings: clock: Convert i.MX6SL clock to
 json-schema
Message-ID: <20200526223105.GA503419@bogus>
References: <1589328684-1397-1-git-send-email-Anson.Huang@nxp.com>
 <1589328684-1397-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589328684-1397-4-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 May 2020 08:11:22 +0800, Anson Huang wrote:
> Convert the i.MX6SL clock binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> ---
> Changes since V4:
> 	- add descriptions for interrupts and each item of it.
> ---
>  .../devicetree/bindings/clock/imx6sl-clock.txt     | 10 -----
>  .../devicetree/bindings/clock/imx6sl-clock.yaml    | 48 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 10 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
> 

Applied, thanks!
