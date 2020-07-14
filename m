Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C72C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D585B22510
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qHkjDzVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgGNOJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgGNOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:09:41 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55BC061755;
        Tue, 14 Jul 2020 07:09:41 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so544910plt.7;
        Tue, 14 Jul 2020 07:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sviTJ3ifb1QWu+NzTxuv0CksN2y7ckL8ftomeUl3lO0=;
        b=qHkjDzVyHOizPFEYz5mPRcWvDgflCh93/f5tD90S0aWhJngQDh5a5RIMqqIKnAR14u
         z0929H1krRfMX3te1RGa9z2ug2AIMG7gqxlZAcZupln55jHoEwhlpDj0wFY99a/HJruk
         IEoLpfx6m7wbu5K8ucG2bWmsQRFSRrbEzOaugThZBF75tVxgD+3szSRMz1v0d6/V7bdu
         hueLDRY7N/sTnz6cXyCxLUaiViocY+ZLrymggYBGVsNdAnM6JLX+z7odkxfP1bovTMIC
         JDOONtuwZsmOhc5WbwZvFDnCpnrbgQ3p+JKDlxF47B9OJMjzlQU9n5DiP+5fxU7Ne58g
         gssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=sviTJ3ifb1QWu+NzTxuv0CksN2y7ckL8ftomeUl3lO0=;
        b=RpsO09zt/yESP/Vy7xnHAGBi38qnuhzEwOyQ0OTjbU1OKBG1UUDyuQpPm4/F2XSyMf
         qEQM7x7Y+zIqPK9QdIsub0dmcu7BXWqTlmMst8TdvjvpUH2DewEHvnHVBU+lgZBDS7eV
         2XWn0sDtWvNy9usDcHMy59sQChEgkloAxH0+wcmJigXW87zJ0wfUimyFnmoKQlISQZ3a
         nQcr/6WzMZ90lDi3fRgXC3svbbmfgE81wW3o+jojPagcMehP6bubgV4Jlm/DmDuZhzQx
         5bU0vXMeWjQiILPppA8HA72PbrDq2yzRlT/KB4JMc1GzDgwIhDsdOmUKaU2PHOYq9UkN
         b/VQ==
X-Gm-Message-State: AOAM532iUh18zwX/FiNY+QVAXQ8bcSO7tX8uHCZRK4y6SR+FqDnILkrc
        slIub3j1IGxKKdjFPyMJUB37YEU4L8s=
X-Google-Smtp-Source: ABdhPJwPwtvGJBEnmhVC8xNAktj+wHzdBO4zRQAQooZnuq53IHRT5hxMCRm8whFsR0OLagrAX8wknQ==
X-Received: by 2002:a17:90a:ea83:: with SMTP id h3mr5066840pjz.176.1594735780380;
        Tue, 14 Jul 2020 07:09:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e8sm18188849pfl.125.2020.07.14.07.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 07:09:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] usb: typec: tcpm: Support bist test data mode for
 compliance
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        reg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200713203838.339297-1-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <ee68dcb9-8335-81f3-fe9f-2d0cf55f4693@roeck-us.net>
Date:   Tue, 14 Jul 2020 07:09:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713203838.339297-1-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 1:38 PM, Badhri Jagan Sridharan wrote:
> TCPM supports BIST carried mode. PD compliance tests require
> BIST Test Data to be supported as well.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

This should be two patches: One to introduce support for
BDO_MODE_TESTDATA into tcpm, and one to enable it in the tcpci
code.

