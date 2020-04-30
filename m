Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCBAC8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4DE2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588240247;
	bh=2m/uMwubJU0+KIoLz1IiF/eJGyPbsWV2OVU8vrOQqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fDUi5tZPJDpEMtEKgdpqxh4qfc2QOG7eWTuCjcTS3y4tLToKJ4SWjjjLHdXeLE3SG
	 Ntr78YF9qBrI792M472HoJ8uX/MT4kdxGMAum7byrUybfAwu6XP1aq9IcHOeKGn0Ys
	 ts4D8Ozg8dKsNlxiWnPvdyyMOMR/Hu3EGUs5BiMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD3Juq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:35366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbgD3Juq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:50:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E8842082E;
        Thu, 30 Apr 2020 09:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588240245;
        bh=2m/uMwubJU0+KIoLz1IiF/eJGyPbsWV2OVU8vrOQqBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2NRs0g5xV7M8d3FZI52+oAVxuGVFjMu5w2Mtg08swn4HAuP9oO90gxHDaPWncU2UL
         LHZJg7J1RhAMhIQhXIHKyOLmHY9dQlwhRuRCVLx4RQskm5Pe4dqAJsLx2cEZ4Q1UHw
         DI8NdPhL4/nhgDpGR/qDoTIRy7rNQwpQDiXhw35A=
Date:   Thu, 30 Apr 2020 10:50:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: fix gcc-10 shift warning
Message-ID: <20200430095037.GA19932@willie-the-truck>
References: <20200429185657.4085975-1-arnd@arndb.de>
 <20200430090251.715f6bf0@why>
 <20200430082927.GA18615@willie-the-truck>
 <20200430193910.294842c4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430193910.294842c4@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 07:39:10PM +1000, Stephen Rothwell wrote:
> On Thu, 30 Apr 2020 09:29:28 +0100 Will Deacon <will@kernel.org> wrote:
> > On Thu, Apr 30, 2020 at 09:02:51AM +0100, Marc Zyngier wrote:
> > > On Wed, 29 Apr 2020 20:56:20 +0200
> > > Arnd Bergmann <arnd@arndb.de> wrote:
> > >   
> > > > Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
> > 
> > Happy to queue via arm64 for 5.8. Does that work for you, Arnd, or were you
> > planning to get this in sooner than that?
> 
> The commit that this fixes is in Andrew's patch series in linux-next,
> so it should just go in there.

Yes, you're right. Sorry for the noise.

Will
