Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEF7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFA42077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgGAJKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgGAJKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:10:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCDC061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:10:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ADA832A0CAB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Add a dependency on
 USB_ROLE_SWITCH
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org, kernel test robot <lkp@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <20200629103223.1284442-1-enric.balletbo@collabora.com>
Message-ID: <d5a8092d-a78c-1614-7d8a-3e58a7ed7d69@collabora.com>
Date:   Wed, 1 Jul 2020 11:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629103223.1284442-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thank you for you ack

On 29/6/20 12:32, Enric Balletbo i Serra wrote:
> As reported by the kernel test robot the cros_ec_typec driver fails to
> build if the USB_ROLE_SWITCH is not selected, to fix that, add a
> dependency on that symbol. This fixes the following build error:
> 
>    drivers/platform/chrome/cros_ec_typec.c:133: undefined reference to `usb_role_switch_put'
>    ld: drivers/platform/chrome/cros_ec_typec.o: in function `cros_typec_get_switch_handles':
>    drivers/platform/chrome/cros_ec_typec.c:108: undefined reference to `fwnode_usb_role_switch_get'
>    ld: drivers/platform/chrome/cros_ec_typec.c:117: undefined reference to `usb_role_switch_put'
> 
> Fixes: 7e7def15fa4b ("platform/chrome: cros_ec_typec: Add USB mux control")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for 5.9

> ---
> 
>  drivers/platform/chrome/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index cf072153bdc5..a056031dee81 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -218,6 +218,7 @@ config CROS_EC_TYPEC
>  	tristate "ChromeOS EC Type-C Connector Control"
>  	depends on MFD_CROS_EC_DEV && TYPEC
>  	depends on CROS_USBPD_NOTIFY
> +	depends on USB_ROLE_SWITCH
>  	default MFD_CROS_EC_DEV
>  	help
>  	  If you say Y here, you get support for accessing Type C connector
> 
