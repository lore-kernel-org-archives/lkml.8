Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DB5C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D005620735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:46:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbgEENq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:46:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:52025 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728180AbgEENqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:46:25 -0400
IronPort-SDR: Sy9rITzggKW7/nnGyFy2l3LwvkfGWjRXp01uJdQotIQcF32CnzA7wI29DPm8cefgciGORbEDbw
 kV5pG8+2NEDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:46:25 -0700
IronPort-SDR: p6F7EkxRkwvT9S0Gh2WXD0ldgh3mABLeE2Kl4aB8g7+Efe3d5WIH3/eJA3I839vqKZ0vF6mqvh
 mHRC0lrJS7NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="434489296"
Received: from marshy.an.intel.com (HELO [10.122.105.159]) ([10.122.105.159])
  by orsmga005.jf.intel.com with ESMTP; 05 May 2020 06:46:24 -0700
Subject: Re: [PATCH 3/4 v2] firmware: stratix10-svc: Fix some error handling
 paths in 'stratix10_svc_drv_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, atull@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
 <0ff40f39de4deb63b03b363d0e0f3e3c8cccd62d.1588142343.git.christophe.jaillet@wanadoo.fr>
From:   Richard Gong <richard.gong@linux.intel.com>
Message-ID: <1c0b3414-aea4-8b10-d4a9-4e04f1988002@linux.intel.com>
Date:   Tue, 5 May 2020 09:02:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0ff40f39de4deb63b03b363d0e0f3e3c8cccd62d.1588142343.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Similarly we need add error handling for controller and chans, something 
like below:

@@ -997,13 +997,17 @@ static int stratix10_svc_drv_probe(struct 
platform_device *pdev)

         /* allocate service controller and supporting channel */
         controller = devm_kzalloc(dev, sizeof(*controller), GFP_KERNEL);
-       if (!controller)
-               return -ENOMEM;
+       if (!controller) {
+               ret = -ENOMEM;
+               goto err_destroy_pool;
+       }

         chans = devm_kmalloc_array(dev, SVC_NUM_CHANNEL,
                                    sizeof(*chans), GFP_KERNEL | 
__GFP_ZERO);
-       if (!chans)
-               return -ENOMEM;
+       if (!chans) {
+               ret = -ENOMEM;
+               goto err_destroy_pool;
+       }

         controller->dev = dev;
         controller->num_chans = SVC_NUM_CHANNEL;

On 4/29/20 1:52 AM, Christophe JAILLET wrote:
> If an error occurs after calling 'svc_create_memory_pool()', the allocated
> genpool should be destroyed with 'gen_pool_destroy()', as already done in
> the remove function.
> 
> If an error occurs after calling 'kfifo_alloc()', the allocated memory
> should be freed with 'kfifo_free()', as already done in the remove
> function.
> 
> While at it, also move a 'platform_device_put()' call to the error handling
> path.
> 
> Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/firmware/stratix10-svc.c | 26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
I am fine with below changes.

> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
> index de5870f76c5e..739004398877 100644
> --- a/drivers/firmware/stratix10-svc.c
> +++ b/drivers/firmware/stratix10-svc.c
> @@ -1024,7 +1024,7 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   	ret = kfifo_alloc(&controller->svc_fifo, fifo_size, GFP_KERNEL);
>   	if (ret) {
>   		dev_err(dev, "failed to allocate FIFO\n");
> -		return ret;
> +		goto err_destroy_pool;
>   	}
>   	spin_lock_init(&controller->svc_fifo_lock);
>   
> @@ -1043,24 +1043,34 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>   
>   	/* add svc client device(s) */
>   	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
> -	if (!svc)
> -		return -ENOMEM;
> +	if (!svc) {
> +		ret = -ENOMEM;
> +		goto err_free_kfifo;
> +	}
>   
>   	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
>   	if (!svc->stratix10_svc_rsu) {
>   		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_free_kfifo;
>   	}
>   
>   	ret = platform_device_add(svc->stratix10_svc_rsu);
> -	if (ret) {
> -		platform_device_put(svc->stratix10_svc_rsu);
> -		return ret;
> -	}
> +	if (ret)
> +		goto put_platform;
> +
>   	dev_set_drvdata(dev, svc);
>   
>   	pr_info("Intel Service Layer Driver Initialized\n");
>   
> +	return 0;
> +
> +put_platform:
> +	platform_device_put(svc->stratix10_svc_rsu);
> +err_free_kfifo:
> +	kfifo_free(&controller->svc_fifo);
> +err_destroy_pool:
> +	gen_pool_destroy(genpool);
>   	return ret;
>   }
>   
> 
Regards,
Richard
