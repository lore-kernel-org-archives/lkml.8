Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55478C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3567B2065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgEPBRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 21:17:13 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47113 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726204AbgEPBRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 21:17:12 -0400
Received: (qmail 14004 invoked by uid 500); 15 May 2020 21:17:11 -0400
Date:   Fri, 15 May 2020 21:17:11 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] USB: EHCI: ehci-mv: fix less than zero
 comparisonof an unsigned int
Message-ID: <20200516011711.GA13833@rowland.harvard.edu>
References: <20200515165453.104028-1-colin.king@canonical.com>
 <20200515172121.GA5498@rowland.harvard.edu>
 <fec1e461-16f3-9d5f-bc23-129c71229b9d@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fec1e461-16f3-9d5f-bc23-129c71229b9d@cmss.chinamobile.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 07:23:42AM +0800, Tang Bin wrote:
> Hi Alan & Colin：
> 
> On 2020/5/16 1:21, Alan Stern wrote:
> > On Fri, May 15, 2020 at 05:54:53PM +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > The comparison of hcd->irq to less than zero for an error check will
> > > never be true because hcd->irq is an unsigned int.  Fix this by
> > > assigning the int retval to the return of platform_get_irq and checking
> > > this for the -ve error condition and assigning hcd->irq to retval.
> > > 
> > > Addresses-Coverity: ("Unsigned compared against 0")
> > > Fixes: c856b4b0fdb5 ("USB: EHCI: ehci-mv: fix error handling in mv_ehci_probe()")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > Thanks to Coverity for spotting this.  Any reason why it didn't spot
> > exactly the same mistake in the ohci-da8xx.c driver?
> 
> I just looked at the code and wondered whether it would be more appropriate
> to modify the header file "hcd.h".  Since 'irq' might be an negative, why
> not just modify the variables in the 'struct usb_hcd',  'unsigned int 
> irq'--> 'int irq'? After all, it's a public one.

I think the code in the drivers should be changed.  The reason is if 
platform_get_irq() returns a negative value, then that value should be 
what the probe function returns.

Alan Stern
