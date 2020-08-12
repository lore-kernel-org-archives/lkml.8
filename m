Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFCAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6483720838
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLPIE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:08:04 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53913 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:08:02 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 28CE020008;
        Wed, 12 Aug 2020 15:07:59 +0000 (UTC)
Date:   Wed, 12 Aug 2020 17:07:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-i3c@lists.infradead.org, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Cc:     Nicolas Pitre <nico@fluxnic.net>,
        Rajeev Huralikoppi <rajeev.huralikoppi@silvaco.com>,
        Conor Culhane <conor.culhane@silvaco.com>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 4/4] MAINTAINERS: Add Silvaco I3C master
Message-ID: <20200812170758.452f7048@xps13>
In-Reply-To: <20200812141312.3331-4-miquel.raynal@bootlin.com>
References: <20200812141312.3331-1-miquel.raynal@bootlin.com>
        <20200812141312.3331-4-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Miquel Raynal <miquel.raynal@bootlin.com> wrote on Wed, 12 Aug 2020
16:13:12 +0200:

> Add Conor and myself as maintainers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> 
> Changes in v2:
> * None.
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e627ed60d75a..fedd10537723 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15764,6 +15764,14 @@ S:	Maintained
>  F:	Documentation/fb/sm712fb.rst
>  F:	drivers/video/fbdev/sm712*
>  
> +SILVACO I3C DUAL-ROLE MASTER
> +M:	Miquel Raynal <miquel.raynal@bootlin.com>
> +M:	Conor Culhane <conor.culhane@silvaco.com>
> +L:	linux-i3c@lists.infradead.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/svc,i3c-master.yaml

Should be silvaco,i3c-master.yaml...

I'll correct in v3.

Thanks,
Miquèl
