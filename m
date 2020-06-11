Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34655C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A6A20829
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591895550;
	bh=+n3fYC/9iagTFJHZVyX/Y73W3bVcAjcHk8YWZHr8tLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=g3b0VlYd9Y2UY2IjalySappkZerWwIZRVhxGjldS4RmO4zY+LqDLCqPj7nDLkAVX5
	 tRvBnBVvFukIEgMTzGReBXZ3Te18WtvLmhn0RQovbn64CXfziv9i/Bwqf1i7RQ37yH
	 2xu2zeyriNFyYNxicK8T9dTM3QOj3H5g8zvG2Uj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgFKRM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgFKRM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:12:28 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EC3C207ED;
        Thu, 11 Jun 2020 17:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591895547;
        bh=+n3fYC/9iagTFJHZVyX/Y73W3bVcAjcHk8YWZHr8tLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIYDmLV4pQ+VScpZK0j6FfcLG6yCMFfeNXbPGe37mo6Gd9wKibO+6WRRvordXe/y4
         b7RQfeNTNqboZp5k3o+YrkhuZgJW74VUEkPUofs2X+5C1xQFBV7AFodxsqZ+0G3eS+
         fYY8Ebx5XUE43Tmfz2xVOmZYnDDblbkkGOKYq78g=
Date:   Thu, 11 Jun 2020 18:12:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Achin Gupta <Achin.Gupta@arm.com>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200611171222.GB7725@willie-the-truck>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 03:46:35PM +0000, Achin Gupta wrote:
> > On 10 Jun 2020, at 08:43, Will Deacon <will@kernel.org> wrote:
> > On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> >> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> >>> Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> >>> at virtual interface(VMs).
> >>> 
> >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> >>> ---
> >>> .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> >>> 1 file changed, 47 insertions(+)
> >>> create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> >> 
> >> I'm hoping this goes away if the firmware is discoverable, but if not DT 
> >> bindings are DT schema now.
> > 
> > We'll need the binding for the kvm host side, because there are plenty
> > of partition properties that are not discoverable (e.g. number of vCPUs).
> 
> Just trying to understand the req. a bit better…
> 
> The FF-A driver in the host can use FFA_PARTITION_INFO_GET to determine
> the count of partitions and their vCPUs.
> 
> Is this about a guest being able to find out how many vCPUs it has? 

This is about KVM finding out the information it needs in order to spawn
non-secure partitions. I don't see how it can do that with
FFA_PARTITION_INFO_GET -- who would respond?

But you're right that number of vCPUs was a bad example. We also need
information such as the entry point.

Will
