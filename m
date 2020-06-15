Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF732C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2C9A206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:50:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UDxE3gxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgFOPun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbgFOPun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:50:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814FFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=LdTpkAqcCzHoSnUW76CzNWV0E3xSX/nz3Wabnr31wsY=; b=UDxE3gxf7yCQ9nVdwFcXqQnVVM
        sAKhTSH0p8MudEpsFwfxTrG3kVV2r9WEvpAtatoy9wadO2KHOKD+zmX8HivDco6idNVEZ921A4CQM
        Ti7/UJXGkirfxycy3Opt5WXPYlezer1svPe8gVtYLQ2wmOAFsaznVLjZsvOqbMGBYIiRqQYxiQIl4
        gyLaRRz5duUUOFJwDBJGaBWiQqBRRhCXqV1herA12c6TJrq5geCQYP0M+LXEv/SjNYaW3V5qWZJ9I
        6DzEZB0TvkyDl30vGyNKyvDKQCEfLzfqNjwks7ERbG1dIvfsXyflYl/LJp8eXhsRiPDp65zHHx62y
        8c2N3SfA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkrNj-00083n-CA; Mon, 15 Jun 2020 15:50:43 +0000
Subject: Re: [PATCH 3/5] Huawei BMA: Adding Huawei BMA driver: host_veth_drv
To:     yunaixin03610@163.com, linux-kernel@vger.kernel.org
Cc:     yunaixin <yunaixin@huawei.com>
References: <20200615145658.956-1-yunaixin03610@163.com>
 <20200615145658.956-4-yunaixin03610@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5b246b73-3aa2-b90a-0ea1-cbf281a97ec2@infradead.org>
Date:   Mon, 15 Jun 2020 08:50:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615145658.956-4-yunaixin03610@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 7:56 AM, yunaixin03610@163.com wrote:
> diff --git a/drivers/net/ethernet/huawei/bma/Kconfig b/drivers/net/ethernet/huawei/bma/Kconfig
> index 12979128fa9d..21e9f7ee5be6 100644
> --- a/drivers/net/ethernet/huawei/bma/Kconfig
> +++ b/drivers/net/ethernet/huawei/bma/Kconfig
> @@ -1,2 +1,3 @@
>  source "drivers/net/ethernet/huawei/bma/edma_drv/Kconfig"
> -source "drivers/net/ethernet/huawei/bma/cdev_drv/Kconfig"
> \ No newline at end of file
> +source "drivers/net/ethernet/huawei/bma/cdev_drv/Kconfig"
> +source "drivers/net/ethernet/huawei/bma/veth_drv/Kconfig"
> \ No newline at end of file

Add newlines characters.

> diff --git a/drivers/net/ethernet/huawei/bma/Makefile b/drivers/net/ethernet/huawei/bma/Makefile
> index c9bbcbf2a388..6ff24d31c650 100644
> --- a/drivers/net/ethernet/huawei/bma/Makefile
> +++ b/drivers/net/ethernet/huawei/bma/Makefile
> @@ -3,4 +3,5 @@
>  # 
>  
>  obj-$(CONFIG_BMA) += edma_drv/
> -obj-$(CONFIG_BMA) += cdev_drv/
> \ No newline at end of file
> +obj-$(CONFIG_BMA) += cdev_drv/
> +obj-$(CONFIG_BMA) += veth_drv/
> \ No newline at end of file

Same here.

> diff --git a/drivers/net/ethernet/huawei/bma/veth_drv/Kconfig b/drivers/net/ethernet/huawei/bma/veth_drv/Kconfig
> new file mode 100644
> index 000000000000..97829c5487c2
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/bma/veth_drv/Kconfig
> @@ -0,0 +1,11 @@
> +#
> +# Huawei BMA software driver configuration
> +#
> +
> +config BMA
> +	tristate "Huawei BMA Software Communication Driver"
> +
> +	---help---

	help

> +	  This driver supports Huawei BMA Software. It is used 
> +	  to communication between Huawei BMA and BMC software.

	  to communicate

> +


-- 
~Randy

