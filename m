Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A61C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5D8206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMLK5QR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505177AbgDNTpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505166AbgDNTo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:44:59 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E09C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:59 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b7so8939097oic.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sse3YVjmkw8Kxhj4W0BzsXVTXj+DMzOM5AWzuhlcxPw=;
        b=dMLK5QR7kXyYrreXVqY0/IEcHw0kXYcBBas7vj2arYyVzQYQRqWksNpKDzIowinfyJ
         QNZz4rosnFYul6H/+vvskzpN+KTiOpk0+GTL0XEfd6E9WlicaGqzKqhrnodt372nnYVv
         4VrAfhyqF4LsT21KKhhBKAm/SFeinRnYS45YprOjuOH2+UvTuxiI6bxHxtoQVh5bMW0n
         qiIpA3RJ34PsGh8Ns+35S+UsRvTy2ScfGlTgfK6tf2LMsMpPo8Gf7oijLMuXRgwkzaXc
         PsVNcXSXKW+NNTmFL8llSdDNpLqAVaKEA40yjvlgDlfrtAFoCAEmM6xHoCSH2kmBgRUM
         I7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=Sse3YVjmkw8Kxhj4W0BzsXVTXj+DMzOM5AWzuhlcxPw=;
        b=hr053nUCaA+L4gWB/iW2TLQFJacSXGl4mgZG15e+P/wsxB+9/9rIQeUG55GfHsuGGd
         Ri4U4ya0SJtdBsWnH2c0HsKaF0OYxGTunfDjjy7rxso4SFL0too9bWg/Try7lwgyzWQb
         debneM8vXBz15Sl/F27bzym7DDGXZJJ8Qh2Zlu7pY+oi7IP3hutACTObzpi3VEyqzdPy
         Fjyvg0Rep9JHyApYBitCq18t67/ZGjaXkij+G9KXiKxj9VxHGSGtBLKWUSdVFMfna4Hr
         ztbxTCvgZADQAZMnY0O+bEORiYRqQpKPfSlWTaopSEylYYlZvQtEP7b8xzKUayYB7a38
         zaHQ==
X-Gm-Message-State: AGi0PuYtFrjGGatmkERBEpuX+QmaVpmzPycsWpEksjg3LeQdOr4JS96L
        SMINfPAQFzE3nMvFnPd9aA==
X-Google-Smtp-Source: APiQypL7gIovUtkdhOS8jiMCup5q6jBnTpjqNKNfhnnWTz2gZvNa9d8otokGawTqRpoo5N7qOHaRiA==
X-Received: by 2002:aca:4085:: with SMTP id n127mr1320346oia.62.1586893498335;
        Tue, 14 Apr 2020 12:44:58 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id e14sm6308381oop.42.2020.04.14.12.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:44:57 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 81257181888;
        Tue, 14 Apr 2020 19:44:56 +0000 (UTC)
Date:   Tue, 14 Apr 2020 14:44:55 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
Subject: Re: [PATCH] ipmi:bt-bmc: Delete superfluous dev_warm() in
 bt_bmc_config_irq()
Message-ID: <20200414194455.GH3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200414141951.19120-1-tangbin@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414141951.19120-1-tangbin@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:19:51PM +0800, Tang Bin wrote:
> The priority of dev_warm() is higher than dev_info(),so if the
> function bt_bmc_probe() uses dev_info() to print error message,
> the dev_warm() is redundant.Thus should be removed.

Actually, this needs to be left in.  That error is not just a that irqs
were not configured, that's an error that something else went wrong.


-corey

> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> ---
>  drivers/char/ipmi/bt-bmc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> index cd0349bff..1d4bf5c65 100644
> --- a/drivers/char/ipmi/bt-bmc.c
> +++ b/drivers/char/ipmi/bt-bmc.c
> @@ -406,7 +406,6 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
>  	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
>  			      DEVICE_NAME, bt_bmc);
>  	if (rc < 0) {
> -		dev_warn(dev, "Unable to request IRQ %d\n", bt_bmc->irq);
>  		bt_bmc->irq = 0;
>  		return rc;
>  	}
> -- 
> 2.20.1.windows.1
> 
> 
> 
