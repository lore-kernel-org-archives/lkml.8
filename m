Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91414C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAF521734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 00:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wq1IealQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVAPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 19:15:19 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38890 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgAVAPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 19:15:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id a33so2428436pgm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 16:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ij5FCD+uLvTnsp5ctxAUXBbDSBnVCtTaib+JJQmxzQo=;
        b=Wq1IealQ86GiAj8sMbJmbgbhDqbwW+SfXsKEEX9Bx0lw5o6GWpC3DC2zgrBfMt9f5r
         imFXlLCbKnwWQ88in8PJNNH44+U50VCIxyGRpPaHrJJs4K8evYdX82rAlWhkk5/VnnYy
         1gLk8XrmEi1os+BdqmVRJPu6gwtKzGM0WOm2JeqGV01N4A+D4fdsZhy40q7kcogtR1Ks
         BSsolGx4N3Uwrrao+N204W+EqBxmBrXSYD5CmG5WBKaZwKgYQFYqrSU0Sqtu2LSOk+DL
         lgkZIEPaVVaeHWWvYqp2wA1Yi9o/YPjwEZubyDbzarh8Sz4OVhktgSfb71veYMnuA1Tw
         x5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ij5FCD+uLvTnsp5ctxAUXBbDSBnVCtTaib+JJQmxzQo=;
        b=mX0XlimZmzSLugbXrGqTcEpho+QG8eNjiimP1ZbusNkqCetzlZ8ew1NG8ZrSqIU7di
         AGo/1VIExQBcWIXgapDLmm1yP4NB8i8/5hdqnJ/tvi48BmnNTA+tGjxrhj8x+9A91t19
         LS3x5nqECDDBK9EblM01zyz+n9j1Iaz+HwWmv6yr5EhABRkoWNv+UPkj43wH4RrBnd9h
         BwDQDnUvBfz0q7zrgh3eor2WP7ouu6BNr7wfil70i++/12a7yknrEYgfZBClY7pvVU2h
         tYfwgNbhHReRRWGvDGeLMuM2ClRcRCMloxL8zAtxKADgfwtcClRDKiFclRoa/LNf0fsM
         difQ==
X-Gm-Message-State: APjAAAVoBjJsYxqW4OEw9aXj71gn3KkZU3QoKQ/evWiEkpjAFfs+biKk
        nH94yq6MP3jIn4p2i4ZDqltjew==
X-Google-Smtp-Source: APXvYqxORiLtvDwxP9mURJXog994SpNhD1/dDL9io/4URQ4OWDATHRUiX+V3a8ZA8x4kKJdxD0fMrA==
X-Received: by 2002:a63:447:: with SMTP id 68mr8479452pge.364.1579652118370;
        Tue, 21 Jan 2020 16:15:18 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id j20sm44100089pfe.168.2020.01.21.16.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 16:15:17 -0800 (PST)
Date:   Tue, 21 Jan 2020 16:15:15 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     ohad@wizery.com, linux-omap@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 3/3] hwspinlock: omap: Use
 devm_hwspin_lock_register() to register hwlock controller
Message-ID: <20200122001515.GA14744@builder>
References: <cover.1578453062.git.baolin.wang7@gmail.com>
 <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315adcc5dfc6aa5c001448401dda4065e33deef2.1578453062.git.baolin.wang7@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 19:14 PST 2020, Baolin Wang wrote:

> Use devm_hwspin_lock_register() to register the hwlock controller instead of
> unregistering the hwlock controller explicitly when removing the device.
> 
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/hwspinlock/omap_hwspinlock.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
> index 3b05560..9e8a8c2 100644
> --- a/drivers/hwspinlock/omap_hwspinlock.c
> +++ b/drivers/hwspinlock/omap_hwspinlock.c
> @@ -131,8 +131,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
>  		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
>  
> -	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
> -						base_id, num_locks);
> +	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
> +					base_id, num_locks);
>  	if (ret)
>  		goto runtime_err;
>  
> @@ -148,15 +148,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
>  
>  static int omap_hwspinlock_remove(struct platform_device *pdev)
>  {
> -	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
> -	int ret;
> -
> -	ret = hwspin_lock_unregister(bank);
> -	if (ret) {
> -		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
> -		return ret;
> -	}
> -

Relying on devm_hwspin_lock_register() to hwspin_lock_unregister() will
mean that pm_runtime_disable() will now be called before the spinlocks
are unregistered.

Regards,
Bjorn

>  	pm_runtime_disable(&pdev->dev);
>  
>  	return 0;
> -- 
> 1.7.9.5
> 
