Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FC81C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7E921927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594714797;
	bh=y+kMcjwj62DUaai6UaM9R3NF5UPVqYjpo4MPe+fl5/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xwlvFD/1jlIPSL+uz4v3NS0+0K92h4bkJki/mVhJk4XI/CGwi5HtKtpMyZ6QKGqDo
	 MZ45X8KJKeV1kMKNI4RhOMiDMAj4u86f8/iNbQtxlVRGuWVQEpeVOQN7EnADEJ9Quu
	 Xsp6hq2uzJvqVN4k8zb9ESA10nuPdaicOz7K/2fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNITz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNITz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:19:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE03B21841;
        Tue, 14 Jul 2020 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594714795;
        bh=y+kMcjwj62DUaai6UaM9R3NF5UPVqYjpo4MPe+fl5/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EwN9vIxQSjaO9e8cUaJo+M3xEPCfTIwpe+D7LX6937JtKIX+pAe1YSSToA2FrjOt9
         BILjibwYsmo1ymsbfg8G9rGHEfj2UVC/9m9Np3VWOIAbcuAqD+976EzWmJBTPeUh6t
         AdZFrIsLB/+40Nck+WUu2TdBz3I+bLlgf4iFlT1k=
Date:   Tue, 14 Jul 2020 09:19:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Tomasz Nowicki <tn@semihalf.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, gregory.clement@bootlin.com,
        robh+dt@kernel.org, hannah@marvell.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        nadavh@marvell.com, linux-arm-kernel@lists.infradead.org,
        mw@semihalf.com
Subject: Re: [PATCH v3 0/4] Add system mmu support for Armada-806
Message-ID: <20200714081949.GA4516@willie-the-truck>
References: <20200702201633.22693-1-tn@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702201633.22693-1-tn@semihalf.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomasz,

On Thu, Jul 02, 2020 at 10:16:29PM +0200, Tomasz Nowicki wrote:
> There were already two versions of series to support SMMU for AP806,
> including workaround for accessing ARM SMMU 64bit registers.
> First [1] by Hanna Hawa and second [2] by Gregory CLEMENT.
> Since it got stuck this is yet another try. I incorporated the V2 comments,
> mainly by moving workaround code to arm-smmu-impl.c as requested.
> 
> For the record, AP-806 can't access SMMU registers with 64bit width,
> this patches split the readq/writeq into two 32bit accesses instead
> and update DT bindings.
> 
> The series was successfully tested on a vanilla v5.8-rc3 kernel and
> Intel e1000e PCIe NIC. The same for platform devices like SATA and USB.
> 
> [1]: https://lkml.org/lkml/2018/10/15/373
> [2]: https://lkml.org/lkml/2019/7/11/426

Do you have a v4 of this series? It looks like there were a few comments
left to address, but with that I can pick it up for 5.9.

Cheers,

Will
