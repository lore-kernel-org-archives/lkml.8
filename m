Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B174FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC08214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592555592;
	bh=xCa39vg9kNjBEYkhG0pB5fRGthr4MY4uUu99DAVyKfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cQ5+bGOolLJP/Z4eRgE2cfGCVkFspQNPhRzJJdyZwqfI5JUm5yxn4N7N0WAQD3Asz
	 DskPfTtISZCIi6CiKc4z19a/rb4r7XnujKM39BQduPs9GGar8hx/JtLvyZRRcxjxfv
	 NvWrXgB+itEku45E7n/rdxzAacT4ZxEa8rCUlAhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731409AbgFSIdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbgFSIdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:33:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8605120776;
        Fri, 19 Jun 2020 08:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592555587;
        bh=xCa39vg9kNjBEYkhG0pB5fRGthr4MY4uUu99DAVyKfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwBrs1OoYHy0uCnuLbIyPQTW0ec5FbUPeoHP6or1oMqEt0gxRb17DyC3qH8LqFF4Y
         bziggZFurrMfEVYgOGdWzt+NFunvzPqfGYj5pfb2uZriPNgfJI7DJ6wCGPxhJhKTy5
         nrw9KDmzWzx+mEL4saVOhVMeOLWPUObok9wgAl3Q=
Date:   Fri, 19 Jun 2020 10:32:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rodolfo C Villordo <rodolfovillordo@gmail.com>
Cc:     devel@driverdev.osuosl.org, Richard Yeh <rcy@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Rob Springer <rspringer@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: replace symbolic permissions
Message-ID: <20200619083224.GA473790@kroah.com>
References: <20200601005240.6315-1-rodolfovillordo@gmail.com>
 <20200618074750.GA186463@kroah.com>
 <20200619082714.GA7780@ip-172-31-24-31.ec2.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619082714.GA7780@ip-172-31-24-31.ec2.internal>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 08:27:14AM +0000, Rodolfo C Villordo wrote:
> On Thu, Jun 18, 2020 at 09:47:50AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jun 01, 2020 at 12:52:40AM +0000, Rodolfo C. Villordo wrote:
> > > WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> > > +               .attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > > warning detected by checkpatch.pl
> > > 
> > > Signed-off-by: Rodolfo C. Villordo <rodolfovillordo@gmail.com>
> > > ---
> > >  drivers/staging/gasket/gasket_sysfs.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/gasket/gasket_sysfs.h b/drivers/staging/gasket/gasket_sysfs.h
> > > index ab5aa351d555..d5e167dfbe76 100644
> > > --- a/drivers/staging/gasket/gasket_sysfs.h
> > > +++ b/drivers/staging/gasket/gasket_sysfs.h
> > > @@ -71,7 +71,7 @@ struct gasket_sysfs_attribute {
> > >  
> > >  #define GASKET_SYSFS_RO(_name, _show_function, _attr_type)                     \
> > >  	{                                                                      \
> > > -		.attr = __ATTR(_name, S_IRUGO, _show_function, NULL),          \
> > > +		.attr = __ATTR(_name, 0444, _show_function, NULL),          \
> > 
> > What about using __ATTR_RO() instead?
> > 
> 
> I'm not sure if __ATTR_RO() is a good match here. The
> GASKET_SYSFS_RO() is invoked with different show functions across the
> code. These functions don't follow the name pattern attr_name_show
> used in __ATTR_RO(). Please correct me if I misunderstood anything.
> 
> ### from include/linux/sysfs.h ###
> #define __ATTR_RO(_name) {                                              \
>         .attr   = { .name = __stringify(_name), .mode = 0444 },         \
>         .show   = _name##_show,                                         \
> }
> ###
> 
> ### macro usage across the driver: ###
> $ grep GASKET_SYSFS_RO drivers/staging/gasket/*
> drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_page_table_entries, sysfs_show,
> drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_simple_page_table_entries, sysfs_show,
> drivers/staging/gasket/apex_driver.c:   GASKET_SYSFS_RO(node_0_num_mapped_pages, sysfs_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_offsets, gasket_sysfs_data_show, ATTR_BAR_OFFSETS),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(bar_sizes, gasket_sysfs_data_show, ATTR_BAR_SIZES),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(driver_version, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(framework_version, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_type, gasket_sysfs_data_show, ATTR_DEVICE_TYPE),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(revision, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(pci_address, gasket_sysfs_data_show, ATTR_PCI_ADDRESS),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(status, gasket_sysfs_data_show, ATTR_STATUS),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(is_device_owned, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(device_owner, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(write_open_count, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(reset_count, gasket_sysfs_data_show, ATTR_RESET_COUNT),
> drivers/staging/gasket/gasket_core.c:   GASKET_SYSFS_RO(user_mem_ranges, gasket_sysfs_data_show,
> drivers/staging/gasket/gasket_interrupt.c:      GASKET_SYSFS_RO(interrupt_counts, interrupt_sysfs_show,
> ###

Ugh, you are right, that's a mess.  Your original patch is fine, can you
resend it and say in the changelog why it's not ok to use __ATTR_RO()?

thanks,

greg k-h
