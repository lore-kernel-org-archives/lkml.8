Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D84520775
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594192474;
	bh=QQWIvI3n12sxZJM84qe1D1kbLSnuodSVm3lx9h7j1Kc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BVyqpeJpt5W5WCheyIeTF11KSE0MLXfuOJ/eYIhvHU5n5xVDqDyTrv3Mz/y0LYLrS
	 prfZ/jDfNrVOZHopUvnOIQbF0uo6I96hE2d7B53qt8ZG3LiMr/yx+0ES39Ev7wzSma
	 0fLoqKi3VeD4JGHng9+gErdJhWhCx74jH7eCx6BU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGHHOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:14:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:41640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728737AbgGHHOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9138920760;
        Wed,  8 Jul 2020 07:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594192472;
        bh=QQWIvI3n12sxZJM84qe1D1kbLSnuodSVm3lx9h7j1Kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUr5Nh3emr2d2VtZ2uByDWFbDxUJImapQ+PSRi8vyafxckqk7hQOULPWzThpBrrGk
         HDt8tk064wrZO6HWaGga4Y8ZV/rdNmEzGad3ToB2zg2NrwpBfL62HmKHtrRsAQlmgM
         Txwt+Q/sDXNyOg6MVuMyhpoWVuA8yFMzYkuKVRX8=
Date:   Wed, 8 Jul 2020 09:14:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:REGISTER MAP ABSTRACTION" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regmap: add missing dependency on SoundWire
Message-ID: <20200708071428.GA353107@kroah.com>
References: <20200707202628.113142-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707202628.113142-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 03:26:28PM -0500, Pierre-Louis Bossart wrote:
> CONFIG_REGMAP is not selected when no other serial bus is supported.
> It's largely academic since CONFIG_I2C is usually selected e.g. by
> DRM, but still this can break randconfig so let's be explicit.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/base/regmap/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/Kconfig b/drivers/base/regmap/Kconfig
> index 0fd6f97ee523..1d1d26b0d279 100644
> --- a/drivers/base/regmap/Kconfig
> +++ b/drivers/base/regmap/Kconfig
> @@ -4,7 +4,7 @@
>  # subsystems should select the appropriate symbols.
>  
>  config REGMAP
> -	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SCCB || REGMAP_I3C)
> +	default y if (REGMAP_I2C || REGMAP_SPI || REGMAP_SPMI || REGMAP_W1 || REGMAP_AC97 || REGMAP_MMIO || REGMAP_IRQ || REGMAP_SOUNDWIRE || REGMAP_SCCB || REGMAP_I3C)

Any reason you didn't add it to the end of the list instead of adding it
to the middle?

