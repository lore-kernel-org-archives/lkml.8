Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C0C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976BF20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068601;
	bh=wcxIzuTzVTn+y2sipFMICNwET2WluJYqIFC8w3O8XNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lJC4K7IHFI4226J26M63cp2Rc3l+ZQHGIteXhR8OuS5ChWORpg2Abd5LovtLaybGr
	 Lr/UIR8lDdX+7sy8g0alzcMXWNi6hornTwpGyL/zGqwUJ9JQtvhtHzrMJzhnztOOwF
	 YLToIwJ+zbM12k1uZNQSNOYpOvxS1jPJtafPUEBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCXQuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:50:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgCXQuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:50:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76715206F6;
        Tue, 24 Mar 2020 16:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585068599;
        bh=wcxIzuTzVTn+y2sipFMICNwET2WluJYqIFC8w3O8XNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2DgxTnVK3EBOA8SEFXFKISPVuPZ7TZSQVWCt4udA1AuM3g/IIAqJFw8Qvqa2xmSUO
         d0UAyfJ3UsLDFz4LmfVf9h00L7f/o414LlKvWAt/RbJl/2IruJM43XzadCPCy+rH10
         npepld2sJHMyhSi28x5kaSdkIM8HT/nUrRBUjZNo=
Date:   Tue, 24 Mar 2020 17:49:56 +0100
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
Message-ID: <20200324164956.GE2518746@kroah.com>
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
 <20200322111022.GA72939@kroah.com>
 <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 05:31:10PM +0100, Enric Balletbo i Serra wrote:
> Hi Greg,
> 
> Many thanks for your quick answer, some comments below.
> 
> On 22/3/20 12:10, Greg Kroah-Hartman wrote:
> > On Sun, Mar 22, 2020 at 10:43:34AM +0100, Enric Balletbo i Serra wrote:
> >> This driver attaches to the ChromeOS ACPI device and then exports the values
> >> reported by the ACPI in a sysfs directory. The ACPI values are presented in
> >> the string form (numbers as decimal values) or binary blobs, and can be
> >> accessed as the contents of the appropriate read only files in the sysfs
> >> directory tree originating in /sys/devices/platform/chromeos_acpi.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > 
> > What is wrong with the "default" ACPI sysfs access?  Why do you need a
> > special driver just for this specific ACPI firmware?
> > 
> 
> Please correct me if I am wrong, as I'm not an ACPI expert and I probably have
> some ACPI leaks and misunderstandings.
> 
> What is exporting this driver is the attributes for the non-default Chromebook
> specific MLST ACPI method. Hence, I assumed we needed a special driver to expose
> these values that can't be done using "default" ACPI sysfs. Note that these
> attributes are dynamically created and are different between Chromebooks so need
> some parsing.
> 
> I didn't find a "standard" way to expose these attributes to userspace, so,
> please kindly point me to one if there is one.

Are you sure they aren't already there under /sys/firmware/acpi/?  I
thought all tables and methods were exported there with no need to do
anything special.

What makes these attributes "special" from any other ACPI method?

> >> +static int __init chromeos_acpi_init(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	chromeos_acpi.pdev = platform_device_register_simple("chromeos_acpi",
> >> +						PLATFORM_DEVID_NONE, NULL, 0);
> >> +	if (IS_ERR(chromeos_acpi.pdev)) {
> >> +		pr_err("unable to register chromeos_acpi platform device\n");
> >> +		return PTR_ERR(chromeos_acpi.pdev);
> >> +	}
> > 
> > Only use platform devices and drivers for things that are actually
> > platform devices and drivers.  That's not what this is, it is an ACPI
> > device and driver.  Don't abuse the platform interface please.
> > 
> 
> Ok. The purpose was to not break ChromeOS userspace since is looking for the
> attributes inside /sys/devices/platform/chromeos_acpi. Not a good reason, I
> know, and I assume we will need to change userspace instead, and convert this to
> a ACPI device and driver only, right?

How can any userspace be looking for anything that hasn't been submitted
before?  That's nothing to worry about, we don't have to support things
like that :)

> I'll investigate the different places in userspace where this is used and see
> how difficult it is to do the changes.

Look at /sys/firmware/acpi/ first please.

thanks,

greg k-h
