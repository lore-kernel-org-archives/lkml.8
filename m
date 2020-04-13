Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1ADC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D3B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 21:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR6+SAhV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389398AbgDMV7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 17:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389370AbgDMV7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:59:46 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52593C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:59:46 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id s202so5516985oih.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=W1jvaZsL9ZNbOXIeEh7lh6mCadCp7P3SgOJXcY82jUs=;
        b=fR6+SAhVIiQCOMsGgNSxsf0AzuYSlO1eFDjPc36hkq9egFeXVkSC+Y5Uvev6njDR/Z
         Ccn1Qk4b/bVSW3N54wHlDfwO5stF2Z+ZoeeqFaM3B9RzwhxxrX0lkdNFXJeM8RmKRB7f
         KcPBwp5rtzO3z26M0wP/bhXLfO6nD5heoI2PcpTC8ZEFJkV8XB+F/h+zJpLL/z/pXSJl
         Fv/7/GqzAND4oNa+GL4wyFXfETrKBiMqSwgu1Y95NU/oTGsrkAzYDfFtRvbplAL0brYq
         j2YfRlWISTyyZ55FjD58H33cMih8KQ1GvAYGZjUxnTh+y+lGxcTVbrXFZnSehM3gFtsA
         lyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=W1jvaZsL9ZNbOXIeEh7lh6mCadCp7P3SgOJXcY82jUs=;
        b=BmkO1zTU37ENeiDcXX71TAo1k2Cz9hWSw8E3hl2QHOrthstklc6Np1rBB5fBH0DDvs
         MI1/Lvze7TnXDysrjp+8jFAKwgzZu4q3aZxg8xIq5TaPhHE6V80wuADKd5irpkZEkWIX
         4orjGkKbP7Y9Yi1uVJhHHXfnXD+dcEMlvdpSvmK9g8j2kp0Br0O+LoVTOxq8slZtoIH0
         wDghdMQQtzqFbQpZw1ZPm8w/SZfb3K31uaWYBypYjuE5toYIZLBKP4MpIqK787YOY8i5
         BkRkic9aDNGjWDBeg8gqLHDnjRYBkHxbhjTLhH2/bk6V1sF1FLB0ZvhQS3GyTBUiQogN
         kb2A==
X-Gm-Message-State: AGi0PuaA1FjiqB5yTmLtAcws4wqRK4STMfMwd4VCU+coHCcZxzYEFXkr
        HT1iV7PuuISXzfaJBaDYiA==
X-Google-Smtp-Source: APiQypJJP7mXCuB0qdrq9bZfxsXY+fRU5oTstHBquZb+OTyQGMHDxMDi/vWRtblvSWINL21tfwv6sA==
X-Received: by 2002:aca:fd12:: with SMTP id b18mr13548979oii.158.1586815185429;
        Mon, 13 Apr 2020 14:59:45 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id n2sm2869446oom.18.2020.04.13.14.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:59:44 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id F0A4918016D;
        Mon, 13 Apr 2020 21:59:42 +0000 (UTC)
Date:   Mon, 13 Apr 2020 16:59:41 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
Message-ID: <20200413215941.GF3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
 <20200413113225.GB3587@minyard.net>
 <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
 <20200413142348.GD3587@minyard.net>
 <3894dab2-0660-999c-6f4c-4b5b9ff57773@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3894dab2-0660-999c-6f4c-4b5b9ff57773@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 11:44:49PM +0800, Tang Bin wrote:
> Hi Corey:
> 
> On 2020/4/13 22:23, Corey Minyard wrote:
> > > Can I consider that the patch will be applied in 5.8？
> > It's in my queue, so that's the plan.
> > 
> > > >    I
> > > > changed the title to be "Avoid unnecessary check".
> > > You have modified it, which means I don't need to submit a new patch？
> > Correct.
> 
> Thank you very much, I am waiting for the applied.
> 
> 
> Then, I have some questions to ask you:
> 
>     I have checked the file bt-bmc.c carefully, and found that there are
> another two problems.Please help me analyze them, if you think it is
> feasible, then I will submit the patch.
> 
>     Q1: About Format Problem
> 
>            In the 469~471 line, the first letter should be indented, please
> check if the writing here is reasonable?
> 

I'm not sure how that happened.  It was that way from the original
submitter and nobody noticed in review.  It's obviously wrong.

> 
>     Q2: About the function bt_bmc_config_irq()
> 
>           1）In the function bt_bmc_probe(), the return value of
> bt_bmc_config_irq() made no judgement, whether it is suitable? （If your
> view is don't need to judge, the following will change.）
> 

Hmm, that's probably not a big deal.  If it fails irqs are just not
used.  It probably shouldn't return a value, though.

> 
>           2）According to the kernel interface of platform_get_irq(),the
> return value is negative,
> 
>                    if (!bt_bmc->irq)
>                         return -ENODEV;
> 
>                so the check here is invalid.The standard way to write is:
> 
>                      if (bt_bmc->irq < 0)
>                           return bt_bmc->irq;
> 
>                But consider if failed, "bt_bmc->irq" must be assigned to
> "0"，the easiest way is to delete the        403~404 line, handled directly
> by the function devm_request_irq().

The problem you point out is real, the check should be < 0.

You don't want it handled by devm_request_irq, that could result in logs
that are invalid.

Also, it should use platform_get_irq_optional() to avoid a spurrious log
when there is no irq.

> 
> 
>         Q3：About dev_warm()
> 
>                 KERN_WARNING is higher than KERN_INFO, the same to
> dev_warn() and dev_info(). When the function bt_bmc_probe() uses dev_info()
> to print error message, the dev_warm() in the line of 409 should be
> redundant.

That is all correct as it is.  If there is an irq specified and it can't
be requested, that is a problem.  If there is no irq specified, that is
fine, just info is good.

Thanks,

-corey

> 
> 
> I am waiting for your replay, and thank you for your guidance.
> 
> Tang Bin
> 
> 
> 
