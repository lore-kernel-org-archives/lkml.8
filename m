Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A16E5C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70CF7206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595535017;
	bh=eNKpwSJoIH/QWZoG8b/RRJYSwe76+p44J5pfJxf14y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjalX2xDkBcvHdAYdh9Mw9W9VV5H2SGQH6XRMubGPnV8B+4KU3MILw4DHLoXvT0Hu
	 r5KTdySF6sVytP74TeQWwH5d4u2e2BWU1x/ySjjv9G4KDM2okSgsU5JH/lvYHGP0Du
	 I/ghT+F74l66JdiIOMfsT960ZnH/xFDKc1YCBkg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgGWUKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:10:16 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36719 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgGWUKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:10:16 -0400
Received: by mail-io1-f68.google.com with SMTP id t131so7605916iod.3;
        Thu, 23 Jul 2020 13:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6qKebxTelJllWzX+vBkDTjUwXCky31GlyoLB/Us13RU=;
        b=m1KZXjXETbceHodYwrOXIHlhGjcabQvxNMPpbhG4AKQoamlCNiCBOBvNyyZaklX3ae
         jiA9R1M0KJo0A8IShcK8PKYQASEThHOXg6BReGMn0tmJvr5/n5buuq7dbouRav8g17lL
         zlDlZ7QgUd/NiHGGZuzR8iYNx3QUzkJuUg/SsfNJKrMRBlPgGTT2JBl+/1zb6RuUEllQ
         VJmjupLDalFl4IaZ9kWlvI9fqd541wzVakPmrWZYC0mrbgiOajq7n1WysUHJx6ALcq3q
         OVQyRQpKpdkBARQRYNJRqE3/gLjUI2/8ydO4E3AV4XkINJ874Jk5nwobFWUxdwwrovzh
         +ExQ==
X-Gm-Message-State: AOAM532evdEofb3v68iq1JnLpI0fxYl0MX5uvw4xSuLeruByEISelU8m
        k3+KC1V2VX6daQpH1UbzGg==
X-Google-Smtp-Source: ABdhPJxGEX8Ak0s03CYs/Oeyc9EzvHmJLaxCDLLXIMq2atxOMK1p55BpCBZEw/SWFXye1D4dLGknwA==
X-Received: by 2002:a05:6602:2184:: with SMTP id b4mr6883379iob.156.1595535015110;
        Thu, 23 Jul 2020 13:10:15 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id k7sm1963383iot.20.2020.07.23.13.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 13:10:14 -0700 (PDT)
Received: (nullmailer pid 783482 invoked by uid 1000);
        Thu, 23 Jul 2020 20:10:13 -0000
Date:   Thu, 23 Jul 2020 14:10:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@xilinx.com,
        saikrishna12468@gmail.com
Subject: Re: [PATCH v2 1/2] dt-bindings: reset: Updated binding for Versal
 reset driver
Message-ID: <20200723201013.GA783435@bogus>
References: <1595402165-8282-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1595402165-8282-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595402165-8282-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 12:46:04 +0530, Sai Krishna Potthuri wrote:
> Added documentation and Versal reset indices to describe
> about Versal reset driver bindings.
> In Versal all reset indices includes Class, SubClass, Type, Index
> information whereas class refers to clock, reset, power etc.,
> Underlying firmware in Versal have such classification and expects
> the ID to be this way.
> [13:0] - Index bits
> [19:14] - Type bits
> [25:20] - SubClass bits
> [31:26] - Class bits.
> 
> Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
> ---
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
>  .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 4 deletions(-)
>  create mode 100644 include/dt-bindings/reset/xlnx-versal-resets.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
