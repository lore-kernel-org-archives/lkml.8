Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271CEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0C6D20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 12:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594900930;
	bh=7Iqze3aCKTzGVZ3weRCFFcPpfvMEeMQ6YLx2H6XwexA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q2ZowAYSEEEidcCQnAluxUZJhw2WxZlRX9N/wN7gFKlXPnHQBY5kXSkokD+89WdTf
	 wtSabFZYnsoG8GMlsJG0DY2fsRjPBGJippXUXuirUsGWt3qehq09o4/SApbz+Bx4dp
	 rPtz03i9Ho+Mpij6f5Y+U8aiudOSskPuvNtqO6PI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgGPMCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:02:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgGPMCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 08:02:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 103B820760;
        Thu, 16 Jul 2020 12:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594900928;
        bh=7Iqze3aCKTzGVZ3weRCFFcPpfvMEeMQ6YLx2H6XwexA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GHV4KnYsXxST+2z6LAqo10KTo00UVUVTgIiq9sBwY3Uho5g5NGlcbdJcI6TjYZvYb
         rI5dEhHh3U+SQcsxC7NecKQ34qblRCi7T6fXXsTq19Zb2P+3V2AZgv0z9Zk33DC3LI
         vUVjHrZwTvFC4TrJVLKNynFaXN2SxkT8kGyMHfV4=
Date:   Thu, 16 Jul 2020 13:02:03 +0100
From:   Will Deacon <will@kernel.org>
To:     robh+dt@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        Tomasz Nowicki <tn@semihalf.com>, hannah@marvell.com,
        gregory.clement@bootlin.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        nadavh@marvell.com, mw@semihalf.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
Message-ID: <20200716120202.GA7485@willie-the-truck>
References: <20200715070649.18733-1-tn@semihalf.com>
 <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159488817559.3788855.4350396507732052751.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:00:43PM +0100, Will Deacon wrote:
> On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
> > The series is meant to support SMMU for AP806 and a workaround
> > for accessing ARM SMMU 64bit registers is the gist of it.
> > 
> > For the record, AP-806 can't access SMMU registers with 64bit width.
> > This patches split the readq/writeq into two 32bit accesses instead
> > and update DT bindings.
> > 
> > [...]
> 
> Applied to will (for-joerg/arm-smmu/updates), thanks!
> 
> [1/3] iommu/arm-smmu: Call configuration impl hook before consuming features
>       https://git.kernel.org/will/c/6a79a5a3842b
> [2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
>       https://git.kernel.org/will/c/f2d9848aeb9f
> [3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
>       https://git.kernel.org/will/c/e85e84d19b9d

(note that I left patch 4 for arm-soc, as that's just updating .dts files)

Will
