Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E55C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C552C20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598466161;
	bh=MGiEIrg8fK0vNbyq71tpCVsjMfGWybSBdj0sBrznJSI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t1DNtrOuIXD1CAzUVXlJdG3eiJIO4M/w/nGwXcHCa02Qs0IP4Urh2br2SbSJ6qtkW
	 VYxTrd9J9uGT91+1oHsMY4o6pPhwT5IOE01T5J/1cN/kHLH/qoWk+W5V728+roi9Zh
	 JhhqXfAgOUWbzo93h8BMkMYInSyqOBS/fC2ZnmXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgHZSWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:22:40 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39111 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgHZSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:22:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id c10so2593751edk.6;
        Wed, 26 Aug 2020 11:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=47B2W9chqSleNpfDGutHaxEQjzT9C3+pWqaOpYKfY50=;
        b=PbNx2hzX7W/T0GGXa9B88D3soPnMMENlLihfgZ8FzFbjE9b8QQZOZ/1XShjOqbtFdz
         USxIJNfPzlQwIWXqSw5RU+WmRN7735lcA7obYZgIuBWSGR5KxqXfw//5AasaZiia8deu
         h4sHGKnUJ4fdY9/Fyu7UPtxku2U5VVkVelpO8xya8G8wfdeI56TezV8cQKoCY5QG/Q4l
         PMmuUiFVwNj8uVDX1suZLFucTrxIqClbP/lcEstE40JwM7pej5zV6YzYGuhAhK0+3X3d
         X0w/qD9BjATTRgSo0YQ4OETNoHa2IveuVfgHdMui5WCLk8CSiTf4cAvn6J3OhsrdlG0s
         4s3A==
X-Gm-Message-State: AOAM533HbuNE/BulVDMU4U29CvnkwRaZFrqzOQ1PLL4BipCT9V4XgJyE
        RLPmxomTGP31z89QaUQppt4=
X-Google-Smtp-Source: ABdhPJyd9xYN9KNF7syF5JCDBo85byE7AJMEAitafvWaoIZ8nSo+RsrNr+IBot47UFGzmZ5z8L8emg==
X-Received: by 2002:a05:6402:1b02:: with SMTP id by2mr12999107edb.95.1598466155084;
        Wed, 26 Aug 2020 11:22:35 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id a23sm2954376eju.43.2020.08.26.11.22.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 11:22:34 -0700 (PDT)
Date:   Wed, 26 Aug 2020 20:22:32 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>,
        Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] memory: omap-gpmc: Fix a couple off by ones
Message-ID: <20200826182232.GA11327@kozik-lap>
References: <20200825104707.GB278587@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200825104707.GB278587@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 01:47:07PM +0300, Dan Carpenter wrote:
> These comparisons should be >= instead of > to prevent reading one
> element beyond the end of the gpmc_cs[] array.
> 
> Fixes: cdd6928c589a ("ARM: OMAP2+: Add device-tree support for NOR flash")
> Fixes: f37e4580c409 ("ARM: OMAP2: Dynamic allocator for GPMC memory space")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/memory/omap-gpmc.c | 4 ++--

Thanks, applied.

Best regards,
Krzysztof

