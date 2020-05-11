Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD494C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92184206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k4meKUSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgEKQ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbgEKQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:58:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32FDC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:58:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s20so4182975plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/050qfJ93sW4lLOTbSTbI1quifuX07x4Ug4l6sawsaw=;
        b=k4meKUSx1VcNFh0d8UQiBhM67iGelQTg5p104vT+K5hAqKvRAtLK3hNjXOHCas+u7y
         Y8OByJqu4RNU8G5VD5Knc6eBHU0BRWIaWWxMc28JAym5OFMoUg9Q4JywBA6VZaXLHUT9
         Dfs8GWJupDNkqNX/geKvgWMOKLginkX9+2IhU2gM3pZ22umGgBsXOX0LYVPp6ZuY/LVT
         LWVjkGrp5rUHewFiigSuNt1FSAJYE4KYKW+GI8h99wAoGfr5CDUpOs20dL77L4p0zehz
         exRkC8g3MTd8oV8LREgDRIKweMoETCZdUan0uNp7qbrrqA8I1SBqq4x7wvCRKj56F1By
         bjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/050qfJ93sW4lLOTbSTbI1quifuX07x4Ug4l6sawsaw=;
        b=PKXo1VByh7PzM3tCJEV8l/PZ3O6+IAIU26fT+9bGFFBYING/iILRPW0Y+r51hDKUQ/
         gtS9HW1IzXtp4pvvW9DprhlGawSTtC+BBJbzS2zStE0M9FSG5oWRNPPkW/b+qrbE0e+U
         P3LIbvKZUmRNzrqS94f34cjHB8pcK4iRlpjywMEC1RMZp+qrER1t3Je3+qFmpvOaNGJc
         juzzGKe60aMnffVvDXIFUek/FKoco8BfGINe3qW4d9xAgb7WgyoVgtY8Jthx3MKTRywo
         XmbFPJYkJX3N7K9KqSM/o7Lc6ymFT45EhoIGwfnSaSfY9xIS7on6SPmFDz4S5kIRPzPi
         xBKQ==
X-Gm-Message-State: AGi0PuaHAcgtM5xTgRY0X8Fkjk/Kd/rUS85GbtgIoo5pfxCRyxqePv+c
        q2kGpc9HrgrPRvmyicKnDZtIzw==
X-Google-Smtp-Source: APiQypL6tL6YIy2dWdZgtY2PfLN89QTp9W/mkGnBVqR6ETrEu681DfbBZeIWFIx98Ge53JPtN6uVlg==
X-Received: by 2002:a17:90b:b07:: with SMTP id bf7mr24037509pjb.231.1589216334380;
        Mon, 11 May 2020 09:58:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id x4sm9684537pff.67.2020.05.11.09.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:58:53 -0700 (PDT)
Date:   Mon, 11 May 2020 10:58:51 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Kathiravan T <kathirav@codeaurora.org>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight: platform: use dev_warn instead of
 dev_warn_once
Message-ID: <20200511165851.GB13202@xps15>
References: <1588933721-18700-1-git-send-email-kathirav@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588933721-18700-1-git-send-email-kathirav@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kathiravan,

On Fri, May 08, 2020 at 03:58:41PM +0530, Kathiravan T wrote:
> When more than one coresight components uses the obsolete DT bindings,
> warning is displayed for only one component and not for the others.
> Lets warn it for all components by replacing dev_warn_once with dev_warn.
> 
> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index 43418a2..b7d9a02 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -284,7 +284,7 @@ static int of_get_coresight_platform_data(struct device *dev,
>  	if (!parent) {
>  		legacy_binding = true;
>  		parent = node;
> -		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
> +		dev_warn(dev, "Uses obsolete Coresight DT bindings\n");

We made a concious decision to use dev_warn_once() rather than dev_warn().
There can be a lot of coresight devices on a platform and warning for every
device doesn't do anything more than adding noise.

If one device is using obsolete bindings the others very likely to do so as
well.  While fixing one device, checking the remaining devices should be
intuitive.

Thanks,
Mathieu 

>  	}
>  
>  	conn = pdata->conns;
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
