Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BF2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF9472065D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 00:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Cut0rtNt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHKAUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 20:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgHKAUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 20:20:32 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807AFC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 17:20:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B21A158;
        Tue, 11 Aug 2020 02:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597105230;
        bh=keX5QvlxidUvTCX6mbkM8E28WiUaAlc2f2K8eUfsH9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cut0rtNtcxP6H+KUsa1VHoQftdsMyeidFBWG0CQeBZzcsicFH0jVxZY2TNQmWg31n
         x3RGj28QbVzPW2ptmrKQLPXfonFRtyEpjl5ZhbL8R49/oaFi23LYjc24UQ5KPGsKUI
         IIbFrISoCIc7ONOQ/6o9EK36htE44B3qqQ4okc/Y=
Date:   Tue, 11 Aug 2020 03:20:17 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     vkoul@kernel.org, kishon@ti.com, linux-kernel@vger.kernel.org,
        maxime@cerno.tech, mparab@cadence.com, yamonkar@cadence.com,
        nsekhar@ti.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        praneeth@ti.com
Subject: Re: [PATCH v4 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Message-ID: <20200811002017.GA6845@pendragon.ideasonboard.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
 <1594968633-12535-2-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594968633-12535-2-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

Thank you for the patch.

On Fri, Jul 17, 2020 at 08:50:32AM +0200, Swapnil Jakhade wrote:
> Add new PHY attribute max_link_rate to struct phy_attrs.
> Add a pair of PHY APIs to get/set all the PHY attributes.
> Use phy_get_attrs() to get attribute values and phy_set_attrs()
> to set attribute values.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  include/linux/phy/phy.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
> index bcee8eba62b3..5d8ebb056c1d 100644
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
> @@ -231,6 +233,20 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
>  {
>  	phy->attrs.bus_width = bus_width;
>  }
> +
> +static inline void phy_get_attrs(struct phy *phy, struct phy_attrs *attrs)
> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(attrs, &phy->attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);
> +}
> +
> +static inline void phy_set_attrs(struct phy *phy, struct phy_attrs attrs)

Passing the second argument by (const) pointer would be more efficient.

> +{
> +	mutex_lock(&phy->mutex);
> +	memcpy(&phy->attrs, &attrs, sizeof(struct phy_attrs));
> +	mutex_unlock(&phy->mutex);
> +}

These two functions should be documented. I'm a but puzzled by the need
to protect the data with phy->mutex. Isn't phy->attrs static,
initialized at driver probe time, and then never changed ? If so I think
we can just access it directly, both in the PHY provider and consumer.

If the data can change at runtime, then the documentation of these
functions need to explain what can change, and when.

>  struct phy *phy_get(struct device *dev, const char *string);
>  struct phy *phy_optional_get(struct device *dev, const char *string);
>  struct phy *devm_phy_get(struct device *dev, const char *string);
> @@ -389,6 +405,16 @@ static inline void phy_set_bus_width(struct phy *phy, int bus_width)
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

-- 
Regards,

Laurent Pinchart
