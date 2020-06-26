Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD9420675
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 09:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgFZJLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 05:11:03 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47084 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgFZJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 05:11:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E58372A59CA
Subject: Re: [PATCH 1/2] platform/chrome: cros_ec_typec: Add TBT pd_ctrl
 fields
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Yicheng Li <yichengli@chromium.org>
References: <20200624080926.165107-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <26f8dac0-36a0-65ba-a219-8c1d65f1799f@collabora.com>
Date:   Fri, 26 Jun 2020 11:10:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624080926.165107-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 24/6/20 10:09, Prashant Malani wrote:
> To support Thunderbolt compatibility mode, synchronize
> ec_response_usb_pd_control_v2 with the Chrome EC version, so that
> we get the Thunderbolt related control fields and macros.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Applied both patches for 5.9

> ---
>  .../linux/platform_data/cros_ec_commands.h    | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
> index a7b0fc440c35..b808570bdd04 100644
> --- a/include/linux/platform_data/cros_ec_commands.h
> +++ b/include/linux/platform_data/cros_ec_commands.h
> @@ -4917,15 +4917,26 @@ struct ec_response_usb_pd_control_v1 {
>  #define USBC_PD_CC_UFP_ATTACHED	4 /* UFP attached to usbc */
>  #define USBC_PD_CC_DFP_ATTACHED	5 /* DPF attached to usbc */
>  
> +/* Active/Passive Cable */
> +#define USB_PD_CTRL_ACTIVE_CABLE        BIT(0)
> +/* Optical/Non-optical cable */
> +#define USB_PD_CTRL_OPTICAL_CABLE       BIT(1)
> +/* 3rd Gen TBT device (or AMA)/2nd gen tbt Adapter */
> +#define USB_PD_CTRL_TBT_LEGACY_ADAPTER  BIT(2)
> +/* Active Link Uni-Direction */
> +#define USB_PD_CTRL_ACTIVE_LINK_UNIDIR  BIT(3)
> +
>  struct ec_response_usb_pd_control_v2 {
>  	uint8_t enabled;
>  	uint8_t role;
>  	uint8_t polarity;
>  	char state[32];
> -	uint8_t cc_state; /* USBC_PD_CC_*Encoded cc state */
> -	uint8_t dp_mode;  /* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> -	/* CL:1500994 Current cable type */
> -	uint8_t reserved_cable_type;
> +	uint8_t cc_state;	/* enum pd_cc_states representing cc state */
> +	uint8_t dp_mode;	/* Current DP pin mode (MODE_DP_PIN_[A-E]) */
> +	uint8_t reserved;	/* Reserved for future use */
> +	uint8_t control_flags;	/* USB_PD_CTRL_*flags */
> +	uint8_t cable_speed;	/* TBT_SS_* cable speed */
> +	uint8_t cable_gen;	/* TBT_GEN3_* cable rounded support */
>  } __ec_align1;
>  
>  #define EC_CMD_USB_PD_PORTS 0x0102
> 
