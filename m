Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E19C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA002073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZWvQZSn5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgFVQs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729492AbgFVQs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:48:26 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3823CC061573;
        Mon, 22 Jun 2020 09:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=BrA6e9Pl0lgGnSBNPXFINOYzmqpmgi0UVxl9CB0xQ/8=; b=ZWvQZSn5KNZaPrVUa67GFcqEqL
        /blvNZ/bNLp/o7RXq/ylNNY2aWZE2DovjOw1XnNIVhCJUVZxeQexl4pXg6DQpjErJEjae3wDZ/tn0
        hm30mRptxfgQPD6ntYecY20sPolsiZoXp/YyKVHwa/b87Fl2Ddplg15+ootEZ8YYWEfgx9w1QsWHj
        kwspysoeyB1rx97ofZrNnEzRS3G7WVr+FS7q7g05mPwlM+na9XtdxfgNw8rghH4RndcC3Gol8AN0X
        4ZQuekN/yNTUdQfkrRK35Cc7PDRVd3n0xxz6jU+sUaaw58e33AebsrCviImFbkDpm7TVauHJFTd+z
        LwvJiFEw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnPTU-0007dG-P9; Mon, 22 Jun 2020 16:39:13 +0000
Subject: Re: [PATCH 1/5] Huawei BMA: Adding Huawei BMA driver: host_edma_drv
To:     yunaixin03610@163.com, netdev@vger.kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, wuguanping@huawei.com,
        wangqindong@huawei.com
References: <20200622160311.1533-1-yunaixin03610@163.com>
 <20200622160311.1533-2-yunaixin03610@163.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ca9b537a-c90a-4156-8e43-65ad9ddfca23@infradead.org>
Date:   Mon, 22 Jun 2020 09:39:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200622160311.1533-2-yunaixin03610@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/20 9:03 AM, yunaixin03610@163.com wrote:
> diff --git a/drivers/net/ethernet/huawei/bma/edma_drv/Kconfig b/drivers/net/ethernet/huawei/bma/edma_drv/Kconfig
> new file mode 100644
> index 000000000000..97829c5487c2
> --- /dev/null
> +++ b/drivers/net/ethernet/huawei/bma/edma_drv/Kconfig
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

Use of ---help--- is being phased out (removed).

> +	  This driver supports Huawei BMA Software. It is used 
> +	  to communication between Huawei BMA and BMC software.
> +

thanks.
-- 
~Randy

