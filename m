Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF60BC33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 914B52087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578764850;
	bh=pAmjWEdCP5LA7xsSoxAyVIGNh+qa3qU5TM4sWq9bl6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=khRRl5x7tjQyridl7DB9yWiLxRJHg1nChPxzxyLGlLZl1LMeRPd+Y8cT8irUknE4u
	 Rc3CW2WDS6dRN6xV3kUpgxN8w/NSEOkS7MRZs85qw56n0sIhN2IZDUE8Gidzqaq355
	 kTky0+qpuvxzppta8OaAkInNYnvsmuXXag8W3/fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730711AbgAKRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbgAKRr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:47:29 -0500
Received: from localhost (unknown [84.241.193.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9F7D2082E;
        Sat, 11 Jan 2020 17:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578764849;
        bh=pAmjWEdCP5LA7xsSoxAyVIGNh+qa3qU5TM4sWq9bl6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D8Ywu562Uv+ddKmbFmwdEObppVDak5G3azTl9j06W6RgaBoXZIW8bTaE2r4qs8ps9
         dv41b5Q0cDMt08MiLcmWtGwq0VxRyvRCKS82nFHCITZtqK2MHJfu/smK9ZTsCaDQQE
         elKDMYthQhGcFTVo5ZRPjepcX/39H/+W8t7U6r14=
Date:   Sat, 11 Jan 2020 18:44:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH 4.19 65/84] arm64: KVM: Trap VM ops when
 ARM64_WORKAROUND_CAVIUM_TX2_219_TVM is set
Message-ID: <20200111174450.GA394778@kroah.com>
References: <20200111094845.328046411@linuxfoundation.org>
 <20200111094910.328555272@linuxfoundation.org>
 <CA+G9fYtfuSAcSURcz+ehqPKXOodmn+SELn2rUKGkG-CUfE-2vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtfuSAcSURcz+ehqPKXOodmn+SELn2rUKGkG-CUfE-2vg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 06:00:19PM +0530, Naresh Kamboju wrote:
> On Sat, 11 Jan 2020 at 15:49, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > From: Marc Zyngier <marc.zyngier@arm.com>
> >
> > commit d3ec3a08fa700c8b46abb137dce4e2514a6f9668 upstream.
> >
> > In order to workaround the TX2-219 erratum, it is necessary to trap
> > TTBRx_EL1 accesses to EL2. This is done by setting HCR_EL2.TVM on
> > guest entry, which has the side effect of trapping all the other
> > VM-related sysregs as well.
> >
> > To minimize the overhead, a fast path is used so that we don't
> > have to go all the way back to the main sysreg handling code,
> > unless the rest of the hypervisor expects to see these accesses.
> >
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> On stable-rc 4.19 all arm64 builds failed due to this error,
> 
> arch/arm64/kvm/hyp/switch.c: In function 'handle_tx2_tvm':
> arch/arm64/kvm/hyp/switch.c:438:2: error: implicit declaration of
> function '__kvm_skip_instr'; did you mean 'kvm_skip_instr'?
> [-Werror=implicit-function-declaration]
>   __kvm_skip_instr(vcpu);
>   ^~~~~~~~~~~~~~~~
>   kvm_skip_instr
> cc1: some warnings being treated as errors
> scripts/Makefile.build:303: recipe for target
> 'arch/arm64/kvm/hyp/switch.o' failed
> 
> Full build log,
> https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-stable-rc-4.19/DISTRO=lkft,MACHINE=hikey,label=docker-lkft/413/consoleText
> 

Crap, this one patch has caused more problems...

I'll go drop it, thanks for verifying that I shouldn't have backported
it in the first place :)

greg k-h
