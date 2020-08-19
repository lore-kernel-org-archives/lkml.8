Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9D7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81AE120772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgHSGdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:33:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:54924 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726685AbgHSGdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:33:08 -0400
IronPort-SDR: VR+3QcAulfk/HIxfCiq8T2S1bybY+5vQK8lxbQRkQNUGpEV2tQfeUNAqVZZRweEBOv/QS7Of1T
 5LPkzzBzO9zQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="152675316"
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="152675316"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 23:30:57 -0700
IronPort-SDR: yWGynPXoF/ygcZzdiuq4SnHzVEviyzMnEv8e3E0nomUDhYzbJYzVNCN8LMryjRcCns9bAmMmcb
 nwLn6d8Wq2LQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,330,1592895600"; 
   d="scan'208";a="400730444"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 18 Aug 2020 23:30:54 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Aug 2020 09:30:54 +0300
Date:   Wed, 19 Aug 2020 09:30:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 v4] tcpm: During PR_SWAP, source caps should be sent
 only after tSwapSourceStart
Message-ID: <20200819063054.GA2772165@kuha.fi.intel.com>
References: <20200817183828.1895015-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817183828.1895015-1-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:38:27AM -0700, Badhri Jagan Sridharan wrote:
> The patch addresses the compliance test failures while running
> TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 of the "Deterministic PD
> Compliance MOI" test plan published in https://www.usb.org/usbc.
> For a product to be Type-C compliant, it's expected that these tests
> are run on usb.org certified Type-C compliance tester as mentioned in
> https://www.usb.org/usbc.
> 
> The purpose of the tests TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 is to
> verify the PR_SWAP response of the device. While doing so, the test
> asserts that Source Capabilities message is NOT received from the test
> device within tSwapSourceStart min (20 ms) from the time the last bit
> of GoodCRC corresponding to the RS_RDY message sent by the UUT was
> sent. If it does then the test fails.
> 
> This is in line with the requirements from the USB Power Delivery
> Specification Revision 3.0, Version 1.2:
> "6.6.8.1 SwapSourceStartTimer
> The SwapSourceStartTimer Shall be used by the new Source, after a
> Power Role Swap or Fast Role Swap, to ensure that it does not send
> Source_Capabilities Message before the new Sink is ready to receive
> the
> Source_Capabilities Message. The new Source Shall Not send the
> Source_Capabilities Message earlier than tSwapSourceStart after the
> last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
> Message sent by the new Source indicating that its power supply is
> ready."
> 
> The patch makes sure that TCPM does not send the Source_Capabilities
> Message within tSwapSourceStart(20ms) by transitioning into
> SRC_STARTUP only after  tSwapSourceStart(20ms).
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V1:
> - Comment on the permissible values of tSwapSourceStart
> 
> Changes since V2:
> - Fixing alignment issue pointed out by Guenter.
> - Added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Changes since V3:
> - Updated commit description and made it elaborate to address Heikki's
>   suggestion.
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
>  include/linux/usb/pd.h        | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 3ef37202ee37..d38347bd3335 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -3555,7 +3555,7 @@ static void run_state_machine(struct tcpm_port *port)
>  		 */
>  		tcpm_set_pwr_role(port, TYPEC_SOURCE);
>  		tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> -		tcpm_set_state(port, SRC_STARTUP, 0);
> +		tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
>  		break;
>  
>  	case VCONN_SWAP_ACCEPT:
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index b6c233e79bd4..1df895e4680b 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
>  #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
>  #define PD_T_NEWSRC            250     /* Maximum of 275ms */
> +#define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
>  
>  #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
>  #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */

thanks,

-- 
heikki
