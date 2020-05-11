Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54753C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FD520720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgEKKqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:46:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:35929 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgEKKqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:46:07 -0400
IronPort-SDR: MU9XcCbWKgTZPKtzlcVfIX2egQgty+6tTm6+j9MGFjpjBIiwRoJZnkInx389npW3E/3tFhvzvi
 PkrQmDK6Ewpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 03:46:07 -0700
IronPort-SDR: 6+wlxQGsVBrFkYcdLlZFMmpWwHUXCZDfh8jl9RM72uix1XLHClRhOnf+DraSIizGZYnxI9okUZ
 ODsCpMZBjBMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,379,1583222400"; 
   d="scan'208";a="371183811"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 11 May 2020 03:46:04 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 11 May 2020 13:46:03 +0300
Date:   Mon, 11 May 2020 13:46:03 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org
Subject: Re: [PATCH v2] usb: typec: tps6598x: Add USB role switching logic
Message-ID: <20200511104603.GA2062175@kuha.fi.intel.com>
References: <20200507215938.1983363-1-bryan.odonoghue@linaro.org>
 <20200507215938.1983363-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507215938.1983363-2-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 07, 2020 at 10:59:38PM +0100, Bryan O'Donoghue wrote:
> @@ -452,6 +471,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
> +	struct fwnode_handle *fwnode;
>  	u32 status;
>  	u32 conf;
>  	u32 vid;
> @@ -495,11 +515,21 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	fwnode = device_get_named_child_node(&client->dev, "connector");
> +	if (!IS_ERR_OR_NULL(fwnode)) {
> +		tps->role_sw = fwnode_usb_role_switch_get(fwnode);
> +		if (IS_ERR(tps->role_sw)) {
> +			ret = PTR_ERR(tps->role_sw);
> +			goto err_fwnode_put;
> +		}
> +	}

        fwnode = device_get_named_child_node(&client->dev, "connector");
        if (IS_ERR(fwnode))
                return PTR_ERR(fwnode);

        tps->role_sw = fwnode_usb_role_switch_get(fwnode);
        if (IS_ERR(tps->role_sw)) {
        	ret = PTR_ERR(tps->role_sw);
        	goto err_fwnode_put;
        }

>  	typec_cap.revision = USB_TYPEC_REV_1_2;
>  	typec_cap.pd_revision = 0x200;
>  	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
>  	typec_cap.driver_data = tps;
>  	typec_cap.ops = &tps6598x_ops;
> +	typec_cap.fwnode = fwnode;
>  
>  	switch (TPS_SYSCONF_PORTINFO(conf)) {
>  	case TPS_PORTINFO_SINK_ACCESSORY:
> @@ -525,12 +555,16 @@ static int tps6598x_probe(struct i2c_client *client)
>  		typec_cap.data = TYPEC_PORT_DFP;
>  		break;
>  	default:
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_role_put;
>  	}
>  
>  	tps->port = typec_register_port(&client->dev, &typec_cap);
> -	if (IS_ERR(tps->port))
> -		return PTR_ERR(tps->port);
> +	if (IS_ERR(tps->port)) {
> +		ret = PTR_ERR(tps->port);
> +		goto err_role_put;
> +	}
> +	fwnode_handle_put(fwnode);
>  
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
>  		ret = tps6598x_connect(tps, status);
> @@ -545,12 +579,19 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret) {
>  		tps6598x_disconnect(tps, 0);
>  		typec_unregister_port(tps->port);
> -		return ret;
> +		goto err_role_put;
>  	}
>  
>  	i2c_set_clientdata(client, tps);
>  
>  	return 0;
> +
> +err_role_put:
> +	usb_role_switch_put(tps->role_sw);
> +err_fwnode_put:
> +	fwnode_handle_put(fwnode);
> +
> +	return ret;
>  }

thanks,

-- 
heikki
