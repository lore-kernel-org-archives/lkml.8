Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5ABC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA40E207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 16:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kk3C3+cv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCQj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 12:39:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A72C06174A;
        Mon,  3 Aug 2020 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=dQEYDiyRx3/dAgyWBNJXoyTGtwi6Q59B1F54ddIVJ44=; b=kk3C3+cvwCr21HpDe5nVr7IzQO
        f/DPD2VkhiCnlRYFJIf0u1ACq/7ZCDmg0eYSDY2odV88tYrjfzS780X7u407zrYoWJZxgIhmccB7Z
        Ld9RgzRniToRQqGReiPyGNYLAmORMc2b+rQw+x1O28NmfMqmKS5f/0ym32sidGAfW/Thhvu2IHss4
        Be3S18ZzxxOEagHEG7SlwA0h3M0Rku2bZF4tvUMS7x/qPnQ/jZVdP/OJC3SBhGi2bXahtYAXzHkIR
        CiOeEPISAZ/Wz3F430uNejoiE7M+fLq3eo321ykU+bXA4Nl6TPIbz2QioOeOcGPt1/DSDf9L5FSzX
        +Gwmb+ug==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2dVB-0004Hc-IH; Mon, 03 Aug 2020 16:39:54 +0000
Subject: Re: [PATCH] ARM64: Setup DMA32 zone size by bootargs
To:     Phil Chang <phil.chang@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20200803142647.16737-1-phil.chang@mediatek.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <91057296-7064-282f-9345-e1d84af78eb4@infradead.org>
Date:   Mon, 3 Aug 2020 09:39:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803142647.16737-1-phil.chang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 7:26 AM, Phil Chang wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index fb95fad81c79..441ad3cb8ee8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -956,6 +956,9 @@
>  			The filter can be disabled or changed to another
>  			driver later using sysfs.
>  
> +	dma32_zone=nn	[KMG] [KNL,BOOT]
> +			Forces the DMA32 zone size of <nn> in mb, arm64 only.

Preferred:

> +	dma32_zone=nn	[KMG] [KNL,BOOT,ARM64]
> +			Forces the DMA32 zone size of <nn> in MB.

> +
>  	driver_async_probe=  [KNL]
>  			List of driver names to be probed asynchronously.
>  			Format: <driver_name1>,<driver_name2>...

thanks.
-- 
~Randy

