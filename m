Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC5AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B822077D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 09:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729544AbgGAJKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgGAJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:10:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7B1C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 02:10:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E2BF12A0CAB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform/chrome: fix a double-unlock issue
To:     wu000273@umn.edu, bleung@chromium.org
Cc:     groeck@chromium.org, linux-kernel@vger.kernel.org, kjlu@umn.edu
References: <20200523031608.17918-1-wu000273@umn.edu>
Message-ID: <3ee01d41-fb55-6a08-f041-f885c8b7415d@collabora.com>
Date:   Wed, 1 Jul 2020 11:10:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200523031608.17918-1-wu000273@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qiushi,

Thank you for the patch.

On 23/5/20 5:16, wu000273@umn.edu wrote:
> From: Qiushi Wu <wu000273@umn.edu>
> 
> In function cros_ec_ishtp_probe(), "up_write" is already called
> before function "cros_ec_dev_init". But "up_write" will be called
> again after the calling of the function "cros_ec_dev_init" failed.
> Thus add a call of the function “down_write” in this if branch
> for the completion of the exception handling.
> 
> Fixes: 26a14267aff2 ("platform/chrome: Add ChromeOS EC ISHTP driver")
> Signed-off-by: Qiushi Wu <wu000273@umn.edu>

Applied for 5.9

> ---
>  drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
> index 93a71e93a2f1..41d60af618c9 100644
> --- a/drivers/platform/chrome/cros_ec_ishtp.c
> +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> @@ -660,8 +660,10 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
>  
>  	/* Register croc_ec_dev mfd */
>  	rv = cros_ec_dev_init(client_data);
> -	if (rv)
> +	if (rv) {
> +		down_write(&init_lock);
>  		goto end_cros_ec_dev_init_error;
> +	}
>  
>  	return 0;
>  
> 
