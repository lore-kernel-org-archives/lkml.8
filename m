Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62789C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49941206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbgG1L4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:56:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:47349 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgG1L4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:56:18 -0400
IronPort-SDR: eDUbmE8oUZ8Ce19dRqYP/LVJuDH+ICaHKGshqT9GV2I0hogO1UhHPWa6wVxV7CxRjKxz25jzf9
 bc7rVtUdWsnw==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="169305966"
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="169305966"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 04:56:18 -0700
IronPort-SDR: tsHcer/XF3MYNZfSm8piNeuMMBqLcG4D6qBKoOrrhgtVpI4L/HTkp+m0xhTEF9DEAgp8gXxE1j
 2D9a52l7baEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,406,1589266800"; 
   d="scan'208";a="394310536"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 28 Jul 2020 04:56:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 28 Jul 2020 14:56:15 +0300
Date:   Tue, 28 Jul 2020 14:56:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Kyle Tso <kyletso@google.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] usb: typec: Comment correction for
 typec_partner_register_altmode
Message-ID: <20200728115615.GD883641@kuha.fi.intel.com>
References: <20200714033453.4044482-1-kyletso@google.com>
 <20200714033453.4044482-2-kyletso@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714033453.4044482-2-kyletso@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 11:34:52AM +0800, Kyle Tso wrote:
> typec_register_altmode returns ERR_PTR on failure.
> 
> Signed-off-by: Kyle Tso <kyletso@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/class.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index c9234748537a..02655694f200 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -580,7 +580,7 @@ EXPORT_SYMBOL_GPL(typec_partner_set_identity);
>   * SVID listed in response to Discover Modes command need to be listed in an
>   * array in @desc.
>   *
> - * Returns handle to the alternate mode on success or NULL on failure.
> + * Returns handle to the alternate mode on success or ERR_PTR on failure.
>   */
>  struct typec_altmode *
>  typec_partner_register_altmode(struct typec_partner *partner,
> -- 
> 2.27.0.389.gc38d7665816-goog

-- 
heikki
