Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C4C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5DE21734
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 22:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581548166;
	bh=dJpfeI0uuBvhIhsEza0VhIC2G+XvIrf3MaBC2aTSshM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=atVafMROv0qScEfA/YW/bRemdwCIBF3vwkM3mmXzlLt5IU8EzQ5vuPfIC16vkjTZf
	 go69B4zk4u41hXWJiAcq0UHxWo+CowvRL5Kh2Gn8ctHaSL5wbkd1mYtRAmVmpbH+SD
	 LvxTXuKJ9PhRFLNuGZikcl2X7deD/ZXaCOQaSDeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgBLW4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 17:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:42504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgBLW4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 17:56:04 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5ABF21569;
        Wed, 12 Feb 2020 22:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548164;
        bh=dJpfeI0uuBvhIhsEza0VhIC2G+XvIrf3MaBC2aTSshM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZnxP8BuZ/Lx5j9m6CT/0ULu3lx3IP+DaF/NdHSdFV8g1l7jTZnnhcBtNL86JP1i2
         a7bIxg3o1sJwYOmIXOtcgB+RqMwAc8vk2mvRw8+f5+v+lnkD3vCSY7b63cJbZyOS81
         XXWoad5cTUus64OU6aS0+KkxJBinI7ZscyNZYOTc=
Date:   Wed, 12 Feb 2020 14:56:03 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200212225603.GA2489060@kroah.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
 <20200211171544.GA1933705@kroah.com>
 <20200211184200.GA302770@tassilo.jf.intel.com>
 <20200211185759.GA1941673@kroah.com>
 <25dca8dd-c52d-676d-ffe4-90f3a6ddc915@linux.intel.com>
 <20200211201427.GA1975593@kroah.com>
 <7a697574-aa76-3eda-d504-1ec72bcb6353@linux.intel.com>
 <323e0892-d34f-a812-4d9a-e7a4bf71afd2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <323e0892-d34f-a812-4d9a-e7a4bf71afd2@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 03:58:50PM -0500, Liang, Kan wrote:
> 
> 
> On 2/12/2020 12:31 PM, Sudarikov, Roman wrote:
> > On 11.02.2020 23:14, Greg KH wrote:
> > > On Tue, Feb 11, 2020 at 02:59:21PM -0500, Liang, Kan wrote:
> > > > 
> > > > On 2/11/2020 1:57 PM, Greg KH wrote:
> > > > > On Tue, Feb 11, 2020 at 10:42:00AM -0800, Andi Kleen wrote:
> > > > > > On Tue, Feb 11, 2020 at 09:15:44AM -0800, Greg KH wrote:
> > > > > > > On Tue, Feb 11, 2020 at 07:15:49PM +0300,
> > > > > > > roman.sudarikov@linux.intel.com wrote:
> > > > > > > > +static ssize_t skx_iio_mapping_show(struct device *dev,
> > > > > > > > +                struct device_attribute *attr, char *buf)
> > > > > > > > +{
> > > > > > > > +    struct pmu *pmu = dev_get_drvdata(dev);
> > > > > > > > +    struct intel_uncore_pmu *uncore_pmu =
> > > > > > > > +        container_of(pmu, struct intel_uncore_pmu, pmu);
> > > > > > > > +
> > > > > > > > +    struct dev_ext_attribute *ea =
> > > > > > > > +        container_of(attr, struct dev_ext_attribute, attr);
> > > > > > > > +    long die = (long)ea->var;
> > > > > > > > +
> > > > > > > > +    return sprintf(buf, "0000:%02x\n",
> > > > > > > > skx_iio_stack(uncore_pmu, die));
> > > > > > > If "0000:" is always the "prefix" of the output of
> > > > > > > this file, why have
> > > > > > > it at all as you always know it is there?
> > > > 
> > > > I think Roman only test with BIOS configured as single-segment. So he
> > > > hard-code the segment# here.
> > > > 
> > > > I'm not sure if Roman can do some test with multiple-segment
> > > > BIOS. If not, I
> > > > think we should at least print a warning here.
> > > > 
> > > > > > > What is ever going to cause that to change?
> > > > > > I think it's just to make it a complete PCI address.
> > > > > Is that what this really is?  If so, it's not a "complete" pci address,
> > > > > is it?  If it is, use the real pci address please.
> > > > I think we don't need a complete PCI address here. The attr is
> > > > to disclose
> > > > the mapping information between die and PCI BUS. Segment:BUS
> > > > should be good
> > > > enough.
> > > "good enough" for today, but note that you can not change the format of
> > > the data in the file in the future, you would have to create a new file.
> > > So I suggest at least try to future-proof it as much as possible if you
> > > _know_ this could change.
> > > 
> > > Just use the full pci address, there's no reason not to, otherwise it's
> > > just confusing.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > Hi Greg,
> > 
> > Yes, the "Segment:Bus" pair is enough to distinguish between different
> > Root ports.
> 
> I think Greg suggests us to use full PCI address here.
> 
> Hi Greg,
> 
> There may be several devices are connected to IIO stack. There is no full
> PCI address for IIO stack.

Please define "full" for me.  Please please don't tell me you are just
using a truncated version of the PCI address.  I thought we got rid of
all of that nonsense 10 years ago...

> I don't think we can list all of devices in the same IIO stack with full PCI
> address here either. It's not necessary, and only increase maintenance
> overhead.

Then what exactly _IS_ this number, if not the PCI address?

Something made up to look almost like a PCI address, but not quite?
Somethine else?

> I think we may have two options here.
> 
> Option 1: Roman's proposal.The format of the file is "Segment:Bus". For the
> future I can see, the format doesn't need to be changed.
>     E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
>          $0000:7f

Again, fake PCI address?

> Option 2: Use full PCI address, but use -1 to indicate invalid address.
>     E.g. $ls /sys/devices/uncore_<type>_<pmu_idx>/die0
>          $0000:7f:-1:-1

"Invalid"?  Why?  Why not just refer to the 0:0 device, as that's the
bus "root" address (or whatever it's called, I can't remember PCI stuff
all that well...)

> Should we use the format in option 2?

What could userspace do with a -1 -1 address?

thanks,

greg k-h
