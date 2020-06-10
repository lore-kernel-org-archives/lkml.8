Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B99C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A4420825
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591775033;
	bh=MJzP5c5PR6Tdbg5SV0+1atLygB5fnKjJ1WvlubG9GS4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AoPC/xPfs9h68f/HQvhsGQNtafchLCfC8nk9ZJtdjmkunJGxajcb8b9XkdzdOlJrH
	 ASH82cAaUht5q7pydAiLvvyd2ReswAaNRSU2Hr8OxGtRp/N7YwVlVPxt6Ginen/rDW
	 3zEn8KhYd4GPElyXiX35TTPMMezugJ+kuD3GTIM8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFJHnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:43:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:33212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbgFJHnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:43:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A7A9207ED;
        Wed, 10 Jun 2020 07:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591775031;
        bh=MJzP5c5PR6Tdbg5SV0+1atLygB5fnKjJ1WvlubG9GS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hf4+gnJDchJ4uO1MJWnvwmDIcd0y21EoTFChE6EaZZkEydefidjSqoYDeUwvTFisi
         Y81pimw4KmKJySeDSaS7iN4SvDD554JqQWgX+hP/nkJkpi29NqAQFYK8wtda4WVqpr
         /NUQE2lWjpPusrUcQB/evYER22xyO+ecj0qVgh8o=
Date:   Wed, 10 Jun 2020 08:43:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200610074346.GB15939@willie-the-truck>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609223551.GA1620273@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > at virtual interface(VMs).
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> 
> I'm hoping this goes away if the firmware is discoverable, but if not DT 
> bindings are DT schema now.

We'll need the binding for the kvm host side, because there are plenty
of partition properties that are not discoverable (e.g. number of vCPUs).

I'll have a go a yamlifying what I have...

Will
