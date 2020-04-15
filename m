Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FC8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D8B2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="reeYQ8Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895539AbgDOJaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895527AbgDOJaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:30:18 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A2C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:30:17 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so5039305wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OBdwBYebBJuoimbTaQN5QWpwweg/EKkjkWJ4yfY8dv8=;
        b=reeYQ8WnjncSc2T7Jajbw6ovboRJQxLghh5cijCOXyREaR7Dl+S8j8D2XG5mStUhwl
         mVaew31PHI9qkmosAPw9GSGyLyVe5zlsjJcDZbr2vAxywVnS2SzWx3Uw8e6jEuwJHU1S
         iovJsQeMZQzBbgYX7Ak1PVka6TVJl0082uVSrQOu3EXpRLsnNLNh2+LkgyIK6Qq6qylD
         inE+/o9g1hR6fynzjHgA+07E+Z+6ltXE+i3BF6w7+/XFpA60n0zNBMiVB7MNGlepPvYQ
         Q7pAST5/u+Eea4/A9OZEen4ukNfsQHOesmlMaqlowLF/1zDMwgQ8VPrh9/fzd0xNJdB+
         LzDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OBdwBYebBJuoimbTaQN5QWpwweg/EKkjkWJ4yfY8dv8=;
        b=jmUW3YSsjlX9++TkJ5crMQt9lYUbmEBhsEtHQDnlVTbXNblFTMa3ZewB9BHDHFMhpB
         6G1JbYcKSsSx4hpX6jSG6tB8RPZPC/R8uWHmPpUbS3RtifGdBCUXWHZ1NI+IjDpDN1lX
         5RHkuWErDECGykf3eFBE9dUp421Lx8RE91KRF360hFp7I7E/DWdlUiABLbCF88OVPXdk
         aNi8nOQIxMoagHxx5oygMEi8TNDOIt9Byf21dC/ugc9WLEKKPsQyP/lGP4Twzept1wqa
         hJv7HNlQYdfKIFoQF7SzVjoanQJf7XaqZUezmXBSafQEzo5xL7aVGfpu52CmAdXt/tTs
         +Qsg==
X-Gm-Message-State: AGi0PuZhRGE+5aOhtLj92wyL+SWSJJprnA7h0fqXXmsf+AG7yjAQgRW4
        dtVVnQmVcRpKIEujY86oPLZByA==
X-Google-Smtp-Source: APiQypJzG0axis5t2o+sttyC3y5d8wml7TaIbWStXxtN12O7zTtqqsicoGy8Ok1q7cM6FamBaWXPaw==
X-Received: by 2002:a5d:6607:: with SMTP id n7mr5205782wru.150.1586943016404;
        Wed, 15 Apr 2020 02:30:16 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id h13sm11465797wrs.22.2020.04.15.02.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 02:30:15 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:31:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Subject: Re: [PATCH v5 1/4] mfd: syscon: Add fwnode_to_regmap
Message-ID: <20200415093116.GH2167633@dell>
References: <cover.1585103753.git.eswara.kota@linux.intel.com>
 <9953bb25281397553cb87b09d641c968d8432dd9.1585103753.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9953bb25281397553cb87b09d641c968d8432dd9.1585103753.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020, Dilip Kota wrote:

> Traverse regmap handle entry from firmware node handle.
> 
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> ---
> Changes on v5:
>   No changes
> 
> Changes on v4:
>   No changes
> 
>  drivers/mfd/syscon.c       | 8 ++++++++
>  include/linux/mfd/syscon.h | 6 ++++++
>  2 files changed, 14 insertions(+)

I think you'll find it very difficult to have a patch merged if you do
not send it to any Maintainers of the associated subsystem(s).

Did you use `scripts/get_maintainer.pl` at all?

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index e22197c832e8..08064ffc5394 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -178,6 +178,14 @@ struct regmap *device_node_to_regmap(struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(device_node_to_regmap);
>  
> +struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
> +{
> +	struct device_node *np = to_of_node(fwnode);
> +
> +	return device_node_get_regmap(np, false);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_to_regmap);
> +
>  struct regmap *syscon_node_to_regmap(struct device_node *np)
>  {
>  	if (!of_device_is_compatible(np, "syscon"))
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index 112dc66262cc..a024dd88bdd4 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -18,6 +18,7 @@ struct device_node;
>  
>  #ifdef CONFIG_MFD_SYSCON
>  extern struct regmap *device_node_to_regmap(struct device_node *np);
> +extern struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode);
>  extern struct regmap *syscon_node_to_regmap(struct device_node *np);
>  extern struct regmap *syscon_regmap_lookup_by_compatible(const char *s);
>  extern struct regmap *syscon_regmap_lookup_by_phandle(
> @@ -29,6 +30,11 @@ static inline struct regmap *device_node_to_regmap(struct device_node *np)
>  	return ERR_PTR(-ENOTSUPP);
>  }
>  
> +static inline struct regmap *fwnode_to_regmap(struct fwnode_handle *fwnode)
> +{
> +	return ERR_PTR(-ENOTSUPP);
> +}
> +
>  static inline struct regmap *syscon_node_to_regmap(struct device_node *np)
>  {
>  	return ERR_PTR(-ENOTSUPP);

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
