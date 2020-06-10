Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3E72078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgFJIKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:10:23 -0400
Received: from foss.arm.com ([217.140.110.172]:54400 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgFJIKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:10:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE6251F1;
        Wed, 10 Jun 2020 01:10:21 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BAA883F6CF;
        Wed, 10 Jun 2020 01:10:18 -0700 (PDT)
Date:   Wed, 10 Jun 2020 09:10:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        tabba@google.com, qwandor@google.com, ardb@kernel.org
Subject: Re: [RFC PATCH 0/3] firmware: Add support for PSA FF-A interface
Message-ID: <20200610081011.GA2689@bogus>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200604133746.GA2951@willie-the-truck>
 <20200609174123.GA5732@bogus>
 <20200610075711.GC15939@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610075711.GC15939@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Wed, Jun 10, 2020 at 08:57:12AM +0100, Will Deacon wrote:
> Hi Sudeep,
>
> On Tue, Jun 09, 2020 at 06:41:23PM +0100, Sudeep Holla wrote:

[...]

> >
> > Agreed, I added for RxTx buffers and initially to build the parent/child
> > hierarchy for all users of the driver. Initially I was assuming only
> > in-kernel users and now I agree we should avoid any in kernel users if
> > possible.
> >
> > One thing to note FFA_PARTITION_INFO_GET relies on Rx buffers to send the
> > information to the caller. So we need to have established buffers before
> > that and one of the reason you don't find that in this RFC. I dropped that
> > too which I wanted initially.
>
> Ok, sounds like we should at least get to a position where we can enumerate
> things, though.
>

Yes.

[...]

> >
> > OK, IIUC that covers mostly KVM implementation. We still need a way to
> > share the RxTx buffer info to the partitions and DT/ACPI(?) is one
> > possible way. Based on you comment about not needing DT node, do you have
> > any other way to communicate the buffer info to the partitions ?
>
> This is only a concern if KVM chooses to provide the Rx/Tx buffer pair
> though, right? If we punt that down the road for the moment, then we can
> just rely on FFA_RXTX_MAP for now.
>

Ah OK, I was under the assumption that we didn't want to use FFA_RXTX_{,UN}MAP

[...]

> >
> > I am confused a bit. When you refer drivers above, are you referring to
> > drivers in host kernel(hypervisor) or in the partitions. I fail to
> > imagine need for the former.
>
> I'm referring to in-kernel users in the host kernel. For KVM-managed guests,
> we may not need these, although signalling things like system shutdown might
> be better off done without relying on userspace. But my point is really that
> separating the buffer management from the users means we can serialise
> consumers, whether they are in-kernel or out in userspace.
>

Understood.

> > > What do you think, and do you reckon you can spin a cut-down driver that
> > > implements the common part of the logic (since I know you've written much
> > > of this code already)?
> > >
> >
> > I am not sure if I am aligned with your thoughts on the buffer sharing
> > yet.
>
> Ok, please let me know if you have any more questions.
>

None ATM. As I mentioned I had ruled out RXTX_{,UN}MAP which was my
misunderstanding.

--
Regards,
Sudeep
