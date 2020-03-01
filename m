Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6040DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1CD222C4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583080291;
	bh=gTMNcMdUJArPkKni9pU1KCNQk2SzW6wgTQlNNM4CwuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7tIq/VRgyE1zHaa8Gf7g1SVLNy4fAUhB0YhgEu6kvChKqDK8P5F2OVm+vJu6kXYs
	 /rrzueZg1EyL1o17Y6SiAoxfyCbBOxe+gNzlvzjv12vfpU/voTPPWsdQR3kofR09P4
	 goOyIaaSGXyAJYrJwP+2zP5/YqH5jy/SbXWjy+aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgCAQba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 11:31:30 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34788 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgCAQb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:31:29 -0500
Received: by mail-pf1-f195.google.com with SMTP id y21so820164pfp.1;
        Sun, 01 Mar 2020 08:31:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hF9aq/Io9bovStuf4wtcdOmPjzW4yrdQMyk+A3d5xnM=;
        b=bPMSRZuw3q6OS/GsS7are2EOShrfBRiAOoqGhPG/pDxEgiBZNGYY/bL+EO5fVYX7i2
         9jaEPCnM2iuGaRKn+MjpOPxzhGd5Tzm3qf19eeQjBTYbI9CvcPA3Txx9gN41YdZuOwxQ
         ncMiGVGAG2wbUvTpeK+9lixanKg7hPcEx8J4NyaycopE4QVBTzW9HSZw6j1zovxsUk0Z
         MJeXkNnKoPVpG60zi7ki21yxZ1tmF2mBY38WhPLVGLA6nUVKLo+yWqvHWzQewG/xA37I
         e2E07lvnOkBZwAMo2zRIcxxdu5bkg51kl8mOuvZohJkW0fXr3LEoVaRrGgiHmcxXS7Hc
         bQag==
X-Gm-Message-State: APjAAAWQVyNgOVadCLyt8aEdaV47WT9dKiDSS6M5dH2v64fkqlMwKbdo
        kAk+1ZpkCCbF+vr8qTlnrzM=
X-Google-Smtp-Source: APXvYqwEzOceSVbWacHwehKTSrTHhWIPujXAvb+qMDIhrfhBgj3owTtwM3qyOJcT1YLUTKHsyoAaGQ==
X-Received: by 2002:a63:1044:: with SMTP id 4mr15499647pgq.412.1583080288534;
        Sun, 01 Mar 2020 08:31:28 -0800 (PST)
Received: from localhost ([2601:647:5b00:710:c2fa:3aa3:193c:db86])
        by smtp.gmail.com with ESMTPSA id g9sm9043227pfi.37.2020.03.01.08.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 08:31:27 -0800 (PST)
Date:   Sun, 1 Mar 2020 08:31:26 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org,
        linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1 7/7] firmware: intel_stratix10_service: add depend on
 agilex
Message-ID: <20200301163126.GB7992@epycbox.lan>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
 <1581696052-11540-8-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581696052-11540-8-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 10:00:52AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add depend on Agilex for Intel Agilex SoC platform.
> 
Acked-by: Moritz Fischer <mdf@kernel.org>
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/firmware/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index ea869ad..8007d4a 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -206,7 +206,7 @@ config FW_CFG_SYSFS_CMDLINE
>  
>  config INTEL_STRATIX10_SERVICE
>  	tristate "Intel Stratix10 Service Layer"
> -	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC
> +	depends on (ARCH_STRATIX10 || ARCH_AGILEX) && HAVE_ARM_SMCCC
>  	default n
>  	help
>  	  Intel Stratix10 service layer runs at privileged exception level,
> -- 
> 2.7.4
> 
