Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE62C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9287A2078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588833708;
	bh=ZfGZjSQzlxql6JrfYK2CjpWc5gUaW3O8isNZHL1cHgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xmSOi6/qTNzXQ7IJfN/0OWfhtjtdLGbZBejgRn46f7IswF1xASG6803TaaadK4Q4o
	 Z2/0jsEiXvZ/CJM7txWhuhdgcxEifUxZsvATXWqX9JA9tPAwO5IBJPLgzbZAo2hXDX
	 nzP1thcfNTqrjdxhxr3MDNRYJPmtshPXrqViyqJU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgEGGls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:41:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgEGGlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:41:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9141F20753;
        Thu,  7 May 2020 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588833707;
        bh=ZfGZjSQzlxql6JrfYK2CjpWc5gUaW3O8isNZHL1cHgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M09WcW1KjQjAJdPTQm0zozAA6/w6JqJ+af+Z9XAf7SHLgvMuh64pWlYzK/VnpMS6I
         mP1uw8407EQPHb2GkFDezqjut6jLHEnsLov8p1RWeNzwruCy100T1i2lCe8MECNhi1
         b2/yksuqVxBEj5B6xSJeLVCPdSnxRKp54DYlAR24=
Date:   Thu, 7 May 2020 08:41:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Alan Cooper <alcooperx@gmail.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v6 3/4] usb: ehci: Add new EHCI driver for Broadcom STB
 SoC's
Message-ID: <20200507064145.GB777100@kroah.com>
References: <20200430111258.6091-1-alcooperx@gmail.com>
 <20200430111258.6091-4-alcooperx@gmail.com>
 <20200505110036.GB93160@kroah.com>
 <CAOGqxeXboYz2OQhgJsYmH5_7qEwKeWR5AA4Ljq_iFdSX=H2fkA@mail.gmail.com>
 <CAHp75VeA8JnsJgEgkv0wivinsxvk51JTVyaPhmLhsjzkqZYR8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeA8JnsJgEgkv0wivinsxvk51JTVyaPhmLhsjzkqZYR8A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 12:01:16AM +0300, Andy Shevchenko wrote:
> On Wed, May 6, 2020 at 11:23 PM Alan Cooper <alcooperx@gmail.com> wrote:
> > On Tue, May 5, 2020 at 7:00 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Thu, Apr 30, 2020 at 07:12:57AM -0400, Al Cooper wrote:
> 
> ...
> 
> > > > +     /* Hook the hub control routine to work around a bug */
> > >
> > > What bug?  This feels wrong.
> >
> > The bug is explained in a comment above the ehci_brcm_hub_control()
> > routine as follows:
> > /*
> >  * ehci_brcm_hub_control
> >  * Intercept echi-hcd request to complete RESUME and align it to the start
> >  * of the next microframe.
> >  * If RESUME is complete too late in the microframe, host controller
> >  * detects babble on suspended port and resets the port afterwards.
> >  * This s/w workaround allows to avoid this problem.
> >  * See SWLINUX-1909 for more details
> >  */
> > I'll remove the internal bug tracking reference from the comment.
> 
> I guess you may leave the internal bug reference. I can tell from my
> experience that's hard to understand what was going on in the driver
> in years perspective. It will help whoever in this company have a
> chance to look after the driver.

"internal bug references" mean nothing to the 99% of the people that can
see this.  Document the heck out of what this is instead please.

greg k-h
