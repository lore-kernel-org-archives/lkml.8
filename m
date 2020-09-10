Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B274C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7F120C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599755545;
	bh=pU7vs9Oqtq1EuN0LnSu799unpKeDDHK8B0ZI7XTbRh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ger7puQweZgcqBZWBcJMRSLqlsBfq1ELalZzXigu+splbObZp1VGrlRlloc3noYPG
	 BZSJuVLwCf0CWIdDFl1ghjQyXVIoSq5WNZD5d21ZvaH+li2AuVa8VnFDRtaUiFjIvA
	 9Xr3IyMzBsZe0zG5qQWI4hcFrSWcsZ1jA0D1Jh+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgIJQcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726841AbgIJQcB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:32:01 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BE720C09;
        Thu, 10 Sep 2020 16:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599755521;
        bh=pU7vs9Oqtq1EuN0LnSu799unpKeDDHK8B0ZI7XTbRh0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uDFhA5k4yX+WzUizO+Zb6wqKrXfTncoQ6z51rA0TvJFV+dhYyifq0/40ocjnU2QiR
         5cc3EX4oIyBFK4gjIEZvohwstFhYNSO2854opBdYqzf6g2mvtFrsaz/ERxg/8cmjf2
         HryVczveTV/E4gDiI56HXK8yIItIrxUxyDGwlg9c=
Date:   Thu, 10 Sep 2020 18:32:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Eads, Gage" <gage.eads@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        "Topel, Bjorn" <bjorn.topel@intel.com>
Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
Message-ID: <20200910163208.GA1321670@kroah.com>
References: <20200901191548.31646-1-gage.eads@intel.com>
 <20200901191548.31646-2-gage.eads@intel.com>
 <20200907130150.GE2371705@kroah.com>
 <SN6PR11MB2574DA2AA215E9566BA4F410F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR11MB2574DA2AA215E9566BA4F410F6270@SN6PR11MB2574.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:24:31PM +0000, Eads, Gage wrote:
> 
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Monday, September 7, 2020 8:02 AM
> > To: Eads, Gage <gage.eads@intel.com>
> > Cc: linux-kernel@vger.kernel.org; arnd@arndb.de; Karlsson, Magnus
> > <magnus.karlsson@intel.com>; Topel, Bjorn <bjorn.topel@intel.com>
> > Subject: Re: [PATCH v3 01/19] dlb2: add skeleton for DLB 2.0 driver
> > 
> > On Tue, Sep 01, 2020 at 02:15:30PM -0500, Gage Eads wrote:
> > > --- /dev/null
> > > +++ b/drivers/misc/dlb2/dlb2_main.c
> > > @@ -0,0 +1,208 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/* Copyright(c) 2018-2020 Intel Corporation */
> > > +
> > > +#include <linux/aer.h>
> > > +#include <linux/cdev.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/fs.h>
> > > +#include <linux/init.h>
> > > +#include <linux/list.h>
> > > +#include <linux/module.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/uaccess.h>
> > > +
> > > +#include "dlb2_main.h"
> > > +
> > > +static const char
> > > +dlb2_driver_copyright[] = "Copyright(c) 2018-2020 Intel Corporation";
> > 
> > Why have this in a string and then:
> > 
> > > +MODULE_LICENSE("GPL v2");
> > > +MODULE_AUTHOR("Copyright(c) 2018-2020 Intel Corporation");
> > 
> > Not use it?
> > 
> > It's probably not needed at all, right?
> > 
> > Don't you get a build warning about this when applying and building this
> > patch?
> > 
> > thanks,
> > 
> > greg k-h
> 
> dlb2_driver_copyright was used in a pr_info() in the v1 patchset that was
> removed at Arnd's recommendation, and I forgot to remove the string. Will fix.
> The unused warning variable was likely missed in the deluge of warnings from
> included kernel headers.

You should not have any build warnings.  If you do, then something is
really wrong, the kernel builds cleanly today.

thanks,

greg k-h
