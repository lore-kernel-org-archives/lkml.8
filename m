Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2548C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C412A207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589808378;
	bh=5FskDrF8oq9/EOjCgVOotNcKcTYNqGcjbricPQEpQ/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fkh56xH/9PEZ0eeuCL8sQt3OnUVnzeg+tOb3H2MlWVYQGaxzHIm6Iur5hnW5DEpiG
	 Y9Ne9Pg9THK2n13Daz6kZI/yDNk9Na1H9kLuDya5UpST4SUzD8DiaXC8N8MaFoKltP
	 875bq9W1rWzoDhGSqohQK9H7wwioCjYs4JJhRIKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgERN0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:56796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgERN0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:26:17 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACAC2065F;
        Mon, 18 May 2020 13:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589808377;
        bh=5FskDrF8oq9/EOjCgVOotNcKcTYNqGcjbricPQEpQ/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zCIecnvOcI+Vv5YVVR2Vajh2t4wob/ajUjiBgaLdFcuXc67GUl5guvg/ISR7QpnJo
         GUdEcyGNpNOkZr8060IV1Ew1pllcMUBppBLiQYwySYxMwQtthT8j3dL6PWc4LxGj4l
         T3ALbIiilt8cEiOsfCdv/qmTTkXhhlXJXjSAPOzI=
Date:   Mon, 18 May 2020 14:26:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 6/6] scs: Move DEFINE_SCS macro into core code
Message-ID: <20200518132612.GE32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-7-will@kernel.org>
 <20200518121441.GE1957@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518121441.GE1957@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:14:41PM +0100, Mark Rutland wrote:
> On Fri, May 15, 2020 at 06:27:56PM +0100, Will Deacon wrote:
> > Defining static shadow call stacks is not architecture-specific, so move
> > the DEFINE_SCS() macro into the core header file.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> I think that we'll have to pull this back into arch code if/when we deal
> with VMAP'd stacks, so I'm not sure this is worthwhile given the
> diffstat is balanced.

I dunno, if another architecture wants to use this then having the stuff
in the core code makes sense to me. I also want to kill asm/scs.h entirely
and move our asm macros somewhere else where they're not mixed up with the
C headers.

Will
