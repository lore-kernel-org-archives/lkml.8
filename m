Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D661BC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5EA217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="COMnqp80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgAUQOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:14:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43886 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728904AbgAUQOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:14:17 -0500
Received: from zn.tnic (p200300EC2F0B04005DFF86DD2C9B2FA6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:400:5dff:86dd:2c9b:2fa6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D4311EC0C82;
        Tue, 21 Jan 2020 17:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579623256;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=xZz0Fg5CoEy6kLuVioKwcLAJmKwf0QEyyMcuqrMgQMw=;
        b=COMnqp80spr3Ypa6XeFuS921Gag6Z3I2vBkFaXdnKFjafRrABF/7x3EihNLFXKV8y6T47Z
        XNYgZMwfdgiUXtrnwatiugq0pMpM9JBTPN+08ugsrND32IwOxIM5VDX3RrO6orBqc38xSd
        KK8dltxPxMZ7wwd6e7dK3DgpK3Re0EA=
Date:   Tue, 21 Jan 2020 17:14:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] x86/speculation: Clarify Spectre-v2 mitigation when
 STIBP/IBPB features are unsupported
Message-ID: <20200121161412.GL7808@zn.tnic>
References: <20200121160257.302999-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121160257.302999-1-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 05:02:57PM +0100, Vitaly Kuznetsov wrote:
> When STIBP/IBPB features are not supported (no microcode update,
> AWS/Azure/... instances deliberately hiding SPEC_CTRL for performance
> reasons,...) /sys/devices/system/cpu/vulnerabilities/spectre_v2 looks like
> 
>   Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
> 
> and this looks imperfect. In particular, STIBP is 'disabled' and 'IBPB'
> is not mentioned while both features are just not supported. Also, for
> STIBP the 'disabled' state (SPECTRE_V2_USER_NONE) can represent both
> the absence of hardware support and deliberate user's choice
> (spectre_v2_user=off)
> 
> Make the following adjustments:
> - Output 'unsupported' for both STIBP/IBPB when there's no support in
>   hardware.
> - Output 'unneeded' for STIBP when SMT is disabled/missing (and this
>   switch_to_cond_stibp is off).
> 
> RFC. Some tools out there may be looking at this information so by
> changing the output we're breaking them. Also, it may make sense to
> separate kernel and userspace protections and switch to something like
> 
>   Mitigation: Kernel: Full generic retpoline, RSB filling; Userspace:
>    Vulnerable
> 
> for the above mentioned case.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  Documentation/admin-guide/hw-vuln/spectre.rst | 3 +++
>  arch/x86/kernel/cpu/bugs.c                    | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

There's another attempt to fix similar aspects of this whole deal going
on ATM:

https://lkml.kernel.org/r/20191229164830.62144-1-asteinhauser@google.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
