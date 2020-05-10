Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCAE8C47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC606208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocSoeAYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgEJC02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 22:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEJC02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:26:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFB9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 19:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=zvNTI8yxzwljxxqPU34+B6SIuU45J1yXDVr7f4pHAVE=; b=ocSoeAYPBJYGOOwIJRb/fYKcAl
        CvkwGWjwBouCIoTYp6B+ZyyIfXadmla+0NtaU4VX3+kdJ6t1Wx8X/KJIZccUnmffsqYS/XZycxyxR
        WPy2o3tVz8lrULrgbANxop+pBTQaw3BrQkXhwPAxpTB0+WOv0l7cS1U41jOZOsA2i4xYcl1SoTWGB
        UQ2Y2/Sv6T1NS9g83JK7Yq79PT6NyTrwjWHY4USCFK/pmnmVC1xLwifanDuovq7ltnphKOlxNup0M
        0+JIC+POO7XhP9/+kTO3Aawk4YssDu/EcvC7w7oYiW/DmrQPB0wedsqTWdfeW3m0Djk0LFLCGf76U
        LxUzlubg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXbfe-0004vr-FS; Sun, 10 May 2020 02:26:26 +0000
Subject: Re: [PATCH v5 1/9] w1_therm: adding code comments and code reordering
To:     Akira Shimahara <akira215corp@gmail.com>, greg@kroah.com
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
References: <20200509235742.422652-1-akira215corp@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eb73984b-8317-a0e9-90ed-2956d3fbc6b0@infradead.org>
Date:   Sat, 9 May 2020 19:26:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200509235742.422652-1-akira215corp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 5/9/20 4:57 PM, Akira Shimahara wrote:
> Adding code comments to split code in dedicated parts. After the global
> declarations (defines, macros and function declarations), code is organized
> as follow :
>  - Device and family dependent structures and functions
>  - Interfaces functions
>  - Helpers functions
>  - Hardware functions
>  - Sysfs interface functions
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
> Main motivation on the first patch of this serie is to clean up the code,
> document it and reorder it to prepare the next patches, which are clearer
> after this.
> 
> One main point is to keep all device/family dependent code gather at the
> beginning to ease adding new devices if required.
> 
> Changes in v5:
> - All patch serie in one .c file
> - Correcting some comments
> - adding <linux/string.h> include
> 
>  drivers/w1/slaves/w1_therm.c | 403 ++++++++++++++++++++---------------
>  1 file changed, 237 insertions(+), 166 deletions(-)
> 
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 18f08d7..f7147b2 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -41,55 +41,99 @@
>  static int w1_strong_pullup = 1;
>  module_param_named(strong_pullup, w1_strong_pullup, int, 0);
>  
> +/*-------------------------------Macros-------------------------------------*/
> +
> +/* return the address of the refcnt in the family data */
> +#define THERM_REFCNT(family_data) \
> +	(&((struct w1_therm_family_data *)family_data)->refcnt)
> +
> +/*----------------------------------Structs---------------------------------*/
> +
> +/**
> + * struct w1_therm_family_converter
> + * \brief Used to bind standard function call
> + * to device specific function
> + * it could be routed to NULL if device don't support feature
> + */

Hi,

All of the struct and function documentation comments in all patches in
this patch series should be using kernel-doc notation instead of the above
(whatever it is; I don't know what it is).


> +struct w1_therm_family_converter {
> +	u8		broken;
> +	u16		reserved;
> +	struct w1_family	*f;
> +	int		(*convert)(u8 rom[9]);
> +	int		(*precision)(struct device *device, int val);
> +	int		(*eeprom)(struct device *device);
> +};
> +

thanks.
-- 
~Randy

