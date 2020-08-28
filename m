Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22322C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0507B207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgH1NQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:16:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:62305 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729480AbgH1NMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:12:24 -0400
IronPort-SDR: 6Q45NdKqU28mSGvdCT2CKnH+cg3DcmzYkPBfiCA1Xvl4lXFjPj4Uo4iIA9AzEQsq8BZYIKftcc
 WGvyRPXA1mHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="155918719"
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="155918719"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 06:12:17 -0700
IronPort-SDR: QGWTfQvXniq0ONUYCBZxLngfoYqrKUfxIbh8+L/QfvkWd7uCh4kyuMFgZtDvCgJhlzES/P+YL3
 EMOdRigbeT9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,363,1592895600"; 
   d="scan'208";a="403747958"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Aug 2020 06:12:14 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 28 Aug 2020 16:12:14 +0300
Date:   Fri, 28 Aug 2020 16:12:14 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/14 v2] usb: typec: tcpci: Add support when hidden tx
 registers are inaccessible
Message-ID: <20200828131214.GH174928@kuha.fi.intel.com>
References: <20200825042210.300632-1-badhri@google.com>
 <20200825042210.300632-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825042210.300632-3-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like you forgot v1 somewhere :-)

On Mon, Aug 24, 2020 at 09:21:58PM -0700, Badhri Jagan Sridharan wrote:
> TCPCI spec forbids direct access of TX_BUF_BYTE_x register.
> The existing version of tcpci driver assumes that those registers
> are directly addressible. Add support for tcpci chips which do
> not support direct access to TX_BUF_BYTE_x registers. TX_BUF_BYTE_x
> can only be accessed by I2C_WRITE_BYTE_COUNT.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpci.c | 49 +++++++++++++++++++++++++---------
>  drivers/usb/typec/tcpm/tcpci.h |  8 ++++++
>  2 files changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f57d91fd0e09..90d348caa6a8 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -320,8 +320,7 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc, bool source, bool sink)
>  	return 0;
>  }
>  
> -static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
> -			     enum tcpm_transmit_type type,
> +static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type,
>  			     const struct pd_message *msg)

That does not look like a relevant change.

>  {
>  	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> @@ -330,23 +329,47 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc,
>  	int ret;
>  
>  	cnt = msg ? pd_header_cnt(header) * 4 : 0;
> -	ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
> -	if (ret < 0)
> -		return ret;
> +	/**
> +	 * TCPCI spec forbids direct access of TCPC_TX_DATA.
> +	 * But, since some of the chipsets offer this capability,
> +	 * it's fair to support both.
> +	 */
> +	if (!tcpci->data->TX_BUF_BYTE_x_hidden) {

Couldn't check if the flag is set first?

        if (tcpci->data->TX_BUF_BYTE_x_hidden) {
                ...

> +		ret = regmap_write(tcpci->regmap, TCPC_TX_BYTE_CNT, cnt + 2);
> +		if (ret < 0)
> +			return ret;
>  
> -	ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> -	if (ret < 0)
> -		return ret;
> +		ret = tcpci_write16(tcpci, TCPC_TX_HDR, header);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (cnt > 0) {
> +			ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA, &msg->payload, cnt);
> +			if (ret < 0)
> +				return ret;
> +		}
> +	} else {
> +		u8 buf[TCPC_TRANSMIT_BUFFER_MAX_LEN] = {0,};
> +		u8 pos = 0;
> +
> +		/* Payload + header + TCPC_TX_BYTE_CNT */
> +		buf[pos++] = cnt + 2;
> +
> +		if (msg)
> +			memcpy(&buf[pos], &msg->header, sizeof(msg->header));
> +
> +		pos += sizeof(header);
> +
> +		if (cnt > 0)
> +			memcpy(&buf[pos], msg->payload, cnt);
>  
> -	if (cnt > 0) {
> -		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_DATA,
> -				       &msg->payload, cnt);
> +		pos += cnt;
> +		ret = regmap_raw_write(tcpci->regmap, TCPC_TX_BYTE_CNT, buf, pos);
>  		if (ret < 0)
>  			return ret;
>  	}
>  
> -	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) |
> -		(type << TCPC_TRANSMIT_TYPE_SHIFT);
> +	reg = (PD_RETRY_COUNT << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
>  	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index fd26ca35814c..cf9d8b63adcb 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -128,9 +128,17 @@
>  #define TCPC_VBUS_VOLTAGE_ALARM_HI_CFG		0x76
>  #define TCPC_VBUS_VOLTAGE_ALARM_LO_CFG		0x78
>  
> +/* I2C_WRITE_BYTE_COUNT + 1 when TX_BUF_BYTE_x is only accessible I2C_WRITE_BYTE_COUNT */
> +#define TCPC_TRANSMIT_BUFFER_MAX_LEN		31
> +
> +/*
> + * @TX_BUF_BYTE_x_hidden
> + *		optional; Set when TX_BUF_BYTE_x can only be accessed through I2C_WRITE_BYTE_COUNT.
> + */
>  struct tcpci;
>  struct tcpci_data {
>  	struct regmap *regmap;
> +	unsigned char TX_BUF_BYTE_x_hidden:1;
>  	int (*init)(struct tcpci *tcpci, struct tcpci_data *data);
>  	int (*set_vconn)(struct tcpci *tcpci, struct tcpci_data *data,
>  			 bool enable);
> -- 
> 2.28.0.297.g1956fa8f8d-goog

thanks,

-- 
heikki
