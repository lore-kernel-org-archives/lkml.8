Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B988920707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592222157;
	bh=AO7AE4H28zPxTT7UHp3OpiQhDU8PH5d+mG1D/8R7SwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UyAApKZixq/C4qmcgZDfh+PorHKr2m2PHs71dW6OX0ZsmUVh9uAB2YLAsfHtNtDiq
	 tsjejVIihdlo7Cu7aarAYVvYBTknRORAgEpgcTg9l9X16anwk1ebs5zeqLN3MYFqCK
	 bY3xkSPzBFXbzS3rXda0etbktrd5tdghvKS9iK2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgFOLz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:55:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729630AbgFOLzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:55:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10F7F20707;
        Mon, 15 Jun 2020 11:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592222154;
        bh=AO7AE4H28zPxTT7UHp3OpiQhDU8PH5d+mG1D/8R7SwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvzQqPQA3BQ1OLRePjsqrdXDVTmCHirBImXPywATw+TELdMrEIE9m+qbuGqLkMtSI
         awSxXXgOxwAKHGYVeID31HizncxE8uNnVDdmjVGRdfvDS9FpPav4KTqnzQRK3W2Rbr
         ufdyXiqS8JkFdaMr+FFK+/vlwf9rTPYhSHlM5AhU=
Date:   Mon, 15 Jun 2020 12:55:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Achin Gupta <achin.gupta@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200615115549.GB2694@willie-the-truck>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
 <20200611171222.GB7725@willie-the-truck>
 <20200615091639.GD46361@C02TC1ARHF1T>
 <20200615095133.GA2477@willie-the-truck>
 <20200615114220.GE46361@C02TC1ARHF1T>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615114220.GE46361@C02TC1ARHF1T>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:42:20PM +0100, Achin Gupta wrote:
> On Mon, Jun 15, 2020 at 10:51:34AM +0100, Will Deacon wrote:
> > On Mon, Jun 15, 2020 at 10:16:39AM +0100, Achin Gupta wrote:
> > > Right! FFA_PARTITION_INFO_GET is meant to help the FF-A driver in the kernel to
> > > determine partition properties. It assumes that EL2 SW has already read each
> > > partition's manifest and will reply to this ABI.
> > >
> > > IIUC, with protected KVM, this information will have to be a part of the
> > > manifest that the KVM host consumes.
> >
> > The host does not consume the manifest directly -- instead, the bootloader
> > will use the manifest to populate these DT nodes. Again, these are *only*
> > for non-secure virtual partitions which are to be managed by KVM.
> 
> Yes. Understand and agree. Manifest is an overloaded term. I was using it to
> describe the DT nodes that the host will consume.

Hmm, I think that conflates two things though because only the partitions
managed by KVM will have DT nodes.

> > > Separate topic, protected KVM does not get dibs on the manifest and it relies on
> > > the KVM host to specify the address ranges for each partition? Does this not
> > > mean that the KVM host can control the physical address space each partition
> > > sees. This seems contrary to the isolation guarantees that protected KVM must
> > > provide?
> >
> > The host is trusted during early boot, and gives up this trust after
> > initialising EL2 fully. So roughly speaking, we:
> >
> > 	* Boot at EL2 and install a shim
> > 	* Drop down to EL2 and start the host kernel
> > 	* Before some initialisation (DT parsing, SMP bringup, etc)
> > 	* Init KVM by calling back up to EL2 to install the full hypervisor
> >
> > At that point, the EL1 host is no longer trusted and the last call
> > effectively "locks it out" from EL2.
> 
> Ok. Protected KVM (PKVM) must create S2 tables when asked to setup a partition
> by the Host. My main concern is if PKVM must trust the Host to provide the
> correct physical address space ranges for a partition?

Yes, but that all happens as part of KVM initialisation: the host parses
the DT nodes and memory reservations, and then passes this information
up to EL2.

> I guess your point is this is not a problem since PKVM can lock the Host out of
> those address ranges in any case?

It has to do this, regardless of how they are probed. Once KVM has
initialised, the host will have a stage-2 which limits it to the memory that
it is allowed to access.

> It is a bit counter intuitive that the Host gets to see and potentially
> manipulate information that was verified and extracted by the bootloader from
> the partition's manifest. This hapens before PKVM sees the same
> information. Can't put my finger on what could go wrong though. Depends upon the
> threat model too!

I think you're trying too hard to separate the host from the EL2 code during
early boot. Don't forget -- this is all part of the same binary payload that
is loaded and initially run at EL2. Having the host take care of early boot
/significantly/ reduces the amount of code at EL2, which has a very
clear security benefit.

Will
