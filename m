Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086C0C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D863220757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 21:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgD2V6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 17:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgD2V6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 17:58:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32335C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 14:58:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 655242A22CF
Subject: Re: [PATCH] platform/chrome: cros_ec_typec: Handle NULL EC pointer
 during probe.
To:     Daniil Lunev <dlunev@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c57b0892-d68d-f0f2-3cc1-b8549983227e@collabora.com>
Date:   Wed, 29 Apr 2020 23:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428110253.1.I926f6741079cafb04ecb592130aef75b24ad31ae@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniil,

Thank you for the patch.

On 28/4/20 3:02, Daniil Lunev wrote:
> Missing EC in device hierarchy causes NULL pointer to be returned to the
> probe function which leads to NULL pointer dereference when trying to
> send a command to the EC. This can be the case if the device is missing
> or incorrectly configured in the firmware blob. Even if the situation

There is any production device with a buggy firmware outside? Or this is just
for defensive programming while developing the firmware? Which device is
affected for this issue?

Thanks,
 Enric

> occures, the driver shall not cause a kernel panic as the condition is
> not critical for the system functions.
> 
> Signed-off-by: Daniil Lunev <dlunev@chromium.org>
> ---
> 
>  drivers/platform/chrome/cros_ec_typec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> index 874269c07073..30d99c930445 100644
> --- a/drivers/platform/chrome/cros_ec_typec.c
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -301,6 +301,11 @@ static int cros_typec_probe(struct platform_device *pdev)
>  
>  	typec->dev = dev;
>  	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	if (!typec->ec) {
> +		dev_err(dev, "Failed to get Cros EC data\n");
> +		return -EINVAL;
> +	}
> +
>  	platform_set_drvdata(pdev, typec);
>  
>  	ret = cros_typec_get_cmd_version(typec);
> 
