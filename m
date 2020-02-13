Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1ADC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F392082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBMLe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:34:28 -0500
Received: from mga09.intel.com ([134.134.136.24]:12562 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgBMLe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:34:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 03:34:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="347712799"
Received: from kuha.fi.intel.com ([10.237.72.53])
  by fmsmga001.fm.intel.com with SMTP; 13 Feb 2020 03:34:24 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 13 Feb 2020 13:34:23 +0200
Date:   Thu, 13 Feb 2020 13:34:23 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: remove redundant assignment to
 variable num
Message-ID: <20200213113423.GK1498@kuha.fi.intel.com>
References: <20200208165022.30429-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208165022.30429-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 04:50:22PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable num is being assigned with a value that is never read, it is
> assigned a new value later in a for-loop. The assignment is redundant
> and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/typec/ucsi/ucsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index d5a6aac86327..b1b72cb7af10 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -400,7 +400,7 @@ static int ucsi_register_altmodes(struct ucsi_connector *con, u8 recipient)
>  	struct typec_altmode_desc desc;
>  	struct ucsi_altmode alt[2];
>  	u64 command;
> -	int num = 1;
> +	int num;
>  	int ret;
>  	int len;
>  	int j;

Greg! I'll pick this, and to you with a few other patches that I have
in my queue for the ucsi driver. I hope that's OK.

thanks,

-- 
heikki
