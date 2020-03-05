Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B201C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0638920848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XizxDUNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgCEPy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:54:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgCEPy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:54:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=FHoAtrnq2TfDWklT4etUCR7uoAYMpCP72dBUNrrO+Co=; b=XizxDUNmkBJyKmTny690w8ct39
        v/VRV4YLutHLgS2i6gmYmh7CWGYA7RC+1VtoIM+nIdLQ69FGTtxCnSzkzj1XW3IgpN7dIVGctImbT
        a1FNAWMdWK23p3Ffgfwcjcuy+Gu6bU06Hp3jf2CNjXXfjvFCyQYMl41NhWhUOXyksIbKGakW0wrpc
        i9r8cTga5rJej7l6l0oTH0/Qv9f3J9U4bZsixjcl3uLrvBw7TPqThl1+JaiJufbB+mxrXdBfc0ZPR
        1jWgXTWAnz7+Z4NeuN0Q3eueboJSUgvTFRERhH1eQ47zlCOJmY3kdwWSm782dGmOQjz3pVEowtxHw
        CrWeC/6g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9spq-00042f-MB; Thu, 05 Mar 2020 15:54:54 +0000
Subject: Re: [PATCH] platform/chrome: Kconfig: Remove CONFIG_ prefix from
 MFD_CROS_EC section
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
References: <20200305102838.108967-1-enric.balletbo@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4131a083-3319-a6e3-a7e2-cfba67016844@infradead.org>
Date:   Thu, 5 Mar 2020 07:54:52 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305102838.108967-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/20 2:28 AM, Enric Balletbo i Serra wrote:
> Remove the CONFIG_ prefix from the select statement for MFD_CROS_EC.
> 
> Fixes: 2fa2b980e3fe1 ("mfd / platform: cros_ec: Rename config to a better name")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  drivers/platform/chrome/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 15fc8b8a2db8..5ae6c49f553d 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -7,7 +7,7 @@ config MFD_CROS_EC
>  	tristate "Platform support for Chrome hardware (transitional)"
>  	select CHROME_PLATFORMS
>  	select CROS_EC
> -	select CONFIG_MFD_CROS_EC_DEV
> +	select MFD_CROS_EC_DEV
>  	depends on X86 || ARM || ARM64 || COMPILE_TEST
>  	help
>  	  This is a transitional Kconfig option and will be removed after
> 


-- 
~Randy

