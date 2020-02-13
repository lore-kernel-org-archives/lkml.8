Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF79C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A772168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXg8YSs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgBMNCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:02:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:40583 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729557AbgBMNCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:02:15 -0500
Received: by mail-oi1-f196.google.com with SMTP id a142so5647745oii.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A+3wMprKg+igdVYsZNJ9ivwdJoPZAYkyawyyUa/pO6U=;
        b=mXg8YSs4G/ZfxUwU2MzESrELoc+GOj54Yjqj0o9bWPuTpsGqP3bg0P1R61bGKmq0/r
         F8mbUrvydomYreQ7W0fdCyBcIQuQ8c0bzwyd/IbJgzqrFBBJbVbfLQ1f1ETkPJ9U6ERl
         fDlFSOTUqJkBEpbilzoFGFnc8GblsaCicldNoB+kxrRbG99Kk3h5IDl56BA8h2eUKIy9
         TDG3wFcEs23nZFmSe4YTNAzmpiiN/Un9c/6e1bfIKWCq1FkiBNaYBgxrhOe+tbjGF/DI
         GhX9fv+ye12i++omcqU/fwu+wxoOv20L9NGNUQC1xOQVpOTZBUL1fiKOApUqHqvzpRk2
         TgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=A+3wMprKg+igdVYsZNJ9ivwdJoPZAYkyawyyUa/pO6U=;
        b=mIQq171abibkNoHgxgr1g7fgmOORvkT2rK/i84bwUh3caLOfqMsnp9peLK4TTKwTOC
         zcoyhXRzFtLZLHE4w/AXopOKg6TYBe6WmhXKypErIibVduA2pwer7rPbHk4itmMrQDqX
         yZlI1IKHv/CeZ25Hthh4oI4aVl6V+uVgPBf/x2xcnQcRnRk/EEt+58yI3XpYFM4m2FCw
         zEbaMTq7+F6u0iAs/f3rUbRg1q63d9l7tH0E5tSs2d+o8rNxKIaWj/zfz+89tf+L7udB
         JnqExD7CY0XWo2Omow4K1Gp1BMs7QeiOZMl6CW4r6K6j3OdlKUafI5mRPEptEu+QxnpW
         8IXA==
X-Gm-Message-State: APjAAAVhdp7zo26+0Tp9HgqXZr+1PDR9iRqKpMa9vdlVhJHbn26xBSWy
        qdh+vDM8RT6mAVVC/uQGPQ==
X-Google-Smtp-Source: APXvYqyXRG2Era0fflTDvw+Wf1os+YHhKgV6rKFYPeyZGsSJt9hh3qOzNfDIEVzeN5yM3UaLJpF+UQ==
X-Received: by 2002:aca:db43:: with SMTP id s64mr2674666oig.144.1581598934487;
        Thu, 13 Feb 2020 05:02:14 -0800 (PST)
Received: from serve.minyard.net ([47.184.136.59])
        by smtp.gmail.com with ESMTPSA id p65sm665303oif.47.2020.02.13.05.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:02:14 -0800 (PST)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e166:6491:dd75:4196])
        by serve.minyard.net (Postfix) with ESMTPSA id 4A5B0180053;
        Thu, 13 Feb 2020 13:02:13 +0000 (UTC)
Date:   Thu, 13 Feb 2020 07:02:12 -0600
From:   Corey Minyard <minyard@acm.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Patrick Vo <patrick.vo@hpe.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipmi_si: Avoid spurious errors for optional IRQs
Message-ID: <20200213130212.GP7842@minyard.net>
Reply-To: minyard@acm.org
References: <20200205093146.1352-1-tiwai@suse.de>
 <s5hpneiyjgb.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpneiyjgb.wl-tiwai@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:34:12AM +0100, Takashi Iwai wrote:
> On Wed, 05 Feb 2020 10:31:46 +0100,
> Takashi Iwai wrote:
> > 
> > Although the IRQ assignment in ipmi_si driver is optional,
> > platform_get_irq() spews error messages unnecessarily:
> >   ipmi_si dmi-ipmi-si.0: IRQ index 0 not found
> > 
> > Fix this by switching to platform_get_irq_optional().
> > 
> > Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()")
> > Reported-and-tested-by: Patrick Vo <patrick.vo@hpe.com>
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> 
> Any review / ack on this?

Sorry, lost in the noise.  I've included this for 5.7.  If you want it
earlier, I can arrange that.

Thanks,

-corey

> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
> > index c78127ccbc0d..638c693e17ad 100644
> > --- a/drivers/char/ipmi/ipmi_si_platform.c
> > +++ b/drivers/char/ipmi/ipmi_si_platform.c
> > @@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct platform_device *pdev)
> >  	else
> >  		io.slave_addr = slave_addr;
> >  
> > -	io.irq = platform_get_irq(pdev, 0);
> > +	io.irq = platform_get_irq_optional(pdev, 0);
> >  	if (io.irq > 0)
> >  		io.irq_setup = ipmi_std_irq_setup;
> >  	else
> > @@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platform_device *pdev)
> >  		io.irq = tmp;
> >  		io.irq_setup = acpi_gpe_irq_setup;
> >  	} else {
> > -		int irq = platform_get_irq(pdev, 0);
> > +		int irq = platform_get_irq_optional(pdev, 0);
> >  
> >  		if (irq > 0) {
> >  			io.irq = irq;
> > -- 
> > 2.16.4
> > 
