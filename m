Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D28C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657BA2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="queh67X4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgFVQmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgFVQmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:42:13 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56417C061573;
        Mon, 22 Jun 2020 09:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=zpd8SSxXRoaX+cZGjnG22oKdAJbs3fN7H0/b3RHBKt8=; b=queh67X456ZLTSW2hrPlNRjujn
        S4zTz3+xV4epDsmHkiRfj4BbBRqvICvKcWrmZpQ9JNzVG072+8K3vKA0jf90FFQETjYcByXUq3Fjm
        U/CbTEp75W1O+mYGxzDnU60ThUDyqTEaFnUCtHFi0elzCS8c6gfzp3VSXDfnsHTk4vynrA6r6SVR0
        fOkFr8u8/6pBzD3WiU7wpDgb1oA0+EpN3KZ77fI6eRyNn4mw3MGe611dTr2xfDU60WNR3GlfmE++/
        ODHhHPDw6a4QCX13/UIuyAfUrAlHtvwEg/tPmo+C4rZYBWY1Q10rvbx0GwWNQNmOOQsVRivi80kPk
        hOLqFY5A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnPW8-0007je-Ol; Mon, 22 Jun 2020 16:41:57 +0000
Subject: Re: [PATCH 3/5] Huawei BMA: Adding Huawei BMA driver: host_veth_drv
To:     yunaixin03610@163.com, netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, wuguanping@huawei.com,
        wangqindong@huawei.com
References: <20200622160311.1533-1-yunaixin03610@163.com>
 <20200622160311.1533-4-yunaixin03610@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <11359034-656c-2fe6-aa5d-b609ed39b477@infradead.org>
Date:   Mon, 22 Jun 2020 09:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622160311.1533-4-yunaixin03610@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 9:03 AM, yunaixin03610@163.com wrote:
> diff --git a/drivers/net/ethernet/huawei/bma/Makefile b/drivers/net/ethernet/huawei/bma/Makefile
> index c9bbcbf2a388..e6e46d820082 100644
> --- a/drivers/net/ethernet/huawei/bma/Makefile
> +++ b/drivers/net/ethernet/huawei/bma/Makefile
> @@ -3,4 +3,5 @@
>  # 
>  
>  obj-$(CONFIG_BMA) += edma_drv/
> -obj-$(CONFIG_BMA) += cdev_drv/
> \ No newline at end of file

Please fix the "No newline" warning.

> +obj-$(CONFIG_BMA) += cdev_drv/
> +obj-$(CONFIG_BMA) += veth_drv/
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

Juse use
	help

> +	  This driver supports Huawei BMA Software. It is used 
> +	  to communication between Huawei BMA and BMC software.
> +


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
