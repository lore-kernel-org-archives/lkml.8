Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A5DC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D8D2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgEKK3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:29:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:6665 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729394AbgEKK3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:29:12 -0400
IronPort-SDR: ohqQBCoaP44PG3Ey/Bu+Ti6JK3Zrkc6VE8+t3MJ0FQhWDyvOudECoYUDZ4/RL+4Evsiu/2Exu1
 WWjH2KToFnAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:29:11 -0700
IronPort-SDR: 9uf0yd90aTqaDUwYgL6zXXxeYu6PTJ2dTvRv2AmDOh9xdegGp85EJ14a21rEYZqTQphm+vLleu
 5diMp+bZJZPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371181275"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:29:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 May 2020 13:29:07 +0300
Date:   Mon, 11 May 2020 13:29:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     robh+dt@kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH v2 2/2] usb: typec: tps6598x: Add OF probe binding
Message-ID: <20200511102907.GE1295548@kuha.fi.intel.com>
References: <20200507214733.1982696-1-bryan.odonoghue@linaro.org>
 <20200507214733.1982696-3-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507214733.1982696-3-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:47:33PM +0100, Bryan O'Donoghue wrote:
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

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tps6598x.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index 0698addd1185..defa651282b0 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -563,6 +563,12 @@ static int tps6598x_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct of_device_id tps6598x_of_match[] = {
> +	{ .compatible = "ti,tps6598x", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> +
>  static const struct i2c_device_id tps6598x_id[] = {
>  	{ "tps6598x" },
>  	{ }
> @@ -572,6 +578,7 @@ MODULE_DEVICE_TABLE(i2c, tps6598x_id);
>  static struct i2c_driver tps6598x_i2c_driver = {
>  	.driver = {
>  		.name = "tps6598x",
> +		.of_match_table = tps6598x_of_match,
>  	},
>  	.probe_new = tps6598x_probe,
>  	.remove = tps6598x_remove,
> -- 
> 2.25.1

thanks,

-- 
heikki
