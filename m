Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8469C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D172072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="AOYso6rM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgCFJws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:52:48 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:39381 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgCFJws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:52:48 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 6681923E62;
        Fri,  6 Mar 2020 10:52:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583488364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+JZ0GQ0s2L+aiUSrf43dcCeKDSpbaMts6VHhOyEnzs=;
        b=AOYso6rM7E59jrFMqnhq+cXh0M0H6oUnJGoJEbn7Rl8jlR77/c2vjvmdH9F4baD6ovufmy
        LFBYlaP8nX3Tw4N2BrDGiMf4cOvMGT7/+AzGBZOYJ7vg1cMkCKyw6GdzErYXx0UtYW3xBw
        vtmRUJECXrlufZ/WtybT+xVdK5oVm4g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Mar 2020 10:52:42 +0100
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Add fsl,ls1028a-dspi compatible
In-Reply-To: <20200218171418.18297-1-michael@walle.cc>
References: <20200218171418.18297-1-michael@walle.cc>
Message-ID: <2ef39885fc5aa0404a88e82921c4586a@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 6681923E62
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         NEURAL_HAM(-0.00)[-0.635];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[arm.com,kernel.org,nxp.com,gmail.com];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-02-18 18:14, schrieb Michael Walle:
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> changes since v1:
>  - none, this is a new patch
> 
>  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> index 162e024b95a0..a6e4bc5e96db 100644
> --- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> +++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> @@ -7,6 +7,7 @@ Required properties:
>  		"fsl,ls2080a-dspi" followed by "fsl,ls2085a-dspi"
>  		"fsl,ls1012a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
>  		"fsl,ls1088a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
> +		"fsl,ls1028a-dspi" followed by "fsl,ls1021a-v1.0-dspi"
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain SPI controller interrupt
>  - clocks: from common clock binding: handle to dspi clock.

This patch is be superseeded by
   https://lore.kernel.org/lkml/20200302001958.11105-2-olteanv@gmail.com/

-michael
