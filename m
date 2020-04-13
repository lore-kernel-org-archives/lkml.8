Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CE3C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D944206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tayvGblV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgDMR6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387498AbgDMR6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:58:41 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E2C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:58:40 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l1so4826020pff.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0keu4PMkXs5TE6dOL0jOplSK+Gz3D/D04Bdh0nv5W9k=;
        b=tayvGblV1EfBLNq0bf+Hjdu/L2wKd2UceRTwQ1v19v8RV3smljbw0OA/W+X5dFWJVr
         a2+IlQV/BBPuG11edlV+cV365l4aNIk9ep5IDta3jXd09Pu/3xh7uszaCGrFncBaU+Ui
         EUtGI95pwilWwoK6P+j5LWHGJSFzkwWVgW9/IIOy+WgqrwcjgyseljiidiZJEKCTYBQf
         KBxn8OO7/b02pl9El+PV0wyK2PT0DEJMObQq8E5N9NJT+JJKwC3F7pTNYIW+oUYUbq5G
         6reA87/CXmwnAs2eWMkVK9bfoYolzEwoiHvWtDH1NwjoAuIpL2pmeYVDU5rCm6QWVU5W
         Tahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0keu4PMkXs5TE6dOL0jOplSK+Gz3D/D04Bdh0nv5W9k=;
        b=krTV3N46rg5+WRPhxu6JCLgAMKEkzwrs3N8199W5j5OiGlXXWjYz4M/S9O9nWqJ7Sn
         c6PNWX/A7X0iZt5x4E+PcsAKAH4wrKU615RuEIwucz5mbPfottPpoLo2dJK4gEEwNQZ6
         V6wqu9ANGqvX6IE+zIFJEDeottdD1YPsec6kepwbGsM4tpgBQsH9YUy4mu5j1TCWK+oH
         JNY5wm73eo9NMqKnpZ2tZ2uUfB4oTpPOJH143V2VNqEF4pSZBTuUreNV+ow0QbJOtTK/
         7IIhGsCVNqWNGi7btjVw91DZ5vRkh4cJZ01bIj4YzXRaA9bRQxr4mm4rXAwY9RcZ5qee
         Or4g==
X-Gm-Message-State: AGi0PubdDi+lKMh97yQ/ToC7yzHSLiRu3vaYu9AKZsqjFIHzS+aBVUCe
        BcLoH+aOelale7G71ifLPOt8TQ==
X-Google-Smtp-Source: APiQypJ4hG26wy+uvhPhK5njQ4Mt6FjcLeTkBC1tThGtSZgPZMfB0noJ/QWQnqj6exVsBvFvBuy8Tw==
X-Received: by 2002:a62:7786:: with SMTP id s128mr19494733pfc.144.1586800720395;
        Mon, 13 Apr 2020 10:58:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id k14sm9306208pfg.15.2020.04.13.10.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:58:39 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:58:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     suzuki.poulose@arm.com, mike.leach@linaro.org,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] coresight: cti: make some symbols static
Message-ID: <20200413175837.GE28804@xps15>
References: <20200413082224.23090-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200413082224.23090-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 04:22:24PM +0800, Jason Yan wrote:
> Fix the following sparse warning:
> 
> drivers/hwtracing/coresight/coresight-cti.c:22:1: warning: symbol
> 'ect_net' was not declared. Should it be static?
> drivers/hwtracing/coresight/coresight-cti.c:625:32: warning: symbol
> 'cti_ops_ect' was not declared. Should it be static?
> drivers/hwtracing/coresight/coresight-cti.c:630:28: warning: symbol
> 'cti_ops' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 9e262f5a85e3..7fc1fc8d7738 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -19,7 +19,7 @@
>   */
>  
>  /* net of CTI devices connected via CTM */
> -LIST_HEAD(ect_net);
> +static LIST_HEAD(ect_net);
>  
>  /* protect the list */
>  static DEFINE_MUTEX(ect_mutex);
> @@ -622,12 +622,12 @@ int cti_disable(struct coresight_device *csdev)
>  	return cti_disable_hw(drvdata);
>  }
>  
> -const struct coresight_ops_ect cti_ops_ect = {
> +static const struct coresight_ops_ect cti_ops_ect = {
>  	.enable = cti_enable,
>  	.disable = cti_disable,
>  };
>  
> -const struct coresight_ops cti_ops = {
> +static const struct coresight_ops cti_ops = {
>  	.ect_ops = &cti_ops_ect,
>  };

Applied - thanks,
Mathieu

>  
> -- 
> 2.21.1
> 
