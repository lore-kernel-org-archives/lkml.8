Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E3C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EFBA206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 13:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHRNiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 09:38:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58922 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgHRNho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:37:44 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id D1A94299361
Subject: Re: [PATCH v3 1/3] platform/chrome: cros_ec_typec: Send enum values
 to usb_role_switch_set_role()
To:     Azhar Shaikh <azhar.shaikh@intel.com>, bleung@chromium.org,
        groeck@chromium.org, heikki.krogerus@linux.intel.com,
        pmalani@chromium.org
Cc:     linux-kernel@vger.kernel.org, rajmohan.mani@intel.com,
        utkarsh.h.patel@intel.com, casey.g.bowman@intel.com
References: <20200811193757.45057-1-azhar.shaikh@intel.com>
 <20200811193757.45057-2-azhar.shaikh@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <da604f7b-04d6-5d1b-c794-28d3aee540e3@collabora.com>
Date:   Tue, 18 Aug 2020 15:37:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811193757.45057-2-azhar.shaikh@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Azhar,

Thank you for your patch.

On 11/8/20 21:37, Azhar Shaikh wrote:
> usb_role_switch_set_role() has the second argument as enum for usb_role.
> Currently depending upon the data role i.e. UFP(0) or DFP(1) is sent.
> This eventually translates to USB_ROLE_NONE in case of UFP and
> USB_ROLE_DEVICE in case of DFP. Correct this by sending correct enum
> values as USB_ROLE_DEVICE in case of UFP and USB_ROLE_HOST in case of
> DFP.
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> 

No extra line here.

> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>

Did the Prashant reviewed tag disappear for some reason? Can you resend the
patches with all the collected tags? (looks like this patch and others from this
series already have been reviewed)

Thanks,
  Enric

> ---
> Changes in v3:
>  - No changes
> 
> Changes in v2:
>  - Update the commit message to change 'USB_ROLE_HOST in case of
>     UFP.'  to 'USB_ROLE_HOST in case of DFP.'
> 
>  drivers/platform/chrome/cros_ec_typec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 3fcd27ec9ad8..06108212ee94 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -591,7 +591,8 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
>  		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
>  
>  	return usb_role_switch_set_role(typec->ports[port_num]->role_sw,
> -					!!(resp.role & PD_CTRL_RESP_ROLE_DATA));
> +				       resp.role & PD_CTRL_RESP_ROLE_DATA
> +				       ? USB_ROLE_HOST : USB_ROLE_DEVICE);
>  }
>  
>  static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> 
