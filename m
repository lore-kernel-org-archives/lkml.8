Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D931C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9AEF20885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd8C+Aa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbgFSI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731227AbgFSI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:27:17 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D24AC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:27:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id q8so8151663qkm.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gHRO6u53fICxpVEP0QhHKvY/XKkf310c1oLvKRI/vuQ=;
        b=Rd8C+Aa2deIZLBQoqhRSSDJ1aEEQQJ4chyGZ6tJROToja0WjQU0vGuFdeLXJj0+Y6P
         0rs6oE7UChzpbRU99ZenQAAcsIISjoPEGMLHwNHBmVABtErAentMmxrWSnVCe9cgtDhn
         pn47NaBswHuzBtqotO5cTqzztbHMmZXBz0/SquKdT/jqYiQdy1zI+9EwulWEc4BNTazx
         gYFJc3OOPU7g2H8DsuAUiKO0iZn4k2xWviZ0ctDM89z9qzzAwtqNnD0OpqsrNWW5EyW/
         fQg7g+oAiv4ioTydeQ0KA9KY7TWESUhn4zyc1Q9BCCWm/EFwQRWv/VgYXrK7Vo5y5/gI
         BbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gHRO6u53fICxpVEP0QhHKvY/XKkf310c1oLvKRI/vuQ=;
        b=jeMsBs6vicUJR6BvCYIj0dpS+4PczyUzw3ibIROzz27hrCpVYccXjK7QEW1oEZHsHV
         7GVrPMjmmKoCIyPKThe8NiMKaCvzPtskQC0333BBPxoOp7/qk5NRB+YUFzDrFC2fGy4v
         IwE6MQlAlWNgEWrZTILVQriRfts6NnsiPphIvoEAXPEC3wIBA5rTbXJOTc0EG3IQMY1v
         KBPqfSNfD05gc41ahzMe2Ihnx51VwtiAuprBBC8KXqJhskoSWAVTYj4fsEgwJPbzhpFw
         ZjFPXmdpTsMksTWBdfDnCOCOjQ32PY1lqESb62DpC26V33x3TchT/R8CF+tO6M0schuy
         gyEQ==
X-Gm-Message-State: AOAM531zVrxJCbw9R/Sc5guVaW8WX7JHWNXob+UkqPtkgcV3tzg6eHDv
        9InGZzRWl+n1Tfqfz9Xg6l/m6mmRcvI=
X-Google-Smtp-Source: ABdhPJzBngVrHQEWjHdgpo7pKCGKg4TafzzHNdsOgG4sXtHASTuG4EtIpKHKoYyVi38p5pWUqK7elw==
X-Received: by 2002:a37:90f:: with SMTP id 15mr2357299qkj.339.1592555236064;
        Fri, 19 Jun 2020 01:27:16 -0700 (PDT)
Received: from ip-172-31-24-31.ec2.internal (ec2-54-234-246-66.compute-1.amazonaws.com. [54.234.246.66])
        by smtp.gmail.com with ESMTPSA id x4sm5077822qtj.50.2020.06.19.01.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Jun 2020 01:27:15 -0700 (PDT)
Date:   Fri, 19 Jun 2020 08:27:14 +0000
From:   Rodolfo C Villordo <rodolfovillordo@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Richard Yeh <rcy@google.com>,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH] staging: gasket: replace symbolic permissions
Message-ID: <20200619082714.GA7780@ip-172-31-24-31.ec2.internal>
References: <20200601005240.6315-1-rodolfovillordo@gmail.com>
 <20200618074750.GA186463@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618074750.GA186463@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:47:50AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jun 01, 2020 at 12:52:40AM +0000, Rodolfo C. Villordo wrote:
> > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > +               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > warning detected by checkpatch.pl
> > 
> > Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
> > ---
> >  drivers/staging/gasket/gasket_sysfs.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> > index ab5aa351d555..d5e167dfbe76 100644
> > --- a/drivers/staging/gasket/gasket_sysfs.h
> > +++ b/drivers/staging/gasket/gasket_sysfs.h
> > @@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
> >  
> >  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
> >  	{                                                                      \
> > -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > +		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
> 
> What about using __ATTR_RO() instead?
> 

I'm not sure if __ATTR_RO() is a good match here. The
GASKET_SYSFS_RO() is invoked with different show functions across the
code. These functions don't follow the name pattern attr_name_show
used in __ATTR_RO(). Please correct me if I misunderstood anything.

### from include/linux/sysfs.h ###
#define __ATTR_RO(_name) {                                              \
        .attr   = { .name = __stringify(_name), .mode = 0444 },         \
        .show   = _name##_show,                                         \
}
###

### macro usage across the driver: ###
$ grep GASKET_SYSFS_RO drivers/staging/gasket/*
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
drivers/staging/gasket/gasket_interrupt.c:      GASKET_SYSFS_RO(interrupt_counts, interrupt_sysfs_show,
###

Thank you!

> thanks,
> 
> greg k-h
