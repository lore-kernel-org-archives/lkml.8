Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E32206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbgG1L4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:56:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:4606 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgG1L4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:56:50 -0400
IronPort-SDR: McS2wKE0XI3MB/Q3ZRFvefwgw9WUtPEYe9XON+y6C7US38VzFW8hf1wW9CicZMkqkQScbOSlGP
 zxAbM1Sen9rA==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="152445565"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="152445565"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 04:56:49 -0700
IronPort-SDR: S2/dcYrIit3AWvum25eTbvPfg1pyeTNBZm4i1SqjNH/oUjcIdlDrGIHuycF+4og8shtMN/Htrh
 UDUc4MtqgIhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="394310584"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Jul 2020 04:56:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jul 2020 14:56:46 +0300
Date:   Tue, 28 Jul 2020 14:56:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: typec: tcpm: Error handling for
 tcpm_register_partner_altmodes
Message-ID: <20200728115646.GE883641@kuha.fi.intel.com>
References: <20200714033453.4044482-1-kyletso@google.com>
 <20200714033453.4044482-3-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714033453.4044482-3-kyletso@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:34:53AM +0800, Kyle Tso wrote:
> typec_partner_register_altmode returns ERR_PTR. Reset the pointer
> altmode to NULL on failure.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 82b19ebd7838..a6d4b03ec250 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1061,9 +1061,11 @@ static void tcpm_register_partner_altmodes(struct tcpm_port *port)
>  	for (i = 0; i < modep->altmodes; i++) {
>  		altmode = typec_partner_register_altmode(port->partner,
>  						&modep->altmode_desc[i]);
> -		if (!altmode)
> +		if (IS_ERR(altmode)) {
>  			tcpm_log(port, "Failed to register partner SVID 0x%04x",
>  				 modep->altmode_desc[i].svid);
> +			altmode = NULL;
> +		}
>  		port->partner_altmode[i] = altmode;
>  	}
>  }
> -- 
> 2.27.0.389.gc38d7665816-goog

thanks,

-- 
heikki
