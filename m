Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B138C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A1C820738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598264887;
	bh=BCio3j5f/7ZCLKH29Tykgm6mdJsxmPdI9l/MRW7143w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xKShyoBYa5AjhHrm8sClhVANLusn58RAKyB6CEB/VMfEE61pBy7ic3TpUW0ika+D0
	 SASYsrSNzgekwM+wKC0ohyp85YdGFBwi45y3eIfFN6CC3U1rqwIxaQWiOZZ8d3XDuv
	 eg1/bnXbpjeBtPDUMOHiUVN+j1lO3yFOkn23ne6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHXK2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:28:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36116 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:28:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id b66so5380210wmb.1;
        Mon, 24 Aug 2020 03:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q0ukcAlh8tjdug5Bm0GaRHtnhaau6O3z3YD0eZHwTVI=;
        b=b5T3LG2ahaGhJQFUL3QxAssoAEHV0dCk1tvF2nJK9+9PBVn3eBR65UpSIQbGTWru3l
         U1t+GFRdIpoI9RP5seKM2J9ENldtN4GYZp/wy80GGLpvgP1iNqfOjkPtjZAc7rq4pedq
         7ySyozDB2IGmAweBOREQzR6Q4aPIbKlKg6Z6Dacp13YAHLMkygvOPRfkWMHGgymDf1On
         bClqfzHDZwY4g047vq1uD5XBK2rpaWNvSuCU/DItuzYtTZxIFHugG5VIlVFNbTIs3CEZ
         /r8Prj0EjJ0NJAlq+kcWoUvDJq7jQebOFW0yU8yMapVs96VIOmr5JmcoeXA4UDsm7PK0
         vgCg==
X-Gm-Message-State: AOAM532ZLiF+MNjbKK86okgv5mcMHEMCI4IzlRdy+Qth4Cre79AsCluf
        OMC4b8kJU7f+bbV0Ht/i05rrDzBz+5E=
X-Google-Smtp-Source: ABdhPJxUxifajMDFaFOO/5LDuktJ23kjeYk+FbpxU+27F4QUbtHlxJDScpWtyRQ9KdHjEqB1J8NWXA==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr4982495wmc.22.1598264882608;
        Mon, 24 Aug 2020 03:28:02 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id s20sm22217695wmh.21.2020.08.24.03.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Aug 2020 03:28:01 -0700 (PDT)
Date:   Mon, 24 Aug 2020 12:27:59 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        Moritz Fischer <mdf@kernel.org>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: zynqmp: Remove additional compatible string
 for i2c IPs
Message-ID: <20200824102759.GB25860@kozik-lap>
References: <cc294ae1a79ef845af6809ddb4049f0c0f5bb87a.1598259551.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc294ae1a79ef845af6809ddb4049f0c0f5bb87a.1598259551.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 10:59:14AM +0200, Michal Simek wrote:
> DT binding permits only one compatible string which was decribed in past by
> commit 63cab195bf49 ("i2c: removed work arounds in i2c driver for Zynq
> Ultrascale+ MPSoC").
> The commit aea37006e183 ("dt-bindings: i2c: cadence: Migrate i2c-cadence
> documentation to YAML") has converted binding to yaml and the following
> issues is reported:
> ...: i2c@ff030000: compatible: Additional items are not allowed
> ('cdns,i2c-r1p10' was unexpected)
> 	From schema:
> .../Documentation/devicetree/bindings/i2c/cdns,i2c-r1p10.yaml fds
> ...: i2c@ff030000: compatible: ['cdns,i2c-r1p14', 'cdns,i2c-r1p10'] is too
> long
> 
> The commit c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string")
> has added the second compatible string but without removing origin one.
> The patch is only keeping one compatible string "cdns,i2c-r1p14".
> 
> Fixes: c415f9e8304a ("ARM64: zynqmp: Fix i2c node's compatible string")
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
