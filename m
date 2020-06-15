Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A976C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15D9120738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592214701;
	bh=VQSsnQX35sR5TfD+RN9LG5tzaQw22yankU/+xU93cY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nrYU+qV3BqohK3bZ5z1WmvbelPVuw5b2cO3qaoPPoBxHG+BZf+rSlBtLES0XU9Bcs
	 UMwYTCyIYAtIYKxay7V0z9Rj0iW7/4FO80Od6j7/bMWns4o9j9FxCOW0jkwIBp/o10
	 Fp9d292QQLQRSXUCCsx3udijKpXuv2eC+qjQvrTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729335AbgFOJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:51:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOJvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:51:39 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473972068E;
        Mon, 15 Jun 2020 09:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592214698;
        bh=VQSsnQX35sR5TfD+RN9LG5tzaQw22yankU/+xU93cY4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQlHIN8i1uqF1tHVpoAL5v8g7CDhJAeOmA5A4ZAFG/9WAYr0bA3PhhvfkIL4Y7/Ou
         f9FQVRO5Ig4MDP3DfzPHGzWExA+gt3xKXnkuw3xtrvsmBqYDns3yZXwM6Ccwytdxom
         9D7nTIyyyknQuA1HM6+iRJOwaNtrKorByKA5bYhg=
Date:   Mon, 15 Jun 2020 10:51:34 +0100
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
Message-ID: <20200615095133.GA2477@willie-the-truck>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
 <20200611171222.GB7725@willie-the-truck>
 <20200615091639.GD46361@C02TC1ARHF1T>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615091639.GD46361@C02TC1ARHF1T>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:16:39AM +0100, Achin Gupta wrote:
> On Thu, Jun 11, 2020 at 06:12:23PM +0100, Will Deacon wrote:
> > On Thu, Jun 11, 2020 at 03:46:35PM +0000, Achin Gupta wrote:
> > > > On 10 Jun 2020, at 08:43, Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> > > >> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > > >>> Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > > >>> at virtual interface(VMs).
> > > >>>
> > > >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > >>> ---
> > > >>> .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> > > >>> 1 file changed, 47 insertions(+)
> > > >>> create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> > > >>
> > > >> I'm hoping this goes away if the firmware is discoverable, but if not DT
> > > >> bindings are DT schema now.
> > > >
> > > > We'll need the binding for the kvm host side, because there are plenty
> > > > of partition properties that are not discoverable (e.g. number of vCPUs).
> > >
> > > Just trying to understand the req. a bit better…
> > >
> > > The FF-A driver in the host can use FFA_PARTITION_INFO_GET to determine
> > > the count of partitions and their vCPUs.
> > >
> > > Is this about a guest being able to find out how many vCPUs it has?
> >
> > This is about KVM finding out the information it needs in order to spawn
> > non-secure partitions. I don't see how it can do that with
> > FFA_PARTITION_INFO_GET -- who would respond?
> 
> Right! FFA_PARTITION_INFO_GET is meant to help the FF-A driver in the kernel to
> determine partition properties. It assumes that EL2 SW has already read each
> partition's manifest and will reply to this ABI.
> 
> IIUC, with protected KVM, this information will have to be a part of the
> manifest that the KVM host consumes.

The host does not consume the manifest directly -- instead, the bootloader
will use the manifest to populate these DT nodes. Again, these are *only*
for non-secure virtual partitions which are to be managed by KVM.

> But then, can this be made discoverable (use a SMC for discovery) at all as Rob
> had originally suggested. Firmware (Secure world) has no clue and the bootloader
> is long gone.

Make what discoverable?

> Separate topic, protected KVM does not get dibs on the manifest and it relies on
> the KVM host to specify the address ranges for each partition? Does this not
> mean that the KVM host can control the physical address space each partition
> sees. This seems contrary to the isolation guarantees that protected KVM must
> provide?

The host is trusted during early boot, and gives up this trust after
initialising EL2 fully. So roughly speaking, we:

	* Boot at EL2 and install a shim
	* Drop down to EL2 and start the host kernel
	* Before some initialisation (DT parsing, SMP bringup, etc)
	* Init KVM by calling back up to EL2 to install the full hypervisor

At that point, the EL1 host is no longer trusted and the last call
effectively "locks it out" from EL2.

> > But you're right that number of vCPUs was a bad example. We also need
> > information such as the entry point.
> 
> Yes. From a spec perspective this should be specified in the partition manifest
> unless the base address of the loaded image can be assummed to be the entry
> point.

Right, but the format of the manifest isn't defined by the spec so I really
don't think it's something that Linux should be dealing with directly.

Will
