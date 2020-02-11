Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B745C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CD020873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581414851;
	bh=dZ6CUij+Y34KbHJA5uYdVJiJ5KihU8UAFU+V7kMs+eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BH/vloeJe5QkoYO3jNRold8s11hePmZqrxLrE/+G9jDBjsBRwg0NDUgZWQfNoBPCB
	 WpEZykAvzv52gbypRNHYtNbjB9HmV1qJ1RNpYXK1UMpjH/ZaOz13Y3SKwaGl0F1gTe
	 8fsj5wrJVVin9NnbBQNsWvrEDBwRj2avSp3m8Zrg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBKJyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:54:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:42404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBKJyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:54:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E938F20714;
        Tue, 11 Feb 2020 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581414849;
        bh=dZ6CUij+Y34KbHJA5uYdVJiJ5KihU8UAFU+V7kMs+eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPuXWwxpf67WBRCSd6gmmbHXBuqvSvmM7CL5fmZPWW/D8lxpA6mBLOiyCCe82Ondo
         3bLF5Mk0tp3wc7yciEiT9D+0q01TUCgH5co17XExIGf17qY4ndjc51TU5p8+1Z7yee
         ZmH+8o2VhBQKJpV1BsMvZ2mVsLoV5sPSz3ZIWmH4=
Date:   Tue, 11 Feb 2020 09:54:02 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     James Morse <james.morse@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 09/11] arm64: disable SCS for hypervisor code
Message-ID: <20200211095401.GA8560@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200128184934.77625-1-samitolvanen@google.com>
 <20200128184934.77625-10-samitolvanen@google.com>
 <6f62b3c0-e796-e91c-f53b-23bd80fcb065@arm.com>
 <20200210175214.GA23318@willie-the-truck>
 <20200210180327.GB20840@lakrids.cambridge.arm.com>
 <20200210180740.GA24354@willie-the-truck>
 <20200210182431.GC20840@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210182431.GC20840@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 06:24:32PM +0000, Mark Rutland wrote:
> On Mon, Feb 10, 2020 at 06:07:41PM +0000, Will Deacon wrote:
> > On Mon, Feb 10, 2020 at 06:03:28PM +0000, Mark Rutland wrote:
> > > On Mon, Feb 10, 2020 at 05:52:15PM +0000, Will Deacon wrote:
> > > > On Mon, Feb 10, 2020 at 05:18:58PM +0000, James Morse wrote:
> > > > > On 28/01/2020 18:49, Sami Tolvanen wrote:
> > > > > > Filter out CC_FLAGS_SCS and -ffixed-x18 for code that runs at a
> > > > > > different exception level.
> > > > > 
> > > > > Hmmm, there are two things being disabled here.
> > > > > 
> > > > > Stashing the lr in memory pointed to by VA won't work transparently at EL2 ... but
> > > > > shouldn't KVM's C code still treat x18 as a fixed register?
> > > > 
> > > > My review of v6 suggested dropping the -ffixed-x18 as well, since it's only
> > > > introduced by SCS (in patch 5) and so isn't required by anything else. Why
> > > > do you think it's needed?
> > > 
> > > When EL1 code calls up to hyp, it expects x18 to be preserved across the
> > > call, so hyp needs to either preserve it explicitly across a transitions
> > > from/to EL1 or always preserve it.
> > 
> > I thought we explicitly saved/restored it across the call after
> > af12376814a5 ("arm64: kvm: stop treating register x18 as caller save"). Is
> > that not sufficient?
> 
> That covers the hyp->guest->hyp round trip, but not the host->hyp->host
> portion surrounding that.

Thanks, I missed that. It's annoying that we'll end up needing /both/
-ffixed-x18 *and* the save/restore around guest transitions, but if we
actually want to use SCS for the VHE code then I see that it will be
required.

Sami -- can you restore -ffixed-x18 and then try the function attribute
as suggested by James, please?

Will
