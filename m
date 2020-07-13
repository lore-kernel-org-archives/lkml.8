Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E278EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0B2206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594638689;
	bh=q/ufI9pax7jCOPNndBGI42Z7xYEkMCMsKVzBMf55igs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mdSXjukDKCQ59iY80Qyq6/B7QuwCJFH2RVuY4+dXcjiP4Xh30yA+ce+IGDkNFyvpi
	 dal//yN15EVR4db8ah3lMl6t7AfquwN7Ru+W29cJnkQ5swLkwNrqUuhsLFNs05MQzC
	 ckNeQWf3qIk8P8zYmBOWKXkcZadWz+zshy4MCDjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgGMLL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgGMLL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:11:27 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8DD620738;
        Mon, 13 Jul 2020 11:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594638687;
        bh=q/ufI9pax7jCOPNndBGI42Z7xYEkMCMsKVzBMf55igs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m1lYZjr481W0UsW/jUxDhuBrTyGPmajq7vz4Sf+oxtHIBjJMniYjmocprjBr6zK50
         8sUF0bpu2+Hd5XUYwKl5n9ovgA+TgTGozPOrCsFokdwOvvXOYtbwBBfAB/kIiw8bYZ
         iQSBkr0zQRSU3hJLHlSAqSIaCeY4WU0Mb/gHtQzQ=
Date:   Mon, 13 Jul 2020 16:41:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, linux-kernel@vger.kernel.org, maxime@cerno.tech,
        mparab@cadence.com, yamonkar@cadence.com, nsekhar@ti.com,
        tomi.valkeinen@ti.com, jsarha@ti.com, praneeth@ti.com
Subject: Re: [PATCH v3 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Message-ID: <20200713111120.GI34333@vkoul-mobl>
References: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
 <1594633112-4155-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594633112-4155-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-07-20, 11:38, Swapnil Jakhade wrote:
> Add new PHY attribute max_link_rate to struct phy_attrs.
> Add a pair of PHY APIs to get/set all the PHY attributes.
> Use phy_set_attrs() to set attribute values in the PHY provider driver.
> Use phy_get_attrs() to get attribute values in the controller driver.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  include/linux/phy/phy.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..7fb59359ab7b 100644
> --- a/include/linux/phy/phy.h
> +++ b/include/linux/phy/phy.h
> @@ -115,10 +115,12 @@ struct phy_ops {
>  /**
>   * struct phy_attrs - represents phy attributes
>   * @bus_width: Data path width implemented by PHY
> + * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
>   * @mode: PHY mode
>   */
>  struct phy_attrs {
>  	u32			bus_width;
> +	u32			max_link_rate;
>  	enum phy_mode		mode;
>  };
>  
> @@ -231,6 +233,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  	phy->attrs.bus_width = bus_width;
>  }
> +
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
> +{
> +	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
> +}

we already have APIs for mode and bus_width so why not add one for
link_rate and call them?

Also I see you are using phy_set_attrs() in second patch, why add
phy_get_attrs() when we have no user?

>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *phy_optional_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> @@ -389,6 +401,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  	return;
>  }
>  
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	return;
> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)
> +{
> +	return;
> +}
> +
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {
>  	return ERR_PTR(-ENOSYS);
> -- 
> 2.26.1

-- 
~Vinod
