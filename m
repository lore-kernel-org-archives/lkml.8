Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E737CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4F43204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgHMI0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:26:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:57118 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgHMI0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:26:02 -0400
IronPort-SDR: OpANuW+XJDfbPGemkxrMtu23FIYRAjLSBnR5cMKff9Q68kTujbtQp9sY9eIyAkMIRr9o5aP6OS
 qJwtHw+M82Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="172224067"
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="172224067"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 01:26:02 -0700
IronPort-SDR: pzc1U5JymRxLIbeCaozGaayX+aGglITVoGdVjthTDFmaa1N8q7nt5djjmbqUkENeuFOOp09465
 1gsGUaqaVJMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,307,1592895600"; 
   d="scan'208";a="399096762"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 13 Aug 2020 01:25:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Aug 2020 11:25:59 +0300
Date:   Thu, 13 Aug 2020 11:25:59 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] usb: typec: pd: Fix formatting in pd.h header
Message-ID: <20200813082559.GF1169992@kuha.fi.intel.com>
References: <20200812022934.568134-1-badhri@google.com>
 <20200812022934.568134-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200812022934.568134-2-badhri@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:29:34PM -0700, Badhri Jagan Sridharan wrote:
> Replacing spaces with tabs for PD_T_* constants.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Change history:
> First version. Keeping the version number same as the parent.
> 
> ---
>  include/linux/usb/pd.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 1df895e4680b..f842e4589bd2 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -471,9 +471,10 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_T_VCONN_SOURCE_ON	100
>  #define PD_T_SINK_REQUEST	100	/* 100 ms minimum */
>  #define PD_T_ERROR_RECOVERY	100	/* minimum 25 is insufficient */
> -#define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
> -#define PD_T_NEWSRC            250     /* Maximum of 275ms */
> +#define PD_T_SRCSWAPSTDBY	625	/* Maximum of 650ms */
> +#define PD_T_NEWSRC		250	/* Maximum of 275ms */
>  #define PD_T_SWAP_SRC_START	20	/* Minimum of 20ms */
> +#define PD_T_BIST_CONT_MODE	50	/* 30 - 60 ms */
>  
>  #define PD_T_DRP_TRY		100	/* 75 - 150 ms */
>  #define PD_T_DRP_TRYWAIT	600	/* 400 - 800 ms */
> @@ -484,5 +485,4 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> -#define PD_T_BIST_CONT_MODE	50 /* 30 - 60 ms */
>  #endif /* __LINUX_USB_PD_H */
> -- 
> 2.28.0.236.gb10cc79966-goog

thanks,

-- 
heikki
