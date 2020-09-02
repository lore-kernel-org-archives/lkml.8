Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EADC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD892068E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ao8TNLwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIBA0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:26:33 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:34548 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgIBA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:26:32 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C1B1AAF2;
        Wed,  2 Sep 2020 02:26:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1599006389;
        bh=GrN9fJ8LgOOnhT1gG8KHelijPX0Qx2QQtxml9aRHrv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ao8TNLwCwxWKkc7l/Rnkw6rQVLCNmnHEgsb+1eCoz/s5TraoNjReFTOzMqXdLoEcm
         +CjTwikwMRuvxa1Vi5C/SICcSGgvXRuVzGjHVSFvk+NEExtkNIWcEtgHrPpKaNvhy1
         /ZYDDAbn58iuJl9sHzIizLJQzW01/BKNoNeCk/+k=
Date:   Wed, 2 Sep 2020 03:26:08 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, mparab@cadence.com, yamonkar@cadence.com,
        nsekhar@ti.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v5 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Message-ID: <20200902002608.GD14351@pendragon.ideasonboard.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598293711-23362-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

Thank you for the patch.

On Mon, Aug 24, 2020 at 08:28:30PM +0200, Swapnil Jakhade wrote:
> Add new PHY attribute max_link_rate to struct phy_attrs.
> Add a pair of PHY APIs to get/set all the PHY attributes.
> Use phy_get_attrs() to get attribute values and phy_set_attrs()
> to set attribute values.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  include/linux/phy/phy.h | 43 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..924cd1a3deea 100644
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
> @@ -231,6 +233,37 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  	phy->attrs.bus_width = bus_width;
>  }
> +
> +/**
> + * phy_get_attrs() - get the values for PHY attributes.
> + * @phy: the phy for which to get the attributes
> + * @attrs: current PHY attributes that will be returned
> + *
> + * Intended to be used by phy consumers to get the current PHY attributes
> + * stored in struct phy_attrs.
> + */
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);

Why is the mutex required, what does it guard against ?

> +}
> +
> +/**
> + * phy_set_attrs() - set PHY attributes with new values.
> + * @phy: the phy for which to set the attributes
> + * @attrs: the &struct phy_attrs containing new PHY attributes to be set
> + *
> + * This can be used by PHY providers or PHY consumers to set the PHY
> + * attributes. The locking is used to protect updating attributes when
> + * PHY consumer is doing some PHY ops.
> + */
> +static inline void phy_set_attrs(struct phy *phy, const struct phy_attrs *attrs)
> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(&phy->attrs, attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);
> +}
>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *phy_optional_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> @@ -389,6 +422,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  	return;
>  }
>  
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	return;

You can drop the return statement.

> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, const struct phy_attrs *attrs)
> +{
> +	return;

Here too.

> +}
> +
>  static inline struct phy *phy_get(struct device *dev, const char *string)
>  {
>  	return ERR_PTR(-ENOSYS);

-- 
Regards,

Laurent Pinchart
