Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC7DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8484A206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 19:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Co6eWZJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFAT50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFAT5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 15:57:25 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28256C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 12:57:24 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id g5so3952926pfm.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 12:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FLEAsLhjK/2hb4HFLEKI6DMEhCblk7HEBjLYOBIeBTw=;
        b=Co6eWZJK4juq/S3/5rSBLiInygTXWg2N1TVrHIZLB4RjM/5kCo8RASKYy790rnz4NT
         eF9DXuVf+oszm+h3QFeS8CVxNqPU7NrCF1GLMXOBr3urHcf9sXbVWVA1ueoiESPX++NP
         HtfI+rizevq1M98SEIz5OQIrk+TNyttfyIu7iYKKbvdz/IGQQ0yvwNL9PvWnjNYWDorM
         4l7HMdoXBFhXRS4GZKhgDqSv+ehawdCynz0Z1XmjdnXBnk1nSSuMCrHppD9ZY/4LBfVe
         m3TjfjOsrlgowJi4aYiEezy1QNKWUBh+R8BsHmC8LTJDU+mdNhSB5hf/IlLXwj1VFjrv
         ZhFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLEAsLhjK/2hb4HFLEKI6DMEhCblk7HEBjLYOBIeBTw=;
        b=K2/OI9HZuJEynrqhsW8n0DGu4MTcMTOZq4Km2HDoycEaXX3pJJDY1lIwTNnyXY28MR
         /6YqObOqltQbD9AOnAFbiwocL+9gjZ913fvxvIhvLhIams5XvMeoX7XsLsEhzpdL3S9C
         0L3B19/aaU77iTTHM0XiP1UDIiyJ7hWKTqsvIsxs8AE2MZDsSIrVHSSPbcwkCa9ri+jb
         MdgfmkUs3cu6Bzs1OEJKhcEhbbObWyXikatYI8Xy7nq17UAQP5P9dTA06Dpz5M42L/MY
         niRhI8JYB0esPmgxkdWghoQfy7FB/DTI+qLQ9Y08XAWg6h+oIfh9fOl6ZwVf0pR8zg2v
         5QHA==
X-Gm-Message-State: AOAM531KPgb+bYepdxcT/R4KfgpX+nihQsnMLDg4dUE2yMiFcKLAo3Ca
        Nx/Daas8o1CmPRQzd4+sY6L2uewWQIQ=
X-Google-Smtp-Source: ABdhPJyhP8CT45x2yvEQdksfe+mUip6xv7jWRC4LXiGyjVE7VPAuR+ovH/pKTvjqweMhjmMeOhb5wA==
X-Received: by 2002:a63:f601:: with SMTP id m1mr20263315pgh.205.1591041443570;
        Mon, 01 Jun 2020 12:57:23 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id j17sm273209pjy.22.2020.06.01.12.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 12:57:23 -0700 (PDT)
Date:   Mon, 1 Jun 2020 13:57:21 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH v1] coresight: Drop double check for ACPI companion device
Message-ID: <20200601195721.GA24287@xps15>
References: <20200529133210.20566-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529133210.20566-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, May 29, 2020 at 04:32:10PM +0300, Andy Shevchenko wrote:
> acpi_dev_get_resources() does perform the NULL pointer check against
> ACPI companion device which is given as function parameter. Thus,
> there is no need to duplicate this check in the caller.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/hwtracing/coresight/coresight-stm.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
> index b908ca104645..673d2f56ed1e 100644
> --- a/drivers/hwtracing/coresight/coresight-stm.c
> +++ b/drivers/hwtracing/coresight/coresight-stm.c
> @@ -727,8 +727,6 @@ static int acpi_stm_get_stimulus_area(struct device *dev, struct resource *res)
>  
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
>  
> -	if (!adev)
> -		return -ENODEV;
>  	rc = acpi_dev_get_resources(adev, &res_list, NULL, NULL);
>  	if (rc < 0)
>  		return rc;

I have applied your patch.

Thanks,
Mathieu

> -- 
> 2.26.2
> 
