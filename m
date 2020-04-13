Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED24C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C654206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 11:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo1oRY57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgDMLjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 07:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgDMLjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 07:39:43 -0400
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 07:39:43 EDT
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48752C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:32:29 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id o25so7083556oic.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 04:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yjxhwc7xO8dRTa7YxVKX58/8YD5/oKTDwOCqnBzm3qo=;
        b=Zo1oRY57tv4YrwtBlQ7gS8Od+a4xDPlozTzEdvBL1kO22irGRWxUGWxM79Te+9SolO
         nhzNRltFYj6zEufhIbhWHRlJmgq0VPMNlhQAJdm0UMKcWCXHSQZj0b9kYIDruh/jGbhl
         PYzOyMTx1K4iuEw2TBjefrgspIZbo7TZtpgCVazbuqsFswnaN5aXc+p5XQKWfJJ8FkzC
         Kid4Uopgf9ZeRj42Eg26Q0n/93ihPgP74oALMV0VNmePO+n8BVLAfoEClXNaJiUksKKV
         RUE1UDZCsdDSEGFsIsR+MJRjOrBdNK8+O+eYzVsGxhQUxinzXYjGOhKOjkEr5LdM58Sp
         RXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Yjxhwc7xO8dRTa7YxVKX58/8YD5/oKTDwOCqnBzm3qo=;
        b=FDi+diMGetAbjiL0So/Lo+9gBESMzPTwwoTObYjMzqRDSXJ7Wyel2P8Tvda+qLX6PJ
         y9clsZuVj/HKklA/dFSGvxAzLAv6ob5fXzRY/9AkAP/TqWGpKLS7J9YmPtsbt4p4vF/5
         K+oebZLSkkpyskpgajVH9vPd1ENDBDRTTmcFpg9xzTWXlTe+6tPiPaYx6l3t/xtArMvP
         3jkzoKbs9MHiL7B+FZ6EouO/BOMSNdxQWNl7+8kse4qHj72WKTMwFNeKEFNsrCsyUWIW
         SXVFDgBEY8l7eU22WLO61ZeCbgrNjSJA8PP3zDrWyfEcUmG5716X99NGrFuNbwY13GGe
         WZqw==
X-Gm-Message-State: AGi0PubxCqTEQX9F75R/5r0bXIVKTFSZ5Z8TyNBuvMhC+81ojsx+eJ9Z
        mSuo5D7Rj+9EnW3aib0olQ==
X-Google-Smtp-Source: APiQypKwLilEFG0hFelMFqiOXPyzs1c/25/gdgVN8sZrJK+uma2ezsGDVkVQ/p0ZneKQB02NJQPmEw==
X-Received: by 2002:a54:4f0a:: with SMTP id e10mr11539844oiy.127.1586777548305;
        Mon, 13 Apr 2020 04:32:28 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id i9sm4361897otf.1.2020.04.13.04.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 04:32:27 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 69A5C18016D;
        Mon, 13 Apr 2020 11:32:26 +0000 (UTC)
Date:   Mon, 13 Apr 2020 06:32:25 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
Message-ID: <20200413113225.GB3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 07:59:58PM +0800, Tang Bin wrote:
> bt_bmc_probe() is only called with an openfirmware platform device.
> Therefore there is no need to check that the passed in device is NULL or
> that it has an openfirmware node.

I waited until after the merge window closed, this is queued for 5.8.  I
changed the title to be "Avoid unnecessary check".  "Judgement",
although technically correct, has a legal or moral connotation.

Thanks,

-corey

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> ---
> Changes from v2:
>  - improve the commit message.
> 
> Changes from v1:
>  - improve the commit message.
> ---
>  drivers/char/ipmi/bt-bmc.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index d36aeacb2..890ad55aa 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -430,9 +430,6 @@ static int bt_bmc_probe(struct platform_device *pdev)
>  	struct device *dev;
>  	int rc;
>  
> -	if (!pdev || !pdev->dev.of_node)
> -		return -ENODEV;
> -
>  	dev = &pdev->dev;
>  	dev_info(dev, "Found bt bmc device\n");
>  
> -- 
> 2.20.1.windows.1
> 
> 
> 
