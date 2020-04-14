Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B550AC2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE99206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 12:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439928AbgDNMKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 08:10:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:35090 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439918AbgDNMKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:10:36 -0400
IronPort-SDR: Sbx7w2g+6r5SrxGvSFT0CSH7Bbd3kQwGbl7stQdqu0N9ssERqgPpYrVzwrmXTeTMo3ic2ZBpQr
 uhKhOL/w4nPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 05:10:35 -0700
IronPort-SDR: JJ/iZDxaMqli2ikt1LKxWGxUP+IQEI+H/Zac7XRD1mQWs2IOxHrhfegmPgoCZG/yRnXx8S4iEy
 giePscINfvkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="363358155"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2020 05:10:33 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 14 Apr 2020 15:10:32 +0300
Date:   Tue, 14 Apr 2020 15:10:32 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: tcpm: remove tcpm_altmode_ops and
 associations
Message-ID: <20200414121032.GF2828150@kuha.fi.intel.com>
References: <20200409085117.45819-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200409085117.45819-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 09, 2020 at 04:51:17PM +0800, Jason Yan wrote:
> Fix the following gcc warning:
> 
> drivers/usb/typec/tcpm/tcpm.c:1551:39: warning: ‘tcpm_altmode_ops’
> defined but not used [-Wunused-const-variable=]
>  static const struct typec_altmode_ops tcpm_altmode_ops = {
>                                        ^~~~~~~~~~~~~~~~
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

This is a fix, so can you resend this with the following tag:

Fixes: a079973f462a ("usb: typec: tcpm: Remove tcpc_config configuration mechanism").

Don't forget the CC stable tag as well.

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 51 -----------------------------------
>  1 file changed, 51 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index de3576e6530a..0fcb1023bdbe 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -1503,57 +1503,6 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
>  	return 0;
>  }
>  
> -static int tcpm_altmode_enter(struct typec_altmode *altmode, u32 *vdo)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	u32 header;
> -
> -	mutex_lock(&port->lock);
> -	header = VDO(altmode->svid, vdo ? 2 : 1, CMD_ENTER_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm(port, header, vdo, vdo ? 1 : 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static int tcpm_altmode_exit(struct typec_altmode *altmode)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -	u32 header;
> -
> -	mutex_lock(&port->lock);
> -	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
> -	header |= VDO_OPOS(altmode->mode);
> -
> -	tcpm_queue_vdm(port, header, NULL, 0);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> -			    u32 header, const u32 *data, int count)
> -{
> -	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> -
> -	mutex_lock(&port->lock);
> -	tcpm_queue_vdm(port, header, data, count - 1);
> -	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> -	mutex_unlock(&port->lock);
> -
> -	return 0;
> -}
> -
> -static const struct typec_altmode_ops tcpm_altmode_ops = {
> -	.enter = tcpm_altmode_enter,
> -	.exit = tcpm_altmode_exit,
> -	.vdm = tcpm_altmode_vdm,
> -};
> -
>  /*
>   * PD (data, control) command handling functions
>   */
> -- 
> 2.17.2

thanks,

-- 
heikki
