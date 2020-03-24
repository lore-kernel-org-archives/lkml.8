Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDE8C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942F02051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585070214;
	bh=WnqSTIFDe/Kb9yoYcJ/YYpeFFnG0haBTY6Mckibtcfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aDK+Fi1Dw+tdi85mLjwoiT0/hOQn8sCRjslZ3bHi+f7YUlGyWLJ6S1N4eJTrthooE
	 Vw1Ln4vwR7+EIqcwGzAF5ZfxN1BGwHrF7uLVsX3ldNtS+sozVp715G1ERTU7pMqMF6
	 k+qFfwAPo4o5AlHST5BxOJDagSERcGz2flVjmF18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCXRQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:16:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:52554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbgCXRQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:16:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EEA32076F;
        Tue, 24 Mar 2020 17:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585070212;
        bh=WnqSTIFDe/Kb9yoYcJ/YYpeFFnG0haBTY6Mckibtcfo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g+k4uyt6h3TRjUftFLvqtN8cf7g2rHMl/zIMxhUkxi798QhsRQOEdJ1z8R0hGUeja
         Ys5aBxwtK9uNtq6qyD/vwcrFCct7wfbGEmlUB0iFpRF5vPP5+Yp1SRjv1ovxLwta/b
         1x6zrVXONbrZnXMknzQ7AuJ890P4PNGIRgjmebwk=
Date:   Tue, 24 Mar 2020 18:16:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, vbendeb@chromium.org,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, andy@infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200324171649.GA2522961@kroah.com>
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
 <20200322111022.GA72939@kroah.com>
 <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
 <20200324164956.GE2518746@kroah.com>
 <3444110c-d6c0-16df-9b5d-12578ed442c5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3444110c-d6c0-16df-9b5d-12578ed442c5@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 06:08:03PM +0100, Enric Balletbo i Serra wrote:
> Hi Greg,
> 
> On 24/3/20 17:49, Greg Kroah-Hartman wrote:
> > On Tue, Mar 24, 2020 at 05:31:10PM +0100, Enric Balletbo i Serra wrote:
> >> Hi Greg,
> >>
> >> Many thanks for your quick answer, some comments below.
> >>
> >> On 22/3/20 12:10, Greg Kroah-Hartman wrote:
> >>> On Sun, Mar 22, 2020 at 10:43:34AM +0100, Enric Balletbo i Serra wrote:
> >>>> This driver attaches to the ChromeOS ACPI device and then exports the values
> >>>> reported by the ACPI in a sysfs directory. The ACPI values are presented in
> >>>> the string form (numbers as decimal values) or binary blobs, and can be
> >>>> accessed as the contents of the appropriate read only files in the sysfs
> >>>> directory tree originating in /sys/devices/platform/chromeos_acpi.
> >>>>
> >>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >>>
> >>> What is wrong with the "default" ACPI sysfs access?  Why do you need a
> >>> special driver just for this specific ACPI firmware?
> >>>
> >>
> >> Please correct me if I am wrong, as I'm not an ACPI expert and I probably have
> >> some ACPI leaks and misunderstandings.
> >>
> >> What is exporting this driver is the attributes for the non-default Chromebook
> >> specific MLST ACPI method. Hence, I assumed we needed a special driver to expose
> >> these values that can't be done using "default" ACPI sysfs. Note that these
> >> attributes are dynamically created and are different between Chromebooks so need
> >> some parsing.
> >>
> >> I didn't find a "standard" way to expose these attributes to userspace, so,
> >> please kindly point me to one if there is one.
> > 
> > Are you sure they aren't already there under /sys/firmware/acpi/?  I
> > thought all tables and methods were exported there with no need to do
> > anything special.
> > 
> 
> That's the first I did when I started to forward port this patch from chromeos
> kernel to mainline.
> 
> On my system I get:
> 
> /sys/firmware/acpi/tables#
> APIC  DSDT  FACP  FACS  HPET  MCFG  SSDT  data  dynamic
> 
> (data and dynamic are empty directories)
> 
> I quickly concluded (maybe wrong) that as there is no a MLST entry it was not
> exported, but maybe one of those already contains the info? Or, should I expect
> a MLST entry here?
> 
> > What makes these attributes "special" from any other ACPI method?
> > 
> 
> I can't answer this question right now. I need to investigate more I guess ;-)

You can always ask the acpi developers as well, you need to get their
review for your driver anyway :)

good luck!

greg k-h
