Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E61E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA78D206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404043AbgFYQfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390396AbgFYQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:35:55 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D8C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:35:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 539C12A572E
Subject: Re: [PATCH 01/10] mfd: cros_ec_dev: Fix cros_feature_to_{name,cells}
 struct descriptions
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
 <20200625163127.4000462-2-lee.jones@linaro.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <023445fb-370f-441f-7f3c-dad0c0695208@collabora.com>
Date:   Thu, 25 Jun 2020 18:35:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625163127.4000462-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Thank you for fixing this.

On 25/6/20 18:31, Lee Jones wrote:
> Kerneldoc expects kernel structures to be prefixed with 'struct'.
> 
> Fixes the following W=1 level warnings:
> 
>  drivers/mfd/cros_ec_dev.c:32: warning: cannot understand function prototype: 'struct cros_feature_to_name '
>  drivers/mfd/cros_ec_dev.c:44: warning: cannot understand function prototype: 'struct cros_feature_to_cells '
> 
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Bill Richardson <wfrichar@chromium.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/mfd/cros_ec_dev.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index 32c2b912b58b2..d07b43d7c761a 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -24,7 +24,7 @@ static struct class cros_class = {
>  };
>  
>  /**
> - * cros_feature_to_name - CrOS feature id to name/short description.
> + * struct cros_feature_to_name - CrOS feature id to name/short description.
>   * @id: The feature identifier.
>   * @name: Device name associated with the feature id.
>   * @desc: Short name that will be displayed.
> @@ -36,7 +36,7 @@ struct cros_feature_to_name {
>  };
>  
>  /**
> - * cros_feature_to_cells - CrOS feature id to mfd cells association.
> + * struct cros_feature_to_cells - CrOS feature id to mfd cells association.
>   * @id: The feature identifier.
>   * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
>   * @num_cells: Number of mfd cells into the array.
> 
