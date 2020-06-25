Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABDDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B263C206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgFYL5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404285AbgFYL5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:57:11 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31580C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 04:57:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 59AC12A50EC
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Make configure_mux static
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, kernel test robot <lkp@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200620020038.230887-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <1a05b712-0617-dc57-6099-dd4a072af9f9@collabora.com>
Date:   Thu, 25 Jun 2020 13:57:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200620020038.230887-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 20/6/20 4:00, Prashant Malani wrote:
> Since cros_typec_configure_mux() is only used in cros-ec-typec,
> it should be marked static.
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Applied for 5.9

> ---
>  drivers/platform/chrome/cros_ec_typec.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 509fc761906b..1df1386f32e4 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -428,9 +428,9 @@ static int cros_typec_enable_dp(struct cros_typec_data *typec,
>  	return typec_mux_set(port->mux, &port->state);
>  }
>  
> -int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> -			     uint8_t mux_flags,
> -			     struct ec_response_usb_pd_control_v2 *pd_ctrl)
> +static int cros_typec_configure_mux(struct cros_typec_data *typec, int port_num,
> +				uint8_t mux_flags,
> +				struct ec_response_usb_pd_control_v2 *pd_ctrl)
>  {
>  	struct cros_typec_port *port = typec->ports[port_num];
>  	enum typec_orientation orientation;
> 
