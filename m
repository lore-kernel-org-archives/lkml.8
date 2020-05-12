Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D99C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65289206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589294691;
	bh=5Txyk5jDqYEDq3T12UeygI410GLM53+4ZLa7xxU31Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nkVNNlmOlTvNV4dHTW5g6nPuxFJDaxoPKmzZriVdNWI56ODXrPFfS5ipv9+lUbT7a
	 pyFthkzhglNXseghABGYZzISL1ImAwM2LhG9cEdQZ+1zSogKQNpngoVksluAzANqQf
	 dKjFDrC0OgVCsTdsvDWlXExs4VJomJe2n/vKUwow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgELOou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgELOou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:44:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0406B206A3;
        Tue, 12 May 2020 14:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589294689;
        bh=5Txyk5jDqYEDq3T12UeygI410GLM53+4ZLa7xxU31Mo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tSnjBkTpC3wOzSungT0wQnY9tEaY9JAStcEx7QthAi+E2bpavkqPqj5YKrGXxsc4C
         in5FkG80Yj772KlSsmXXrclibSyvjWbf3mROF2Mj1cSk6kutdJ4gkdhHrxRAwt2eUG
         5pNfmceQgPHCVf1TxAENp7sC/2dMCixjnDsMCovA=
Date:   Tue, 12 May 2020 15:44:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: cpufeature: Add "or" to mitigations for multiple
 errata
Message-ID: <20200512144445.GE3021@willie-the-truck>
References: <20200512124238.28792-1-geert+renesas@glider.be>
 <20200512141200.GD3021@willie-the-truck>
 <CAMuHMdXM5GGXvxEemmLtcTU14nKgKVmO_yON+7+pLnUv2oExtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXM5GGXvxEemmLtcTU14nKgKVmO_yON+7+pLnUv2oExtQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 04:38:19PM +0200, Geert Uytterhoeven wrote:
> On Tue, May 12, 2020 at 4:12 PM Will Deacon <will@kernel.org> wrote:
> > On Tue, May 12, 2020 at 02:42:38PM +0200, Geert Uytterhoeven wrote:
> > > Several actions are not mitigations for a single erratum, but for
> > > multiple errata.  However, printing a line like
> > >
> > >     CPU features: detected: ARM errata 1165522, 1319367, 1530923
> > >
> > > may give the false impression that all three listed errata have been
> > > detected.  This can confuse the user, who may think his Cortex-A57 is
> > > suddenly affected by Cortex-A76 and Cortex-A55 errata.
> > >
> > > Add "or" to all descriptions for mitigations for multiple errata, to
> > > make it clear that only one or more of the errata printed are
> > > applicable, and not necessarily all of them.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > >  arch/arm64/kernel/cpu_errata.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > This seems to conflict with the other patch you sent to reorder the entries.
> 
> My reordering applied to the Kconfig file.

Sorry, you're right. Your patch didn't apply on top of that, so I wrongly
assumed that it was the culprit.

> > Please can you send another version, based on the arm64 for-next/kconfig
> > branch?
> 
> Then it will conflict with commit 02ab1f5018c3ad0b ("arm64: Unify
> WORKAROUND_SPECULATIVE_AT_{NVHE,VHE}") from for-next/kvm/errata?

Ah, that's ok. I recreate for-next/core so I have flexibility in dropping
branches if they cause problems. Please can you send a version against
for-next/kconfig, and I'll handle the conflict now that you've pointed it
out/

Cheers,

Will
