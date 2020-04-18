Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ACDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC52214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQeoZIad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRCOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725535AbgDRCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:14:45 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E54C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:14:45 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x10so3850358oie.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=umk7gi6BmXUnjeGcg+cvTgVz8SwIa0aokBJtfxL9v1M=;
        b=EQeoZIad3jcvCKEn+qVHBBxOu++l8jW4e8ceH1uK1iCLIq78XMm0bPJfEY+1AZMcCX
         Sk0Phv0mr1NoARtM6HYnryJoDOfe4VS47hsM0Qk+mjUisobW5J0pFRbISFntPIh9qvmE
         xV/r7GFrAVKnB/kBLUzndjrZtT6X93zLCfIKxDVWZf0WuV+KlXjpDcBM+Oz9lIJbofvc
         BFeNuRRP0pte0tDzEHYD7oIxTW4ixjbY48hx0VWHOCM5/42e/jD2+6pRwaqxmiw3qGAM
         qUmP5IRdDACLNPAFkSr7Pb9nkSLhztyOck2Cxwyaf9Zl8hRrD6vSFVbE0blabqQNGhK3
         5kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=umk7gi6BmXUnjeGcg+cvTgVz8SwIa0aokBJtfxL9v1M=;
        b=QBNUGRbDa3NX48mSVV+szV7ZCtimYNKhUlzGSuH52Es9f1yaTqr68l0kEpCqtlxK6H
         hpLibohKVRyZzNN4pq1ZGwnQaZZoaLEB8/jyhGLyVW2UUVRmHXJb6fmwDeLeOjuosmKE
         VH05gxz09uzC8ODEg15vdlyBP0qDZiLqsyxljd1o8h/LZm14zPEPfCCoEGjtGi0ovBXu
         c5TO9mrx25ZeFhbP1K9gewU7z+FS9CDx/FQ8PEi8g42ltW+ZBFjwFUGtXsd8xxDVLyU1
         axlKhO7O91SidckClI4iVjS94GzIgpC1Mt/cBuNxiNi6yKq1c2pb9vp1RkkzRrH03oJZ
         45xQ==
X-Gm-Message-State: AGi0PuY3oog1543ozlE2gofPQlRdAq8Kt+AIqjlnpsFlG64mQfbRHJ2m
        PKLRXcQgXt+1gZtJNwADyw==
X-Google-Smtp-Source: APiQypJ7RSnwBJHE/SOlo0G7WfCYgILarclXrI1zHvgWV3ZckKBwYy2nOTYyRVvseRkdBr4DuXtTnw==
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr316400oie.40.1587176084776;
        Fri, 17 Apr 2020 19:14:44 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id x88sm8377641ota.44.2020.04.17.19.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 19:14:43 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id A72E5181888;
        Sat, 18 Apr 2020 02:14:42 +0000 (UTC)
Date:   Fri, 17 Apr 2020 21:14:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ipmi:bt-bmc: Fix error handling and status check
Message-ID: <20200418021441.GC6246@minyard.net>
Reply-To: minyard@acm.org
References: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
 <20200414201832.GJ3587@minyard.net>
 <f5a848ae-d19f-5ab6-7c7d-2d0811fc174b@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5a848ae-d19f-5ab6-7c7d-2d0811fc174b@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:14:06AM +0800, Tang Bin wrote:
