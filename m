Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C59C7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:33:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0944206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbuFPrqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgHXJdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbgHXItl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:49:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E00C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:49:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so7833494wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zDiYUFquth7cyRebjTDkbtYp+6xmfLZ57umDUURK8BE=;
        b=jbuFPrqnGdZkpuf0OoZ4MhNtVoU3u8mDO+7eohccVgR+/Ufb34v5QUQ1egDxgLLvit
         ny7igxC9wkACDhQkRr6+LAbF0s6BZERAJWLkn2TjC/jSUayf/7jKcIgTD9BRh5sfwpek
         3/+3sXt8ISswLoWakmDyEnDaPXmLm0rh8qkSMNTJprXWyqxrRniGADdppFvoknlBT2H9
         BREN1po5rN1VfvrAmPoB1o/kZrHjxz4JW0t7F0oAXyOIyCTU66lSBtz6JvHjU2z7VNOd
         d50rMA6vUVl/W1kA/QnRMVU/hyLBhrX12Kx4r7jko5z9Rat7BgJB18ZW2Wq6kUhA4+63
         W+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zDiYUFquth7cyRebjTDkbtYp+6xmfLZ57umDUURK8BE=;
        b=hIjWu/ivfLIrz3m2NBA0vj1Wu2jraEwMXJo4HxRv5ccAgE2VQ7n54L7n924cdGhVT9
         yvrLqqT95Vh4dyv36BytDAUaIXYW0xAJriIqyTQKWfaMimPOfgdXfcIE5lQDR6hpBagn
         DnpnjQyv6NyBYcz+uurpQA1V6AIPciL2/vovtZAfh9KrROgME3yDV0ruSxO1T5ZfAXIy
         PgWb4Rz3eaSdWsH4Hn4xUM6Coc/WIo8fTJhig+F+pj5tslN6qa6zwk31q4cJLUYXUvFu
         Ott3VMxA2vtmysZJJxPBb9xh3opy6/VRkBBz0tGU9oBQrJASXfp18aLahY4ZuFVuHdcM
         jS3Q==
X-Gm-Message-State: AOAM5310pAGxjxw0hNAn042mj9YtkLrM6ffzDiTO19bbJE5ettDKS75Q
        MgJM4XrYcN5qpMzOXO3g9y4swA==
X-Google-Smtp-Source: ABdhPJz9eKE3NWBVPX2z+eAhK9dcu43QK9Wj+PEVt/vF9PIoZWnjq56T72brZlxcizBu89MfN7lRcw==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr4730824wru.211.1598258977851;
        Mon, 24 Aug 2020 01:49:37 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id n205sm12973788wma.47.2020.08.24.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 01:49:37 -0700 (PDT)
Date:   Mon, 24 Aug 2020 09:49:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mfd: core: Fix double-free in mfd_remove_devices_fn()
Message-ID: <20200824084935.GJ3248864@dell>
References: <20200817235048.24577-1-digetx@gmail.com>
 <CGME20200824083847eucas1p2e5fee0790df8f21934d99e848dc14afe@eucas1p2.samsung.com>
 <ac27b0cc-6ede-c7ed-19ee-2472f87f93f7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac27b0cc-6ede-c7ed-19ee-2472f87f93f7@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Aug 2020, Marek Szyprowski wrote:

> Hi
> 
> On 18.08.2020 01:50, Dmitry Osipenko wrote:
> > The pdev.mfd_cell is released by platform_device_release(), which is
> > invoked by platform_device_unregister(). Hence mfd_remove_devices_fn()
> > shouldn't release the cell variable. The double-free bug is reported KASAN
> > during of MFD driver module removal.
> >
> > Fixes: 466a62d7642f ("mfd: core: Make a best effort attempt to match devices with the correct of_nodes")
> > Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > ---
> 
> I've reported that almost a week earlier and got information that it 
> will be dropped:
> 
> https://lore.kernel.org/lkml/79bcd1b5-2247-5e00-7d49-2f94f9b40744@samsung.com/
> 
> https://lore.kernel.org/lkml/20200813080100.GI4354@dell/
> 
> Sadly it finally landed in v5.9-rc1. Would be nice to mention this in 
> the revert:

That's true.  The patch was taken out but the change managed to get in
via another commit.  I will add your Reported-by to the revert.

> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> >   drivers/mfd/mfd-core.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index c3651f06684f..c50718e3db58 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -370,8 +370,6 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
> >   	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
> >   					       cell->num_parent_supplies);
> >   
> > -	kfree(cell);
> > -
> >   	platform_device_unregister(pdev);
> >   	return 0;
> >   }
> 
> Best regards

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
