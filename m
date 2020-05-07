Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B8EC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423562064A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGMdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:33:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:56628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgEGMdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:33:46 -0400
IronPort-SDR: uwnerz3jw2413KLcLg/J9sq6l/V7UNPlIVehgghZVqjYOvnVfTVAonjOCHra4ipTc1YZt6fmPa
 R5Q/FjgD4a5Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 05:33:46 -0700
IronPort-SDR: +1OWKyvZqXbaz4Hadljb0cNX8dJujF+OY7bq1KsEwpbMg/imZET7tyloAg7Ocl09zcF23uratp
 wABJANClkiTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; 
   d="scan'208";a="461831878"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005.fm.intel.com with ESMTP; 07 May 2020 05:33:43 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jWfik-005DGk-O0; Thu, 07 May 2020 15:33:46 +0300
Date:   Thu, 7 May 2020 15:33:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH 2/2] usb: typec: tps6598x: Add OF probe binding
Message-ID: <20200507123346.GU185537@smile.fi.intel.com>
References: <20200507122352.1773661-1-bryan.odonoghue@linaro.org>
 <20200507122352.1773661-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507122352.1773661-3-bryan.odonoghue@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:23:52PM +0100, Bryan O'Donoghue wrote:
> Adds a MODULE_DEVICE_TABLE() to allow probing of this driver from a DTS
> setting.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Gustavo A. R. Silva <garsilva@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  drivers/usb/typec/tps6598x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 0698addd1185..61c6761072c9 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -563,6 +563,14 @@ static int tps6598x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF

No need for this (and thus for of_match_ptr() macro below). Saving few dozens of bytes?

> +static const struct of_device_id tps6598x_of_match[] = {
> +	{ .compatible = "ti,tps6598x", },

> +	{},

No comma for terminator line.

> +};
> +MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> +#endif
> +
>  static const struct i2c_device_id tps6598x_id[] = {
>  	{ "tps6598x" },
>  	{ }
> @@ -572,6 +580,7 @@ MODULE_DEVICE_TABLE(i2c, tps6598x_id);
>  static struct i2c_driver tps6598x_i2c_driver = {
>  	.driver = {
>  		.name = "tps6598x",
> +		.of_match_table = of_match_ptr(tps6598x_of_match),

-- 
With Best Regards,
Andy Shevchenko


