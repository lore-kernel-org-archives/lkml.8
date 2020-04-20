Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BDDC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E041206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eTUBHHkJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgDTOn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:43:27 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7940 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgDTOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:43:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9db4d10000>; Mon, 20 Apr 2020 07:42:25 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Apr 2020 07:43:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Apr 2020 07:43:26 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 14:43:26 +0000
Received: from [10.26.73.5] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 20 Apr
 2020 14:43:24 +0000
Subject: Re: [PATCH] mfd: max77620: Use single-byte writes on MAX77620
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200417170913.2552327-1-thierry.reding@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b884da97-5927-5742-b059-be27d43b27ea@nvidia.com>
Date:   Mon, 20 Apr 2020 15:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417170913.2552327-1-thierry.reding@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587393745; bh=XCluQ01BuIz1K/cusH78+6Zmrf9POiBG10AUiUsZTII=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=eTUBHHkJDwcg/XWRsmWRTAKc5me9ZJ6YqWvvlDyla0aM+Job+VmqftQpwINiYiJw3
         pp6QwYOjVx11OxgPFM9+YqfJ2Swr3J6wnoj5G3aB0qof6Fn4dAwJic0irOlTHNtHjg
         7/AQyFK6lSqHmUney1OUcV6/14LJ0MQpWUZOeKMU2Pl0psXp3Oik7UeOMyPPpkGGRI
         aAc6QX2cEcQfcs9LhE6bZYKZ49nB1pMQhR3rCRF8J4RA5t4Be77SXmhl67LS2iGHMI
         KWkMQOTE2jLCsQEc8EzpNBfpzzTD8eG5jvJCYxTOcq5x0t32nAxPJBlLi+P+5/6QAm
         jZc3E7ezcthCA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2020 18:09, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The MAX77620 doesn't support bulk writes, so make sure the regmap code
> breaks bulk writes into multiple single-byte writes.
> 
> Note that this is mostly cosmetic because currently only the RTC sub-
> driver uses bulk writes and the RTC driver ends up using a different
> regmap on the MAX77620 anyway. However, it seems like a good idea to
> make this change now in order to avoid running into issues if bulk
> writes are ever used by other sub-drivers sometime down the road.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/mfd/max77620.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mfd/max77620.c b/drivers/mfd/max77620.c
> index c7ed5c353553..fec2096474ad 100644
> --- a/drivers/mfd/max77620.c
> +++ b/drivers/mfd/max77620.c
> @@ -177,6 +177,7 @@ static const struct regmap_config max77620_regmap_config = {
>  	.rd_table = &max77620_readable_table,
>  	.wr_table = &max77620_writable_table,
>  	.volatile_table = &max77620_volatile_table,
> +	.use_single_write = true,
>  };
>  
>  static const struct regmap_config max20024_regmap_config = {
> 


Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
