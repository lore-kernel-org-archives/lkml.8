Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5827BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3959B20657
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:44:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgERPoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:44:00 -0400
Received: from foss.arm.com ([217.140.110.172]:42968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERPoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:44:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61E0C101E;
        Mon, 18 May 2020 08:43:59 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CDB43F52E;
        Mon, 18 May 2020 08:43:58 -0700 (PDT)
Date:   Mon, 18 May 2020 16:43:55 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Oliver Neukum <oneukum@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb/ohci-platform: Fix a warning when hibernating
Message-ID: <20200518154355.qzur4fy6wowjarwp@e107158-lin.cambridge.arm.com>
References: <20200424134800.4629-1-qais.yousef@arm.com>
 <Pine.LNX.4.44L0.2004281459240.1555-100000@netrider.rowland.org>
 <20200518145748.puvxkcmyrxc7eqt7@e107158-lin.cambridge.arm.com>
 <20200518151940.GC15479@rowland.harvard.edu>
 <20200518153312.GA1963214@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518153312.GA1963214@kroah.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/20 17:33, Greg Kroah-Hartman wrote:
> On Mon, May 18, 2020 at 11:19:40AM -0400, Alan Stern wrote:
> > On Mon, May 18, 2020 at 03:57:49PM +0100, Qais Yousef wrote:
> > > > For both this patch and the 3/3 patch (ehci-platform):
> > > > 
> > > > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> > > 
> > > Thanks Alan. Did this make it through to any tree? I don't see it on next, nor
> > > on Linus. But it could be queued somewhere else.
> > > 
> > > I have sent v2 to patch 2 (xhci) as a reply, so hopefully it wasn't missed.
> > > I can resend the whole series if necessary.
> > 
> > Greg, what happened to this series?  Did it just fall through the 
> > cracks?
> 
> No idea, it's not in my to-review queue, so maybe it got merged
> somewhere?  If not, can someone resend it please?

Sure, I'll get it out ASAP.

Thanks

--
Qais Yousef
