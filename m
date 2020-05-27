Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720B4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45D11206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcAowrrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgE0Qkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 12:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgE0Qkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:40:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4EFC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:40:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so1721243pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uHhJpfFsD/vONvAsVvtz6rjp43VNNhX+VTZ9/q4aMwo=;
        b=qcAowrrtbV50Kn3dGfOetWYVLFdCRijJDVCzz2/S44hA4cbH0p9CfEm3wLDwR6D/Wp
         btmYZ+MR9xXEjil125KcKvcbYdDApFmoGX/fbWkynMEgE0pY9g4bDWCqbLtzDuNIiGvv
         fFmBKEX2N7z7AVUCqDjt8yIeleJGRXo0fpb+D5z1hr1fbXs/lNPteiXUn2/tSSS+obv1
         y7PvAkgfEbd3DC8mu3TSgBa5z1lMr3fcQ3orU6lrHvzd5eaH3riVLqF70K7u1TVj+B3u
         bIRCl9Kbeol6APv2lMwV1VFaz9I1mn9BfPyIvQt9KvlEejktLp8p4yrFa1Dj2DDaluRx
         clVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uHhJpfFsD/vONvAsVvtz6rjp43VNNhX+VTZ9/q4aMwo=;
        b=cJqfZwGtRjG5nMcDxRIqpW3bWpuhaYr18veBMHjgc+uIY5mS1C0qfOFqzUVbsAQBzt
         bi8y/yjsfJhfeQvIODCI+WuQZA6y1G02O/eVfyWPL18W6WZkrTx/4H1K0GWiqjZptCbw
         AWIUkto7KPyFfdLFHmhBPxQdkuwVlHx4ZgLszb7tLYMUVE/dZDz4oriB6yXHNVY8a8BD
         ZK8VqjLMgnR9vvGD1PX30eAkI1mubbLtUeAN+AR/m/ppLU5AoJoMKBNjNkJZ2qFPgUAg
         ihT3dPPu6RKySyuTBdPMOJ8k0k5czXvdGx9S3uyOudIPnFGLUbascSSxRW7MxRJR9AVT
         ZZJA==
X-Gm-Message-State: AOAM530cGMYFddKH0HHjYRTH1+ZBIUtIMeahog2MSlZLxT1BgZUqlCgt
        6aJzQ+22c4Dpb1DDD9Xt9jE=
X-Google-Smtp-Source: ABdhPJzHC3KCdoyjbJ2iHDHB8d0N/FagG0nsP6DiEt0Yt2XvH5VCJGNI8ILghdx3ImB45dPCOZVDlg==
X-Received: by 2002:a17:90a:1aa3:: with SMTP id p32mr6262456pjp.4.1590597638410;
        Wed, 27 May 2020 09:40:38 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id q145sm2425759pfq.128.2020.05.27.09.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:40:37 -0700 (PDT)
Date:   Wed, 27 May 2020 09:40:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] phy: intel: fix enum type mismatch warning
Message-ID: <20200527164035.GA1073507@ubuntu-s3-xlarge-x86>
References: <20200527134518.908624-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527134518.908624-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:45:06PM +0200, Arnd Bergmann wrote:
> clang points out that a local variable is initialized with
> an enum value of the wrong type:
> 
> drivers/phy/intel/phy-intel-combo.c:202:34: error: implicit conversion from enumeration type 'enum intel_phy_mode' to different enumeration type 'enum intel_combo_mode' [-Werror,-Wenum-conversion]
>         enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
>                               ~~~~~~~   ^~~~~~~~~~~~~
> 
> From reading the code, it seems that this was not only the
> wrong type, but not even supposed to be a code path that can
> happen in practice.
> 
> Change the code to have no default phy mode but instead return an
> error for invalid input.
> 
> Fixes: ac0a95a3ea78 ("phy: intel: Add driver support for ComboPhy")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/phy/intel/phy-intel-combo.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-combo.c
> index c2a35be4cdfb..04f7b0d08742 100644
> --- a/drivers/phy/intel/phy-intel-combo.c
> +++ b/drivers/phy/intel/phy-intel-combo.c
> @@ -199,7 +199,7 @@ static int intel_cbphy_pcie_dis_pad_refclk(struct intel_cbphy_iphy *iphy)
>  
>  static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>  {
> -	enum intel_combo_mode cb_mode = PHY_PCIE_MODE;
> +	enum intel_combo_mode cb_mode;
>  	enum aggregated_mode aggr = cbphy->aggr_mode;
>  	struct device *dev = cbphy->dev;
>  	enum intel_phy_mode mode;
> @@ -224,6 +224,8 @@ static int intel_cbphy_set_mode(struct intel_combo_phy *cbphy)
>  
>  		cb_mode = SATA0_SATA1_MODE;
>  		break;
> +	default:
> +		return -EINVAL;
>  	}
>  
>  	ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
> -- 
> 2.26.2
> 

I sent an almost identical patch:

https://lore.kernel.org/lkml/20200523035043.3305846-1-natechancellor@gmail.com/

I left out the default case since clang warns when a switch on an enum
does not handle all the values (compile time scream) versus a run time
scream like yours.

I don't have a preference for either so:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
