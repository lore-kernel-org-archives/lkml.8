Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18818C3524C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 19:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2116206D3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 19:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phTQ09+j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgBBT3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 14:29:15 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38222 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgBBT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 14:29:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id a33so6600961pgm.5;
        Sun, 02 Feb 2020 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=83XBXAdF60qQhjfbLi9bwa5VGB/pa56aRpXZec7GZUQ=;
        b=phTQ09+j8Vr2PTCfUXpoYipZuNKH07aPv2Zc4kKmqWltkBWIFf9lbdsKaJi04tqGKB
         89O9EaYkOjA51Y7sM+LHx35FD96pzQrI8ycxQF5cEY/yC1ssICLlZEQUycHoZWIVUWt2
         q16FVK+zhYaWdLk8XAHU1LN0lvwpKUL99e4YsRBtm7+KfvKJwYQvUyk+CtcydCMaq+ET
         221+uh0dgiGXI2gstojGhDXQ1o8QOETUOOtvRTfRA68FI1vzrH0FMON1RKItRVa6CRuq
         g8b3vyU06z53cNAR6K9+60lftqNVoGeOuyjvd2bJRGZh6EoIfJa1jV/TIfNInWanSkyq
         RaVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=83XBXAdF60qQhjfbLi9bwa5VGB/pa56aRpXZec7GZUQ=;
        b=VN8H8mCN2nmRVpbvUQ1jbu9U5uQDwy8dP6fwvMAMeAKOHWyxQE000z3BAmfxISjkF2
         1l5ci0nmLwrhnKJmjaGCVJHzxQfFqHKYIuuIE4d4kHGx5W/EdgprH34JdKuANGQVKTJf
         3RaMHW+bg8gU7EXOR1ciT9vXFIBQ8JIky8mm5CCvUYOzyH8HMk4DY3qqnqOfu9MAA74m
         5ddu6PqJmmdfMxipSHcw7W72GA693MqMxZ49n9rak8xYEWvuWa3otYvjQ6Fk18AJWDcG
         T/4j0jKfc5+tQnt7qMSmrIq3qd76u9mHknroHOzrgDapaPiwi5VArSjPH8UvE1+lcvb7
         3oKg==
X-Gm-Message-State: APjAAAXIYN+rIn9rYVJ+yBqCkllJuwprJWOO/UYQ6H4LTLQxKJrozHfK
        aWmhrFDa6SJv74qkUlAFZhQWiFnG
X-Google-Smtp-Source: APXvYqzJztCs5B5fO2HsKuk9KrOTKzLnJc/BQ7QWxXvbl/crt2aXnI7p1PJyFU1wfbUJKbCsn2dMEA==
X-Received: by 2002:a63:8dc4:: with SMTP id z187mr5569042pgd.68.1580671754231;
        Sun, 02 Feb 2020 11:29:14 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4sm17987390pfd.18.2020.02.02.11.29.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Feb 2020 11:29:13 -0800 (PST)
Date:   Sun, 2 Feb 2020 11:29:12 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Sriharsha Allenki <sallenki@codeaurora.org>
Subject: Re: [PATCH] xhci-mtk: Fix NULL pointer dereference with xhci_irq()
 for shared_hcd
Message-ID: <20200202192912.GA20763@roeck-us.net>
References: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579246910-22736-1-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 03:41:50PM +0800, Macpaul Lin wrote:
> According to NULL pointer fix: https://tinyurl.com/uqft5ra
> xhci: Fix NULL pointer dereference with xhci_irq() for shared_hcd
> The similar issue has also been found in QC activities in Mediatek.
> 
> Here quote the description from the referenced patch as follows.
> "Commit ("f068090426ea xhci: Fix leaking USB3 shared_hcd
> at xhci removal") sets xhci_shared_hcd to NULL without
> stopping xhci host. This results into a race condition
> where shared_hcd (super speed roothub) related interrupts
> are being handled with xhci_irq happens when the
> xhci_plat_remove is called and shared_hcd is set to NULL.
> Fix this by setting the shared_hcd to NULL only after the
> controller is halted and no interrupts are generated."
> 
> Signed-off-by: Sriharsha Allenki <sallenki@codeaurora.org>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  drivers/usb/host/xhci-mtk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
> index b18a6baef204..c227c67f5dc5 100644
> --- a/drivers/usb/host/xhci-mtk.c
> +++ b/drivers/usb/host/xhci-mtk.c
> @@ -593,11 +593,11 @@ static int xhci_mtk_remove(struct platform_device *dev)
>  	struct usb_hcd  *shared_hcd = xhci->shared_hcd;
>  
>  	usb_remove_hcd(shared_hcd);
> -	xhci->shared_hcd = NULL;
>  	device_init_wakeup(&dev->dev, false);
>  
>  	usb_remove_hcd(hcd);
>  	usb_put_hcd(shared_hcd);
> +	xhci->shared_hcd = NULL;

I may be wrong, but I have some concerns that this replaces
the NULL pointer access with a UAF.

Guenter

>  	usb_put_hcd(hcd);
>  	xhci_mtk_sch_exit(mtk);
>  	xhci_mtk_clks_disable(mtk);
> -- 
> 2.18.0
