Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5028AC55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A65E20A8B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgDZQhD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 12:37:03 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60400 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgDZQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 12:37:03 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id 1cee46b1b99a3b96; Sun, 26 Apr 2020 18:37:01 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: Output correct message on target power state
Date:   Sun, 26 Apr 2020 18:37:01 +0200
Message-ID: <3055388.nd58z99ANK@kreacher>
In-Reply-To: <20200421075516.23019-1-kai.heng.feng@canonical.com>
References: <20200421075516.23019-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 21, 2020 9:55:16 AM CEST Kai-Heng Feng wrote:
> Transitioned power state logged at the end of setting ACPI power.
> 
> However, D3cold won't be in the message because state can only be D3hot
> at most.
> 
> Use target_state to corretly report when power state is D3cold.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/acpi/device_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
> index b2263ec67b43..5832bc10aca8 100644
> --- a/drivers/acpi/device_pm.c
> +++ b/drivers/acpi/device_pm.c
> @@ -273,13 +273,13 @@ int acpi_device_set_power(struct acpi_device *device, int state)
>   end:
>  	if (result) {
>  		dev_warn(&device->dev, "Failed to change power state to %s\n",
> -			 acpi_power_state_string(state));
> +			 acpi_power_state_string(target_state));
>  	} else {
>  		device->power.state = target_state;
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Device [%s] transitioned to %s\n",
>  				  device->pnp.bus_id,
> -				  acpi_power_state_string(state)));
> +				  acpi_power_state_string(target_state)));
>  	}
>  
>  	return result;
> 

Applied as a fix for 5.7-rc4, thanks!




