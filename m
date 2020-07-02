Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E66C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7253B2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593693860;
	bh=NNnXYAZrMdovQtKASx+58SBwBWrvkkoyxFdTKeD8acw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qA5wJ2TnSjBKtX19snzE3BUftmMrXTkI0eCIOddjYlGowCYJbv2R9ufhVBeI3grJP
	 yLyvtwUEZgDRY9qV9E3xCDeJjMEhI3vT5frStwBQAPZX8r5wp0S7CMYa5eriIXyc6/
	 RRhlkkSg8Ifyex7G2zmBw4+TCD4dSCRU8KnssMSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgGBMoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:44:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9090320885;
        Thu,  2 Jul 2020 12:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593693856;
        bh=NNnXYAZrMdovQtKASx+58SBwBWrvkkoyxFdTKeD8acw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEbhX1/5T3fgMTVC8jIrohXYAvX3YB/xyX42v6s7wXfO/jF2MGTsD6i2XHe37aRoQ
         zDV8OGUpH+XPGXWOiY53Erj5ztNaMNXpa7JHhg/6NiE5IEVQN1EDj76Fwa1itUHYZW
         k2tF0lbHgHctXYlejR+RphhTqiEG5JvR/HxmAd7k=
Date:   Thu, 2 Jul 2020 14:44:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 6/6] hwmon: pmbus: use more devres helpers
Message-ID: <20200702124419.GB1882489@kroah.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
 <20200629065008.27620-7-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629065008.27620-7-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:50:08AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Shrink pmbus code by using devm_hwmon_device_register_with_groups()
> and devm_krealloc() instead of their non-managed variants.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index a420877ba533..225d0ac162c7 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1022,9 +1022,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
>  {
>  	if (data->num_attributes >= data->max_attributes - 1) {
>  		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
> -		void *new_attrs = krealloc(data->group.attrs,
> -					   new_max_attrs * sizeof(void *),
> -					   GFP_KERNEL);
> +		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
> +						new_max_attrs * sizeof(void *),
> +						GFP_KERNEL);

dynamic sysfs attributes in a devm-allocated chunk of memory?  What
could go wrong...

Anyway, is this the only in-kernel user that you could find for this
function?  If so, it feels like it's a lot of extra work for no real
gain.

thanks,

greg k-h
