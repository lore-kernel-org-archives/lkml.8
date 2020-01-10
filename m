Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D0C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87ED32082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HtMROQ3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbgAJLAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:00:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33880 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727670AbgAJLAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:00:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00AB0WIu035463;
        Fri, 10 Jan 2020 05:00:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578654032;
        bh=jxtcpp4wv+hTwwi1lQ91nMik4CFwpDAD22wxC64xvi0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HtMROQ3jnHJqUDiQzlcPXO7ZOvxczkxJu3rEL/gvGaPNSUlbeUW5VIZ3T8wcBZOTF
         9Bok2C3oOuWT5N/Y/iCoPjgRgbfvA4PzkF/nv+uf4KNN0xZjvx14QtpYWad6LS7y3l
         NvmIbhUxP3f+u2KcoB6yLmfjOw+jcpCc0kHBKW08=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00AB0V5n126818
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jan 2020 05:00:32 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 10
 Jan 2020 05:00:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 10 Jan 2020 05:00:31 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00AB0SY0046697;
        Fri, 10 Jan 2020 05:00:29 -0600
Subject: Re: [PATCH] phy: core: Fix error path in devm_of_phy_get()
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        <linux-samsung-soc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <CGME20200108132350eucas1p1476f4aa038dbf5ea199b84c5c82a25a5@eucas1p1.samsung.com>
 <20200108132342.14635-1-m.szyprowski@samsung.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <4c612381-55c1-635a-d40d-e1bb3aa60998@ti.com>
Date:   Fri, 10 Jan 2020 16:32:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200108132342.14635-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/20 6:53 PM, Marek Szyprowski wrote:
> Commit 5253fe05bb47 ("phy: core: Add consumer device link support") added
> support for consumer device links, but it missed proper update for error
> handling in devm_of_phy_get(). Fix this by adding proper return statement.
> 
> This patch fixes the following invalid pointer dereference on
> Exynos5250-based Arndale board with multi_v7_defconfig:
> 
> 8<--- cut here ---
> Unable to handle kernel paging request at virtual address fffffe7f
> pgd = (ptrval)
> [fffffe7f] *pgd=6ffff841, *pte=00000000, *ppte=00000000
> Internal error: Oops: 27 [#1] SMP ARM
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc5-next-20200108 #167
> Hardware name: Samsung Exynos (Flattened Device Tree)
> PC is at device_link_add+0x68/0x4c4
> LR is at device_link_add+0x68/0x4c4
> ...
> Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
> ...
> [<c0984d70>] (device_link_add) from [<c0707e8c>] (devm_of_phy_get+0x6c/0xb0)
> [<c0707e8c>] (devm_of_phy_get) from [<c0a0deb8>] (ahci_platform_get_phy+0x28/0xe0)
> [<c0a0deb8>] (ahci_platform_get_phy) from [<c0a0e64c>] (ahci_platform_get_resources+0x398/0x48c)
> [<c0a0e64c>] (ahci_platform_get_resources) from [<c0a0daec>] (ahci_probe+0x14/0xb4)
> [<c0a0daec>] (ahci_probe) from [<c098a1ec>] (platform_drv_probe+0x48/0x9c)
> [<c098a1ec>] (platform_drv_probe) from [<c0988214>] (really_probe+0x1dc/0x33c)
> [<c0988214>] (really_probe) from [<c09884f4>] (driver_probe_device+0x60/0x164)
> [<c09884f4>] (driver_probe_device) from [<c09887a0>] (device_driver_attach+0x58/0x60)
> [<c09887a0>] (device_driver_attach) from [<c0988828>] (__driver_attach+0x80/0xbc)
> [<c0988828>] (__driver_attach) from [<c09865b4>] (bus_for_each_dev+0x68/0xb4)
> [<c09865b4>] (bus_for_each_dev) from [<c0987594>] (bus_add_driver+0x160/0x1e4)
> [<c0987594>] (bus_add_driver) from [<c09892c0>] (driver_register+0x78/0x10c)
> [<c09892c0>] (driver_register) from [<c0302f14>] (do_one_initcall+0x54/0x220)
> [<c0302f14>] (do_one_initcall) from [<c1500f4c>] (kernel_init_freeable+0x150/0x1b4)
> [<c1500f4c>] (kernel_init_freeable) from [<c0ef6b34>] (kernel_init+0x8/0x10c)
> [<c0ef6b34>] (kernel_init) from [<c03010e8>] (ret_from_fork+0x14/0x2c)

I've already merged a patch fixing this.

Thanks
Kishon

> ...
> 
> Fixes: 5253fe05bb47 ("phy: core: Add consumer device link support")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/phy/phy-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 8dfb4868c8c3..2eb28cc2d2dc 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -799,6 +799,7 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>  		devres_add(dev, ptr);
>  	} else {
>  		devres_free(ptr);
> +		return phy;
>  	}
>  
>  	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> 
