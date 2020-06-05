Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03450C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0F0207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 06:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="erAw05C/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFEGCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 02:02:46 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:12532 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgFEGCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 02:02:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ed9dff90000>; Thu, 04 Jun 2020 23:02:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Jun 2020 23:02:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Jun 2020 23:02:45 -0700
Received: from [10.26.75.201] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Jun
 2020 06:02:42 +0000
Subject: Re: [PATCH] spi: tegra20-slink: add missing pm_runtime_put
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <emamd001@umn.edu>, <wu000273@umn.edu>, <kjlu@umn.edu>,
        <smccaman@umn.edu>
References: <20200602052602.91374-1-navid.emamdoost@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <555a3d93-ea24-a633-2ea4-904fcd8fd8a2@nvidia.com>
Date:   Fri, 5 Jun 2020 07:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602052602.91374-1-navid.emamdoost@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1591336953; bh=mppFNzTH6LZ5rq9HNWYw/2EXLZTDgKQIdkoIRo40OzY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=erAw05C/uAFBnKnBPShjFQiFW54fajoyweUFrcpn2gwxnEmRgNdUc+VSIuIMvak93
         7gZHxe1opyXZ+dOGJjk0ayQ9o0LPFAEHun9iBmFxdijBkRF2Gw/N5Q8WAR/Bf4SjPS
         yXckO92hQuz5bv/E7rs8Kt7ZQ9n9V+WDUSht7d4pRdtDOuKd0TdB9M8Agdv7XFkZ/A
         SPKBsYyC8SpYXGcP6ek4KANfyXaGzMU4eyRF0PGEkC5aNaCpJqii4SA/VnVaAaAruV
         F3iFCbyoXJshW5qzX4yhsgaLAh098kTJp1WydRYs7XSUa83gSxCrzYYjbPXX02wPi7
         rQPL5Oa+7jXgQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 02/06/2020 06:26, Navid Emamdoost wrote:
> Call to pm_runtime_get_sync increments counter even in case of
> failure leading to incorrect ref count.
> Call pm_runtime_put if pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/spi/spi-tegra20-slink.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index 7f4d932dade7..0675b36d647b 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1192,6 +1192,7 @@ static int tegra_slink_resume(struct device *dev)
>  	ret = pm_runtime_get_sync(dev);
>  	if (ret < 0) {
>  		dev_err(dev, "pm runtime failed, e = %d\n", ret);
> +		pm_runtime_put(dev);
>  		return ret;
>  	}
>  	tegra_slink_writel(tspi, tspi->command_reg, SLINK_COMMAND);

Please squash this patch with the other 2 that are fixing the same
issues in the same driver.

Jon

-- 
nvpublic
