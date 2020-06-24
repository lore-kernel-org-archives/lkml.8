Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F57C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE0920885
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 09:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbgFXJiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 05:38:52 -0400
Received: from foss.arm.com ([217.140.110.172]:53582 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbgFXJiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 05:38:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD8111FB;
        Wed, 24 Jun 2020 02:38:51 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68A463F73C;
        Wed, 24 Jun 2020 02:38:50 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:38:48 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     Steven Price <steven.price@arm.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 0/2] MTE support for KVM guest
Message-ID: <20200624093846.GA11863@gaia>
References: <20200617123844.29960-1-steven.price@arm.com>
 <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Myn_QEjfk4Ka604PDAUAWXs6dLUY5bEQ98C__oMsmhA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:05:07PM +0100, Peter Maydell wrote:
> On Wed, 17 Jun 2020 at 13:39, Steven Price <steven.price@arm.com> wrote:
> > These patches add support to KVM to enable MTE within a guest. It is
> > based on Catalin's v4 MTE user space series[1].
> >
> > [1] http://lkml.kernel.org/r/20200515171612.1020-1-catalin.marinas%40arm.com
> >
> > Posting as an RFC as I'd like feedback on the approach taken.
> 
> What's your plan for handling tags across VM migration?
> Will the kernel expose the tag ram to userspace so we
> can copy it from the source machine to the destination
> at the same time as we copy the actual ram contents ?

Qemu can map the guest memory with PROT_MTE and access the tags directly
with LDG/STG instructions. Steven was actually asking in the cover
letter whether we should require that the VMM maps the guest memory with
PROT_MTE as a guarantee that it can access the guest tags.

There is no architecturally visible tag ram (tag storage), that's a
microarchitecture detail.

-- 
Catalin