> ---
>  drivers/usb/typec/tcpm/tcpci.c | 14 ++++++++++++++
>  drivers/usb/typec/tcpm/tcpci.h |  3 +++
>  drivers/usb/typec/tcpm/tcpm.c  |  7 +++++++
>  include/linux/usb/tcpm.h       |  2 ++
>  4 files changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index 753645bb25273a..3616263f661233 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -227,6 +227,19 @@ static int tcpci_set_vconn(struct tcpc_dev *tcpc, bool enable)
>  				enable ? TCPC_POWER_CTRL_VCONN_ENABLE : 0);
>  }
>  
> +static int tcpci_set_bist_data(struct tcpc_dev *tcpc, bool enable)
> +{
> +	struct tcpci *tcpci = tcpc_to_tcpci(tcpc);
> +	int ret;
> +
> +	dev_info(tcpci->dev, "set bist %s\n", enable ? "true" : "false");

This should be a tcpm log message in the calling code, and not go to the kernel log.

> +	ret = regmap_update_bits(tcpci->regmap, TCPC_TCPC_CTRL,
> +				 TCPC_TCPC_CTRL_BIST_TM, enable ?
> +				 TCPC_TCPC_CTRL_BIST_TM : 0);

Formatting is a bit off here. First, the limit is now 100 columns, and
"enable ? ..." should be in one line.

> +
> +	return ret;

Just
	return regmap_update_bits(...);

> +}
> +
>  static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
>  			   enum typec_role role, enum typec_data_role data)
>  {
> @@ -530,6 +543,7 @@ struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data)
>  	tcpci->tcpc.set_pd_rx = tcpci_set_pd_rx;
>  	tcpci->tcpc.set_roles = tcpci_set_roles;
>  	tcpci->tcpc.pd_transmit = tcpci_pd_transmit;
> +	tcpci->tcpc.set_bist_data = tcpci_set_bist_data;
>  
>  	err = tcpci_parse_config(tcpci);
>  	if (err < 0)
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/drivers/usb/typec/tcpm/tcpci.h
> index 303ebde265465c..a29c8b6c2efe07 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/drivers/usb/typec/tcpm/tcpci.h
> @@ -36,6 +36,7 @@
>  
>  #define TCPC_TCPC_CTRL			0x19
>  #define TCPC_TCPC_CTRL_ORIENTATION	BIT(0)
> +#define TCPC_TCPC_CTRL_BIST_TM		BIT(1)
>  
>  #define TCPC_ROLE_CTRL			0x1a
>  #define TCPC_ROLE_CTRL_DRP		BIT(6)
> @@ -130,6 +131,8 @@ struct tcpci_data {
>  			 bool enable);
>  	int (*start_drp_toggling)(struct tcpci *tcpci, struct tcpci_data *data,
>  				  enum typec_cc_status cc);
> +	int (*set_bist_data)(struct tcpci *tcpci, struct tcpci_data *data,
> +			     bool enable);
>  };
>  
>  struct tcpci *tcpci_register_port(struct device *dev, struct tcpci_data *data);
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 82b19ebd7838e0..525379798d6c5c 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2746,6 +2746,9 @@ static void tcpm_detach(struct tcpm_port *port)
>  	if (!port->attached)
>  		return;
>  
> +	if (port->tcpc->set_bist_data)
> +		port->tcpc->set_bist_data(port->tcpc, false);
> +
>  	if (tcpm_port_is_disconnected(port))
>  		port->hard_reset_count = 0;
>  
> @@ -3555,6 +3558,10 @@ static void run_state_machine(struct tcpm_port *port)
>  		case BDO_MODE_CARRIER2:
>  			tcpm_pd_transmit(port, TCPC_TX_BIST_MODE_2, NULL);
>  			break;
> +		case BDO_MODE_TESTDATA:
> +			if (port->tcpc->set_bist_data)
> +				port->tcpc->set_bist_data(port->tcpc, true);
> +			break;
>  		default:
>  			break;
>  		}
> diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
> index e7979c01c3517c..89f58760cf4800 100644
> --- a/include/linux/usb/tcpm.h
> +++ b/include/linux/usb/tcpm.h
> @@ -79,6 +79,7 @@ enum tcpm_transmit_type {
>   * @try_role:	Optional; called to set a preferred role
>   * @pd_transmit:Called to transmit PD message
>   * @mux:	Pointer to multiplexer data
> + * @set_bist_data: Turn on/off bist data mode for compliance testing
>   */
>  struct tcpc_dev {
>  	struct fwnode_handle *fwnode;
> @@ -103,6 +104,7 @@ struct tcpc_dev {
>  	int (*try_role)(struct tcpc_dev *dev, int role);
>  	int (*pd_transmit)(struct tcpc_dev *dev, enum tcpm_transmit_type type,
>  			   const struct pd_message *msg);
> +	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
>  };
>  
>  struct tcpm_port;
> 

