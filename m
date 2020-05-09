Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D993CC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5FB24953
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:37:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tQrFS6W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgEIGhK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 02:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726106AbgEIGhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:37:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9870EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 23:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=mcO8+1EDxZvAX8ZD4A53xevhvEfo/u+dOx6XCDnH4Do=; b=tQrFS6W8yF0rzk4LRpqpeK8Xt9
        VUn8R+0YHMMYINrzX9E//hI5rJV1rTmbkoyq+L+KZvguwZOatxNJ8Q4vzFyM8IIavIqBCnZEPj86f
        3uEujsbtM2S902GBpY7lfcd4rkBpA0CQ3J5iWwsnHsElWnEyr762pT4s5mJbhXuRy7S7bA3SBp8Nl
        PcQZhTxz/BhF1OL45Y+9clGzRy8/848PKGM8LoU2Sj5LuzcxWoOd14famKG9+ZiPuEx3b+EZ713z4
        jXLDEebJrQ1WDuzERid/GfpC1+J8nSX8Xb87h0OsEedjNiRIan4vVCVnXGkRpnR5aEPH8WlJ0Um87
        sJ6SeQkw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXJ6Z-0005sH-CZ; Sat, 09 May 2020 06:36:59 +0000
Subject: Re: [PATCH] drm/panel: visionox-rm69299: Add module license
To:     Jason Yan <yanaijie@huawei.com>, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        harigovi@codeaurora.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200509063017.2000-1-yanaijie@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5d692435-1d55-ade9-fe22-00ffc1cdca64@infradead.org>
Date:   Fri, 8 May 2020 23:36:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509063017.2000-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 11:30 PM, Jason Yan wrote:
> Fix the following build warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/gpu/drm/panel/panel-visionox-rm69299.o
> see include/linux/module.h for more information
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> index 25fe8b0bb040..ec279ffdbd94 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> @@ -300,3 +300,4 @@ static struct mipi_dsi_driver visionox_rm69299_driver = {
>  module_mipi_dsi_driver(visionox_rm69299_driver);
>  
>  MODULE_DESCRIPTION("Visionox RM69299 DSI Panel Driver");
> +MODULE_LICENSE("GPL");
> 

I sent a patch for this yesterday.


-- 
~Randy

