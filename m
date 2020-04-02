Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B447C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8742078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585815234;
	bh=MfvQQkIj2OFoUDYO9jUXwG7FM99uzokTU3uHkH5wg0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zlvCFR9JBv/juZhNsse1wBTv0LwEkypbrot3ImXRKp0pZJ88oBWN6HVaLvaucgF7+
	 EtwlfnLUov2L31+ip/AY/a3HgIV84Ag81ta/HuKYuMMmzQkhWt6N4OsGpW0c89zE0O
	 m+3/ZVJqTGDM3IDVBF2wylvgDZUfUe1y0Vy/4f8k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbgDBINw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgDBINw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:13:52 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD42F2078B;
        Thu,  2 Apr 2020 08:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585815232;
        bh=MfvQQkIj2OFoUDYO9jUXwG7FM99uzokTU3uHkH5wg0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lq/LJrlM2qvKHHPYYTWR7RsC++8+oesBipjopjmq3dFbpRSnuBHDI9xa8/9afO/s1
         GhDRHhUSi7sdxX9Ps1865zTSvyjC/n+k1bjKPrVBosVPvvP/Fg/jToNU2O/XicfKJH
         /iEcLGvV4zdP4OlFXxZOt0Y4+V/NH4W7D6Ki5VZc=
Date:   Thu, 2 Apr 2020 09:13:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        geert+renesas@glider.be, swboyd@chromium.org, robh@kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] Documentation: dt-bindings: Document 'rng-seed' for
 /chosen
Message-ID: <20200402081346.GA2548@willie-the-truck>
References: <20200402033640.12465-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402033640.12465-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Wed, Apr 01, 2020 at 08:36:40PM -0700, Florian Fainelli wrote:
> The /chosen node can have a 'rng-seed' property read as a u32 quantity
> which would contain a random number provided by the boot agent. This is
> useful in configurations where the kernel does not have access to a
> random number generator.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  Documentation/devicetree/bindings/chosen.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Thanks for doing this; I realised it was undocumented the other day when I
tried to look it up myself.

> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
> index 45e79172a646..126b31eecfeb 100644
> --- a/Documentation/devicetree/bindings/chosen.txt
> +++ b/Documentation/devicetree/bindings/chosen.txt
> @@ -28,6 +28,19 @@ mode) when EFI_RNG_PROTOCOL is supported, it will be overwritten by
>  the Linux EFI stub (which will populate the property itself, using
>  EFI_RNG_PROTOCOL).
>  
> +rng-seed
> +--------
> +
> +This property is used to initialize the kernel's entropy pool from a
> +trusted boot agent capable of providing a random number. It is parsed
> +as a u32 value, e.g.

Are you sure about this being limited to a u32 value? I thought you could
pass an arbitrary-length value here.

Will
