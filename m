Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76289C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43804208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iR/Hnhsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgBUF2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:28:00 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40158 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgBUF2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 00:28:00 -0500
Received: by mail-lf1-f66.google.com with SMTP id c23so555859lfi.7;
        Thu, 20 Feb 2020 21:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=53gVHOVv+aazLVffnAnZapThLxuxSIM6yvCzFavsnfo=;
        b=iR/HnhswRBJL0Eb1YhkshQ71r8WZae6s4qyPXEHFu1b3G/BwJGgfoTZEN/7NbiTeVY
         wJcjGcaRiLLkplm0dxXtJtMKSRd4S+h5thVN0BJ6pzca7M+/D/UoVd7ueUSDNxKbuih2
         cx7eRCAaMXE6p97TXrl2RtHyvO87oraaNkt7CuF773rqooTm+EMV2zStQXm5dkmGwPQP
         tEa4is0Oc6e0xGlVo7YO+5hutXKoTwxlUZzlHXz720uWKTaBVTI8iJKnZC5jIuEJbBaS
         js5XdhRE5VDOCWHwlA4G3FtMaj3izXanmukoI0P0aOnBBHCSDSoHUUfBluGYl6OWOgn8
         NdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=53gVHOVv+aazLVffnAnZapThLxuxSIM6yvCzFavsnfo=;
        b=bMjgUz/cLtwZbMJ6gMIWGsfB7b2kRslfjC2ASNNOmSByb7ppJCbTBSxtsB05jlh9Hb
         6RuNLGbAzQvb2+dHso7ahr3Sr+wP3y9GSbdmcRgsqNYZ3I86BXG2QHSg2OXKo85/Hgc2
         G4t/q9gOhBc3Hpf/1p3umNM9t2xDqH7XN04+19oX6pN96LaKk2jiFRjt4kqH+OKBQ0R6
         E+XiS7uKRUte8yX6vWI1u9BIOsdlToYkRMSJ7WF5mNi86NKgy6cO8lhNz49ggZDVlDhr
         tZVU0tt6Xde3wFp0SJgzwF+kfPB1nlxvwnG+AzcsXcnI2jvbGb6jig1tYI1ld6/efaz1
         UUlA==
X-Gm-Message-State: APjAAAWT3eXDNKjr2dekf5bbImVVZHOQBanY5KLYTlWcryZsSC04zEpg
        IWYAOgPq4QlhJg3AstLJMLs=
X-Google-Smtp-Source: APXvYqyiPLAcLmfgNz8dfxXwbYBLTptG6VXSzZJ+C7dVJ8PZhJq6nscU8y34IZsubI8W7nKWqe2djA==
X-Received: by 2002:ac2:44a7:: with SMTP id c7mr7647289lfm.32.1582262877961;
        Thu, 20 Feb 2020 21:27:57 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id f16sm876606ljn.17.2020.02.20.21.27.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 21:27:57 -0800 (PST)
Subject: Re: [PATCH v3 02/10] ASoC: tegra: add support for CIF programming
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com
References: <1582180492-25297-1-git-send-email-spujar@nvidia.com>
 <1582180492-25297-3-git-send-email-spujar@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <8c39dbe9-a2b9-62e8-3a26-32cc747d0e60@gmail.com>
Date:   Fri, 21 Feb 2020 08:27:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1582180492-25297-3-git-send-email-spujar@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

20.02.2020 09:34, Sameer Pujar пишет:
> Audio Client Interface (CIF) is a proprietary interface employed to route
> audio samples through Audio Hub (AHUB) components by inter connecting the
> various modules.
> 
> This patch exports an inline function tegra_set_cif() which can be used,
> for now, to program CIF on Tegra210 and later Tegra generations. Later it
> can be extended to include helpers for legacy chips as well.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> ---
>  sound/soc/tegra/tegra_cif.h | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 sound/soc/tegra/tegra_cif.h
> 
> diff --git a/sound/soc/tegra/tegra_cif.h b/sound/soc/tegra/tegra_cif.h
> new file mode 100644
> index 0000000..ecc0850
> --- /dev/null
> +++ b/sound/soc/tegra/tegra_cif.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * tegra_cif.h - TEGRA Audio CIF Programming
> + *
> + * Copyright (c) 2020 NVIDIA CORPORATION.  All rights reserved.
> + *
> + */
> +
> +#ifndef __TEGRA_CIF_H__
> +#define __TEGRA_CIF_H__

For completeness here should be:

#include <linux/regmap.h>

...
> +static inline void tegra_set_cif(struct regmap *regmap, unsigned int reg,
> +				 struct tegra_cif_conf *conf)
> +{
...
> +	regmap_update_bits(regmap, reg, TEGRA_ACIF_UPDATE_MASK, value);
> +}
> +
> +#endif
> 

Otherwise:

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
