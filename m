Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9942C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE656208B8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fanpFU30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgFPTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:43:02 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:16648 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728144AbgFPTnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:43:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ee920940000>; Tue, 16 Jun 2020 12:42:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 16 Jun 2020 12:43:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 16 Jun 2020 12:43:01 -0700
Received: from [10.26.75.222] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 16 Jun
 2020 19:42:53 +0000
Subject: Re: [PATCH] ASoC: tegra: Fix reference count leaks.
To:     <wu000273@umn.edu>, <kjlu@umn.edu>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        Edward Cragg <edward.cragg@codethink.co.uk>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200613204422.24484-1-wu000273@umn.edu>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <9492fa91-067b-f74f-1a52-a2622d8f28d6@nvidia.com>
Date:   Tue, 16 Jun 2020 20:42:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613204422.24484-1-wu000273@umn.edu>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592336532; bh=Dp/0r6Nw2uRw3rP0FQK/EUznQLmj2KVDZ1kdtwhRPqg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fanpFU3012dPk+RxNw8Z8OH9a8yVg3Ep2EZFgySPCXu7I7bateQDqSJXuqeMK5XXM
         b7ltzhNCUAFQ8kjhZVL73eUgCoRh2ze1h/gKVYGUmvPjwmNO4+LMqe5hLv+WOOXIP0
         rfFqnxn1y3pd9GuzXpP4Fqpbg+YD3DQvt+FaPJgxy7MEOdHnExRlZwiZ9p5vIgz2Hj
         vuy3qreGl0kkuJXyEIxd21POD/SvJPIIOsVmjyJleSeY6GBbfZxR6OTFhJPENrRQ05
         c2LxeDWz8GsTOVXRiw43JYE8vYMaHMZ+GoaawdaJOxFOcVR1XAxzezJQvJjA40L/fV
         0V4lObTvqbCeg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/06/2020 21:44, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count if pm_runtime_put is not called in
> error handling paths. Call pm_runtime_put if pm_runtime_get_sync fails.
> 
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>
> ---
>  sound/soc/tegra/tegra30_ahub.c | 4 +++-
>  sound/soc/tegra/tegra30_i2s.c  | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra30_ahub.c b/sound/soc/tegra/tegra30_ahub.c
> index 635eacbd28d4..156e3b9d613c 100644
> --- a/sound/soc/tegra/tegra30_ahub.c
> +++ b/sound/soc/tegra/tegra30_ahub.c
> @@ -643,8 +643,10 @@ static int tegra30_ahub_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(dev);
>  		return ret;
> +	}
>  	ret = regcache_sync(ahub->regmap_ahub);
>  	ret |= regcache_sync(ahub->regmap_apbif);
>  	pm_runtime_put(dev);
> diff --git a/sound/soc/tegra/tegra30_i2s.c b/sound/soc/tegra/tegra30_i2s.c
> index d59882ec48f1..db5a8587bfa4 100644
> --- a/sound/soc/tegra/tegra30_i2s.c
> +++ b/sound/soc/tegra/tegra30_i2s.c
> @@ -567,8 +567,10 @@ static int tegra30_i2s_resume(struct device *dev)
>  	int ret;
>  
>  	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		pm_runtime_put(dev);
>  		return ret;
> +	}
>  	ret = regcache_sync(i2s->regmap);
>  	pm_runtime_put(dev);

Thanks.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
