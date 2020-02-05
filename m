Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC674C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDD820672
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 23:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="o+udOMUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbgBEXxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 18:53:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45738 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEXxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 18:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QxM7vFDpeUoZ8IDa9CFBEsGoHA6Q5iGUKmBkcPl6X2M=; b=o+udOMURKZLfOAnHR78OlJ0Mw
        ObYjpnWzc0G8G332wh9jnadCgnlTtlUsGc0rpAP2eaL8xHeTv6ntJ+cgoxMpfO99FNwOTy7hyDTWM
        jr9kCvjZHyxT74Z1U4K8EsXGDFJgvAukocoMmpIfrFoRHfIPlL28FY52V/Vcp0FPB9BFl7YRpI8V4
        WDg35zfmXQFIG1zZal1eD/Ga+rn2kAjV15w8wk7bMh/ZOKgYLOvn5FW+8khnEsbJOTCnlm+SdZVQ9
        7hJy9+XAmJwpcfpcO5EEXgIJuvCbVMFTPxl10EYNARVAlaRWB0ZgKYso7tnupDjJeSWcKIpn07pcS
        q2LMTSQ/A==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:43986)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1izUU7-0003jB-Oz; Wed, 05 Feb 2020 23:53:31 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1izUU3-0002IX-C8; Wed, 05 Feb 2020 23:53:27 +0000
Date:   Wed, 5 Feb 2020 23:53:27 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arnd@arndb.de, linus.walleij@linaro.org, akpm@linux-foundation.org,
        nsekhar@ti.com, mchehab+samsung@kernel.org,
        bgolaszewski@baylibre.com, armlinux@m.disordat.com,
        benjamin.gaignard@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] arm: make kexec depend on MMU
Message-ID: <20200205235327.GV25745@shell.armlinux.org.uk>
References: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b595d37283f043df78259221f2b7d18e0cb0ce5.1580942558.git.stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Does patch 8951/1, which has been merged into mainline, not fix this?

On Wed, Feb 05, 2020 at 11:43:44PM +0100, Stefan Agner wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> arm nommu config with KEXEC enabled doesn't compile
> arch/arm/kernel/setup.c: In function 'reserve_crashkernel':
> arch/arm/kernel/setup.c:1005:25: error: 'SECTION_SIZE' undeclared (first
> use in this function)
>              crash_size, SECTION_SIZE);
> 
> since 61603016e212 ("ARM: kexec: fix crashkernel= handling") which is
> over one year without anybody noticing. I have only noticed beause of
> my testing nommu config which somehow gained CONFIG_KEXEC without
> an intention. This suggests that nobody is actually using KEXEC
> on nommu ARM configs. It is even a question whether kexec works with
> nommu.
> 
> Make KEXEC depend on MMU to make this clear. If somebody wants to enable
> there will be probably more things to take care.
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> Reviewed-by: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 96dab76da3b3..59ce8943151f 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1906,6 +1906,7 @@ config KEXEC
>  	bool "Kexec system call (EXPERIMENTAL)"
>  	depends on (!SMP || PM_SLEEP_SMP)
>  	depends on !CPU_V7M
> +	depends on MMU
>  	select KEXEC_CORE
>  	help
>  	  kexec is a system call that implements the ability to shutdown your
> -- 
> 2.25.0
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
