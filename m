Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B052AC83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80F1A206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ci1v01CW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgD1DQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgD1DQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:16:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E7C03C1A9;
        Mon, 27 Apr 2020 20:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Mz7QWM707vs0N32HDgEponGOOZMsOtDZrZmmttfw1aQ=; b=ci1v01CWqM0VHb6vVz7eVBoYZT
        Y8RHbQnKKILxKQgnmixzk/rh8vKzHCvRwSV3PPQWrJI7Rvn043B+qnxrgabfHJ43jg6IcMMPRmZJP
        IhgF2Yd9mCSkB+k//1+Td3mu22L/RbKFimnj7NAewcSCtCjXtksOI0xjkkwvl1caD3kESL2C0CdXi
        RmzrHskkULKcmuYLdYqjuPXxs9qCXdnATl39gkzN9vBsT1gi8+IqnGPpI5Sj1Im5HsVTT484ESl1p
        vGJckS9lkFfaMbHMpPGgJDZmeusOfRoxAdrrfIYZTlenvJcEIu5zc4VqB/Yh0FS9ZOvnnSAG8s4GM
        pw5Sj0dw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTGjA-00024R-FN; Tue, 28 Apr 2020 03:16:08 +0000
Subject: Re: [PATCH v4 2/2] mailbox: sprd: Add Spreadtrum mailbox driver
To:     Baolin Wang <baolin.wang7@gmail.com>, robh+dt@kernel.org,
        jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8d29eba045ef18c5489e122b3668afc20431f15d.1588043236.git.baolin.wang7@gmail.com>
 <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <62b3d9fc-1cc9-ac42-69e5-1c7bdac7bd0c@infradead.org>
Date:   Mon, 27 Apr 2020 20:16:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4b224e7bb703e15469e5cd79a54f7bc00a790fc5.1588043236.git.baolin.wang7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:10 PM, Baolin Wang wrote:
> diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> index 5a577a6734cf..e03f3fb5caed 100644
> --- a/drivers/mailbox/Kconfig
> +++ b/drivers/mailbox/Kconfig
> @@ -236,4 +236,12 @@ config SUN6I_MSGBOX
>  	  various Allwinner SoCs. This mailbox is used for communication
>  	  between the application CPUs and the power management coprocessor.
>  
> +config SPRD_MBOX
> +	tristate "Spreadtrum Mailbox"
> +	depends on ARCH_SPRD || COMPILE_TEST
> +	help
> +	  Mailbox driver implementation for the Spreadtrum platform. It is used
> +	  to send message between application processors and MCU. Say Y here if
> +	  you want to build the Spreatrum mailbox controller driver.

	                        ^^typo^^

> +
>  endif


-- 
~Randy

