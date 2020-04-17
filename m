Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0205CC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6791208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T6IptGXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730328AbgDQJfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbgDQJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:35:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE37C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:35:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so2239295wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eCVHboKKWOnwvWAz8+xL2mDoaCizI1H5EPD58JQK6Rk=;
        b=T6IptGXXEQkhtJrMUTTA3jtihdAaJ+tHkexXg51Vh/hdym9qz6otEVa7epFXYPt0pg
         TrjvTI3txaGa9GjA5HnEn3PgSx0/w3UAkIIJUYDfxEKKyvIGJse0wuWVDPGE/NxA+XaU
         4tbwKw4ROj0kINMZRN8exQ8EmkktRpO1NQjnUDI706IXO9y+g1pQ8d7GIooWXpg2x2gp
         MVMaRT0Y2gfp8nP0eq9iaxnfZ2+30LpGFbN8Za5fJIScOv+NQhkZUJoGDlUxSs9NTc9l
         s/hCwy9lNBJhlGy18L9093l+xRIByTaz/sKhqo8gGGmYfcHUJLntHrf746YMhxk01acH
         szQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eCVHboKKWOnwvWAz8+xL2mDoaCizI1H5EPD58JQK6Rk=;
        b=RvFVL3KehAUP67jQaca55CZZn9gVJZc2WKrDh5DuiP322cz/wcGdBqsNPEM5/NDIg+
         mQxN+hPS3M38trjqx4WQT+AB9ZJDqMeHidisGbbSTu3CrqAhGgnS1P58jshG9R0bUlWP
         /FYEdVL6iuzGX2utyQbYQbuDwPwjhjm3gNFmFV/OfCMrihLNhUCD2lkd5H5vJf8WbRpJ
         CUcTD4b/ykAAo0aImk0jHse4UoFRTipBesGuisHALUEmh1nTjDf2lAqa8a3Ra868KJD0
         98KV5+FC81w496AzSjZn7mtmIov9Lwc1XLN5A+YYbaUTl5moj6CVstbU7LD9eNfSy/Fn
         veaw==
X-Gm-Message-State: AGi0PuamrHowKb9iqG9I0byD9s5tNkGgZYl+i549R8q6RZaWgOvGbk6i
        o/LvfUNHFTa2CFWipjLvkEP7tKLKUpk=
X-Google-Smtp-Source: APiQypJIfwLF/8KROwCfC+/ond22ImgZcm7Tb1JWQFyUHiQTIwCxofND0HxoXClayCvlxRkhoaJEuA==
X-Received: by 2002:a5d:634d:: with SMTP id b13mr2843037wrw.353.1587116142734;
        Fri, 17 Apr 2020 02:35:42 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h188sm7519481wme.8.2020.04.17.02.35.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:35:42 -0700 (PDT)
Subject: Re: [PATCH v1] slimbus: core: Fix mismatch in of_node_get/put
To:     Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20200326173457.29233-1-saravanak@google.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <5b5ec594-9e17-8504-4711-0db8a6a53c22@linaro.org>
Date:   Fri, 17 Apr 2020 10:35:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200326173457.29233-1-saravanak@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/03/2020 17:34, Saravana Kannan wrote:
> Also, remove some unnecessary NULL checks. The functions in question
> already do NULL checks.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

Applied Thanks,
--srini

> ---
>   drivers/slimbus/core.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
> index 44228a5b246d..ae1e248a8fb8 100644
> --- a/drivers/slimbus/core.c
> +++ b/drivers/slimbus/core.c
> @@ -162,11 +162,8 @@ static int slim_add_device(struct slim_controller *ctrl,
>   	sbdev->ctrl = ctrl;
>   	INIT_LIST_HEAD(&sbdev->stream_list);
>   	spin_lock_init(&sbdev->stream_list_lock);
> -
> -	if (node) {
> -		sbdev->dev.of_node = of_node_get(node);
> -		sbdev->dev.fwnode = of_fwnode_handle(node);
> -	}
> +	sbdev->dev.of_node = of_node_get(node);
> +	sbdev->dev.fwnode = of_fwnode_handle(node);
>   
>   	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
>   				  sbdev->e_addr.manf_id,
> @@ -285,6 +282,7 @@ EXPORT_SYMBOL_GPL(slim_register_controller);
>   /* slim_remove_device: Remove the effect of slim_add_device() */
>   static void slim_remove_device(struct slim_device *sbdev)
>   {
> +	of_node_put(sbdev->dev.of_node);
>   	device_unregister(&sbdev->dev);
>   }
>   
> 
