Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFE9C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C38521734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581447481;
	bh=SYGr/poOOxABNG/sEWpaMTCIoISL7kajfj6opKOEj/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mtqfMkwEuPTspC/+NxMo+H0idZ+7kiOn8wDDSNRtmTzzPJtNK0I50IbukE5+mSvUg
	 a+BFGBEHMPd1wr33C8pBfoxFpsuzPZBvLIq5ltTWhvZ6rBhkXNKbRDGnq2Hq0iDgku
	 cW/4dhfHZ3DxmPf6mG0an90vh3gPDhtHcQLoG3Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730803AbgBKS6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:55600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727722AbgBKS6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:00 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9640F2168B;
        Tue, 11 Feb 2020 18:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581447479;
        bh=SYGr/poOOxABNG/sEWpaMTCIoISL7kajfj6opKOEj/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0XPIYzUoVXHabiF9sZZz8W1qNiFvFY5hmzZ/OPpyvFZgXct19ICW58gEa/dhPpLn/
         TH3SMnOouuGySAI7aZDT6+WJaxTRSUdbweso0dgIMS9czgE7EphXdCOyiLCC4rGHnk
         rwBEZoF5fQVf8cSPuR2iqkHx72zgAP0oBiw8wpcg=
Date:   Tue, 11 Feb 2020 10:57:59 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200211185759.GA1941673@kroah.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211184200.GA302770@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
> On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
> > On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
> > > +static ssize_t skx_iio_mapping_show(struct device *dev,
> > > +				struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pmu *pmu = dev_get_drvdata(dev);
> > > +	struct intel_uncore_pmu *uncore_pmu =
> > > +		container_of(pmu, struct intel_uncore_pmu, pmu);
> > > +
> > > +	struct dev_ext_attribute *ea =
> > > +		container_of(attr, struct dev_ext_attribute, attr);
> > > +	long die = (long)ea->var;
> > > +
> > > +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> > 
> > If "0000:" is always the "prefix" of the output of this file, why have
> > it at all as you always know it is there?
> > 
> > What is ever going to cause that to change?
> 
> I think it's just to make it a complete PCI address.

Is that what this really is?  If so, it's not a "complete" pci address,
is it?  If it is, use the real pci address please.

> In theory it might be different on a complex multi node system with
> custom interconnect and multiple PCI segments, but that would need code
> changes too.
> 
> This version of the patchkit only supports standard SKX systems
> at this point.

I have no idea what that means, please translate for non-Intel people :)

greg k-h
