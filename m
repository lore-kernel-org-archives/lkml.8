Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B20206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgFKQcE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:32:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:64834 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQcD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:32:03 -0400
IronPort-SDR: T4IudeG5u7Qn2jxD6y5DzJlZzXYMK+NLOr/hAqWrPKeSe5v1tSleBy8ClsxsGv79WCgs7B//go
 KX42VjgaPsrw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 09:32:03 -0700
IronPort-SDR: PVunhJ0wQk6hACj1iOao85SPmBxVDJXTBzUmMPzi+e50sgSu8TcxnrgJ77X3TkZUV8zMsAR1BU
 MmjeIE8gcdtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,499,1583222400"; 
   d="scan'208";a="275387757"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
  by orsmga006.jf.intel.com with ESMTP; 11 Jun 2020 09:32:02 -0700
Date:   Thu, 11 Jun 2020 09:38:27 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/3] docs: IOMMU user API
Message-ID: <20200611093827.7d7a3185@jacob-builder>
In-Reply-To: <20200611075500.44fa6cd4@lwn.net>
References: <1591848735-12447-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1591848735-12447-2-git-send-email-jacob.jun.pan@linux.intel.com>
        <20200611075500.44fa6cd4@lwn.net>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On Thu, 11 Jun 2020 07:55:00 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> On Wed, 10 Jun 2020 21:12:13 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> A little nit but...this pattern:
> 
> > +pattern below:
> > +
> > +::
> > +
> > +   struct {
> > +	__u32 argsz;
> > +	__u32 flags;
> > +	__u8  data[];
> > +  }  
> 
> can be more concisely and attractively written as:
> 
>    pattern below::
> 
> 	struct { 
> ...
> 
Will do. thanks!

> Thanks,
> 
> jon

[Jacob Pan]
