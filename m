Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C834C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2AD20809
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589815996;
	bh=TyenBBcRlC7bHcDCgrQGTESSKFo/bxcfFo2JmDj2gPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fr47uEj+luFl9yxhKyHtR1D1X546QoGSCQBpbqe8gK1YQTJ8z52zMz/3XXSZRTofU
	 2uUfki/eerFRsaGOr9DEugpyPkRUGKvrRGb2k8P7Kk/4KHFQzhkSa0GJRlRM0Td4CL
	 Bc7JdOjP03jYm72B9gJEtQYdWL84EJ90Y9PX++ZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgERPdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:33:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERPdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:33:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 269B0207ED;
        Mon, 18 May 2020 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589815994;
        bh=TyenBBcRlC7bHcDCgrQGTESSKFo/bxcfFo2JmDj2gPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2bkezwy1Dc3M7HZgrw3dCxOGmxDcnV20LYmEDJpxoZlAjzDsoEut3EaU8jMFKnHH7
         9eO7bFr7vaIXSYWoj9XUc5T/0mtcMFZg0oDggYw7qupQHvTtJEOmou1pm00LR+XO+b
         gDN3m0O1mh9OPm14IdCrla7JnVoJlBC7DzuhojYA=
Date:   Mon, 18 May 2020 17:33:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb/ohci-platform: Fix a warning when hibernating
Message-ID: <20200518153312.GA1963214@kroah.com>
References: <20200424134800.4629-1-qais.yousef@arm.com>
 <Pine.LNX.4.44L0.2004281459240.1555-100000@netrider.rowland.org>
 <20200518145748.puvxkcmyrxc7eqt7@e107158-lin.cambridge.arm.com>
 <20200518151940.GC15479@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518151940.GC15479@rowland.harvard.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 11:19:40AM -0400, Alan Stern wrote:
> On Mon, May 18, 2020 at 03:57:49PM +0100, Qais Yousef wrote:
> > > For both this patch and the 3/3 patch (ehci-platform):
> > > 
> > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > 
> > Thanks Alan. Did this make it through to any tree? I don't see it on next, nor
> > on Linus. But it could be queued somewhere else.
> > 
> > I have sent v2 to patch 2 (xhci) as a reply, so hopefully it wasn't missed.
> > I can resend the whole series if necessary.
> 
> Greg, what happened to this series?  Did it just fall through the 
> cracks?

No idea, it's not in my to-review queue, so maybe it got merged
somewhere?  If not, can someone resend it please?

thanks,

greg k-h
