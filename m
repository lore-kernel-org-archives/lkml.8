Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BFEC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84ECE2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:04:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439820AbgDNMES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:04:18 -0400
Received: from mga05.intel.com ([192.55.52.43]:42675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439796AbgDNMEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:04:11 -0400
IronPort-SDR: RNOdD/naQ0iNkiVc6nioCPwhSqlgUSEVPp4e3cB7gVje873pR6J+C6lxsw6dHduJI+JP57xgp8
 39rT/Jc6lwIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:04:10 -0700
IronPort-SDR: oRMDJOms2rSS5xzB+UCZuIQpCbcLy78EEdThCfOkqiNyBSJYsitY/zsuKdb3C1McBCmkd2YKka
 erVTBiEPhOCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="363356670"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 05:04:08 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 15:04:07 +0300
Date:   Tue, 14 Apr 2020 15:04:07 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Ignore CC and vbus changes in
 PORT_RESET change
Message-ID: <20200414120407.GE2828150@kuha.fi.intel.com>
References: <20200402215947.176577-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402215947.176577-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 02:59:47PM -0700, Badhri Jagan Sridharan wrote:
> After PORT_RESET, the port is set to the appropriate
> default_state. Ignore processing CC changes here as this
> could cause the port to be switched into sink states
> by default.
> 
> echo source > /sys/class/typec/port0/port_type
> 
> Before:
> [  154.528547] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms
> [  154.528560] CC1: 0 -> 0, CC2: 3 -> 0 [state PORT_RESET, polarity 0, disconnected]
> [  154.528564] state change PORT_RESET -> SNK_UNATTACHED
> 
> After:
> [  151.068814] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
> [  151.072440] CC1: 3 -> 0, CC2: 0 -> 0 [state PORT_RESET, polarity 0, disconnected]
> [  151.172117] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
> [  151.172136] pending state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED @ 870 ms [rev3 NONE_AMS]
> [  152.060106] state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED [delayed 870 ms]
> [  152.060118] Start toggling

Guenter, can you take a look at this?

> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index de3576e6530ab2..82b19ebd7838e0 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3794,6 +3794,14 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
>  		 */
>  		break;
>  
> +	case PORT_RESET:
> +	case PORT_RESET_WAIT_OFF:
> +		/*
> +		 * State set back to default mode once the timer completes.
> +		 * Ignore CC changes here.
> +		 */
> +		break;
> +
>  	default:
>  		if (tcpm_port_is_disconnected(port))
>  			tcpm_set_state(port, unattached_state(port), 0);
> @@ -3855,6 +3863,15 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
>  	case SRC_TRY_DEBOUNCE:
>  		/* Do nothing, waiting for sink detection */
>  		break;
> +
> +	case PORT_RESET:
> +	case PORT_RESET_WAIT_OFF:
> +		/*
> +		 * State set back to default mode once the timer completes.
> +		 * Ignore vbus changes here.
> +		 */
> +		break;
> +
>  	default:
>  		break;
>  	}
> @@ -3908,10 +3925,19 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
>  	case PORT_RESET_WAIT_OFF:
>  		tcpm_set_state(port, tcpm_default_state(port), 0);
>  		break;
> +
>  	case SRC_TRY_WAIT:
>  	case SRC_TRY_DEBOUNCE:
>  		/* Do nothing, waiting for sink detection */
>  		break;
> +
> +	case PORT_RESET:
> +		/*
> +		 * State set back to default mode once the timer completes.
> +		 * Ignore vbus changes here.
> +		 */
> +		break;
> +
>  	default:
>  		if (port->pwr_role == TYPEC_SINK &&
>  		    port->attached)
> -- 
> 2.26.0.292.g33ef6b2f38-goog

thanks,

-- 
heikki
