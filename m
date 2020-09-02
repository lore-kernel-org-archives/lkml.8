Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E18CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14DEC20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y2GqRyjf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgIBQwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:52:22 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32828 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgIBQwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:52:21 -0400
Received: from zn.tnic (p200300ec2f0d7a00acdede37bac547d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:acde:de37:bac5:47d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DACA1EC0493;
        Wed,  2 Sep 2020 18:52:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599065540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=agIwxdotGavgVufm8ANMtee53aatZqrnYawgSob6eFk=;
        b=Y2GqRyjfLNTXQuTlPTxaGp+ZwJv27pxB4vLUxlBX8N4T0WRughh3gBbwJTXeWM+qMAZtIM
        T9Ni8FYGCoDo42PsL1/2CZBDEoowB7Aaq+jeFsUgZysm9kxiuUWO8zkLwtYJN8Jzep6lt0
        Ke/TsD4kT81Atku75LkW91oqTZQ03wo=
Date:   Wed, 2 Sep 2020 18:52:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902165216.GB21537@zn.tnic>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902154018.GA21537@zn.tnic>
 <5ef17179-7557-b609-2e72-20caa1369d46@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ef17179-7557-b609-2e72-20caa1369d46@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:25:17AM -0700, Dave Hansen wrote:
> Ugh.  I hate text parsers.  But, I do see what you're getting at.

That's why it'll be a simple one. Nothing fancy. I'm hoping the final
version would be somewhat readable to humans too.

> If we do this, I bet having each value on its own line, I bet this would
> be a bit less painful to parse.  It'll be a _bit_ harder to read, but
> not really.  Maybe:
>
> LEAF[07],SUBLEAF[00],EAX[31:0],max_value,	Max input value for supported
> subleafs
> LEAF[07],SUBLEAF[00],EBX[   0],FSGSBASE,
> RDFSBASE/RDGSBASE/WRFSBASE/WRGSBASE if 1.
> LEAF[07],SUBLEAF[00],EBX[   1],TSC_ADJUST,	IA32_TSC_ADJUST MSR is
> supported if 1.
> LEAF[07],SUBLEAF[00],EBX[   2],SGX,		Supports Intel® Software Guard
> Extensions (Intel® SGX Extensions) if 1.

Yeah, this was just a stupid example to start the conversation.

> I was *really* hoping that we could eventually feed kcpuid and the
> X86_FEATURE_* bits from the same source.

But X86_FEATURE_* won't be all bits in all CPUID leafs - only the ones the
kernel has enabled/use for/needs/...

Also you have CPUID fields which are multi-bit and which cannot be
X86_FEATURE_* things.

So you need a place which has the whole CPUID space and X86_FEATURE_*
simply cannot represent it all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
