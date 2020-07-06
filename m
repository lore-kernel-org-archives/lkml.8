Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3159520715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d6OFUJ0p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgGFPQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:16:33 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8577 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgGFPQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:16:32 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f033fe70000>; Mon, 06 Jul 2020 08:14:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 08:16:32 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 06 Jul 2020 08:16:32 -0700
Received: from [10.26.72.33] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 15:16:20 +0000
Subject: Re: [PATCH 7/8] ASoC: tegra: tegra20_das: remove always-true
 comparison
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.de>, <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200702165901.164100-1-pierre-louis.bossart@linux.intel.com>
 <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <1a7c7025-7689-54a0-dbc0-00b5c1fcd0f1@nvidia.com>
Date:   Mon, 6 Jul 2020 16:16:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702165901.164100-8-pierre-louis.bossart@linux.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594048487; bh=S3qOsW4jy3ZymnO+RQ9II2XOQKKoroUl5+GuXsnukfU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=d6OFUJ0pQtg6JQNVFCgkn/XX5QvOjZQA7YGkzOh5jeFI1EEr9d+9uXjmZBMHygc7i
         +fMiz5QaZP2St9MCr/wjAiDsGA3nMwV9kXM12bX28umi38ousxAkAwYFukFs2+qr9m
         DCXLZZuViVo6JARF8034PM2zUKb1ihpLn+de3tmDU2jrBRyOr0vEwRg86NdPauItf4
         lMLsoErnsyCo6EWjSVqqgECpya2Upq1awjOuxQRTSbpVVcDhRZ3bb7a3UXdcX1futz
         EbIQZhihEllFEKDsBgXLOX++Y4glQJTFP9jMsvK+dVkDw0Ou1BJJiDy1U19xd9q99L
         6MUUXS/P0jwUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/07/2020 17:59, Pierre-Louis Bossart wrote:
> Fix W=1 warning:
> 
> sound/soc//tegra/tegra20_das.c:101:11: warning:
> comparison of unsigned expression >= 0 is always true [-Wtype-limits]
>   101 |  if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
>       |           ^~
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/tegra/tegra20_das.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/tegra/tegra20_das.c b/sound/soc/tegra/tegra20_das.c
> index 1070b2710d5e..79dba878d854 100644
> --- a/sound/soc/tegra/tegra20_das.c
> +++ b/sound/soc/tegra/tegra20_das.c
> @@ -98,8 +98,7 @@ EXPORT_SYMBOL_GPL(tegra20_das_connect_dac_to_dap);
>  
>  static bool tegra20_das_wr_rd_reg(struct device *dev, unsigned int reg)
>  {
> -	if ((reg >= TEGRA20_DAS_DAP_CTRL_SEL) &&
> -	    (reg <= LAST_REG(DAP_CTRL_SEL)))
> +	if (reg <= LAST_REG(DAP_CTRL_SEL))
>  		return true;
>  	if ((reg >= TEGRA20_DAS_DAC_INPUT_DATA_CLK_SEL) &&
>  	    (reg <= LAST_REG(DAC_INPUT_DATA_CLK_SEL)))
> 

Thanks!

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
