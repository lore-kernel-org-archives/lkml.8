Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D21DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D516F214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 14:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579790110;
	bh=JNtixxJ/yw1iFwwAJ9ohnh46vXkDLO9OMR488psZi7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/SM8JES4pePhmPe7533jO3ypROPeKtdl5QmBVbCal7BFQQUhUwJ7Najl0jC3cCvC
	 uCLn4MdR1RDR8SGOWJdnRTkHSexNnf/MuLLYYhBvqiJ8J8Ffjz1RseVPZL8LmLGCM+
	 WScfn+b03dcgoza8QmLWn5xaNZzkTOwjArOVHPiA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgAWOfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:35:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAWOfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 09:35:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BAF2087E;
        Thu, 23 Jan 2020 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579790108;
        bh=JNtixxJ/yw1iFwwAJ9ohnh46vXkDLO9OMR488psZi7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0BsJ627kvWrt2CDSqPfrDlznsX+RCpuOBXBDDOxDvG++isOd/KeDDX6iSaEZtPmvG
         YRkdpadtdV/Obl9NJ3Dmn9Kd7PaJJW3s+dOrbPn8k/X/sGC1vy8sHxnObLD/1LjGMX
         WF8lClEQHLsDqE2aLHc1FlTqaHupTpHJm+0o42Y4=
Date:   Thu, 23 Jan 2020 14:35:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Julien Thierry <jthierry@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        catalin.marinas@arm.com
Subject: Re: [RFC v5 00/57] objtool: Add support for arm64
Message-ID: <20200123143503.GA19649@willie-the-truck>
References: <20200109160300.26150-1-jthierry@redhat.com>
 <20200121103025.GC11154@willie-the-truck>
 <400d402d-c964-6f0c-2954-6f6afcb94635@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400d402d-c964-6f0c-2954-6f6afcb94635@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 01:52:17PM +0000, Julien Thierry wrote:
> 
> 
> On 1/21/20 10:30 AM, Will Deacon wrote:
> > On Thu, Jan 09, 2020 at 04:02:03PM +0000, Julien Thierry wrote:
> > > This patch series is the continuation of Raphael's work [1]. All the
> > > patches can be retrieved from:
> > > git clone -b arm64-objtool-v5 https://github.com/julien-thierry/linux.git
> > 
> > [...]
> > 
> > >    objtool: arm64: Decode unknown instructions
> > >    objtool: arm64: Decode simple data processing instructions
> > >    objtool: arm64: Decode add/sub immediate instructions
> > >    objtool: arm64: Decode logical data processing instructions
> > >    objtool: arm64: Decode system instructions not affecting the flow
> > >    objtool: arm64: Decode calls to higher EL
> > >    objtool: arm64: Decode brk instruction
> > >    objtool: arm64: Decode instruction triggering context switch
> > >    objtool: arm64: Decode branch instructions with PC relative immediates
> > >    objtool: arm64: Decode branch to register instruction
> > >    objtool: arm64: Decode basic load/stores
> > >    objtool: arm64: Decode load/store with register offset
> > >    objtool: arm64: Decode load/store register pair instructions
> > >    objtool: arm64: Decode FP/SIMD load/store instructions
> > >    objtool: arm64: Decode load/store exclusive
> > >    objtool: arm64: Decode atomic load/store
> > >    objtool: arm64: Decode pointer auth load instructions
> > >    objtool: arm64: Decode load acquire/store release
> > >    objtool: arm64: Decode load/store with memory tag
> > >    objtool: arm64: Decode load literal
> > >    objtool: arm64: Decode register data processing instructions
> > >    objtool: arm64: Decode FP/SIMD data processing instructions
> > >    objtool: arm64: Decode SVE instructions
> > 
> > That's a lot of decoding logic which we already have in
> > arch/arm64/{kernel/insn.c,include/asm/insn.h}. I'd prefer to see this stuff
> > reused or generated from a single source, since it's really easy to get it
> > wrong, has a tendency to bitrot and is nasty to debug.
> > 
> 
> The thing is that the code in those files is mostly encoding logic
> (motivated by BPF) rather than decoding (except for the instruction that
> might be trapped, but these rarely overlap with instructions that objtools
> cares about). I agree that ideally the decoding/encoding should be under
> arch/arm64/lib, I was just a bit weary introducing a lot of decoding code
> under arch/arm64 that wouldn't even be used in kernel code.

Hmm, but kprobes decodes instructions somehow :p

Not saying you have to refactor everything, but I'd hope you could reuse
some of the aarch64_insn_is* and aarch64_insn_extract* functions at least.

Will
