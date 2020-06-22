Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA0B25444
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 07:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApgCSBjR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbgFVHNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgFVHNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 03:13:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54035C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:13:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so11906441qtn.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 00:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WHNU4BqPOMoXAHyrLfd9lVnT4NBoEXCk4Mpzmq7GhX4=;
        b=ApgCSBjR6KQwE9jwA6OVhMb5LjAvrIIVbWtH2r+NSsPAIXg4DLiEBreZm6lm4B6UBV
         n5lD/FpyiEaDFviQ125vK/eomoSciBK3CF4PV8bm3CUknheVfozZG7Kuc5ErxXRPLvOd
         oYLi00zgbo3fCdOT9CEZMq2zvSyDGacfoRVkDXEGraFScyvYCc0QwrMZEtuqAaR2IWqf
         vtvlh2qfyfCeXFRetIisMTQnGqNfZX7fp3+iH44i6YHHH1lQLERAQtvLZX1Zg6UePggo
         8Jte5N4+1eendOw4eEK1CEdzN+5bv7NElo+MDzS0UmryKDMrytionhqoIfAVsPn9ltTe
         kttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WHNU4BqPOMoXAHyrLfd9lVnT4NBoEXCk4Mpzmq7GhX4=;
        b=Yti2qdiWNRTDO97hzdJAxLmIHd/I77vXRJ5LySSKGBhzHI2YXQvjQnmQS2gt/1jycE
         nDeBxmR2KqFrT9NdXEOwEL7vDK6MtGo/KYMsHFE3lL7vW07BJ5ayp6gIFLM4E6Kp/m1n
         oTdGkMJBkAWh9u328AyXFQ5qLEn5yB28jJMYiBTrRLPytj14eJkNCnUOsrgncrAVUB4e
         kw3Gj5azUSqXXgWH5JjLH22GpoXpQSBia7GNv0/lZZYFLOgJS2nQ/bGpoSwmYn5rswtv
         pw3bWWBP40RMRWOxPWcZUAerjlsufUUyI8Bj+8oNXQW3M29nX61Fpfq1VLog7a9mTSRE
         TWtg==
X-Gm-Message-State: AOAM5318N9ADbYzLMu9UgmjhMw9+POlS91fodiV2up1Zr02UOY8VWJqb
        CE84xYf4lKFGmvmnHOCIEaY=
X-Google-Smtp-Source: ABdhPJwqlbRRjNacvHiDV4+FkmTyXT24Nd7dcjG7phBqXx+I/U8tIYUagKgxAs7zN/p290t4cVfCZg==
X-Received: by 2002:aed:3987:: with SMTP id m7mr13159266qte.220.1592809995360;
        Mon, 22 Jun 2020 00:13:15 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id h52sm5645607qtb.88.2020.06.22.00.13.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 00:13:14 -0700 (PDT)
Date:   Mon, 22 Jun 2020 07:13:13 +0000
From:   Rodolfo C Villordo <rodolfovillordo@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Richard Yeh <rcy@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Rob Springer <rspringer@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: replace symbolic permissions
Message-ID: <20200622071313.GA11977@ip-172-31-24-31.ec2.internal>
References: <20200601005240.6315-1-rodolfovillordo@gmail.com>
 <20200618074750.GA186463@kroah.com>
 <20200619082714.GA7780@ip-172-31-24-31.ec2.internal>
 <20200619083224.GA473790@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619083224.GA473790@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:32:24AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 19, 2020 at 08:27:14AM +0000, Rodolfo C Villordo wrote:
> > On Thu, Jun 18, 2020 at 09:47:50AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jun 01, 2020 at 12:52:40AM +0000, Rodolfo C. Villordo wrote:
> > > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > > +               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > > > warning detected by checkpatch.pl
> > > > 
> > > > Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
> > > > ---
> > > >  drivers/staging/gasket/gasket_sysfs.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> > > > index ab5aa351d555..d5e167dfbe76 100644
> > > > --- a/drivers/staging/gasket/gasket_sysfs.h
> > > > +++ b/drivers/staging/gasket/gasket_sysfs.h
> > > > @@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
> > > >  
> > > >  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
> > > >  	{                                                                      \
> > > > -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > > > +		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
> > > 
> > > What about using __ATTR_RO() instead?
> > > 
> > 
> > I'm not sure if __ATTR_RO() is a good match here. The
> > GASKET_SYSFS_RO() is invoked with different show functions across the
> > code. These functions don't follow the name pattern attr_name_show
> > used in __ATTR_RO(). Please correct me if I misunderstood anything.
> > 
> > ### from include/linux/sysfs.h ###
> > #define __ATTR_RO(_name) {                                              \
> >         .attr   = { .name = __stringify(_name), .mode = 0444 },         \
> >         .show   = _name##_show,                                         \
> > }
> > ###
> > 
> > ### macro usage across the driver: ###
> > $ grep GASKET_SYSFS_RO drivers/staging/gasket/*
> > drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
> > drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
> > drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
> > drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
> > drivers/staging/gasket/gasket_interrupt.c:      GASKET_SYSFS_RO(interrupt_counts, interrupt_sysfs_show,
> > ###
> 
> Ugh, you are right, that's a mess.  Your original patch is fine, can you
> resend it and say in the changelog why it's not ok to use __ATTR_RO()?
> 
Sure, doing it now.

Thanks

> thanks,
> 
> greg k-h
