Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951D3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796C42065F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGOWGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:06:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:25047 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgGOWGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:06:12 -0400
IronPort-SDR: S1PX3zpD7WzAzQx9/50EHbYbqGYeDvYEUTjC5N8qvtgOdcQa3k/ImIyxvs7W4/WESOQJVstQKc
 VouZuBCLRESQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150666074"
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="150666074"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 15:06:12 -0700
IronPort-SDR: iRsrS99HS6MdNE/ujfwpMklUKMIuF8aus3svltBIRJ1DtYDwGdUXXLIkBEqJN+RtwwwIlxsK1C
 /CKUf9AKQQpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="360848017"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 15 Jul 2020 15:06:12 -0700
Date:   Wed, 15 Jul 2020 15:12:54 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 1/5] docs: IOMMU user API
Message-ID: <20200715151254.511ab0b5@jacob-builder>
In-Reply-To: <20200714130412.0ef8f00c@x1.home>
References: <1594165429-20075-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1594165429-20075-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200713164842.693ff2ff@x1.home>
        <20200713220023.35f7c79b@jacob-builder>
        <20200714130412.0ef8f00c@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 13:04:12 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> > >  The
> > > mangling of the user provided argsz above makes me cringe a
> > > little too for that reason, once we start modifying the user
> > > values in the core it could get messy for the vendor drivers.
> > >     
> > We do have vendor specific union in bind_gpasid UAPI. Could you
> > elaborate your concern?  
> 
> The vendor driver is no longer seeing the value the user provided,
> what if some future vendor structure ends with something like:
> 
> 	__u32 nr_entries;
> 	__u32 entries[];
> }
> 
> The core code clobbered the user value, so the vendor driver wouldn't
> be able to perform any additional user copies.  Clearly that's also a
> bug that could be fixed at the time such functionality becomes
> necessary, it seems unnecessary to perform that clobbering in the
> first place if everyone is on guard for user supplied data.  Thanks,
Sorry I missed this in my last reply.

Make sense not to clobber user data in the core. So we should pass the
argsz as is to the vendor driver, but copy from user only up to the
size of the current kernel supports.
i.e.

	/*
	 * User might be using a newer UAPI header which has a larger data
	 * size, we shall support the existing flags within the current
	 * size. Copy the remaining user data _after_ minsz but not more
	 * than the current kernel supported size.
	 */
	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
				min(inv_info.argsz, maxsz) - minsz))
		return -EFAULT;

Currently, vendor driver does not handle user pointer. Once the
extension as you described above becomes necessary, we can change the
vendor driver interface. Is that a reasonable plan?

