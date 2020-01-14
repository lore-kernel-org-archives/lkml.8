Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B504AC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D53F2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579020350;
	bh=rH/RDxa3aDON1h6odC8ATdFjCaRm+9u0dtk/K0hiIXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=idhJ/EAWOw4DDqaaXDHdDhhvXIQpuopj9BjGj3LKTseAcze0P/8rubK/s6wROZIvT
	 Dukgr5KM73dCdjR4UkcfxP75GyHiGs7o9yJAj/oGlutlbNieEDJrtpje60/3i/0Wkf
	 0exRW0ZQ50Jy3ddTTP6jCj8aWtzZy1czrb139TuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgANQpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:45:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:41656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANQpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:45:49 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61ED72075B;
        Tue, 14 Jan 2020 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579020349;
        bh=rH/RDxa3aDON1h6odC8ATdFjCaRm+9u0dtk/K0hiIXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hmsaowv+R3R8eS752gOgWAxq6ARtQoXDTAs36J0Y07vEKJc1daHBkPor8BVcONK6I
         Uvz3JrLvGLDQqzFaa7XbpaR6i4AK5K8hPJZai1epyL7ftf4czsPSdaZnFPfRtTuz1R
         s5XgCnLah2e0bPTkqUvV384qlEgPKXqID8lB+H/c=
Date:   Tue, 14 Jan 2020 16:45:44 +0000
From:   Will Deacon <will@kernel.org>
To:     Steven Price <steven.price@arm.com>, maz@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v5 0/3] arm64: Workaround for Cortex-A55 erratum 1530923
Message-ID: <20200114164543.GD2579@willie-the-truck>
References: <20191216115631.17804-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216115631.17804-1-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 11:56:28AM +0000, Steven Price wrote:
> Version 5 is a rebasing of version 4 (no changes).
> 
> This series enables a workaround for Cortex-A55 erratum 1530923. The
> erratum potentially allows TLB entries to be allocated as a result of a
> speculative AT instruction. This may happen in the middle of a guest
> world switch while the relevant VMSA configuration is in an inconsistent
> state, leading to erroneous content being allocated into TLBs.
> 
> There are existing workarounds for similar issues, 1165522 is
> effectively the same, and 1319367/1319537 is similar but without VHE
> support.  Rather than add to the selection of errata, the first patch
> renames 1165522 to WORKAROUND_SPECULATIVE_AT which can be reused (in the
> final patch) for 1530923.
> 
> The workaround for errata 1319367 and 1319537 although similar cannot
> use VHE (not available on those CPUs) so cannot share the workaround.
> However, to keep some sense of symmetry the workaround is renamed to
> SPECULATIVE_AT_NVHE.
> 
> Changes since v4:
>  * Rebased to v5.5-rc1

Looks fine to me. Marc, are you ok with me queueing this via arm64 (that's
where the existing workarounds came from), or would you prefer to take them
via kvm-arm?

Will
