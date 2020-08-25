Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F23442065F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmDZwmz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbgHYIPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgHYIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:15:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:15:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r15so11722852wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fCMhYRJmjkYiKHZv5M9E4fwHUfNifLkPhD+twyPnjk8=;
        b=PmDZwmz/MeYnNaxx634n/X2V9xw4jBokuKq3G9Cymy+g8c25WRZi9y9Dt0sYltwoLj
         rfXvOeghHR2ar1bXcVTbSDIa6gZt19jSb5F6pyMM3XPnP/Pf+lRj5siFbW4Lyo4eUGGg
         u4lCIRzS13c/cp77o+pDAdycl01PenDOecNgaLrtL4j2Nr3m50ytRhyw4IK2jOkjkCqD
         h+HADUFO3wFFJtzG6+7F1Gfhx6tPzeWEYpmLaXSebSkzhKIUyw/V62kWOhEfZ8zI8tiF
         vnM+JUMmVfHKEc7KPfwaXphrA7P4eaUfbKqKvOtGFeXJJCYM7Hc8VEKBlEN1McplTPO5
         wvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fCMhYRJmjkYiKHZv5M9E4fwHUfNifLkPhD+twyPnjk8=;
        b=t6q4vvDZ482xpBiFWCbtl9xyC6LcuVL4qOwq9aH/ivc2w/7HwqjjfqP+qWc/E37Te3
         YoyZ8JPCrzpG3lc1PuSqR6MU2xhkwUj++oEiEoLFOhPb/1B9OxYEuPDDDpbtR75bLxQh
         z9Dsyn0Bubo/2gqUzB8i5wfmJ6P+YqojhSPKxqQMEeeIuOXjRpjB6rLCtFD87akmvWYN
         pwSBueTbLjaxbmc7DOEvIs3NL+ApbeAMXqf743AMhY8z3SFC+/dhZGFPDGNyTYTBazGG
         gLi2Dzob+Us7ZbgpXnNYFesvbKSmxhFvSeJMnMmXdFHryDq2wCkwbQpGkQqea25tiPs3
         zGwg==
X-Gm-Message-State: AOAM5320KkLHkZtq6TIbEizvhnvZbYqTf3xHldcqMna92mqxT6DDosm1
        rFAjmPhg6Qoi878+fruEFgk=
X-Google-Smtp-Source: ABdhPJx/HZbjSGWiAMZDR8byiF2se8q102htS9s8NywuAX8BwxBr4+FOSWXB9/ZHj8ZWtL6kI4/uJA==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr5689661wru.358.1598343301615;
        Tue, 25 Aug 2020 01:15:01 -0700 (PDT)
Received: from lenovo-laptop (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id v67sm4395205wma.46.2020.08.25.01.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 01:15:00 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Tue, 25 Aug 2020 09:14:59 +0100
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, devel@driverdev.osuosl.org,
        Saiyam Doshi <saiyamdoshi.in@gmail.com>,
        Magnus Damm <damm+renesas@opensource.se>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        "Javier F. Arias" <jarias.linux@gmail.com>,
        "Frank A. Cancio Bello" <frank@generalsoftwareinc.com>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: Re: [PATCH] staging: emxx_udc: Fix passing of NULL to
 dma_alloc_coherent()
Message-ID: <20200825081459.qfvswtep5fkaqai2@lenovo-laptop>
References: <20200824142118.GA223827@mwanda>
 <20200824151920.251446-1-alex.dewar90@gmail.com>
 <20200824155712.4kgxwqiufm2ieboz@medion>
 <20200825073713.GR1793@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825073713.GR1793@kadam>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:37:13AM +0300, Dan Carpenter wrote:
> On Mon, Aug 24, 2020 at 04:57:12PM +0100, Alex Dewar wrote:
> > On Mon, Aug 24, 2020 at 04:19:17PM +0100, Alex Dewar wrote:
> > > In nbu2ss_eq_queue() memory is allocated with dma_alloc_coherent(),
> > > though, strangely, NULL is passed as the struct device* argument. Pass
> > > the UDC's device instead.
> 
> I think passing NULL was always wrong, but it used to not cause an Oops.
> This was changed a year or two ago.
> 
> > > 
> > > Build-tested on x86 only.
> > > 
> > > Fixes: 33aa8d45a4fe ("staging: emxx_udc: Add Emma Mobile USB Gadget driver")
> > > Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> > > ---
> > > 
> > > So I *think* this is the right fix, but I don't have the hardware so
> > > I've only been able to build-test it. My worry is that I could be
> > > passing in the wrong struct device* here, which would squelch the
> > > warning without fixing the breakage.
> > > 
> > > Can someone cleverer than me tell me if this makes sense?
> > > 
> > > - Alex
> > 
> > PS -- I meant to put an RFC in the subject line and an extra tag:
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> 
> I don't know which dev pointer we're supposed to pass...  It would be
> good to find someone to test the patch but if not then applying your
> patch is reasonable.
> 
> But could you search through the file and update the rest as well.
> The dma_free_coherent() needs to be updated and there was a second
> dma_alloc_coherent() in the bug report.
> 
> regards,
> dan carpenter
> 

I can only find the one instance of dma_alloc_coherent(). Was it by any
chance a different warning about the same call....?
