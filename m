Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41F42206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 15:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597937115;
	bh=Rr8BadVQmc+yhuxW6996EN9N6bisFQ+xqkh4fdqJ/nI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JJ+Yct6SteSX3Bkr7IQ0DoTXKO66vVp/v41nHnHOQ0iQwatC3WTnA1m1zLSHto3fa
	 voMt3oW6IXyjep1eYm7lL9y/mqXEZhvAHZ56zz5mh+gn+8CLqQI3QPRJA9HsGpmOLE
	 GASbUTRqpQjuYHQYZwBAXu0iA+9EHK/y/9764Km4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbgHTPZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 11:25:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39337 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgHTPZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 11:25:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id g75so1939695wme.4;
        Thu, 20 Aug 2020 08:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jna++P8ibJUzY4rXBqsDRJ76r2GrW9IXjOzwbfnLiaU=;
        b=Tm7kRo+C19QeR8Pm6PpIzqDyoFxnVhjN7Hz63D6e6lKwZnr6k9sNoGtzJractJh4ad
         D2PNJbi/fV7HsMwal0VwsS60PYzgk/dLpwRZb9A8bQ19xKphk436S5G5H5klkz5zYUHJ
         rAkPLZNcR6zcBnG6T8QDbn4i6tacVQi4fTRYq2A0eDOY5u3D6b2+YyR/hj0cyXTTmVbh
         ApwTZIIr1AjlG7XNtC84/LbHirwzEll84X+SRmokjqXWrOLVzNkacXUejMxun6LeIkuL
         y5sq1W+Bgl9hZ1yU44H7TWPtNsK4I5dVg6xjZwukEQDnRJJkTS/N0d9mFVJMqKtz57WX
         QRHQ==
X-Gm-Message-State: AOAM531U6ASPnOvJpWrSiNpXw1BZ9F7SXGpOBmyiajaWee3w4/XRPXqZ
        NG7V6jVpjMKEG16WJjhqpDM=
X-Google-Smtp-Source: ABdhPJxHoozIQKOovfpdgjFEUuF8vXf4rcux9Gapm/Z8yZh3pdQKppbCBoVdTwT2wswiFa0z+kTx5g==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr3915978wmh.140.1597937100925;
        Thu, 20 Aug 2020 08:25:00 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id k204sm5178775wma.21.2020.08.20.08.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Aug 2020 08:25:00 -0700 (PDT)
Date:   Thu, 20 Aug 2020 17:24:58 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] memory: tegra: Correct shift value of apew
Message-ID: <20200820152458.GA17144@kozik-lap>
References: <20200818095121.13645-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818095121.13645-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:51:21AM -0700, Nicolin Chen wrote:
> According to Tegra X1 (Tegra210) TRM, the APEW field is between
> [23:16] so the shift bit for apew should be 16 accordingly.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  drivers/memory/tegra/tegra210.c | 2 +-

Thanks, applied to drivers/memory.

Best regards,
Krzysztof