> Hi Corey:
> 
> On 2020/4/15 4:18, Corey Minyard wrote:
> > On Tue, Apr 14, 2020 at 10:14:24PM +0800, Tang Bin wrote:
> > > If the function platform_get_irq() failed, the negative
> > > value returned will not be detected here. So fix error
> > > handling in bt_bmc_config_irq(). And if devm_request_irq()
> > > failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
> > > it may be more suitable for using the correct negative values
> > > to make the status check in the function bt_bmc_remove().
> > Comments inline..
> > 
> > > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > > Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> > > ---
> > >   drivers/char/ipmi/bt-bmc.c | 12 +++++-------
> > >   1 file changed, 5 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
> > > index 1d4bf5c65..1740c6dc8 100644
> > > --- a/drivers/char/ipmi/bt-bmc.c
> > > +++ b/drivers/char/ipmi/bt-bmc.c
> > > @@ -399,16 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
> > >   	struct device *dev = &pdev->dev;
> > >   	int rc;
> > > -	bt_bmc->irq = platform_get_irq(pdev, 0);
> > > -	if (!bt_bmc->irq)
> > > -		return -ENODEV;
> > > +	bt_bmc->irq = platform_get_irq_optional(pdev, 0);
> > > +	if (bt_bmc->irq < 0)
> > > +		return bt_bmc->irq;
> For us, this part of modification have reached a consensus.
> > >   	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
> > >   			      DEVICE_NAME, bt_bmc);
> > > -	if (rc < 0) {
> > > -		bt_bmc->irq = 0;
> > > +	if (rc < 0)
> > >   		return rc;
> > I don't think this part is correct.  You will want to set bt_bmc->irq to
> > rc here to match what is done elsewhere so it's the error if negative.
> 
> Nonono, I don't want to set bt_bmc->irq to rc, I think they are irrelevant.
> 
> The logic of the previous code will continue to execute even if
> platform_get_irq() failed,which will be brought devm_request_irq() failed
> too. "bt_bmc->irq = 0" here is just for bt_bmc_remove() to execute
> del_timer_sync(). Otherwise the function del_timer_sync() will not execute
> if not set "bt_bmc->irq" to zero, because it's negative actually.

Sorry for the delay, I have had a lot of distractions.

The trouble is that the handling of bt_bmc->irq needs to be consistent.
Either it needs to be negative if the irq allocation fails, or it needs
to be zero if the irq allocation fails.  I think it needs to be negative
because zero is a valid interrupt in some cases.

Consider the following code:

       bt_bmc_config_irq(bt_bmc, pdev);

        if (bt_bmc->irq) {
                dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
        } else {
                dev_info(dev, "No IRQ; using timer\n");
                timer_setup(&bt_bmc->poll_timer, poll_timer, 0);

If bt_bmc->irq is negative (if platform_get_irq_optional() fails), it
will say it's using the irq and won't start a timer and the driver won't
work.  Then later (in your change below) it will try to stop the timer
even though it's not running.

If devm_request_irq() fails, then the interrupt is not set, but since
bt_bmc->irq is most likely not zero, it will not start the timer and the
driver won't work.

You really need to set bt_bmc->irq negative if it fails.  And fix the
check above to be if (bt_bmc->irq >= 0).

-corey

> 
> 
> > 
> > Also, I believe this function should no longer return an error.  It
> > should just set the irq to the error if one happens.  The driver needs
> > to continue to operate even if it can't get its interrupt.
> > 
> > The rest of the changes are correct, I believe.
> > 
> > 
> > > -	}
> > >   	/*
> > >   	 * Configure IRQs on the bmc clearing the H2B and HBUSY bits;
> > > @@ -499,7 +497,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
> > >   	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
> > >   	misc_deregister(&bt_bmc->miscdev);
> > > -	if (!bt_bmc->irq)
> > > +	if (bt_bmc->irq < 0)
> > >   		del_timer_sync(&bt_bmc->poll_timer);
> > >   	return 0;
> > >   }
> 
> But now, the logic is: if the platform_get_irq_optional() failed, it returns
> immediately, the irq at this point is negative,the bt_bmc_probe() continue
> to operate. But in the function bt_bmc_remove(), we need status check in
> order to execute del_timer_sync(), so change "!bt_bmc->irq" to "bt_bmc->irq
> < 0".
> 
> So, when the judgment of "bt_bmc->irq" in the function bt_bmc_remove() goes
> back to  the original negative value, the "bt_bmc->irq = 0" in the line 410
> become redundant. That's why I remove it.
> 
> 
> 
> I am very glad to communicate and discuss with you these days.
> 
> Thanks,
> 
> Tang Bin
> 
> 
> > > 
> > > 
> > > 
> 
> 
