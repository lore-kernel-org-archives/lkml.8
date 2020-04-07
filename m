Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0ECC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6558D2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586254964;
	bh=juQKuUZDgyyxGgsF7uNhckuR4k0PFa3vOdCv8igXe0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zJ8bmu1ryURyLWcuiyV6Gk/5tl/Je9uO3LeEDHGG/xR9edIjWu7+MksOG7k7lsa2O
	 0fTp4bbmMe1IgkZmGs3vRUGCHBTk2QK7M1x67Urmqo8hNooeMtf5WhlpwGsmi/HgGx
	 goE85RcFlcX5dHKahNUepeF5/dSHLk/CAX5hKpj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbgDGKWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:22:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbgDGKWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:22:41 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4281720771;
        Tue,  7 Apr 2020 10:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586254960;
        bh=juQKuUZDgyyxGgsF7uNhckuR4k0PFa3vOdCv8igXe0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sgYqeamJWAiaBCp2NFSD03QPo70At2AUr/IUVrprBg+Ml5NDCfoPAKTNJYYXNX6an
         vAQ7e3e2LWUeFyKv98p4GoBGzkyh2TeRFOvdvOm18bZZP3vlg38k0CTydolrBFmEWu
         29LGMbGbHOxwLRXzrU3Ok29lE8bw89yC7XaBAWNk=
Received: by pali.im (Postfix)
        id 418C85F1; Tue,  7 Apr 2020 12:22:38 +0200 (CEST)
Date:   Tue, 7 Apr 2020 12:22:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Thomas Hebb <tommyhebb@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (dell-smm) Use one DMI match for all XPS models
Message-ID: <20200407102238.zweh7s7t6rn5cwhf@pali>
References: <5d7e498b83e89ce7c41a449b61919c65d0770b73.1586033337.git.tommyhebb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d7e498b83e89ce7c41a449b61919c65d0770b73.1586033337.git.tommyhebb@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Saturday 04 April 2020 16:49:00 Thomas Hebb wrote:
> Currently, each new XPS has to be added manually for module autoloading
> to work. Since fan multiplier autodetection should work fine on all XPS
> models, just match them all with one block like is done for Precision
> and Studio.

It makes sense. We already load driver for all Inspirion, Latitude,
Precision, Vostro and Studio models so I do not see reason why not to
load it also for all XPS models. I doubt that Dell uses one base
firmware for all mentioned models and second one specially for XPS.

> The only match we replace that doesn't already use autodetection is
> "XPS13" which, according to Google, only matches the XPS 13 9333. (All
> other XPS 13 models have "XPS" as its own word, surrounded by spaces.)
> According to the thread at [1], autodetection works for the XPS 13 9333,
> meaning this shouldn't regress it. I do not own one to confirm with,
> though.
> 
> Tested on an XPS 13 9350 and confirmed the module now autoloads and
> reports reasonable-looking data. I am using BIOS 1.12.2 and do not see
> any freezes when querying fan speed.
> 
> [1] https://lore.kernel.org/patchwork/patch/525367/

I guess that these two tests are enough based on the fact that lot of
XPS models are already whitelisted.

Guenter, it is fine for you now? Or is something else needed?

> Signed-off-by: Thomas Hebb <tommyhebb@gmail.com>

Acked-by: Pali Rohár <pali@kernel.org>

> ---
> 
> Changes in v2:
> - Remove another now-redundant XPS entry that I'd missed.
> 
>  drivers/hwmon/dell-smm-hwmon.c | 26 ++------------------------
>  1 file changed, 2 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
> index d4c83009d625..ca30bf903ec7 100644
> --- a/drivers/hwmon/dell-smm-hwmon.c
> +++ b/drivers/hwmon/dell-smm-hwmon.c
> @@ -1072,13 +1072,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Vostro"),
>  		},
>  	},
> -	{
> -		.ident = "Dell XPS421",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
> -		},
> -	},
>  	{
>  		.ident = "Dell Studio",
>  		.matches = {
> @@ -1087,14 +1080,6 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  		},
>  		.driver_data = (void *)&i8k_config_data[DELL_STUDIO],
>  	},
> -	{
> -		.ident = "Dell XPS 13",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS13"),
> -		},
> -		.driver_data = (void *)&i8k_config_data[DELL_XPS],
> -	},
>  	{
>  		.ident = "Dell XPS M140",
>  		.matches = {
> @@ -1104,17 +1089,10 @@ static const struct dmi_system_id i8k_dmi_table[] __initconst = {
>  		.driver_data = (void *)&i8k_config_data[DELL_XPS],
>  	},
>  	{
> -		.ident = "Dell XPS 15 9560",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9560"),
> -		},
> -	},
> -	{
> -		.ident = "Dell XPS 15 9570",
> +		.ident = "Dell XPS",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "XPS 15 9570"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "XPS"),
>  		},
>  	},
>  	{ }
> -- 
> 2.25.2
> 
