Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D78C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F80521D91
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoXFNKZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgDQJfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgDQJfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:35:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417FC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:35:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h2so2233463wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f50Rp9fX0B6RGwIPtYeIoasFyg69G1qVoaejlKsFhjU=;
        b=zoXFNKZCD083C8bPzbEhJ8UQr7lCBAyG0ZEkzPv2iA4Ul0JJx73+cvp/+DXem679/p
         93Gu5BANNidBCAkmlTONFFSnBJHvQ6wlQ4n2OpiCL120Sl5GD1YcKJ2/L6z//iBoXh97
         Y3evIlrwENOIE7aSBojUH1IIT3Zwbmu6nNJxz3JNx0rXgsmhN3hY1xNJdCJ4ytV4atzx
         Ne7GSJlbcG7vRJcTlYrN6/0bCyG92hpioGBLXlHnX2j/aC0vTyKzFIoRL3o1Hyr8NDiB
         xNKbMEqczafeBvrQyf+Rk8L+XEMbRa0y8oHdshJ3OezJkwEdsrgtgdaN0dkFBGrDgkh7
         aEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f50Rp9fX0B6RGwIPtYeIoasFyg69G1qVoaejlKsFhjU=;
        b=dK4BfhORyOgqHXjjJ2tF7DSx4sH1SNoVKjX8Of6zk30vCuWj3u1HF5MtAiA7U9fzCU
         EnNd0slvCDZqUs+bRlXeO+LKli9kVamlMhgT1zyOUJxNoxvxEujDUognfVVxAawghqoG
         fM99J4tpfQfYTwdn53FR8oB0kXBDywQs3pJRfDECAnhldvL5YF2GyKyBhxeNMCKDFVTs
         xlXnUghje217St/wLwdKAnAHHYMaUZEiRX2V1/HFzw8lQqFb+LGum6J2o4eBpXxcqJQ4
         nZQcyzvc935OlB+gmlLgRhSFMLC9U1j63q+7CdI+wi4pwpYwXrBFEHZRyEGJzxQqbA7t
         jhOw==
X-Gm-Message-State: AGi0PubiUXkePAjFG2oRWko6FLCJkT47kraExzjG5CbbFp18dmxYmT5Z
        yg7guYPcb37zoDjduSL32Dv/XU1amcA=
X-Google-Smtp-Source: APiQypK8pqAGTMRV3NBuqhRZc4DeFWddMOR6owMH2wbsZ4oYS+Q35xyiKr9C8Llsffkt6HeUqy+uCw==
X-Received: by 2002:a1c:3986:: with SMTP id g128mr2441087wma.8.1587116149452;
        Fri, 17 Apr 2020 02:35:49 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id y63sm7112981wmg.21.2020.04.17.02.35.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:35:48 -0700 (PDT)
Subject: Re: [PATCH v2] slimbus: core: Set fwnode for a device when setting
 of_node
To:     Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200326172457.205493-1-saravanak@google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1da61e5c-7a8b-8c38-bba4-6f4043f50ecf@linaro.org>
Date:   Fri, 17 Apr 2020 10:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200326172457.205493-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/03/2020 17:24, Saravana Kannan wrote:
> When setting the of_node for a newly created device, also set the
> fwnode. This allows fw_devlink feature to work for slimbus devices.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Applied Thanks,
--srini
> ---
>   drivers/slimbus/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 526e3215d8fe..44228a5b246d 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
>   	INIT_LIST_HEAD(&sbdev->stream_list);
>   	spin_lock_init(&sbdev->stream_list_lock);
>   
> -	if (node)
> +	if (node) {
>   		sbdev->dev.of_node = of_node_get(node);
> +		sbdev->dev.fwnode = of_fwnode_handle(node);
> +	}
>   
>   	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>   				  sbdev->e_addr.manf_id,
> 
