Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88505CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD36204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 14:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388878AbgEMOFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 10:05:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:11955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388325AbgEMOFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 10:05:17 -0400
IronPort-SDR: m2f3H+AKghJAV6vzjVJhpjV8xKIsS4SCsdL5QIRi3FgTgvsg9C8fU/F9ig1NUJoE4UK7Ag9M42
 7E+bRS5fzp4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 07:04:58 -0700
IronPort-SDR: lQOMhYCNEN5EtjiPCFHMQ65qf8SY1cqAwpRPe86DEW3lanjbEDd2BWx+e9xgd4ukWyJoTX+IC5
 ljY7P+gWQtkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,388,1583222400"; 
   d="scan'208";a="371916009"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 May 2020 07:04:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 May 2020 17:04:54 +0300
Date:   Wed, 13 May 2020 17:04:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] usb: typec: tps6598x: Add USB role switching logic
Message-ID: <20200513140454.GE2085641@kuha.fi.intel.com>
References: <20200511231930.2825183-1-bryan.odonoghue@linaro.org>
 <20200511231930.2825183-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511231930.2825183-2-bryan.odonoghue@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 12:19:30AM +0100, Bryan O'Donoghue wrote:
> This patch adds USB role switch support to the tps6598x.
> 
> The setup to initiate or accept a data-role switch is both assumed and
> currently required to be baked-into the firmware as described in TI's
> document here.
> 
> Link: https://www.ti.com/lit/an/slva843a/slva843a.pdf
> 
> With this change its possible to use the USB role-switch API to detect and
> notify role-switches to downstream consumers.
> 
> Tested with a ChipIdea controller on a Qualcomm MSM8939.
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

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tps6598x.c | 57 +++++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/tps6598x.c b/drivers/usb/typec/tps6598x.c
> index defa651282b0..b7c9fe5caabe 100644
> --- a/drivers/usb/typec/tps6598x.c
> +++ b/drivers/usb/typec/tps6598x.c
> @@ -12,6 +12,7 @@
>  #include <linux/regmap.h>
>  #include <linux/interrupt.h>
>  #include <linux/usb/typec.h>
> +#include <linux/usb/role.h>
>  
>  /* Register offsets */
>  #define TPS_REG_VID			0x00
> @@ -94,6 +95,7 @@ struct tps6598x {
>  	struct typec_port *port;
>  	struct typec_partner *partner;
>  	struct usb_pd_identity partner_identity;
> +	struct usb_role_switch *role_sw;
>  };
>  
>  /*
> @@ -190,6 +192,23 @@ static int tps6598x_read_partner_identity(struct tps6598x *tps)
>  	return 0;
>  }
>  
> +static void tps6598x_set_data_role(struct tps6598x *tps,
> +				   enum typec_data_role role, bool connected)
> +{
> +	enum usb_role role_val;
> +
> +	if (role == TYPEC_HOST)
> +		role_val = USB_ROLE_HOST;
> +	else
> +		role_val = USB_ROLE_DEVICE;
> +
> +	if (!connected)
> +		role_val = USB_ROLE_NONE;
> +
> +	usb_role_switch_set_role(tps->role_sw, role_val);
> +	typec_set_data_role(tps->port, role);
> +}
> +
>  static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  {
>  	struct typec_partner_desc desc;
> @@ -220,7 +239,7 @@ static int tps6598x_connect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_opmode(tps->port, mode);
>  	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
> -	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
> +	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), true);
>  
>  	tps->partner = typec_register_partner(tps->port, &desc);
>  	if (IS_ERR(tps->partner))
> @@ -240,7 +259,7 @@ static void tps6598x_disconnect(struct tps6598x *tps, u32 status)
>  	typec_set_pwr_opmode(tps->port, TYPEC_PWR_MODE_USB);
>  	typec_set_pwr_role(tps->port, TPS_STATUS_PORTROLE(status));
>  	typec_set_vconn_role(tps->port, TPS_STATUS_VCONN(status));
> -	typec_set_data_role(tps->port, TPS_STATUS_DATAROLE(status));
> +	tps6598x_set_data_role(tps, TPS_STATUS_DATAROLE(status), false);
>  }
>  
>  static int tps6598x_exec_cmd(struct tps6598x *tps, const char *cmd,
> @@ -328,7 +347,7 @@ static int tps6598x_dr_set(struct typec_port *port, enum typec_data_role role)
>  		goto out_unlock;
>  	}
>  
> -	typec_set_data_role(tps->port, role);
> +	tps6598x_set_data_role(tps, role, true);
>  
>  out_unlock:
>  	mutex_unlock(&tps->lock);
> @@ -452,6 +471,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  {
>  	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
> +	struct fwnode_handle *fwnode;
>  	u32 status;
>  	u32 conf;
>  	u32 vid;
> @@ -495,11 +515,22 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret < 0)
>  		return ret;
>  
> +	fwnode = device_get_named_child_node(&client->dev, "connector");
> +	if (IS_ERR(fwnode))
> +		return PTR_ERR(fwnode);
> +
> +	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
> +	if (IS_ERR(tps->role_sw)) {
> +		ret = PTR_ERR(tps->role_sw);
> +		goto err_fwnode_put;
> +	}
> +
>  	typec_cap.revision = USB_TYPEC_REV_1_2;
>  	typec_cap.pd_revision = 0x200;
>  	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
>  	typec_cap.driver_data = tps;
>  	typec_cap.ops = &tps6598x_ops;
> +	typec_cap.fwnode = fwnode;
>  
>  	switch (TPS_SYSCONF_PORTINFO(conf)) {
>  	case TPS_PORTINFO_SINK_ACCESSORY:
> @@ -525,12 +556,16 @@ static int tps6598x_probe(struct i2c_client *client)
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
> @@ -545,12 +580,19 @@ static int tps6598x_probe(struct i2c_client *client)
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
>  
>  static int tps6598x_remove(struct i2c_client *client)
> @@ -559,6 +601,7 @@ static int tps6598x_remove(struct i2c_client *client)
>  
>  	tps6598x_disconnect(tps, 0);
>  	typec_unregister_port(tps->port);
> +	usb_role_switch_put(tps->role_sw);
>  
>  	return 0;
>  }
> -- 
> 2.25.1

thanks,

-- 
heikki
