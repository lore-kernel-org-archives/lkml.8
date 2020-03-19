Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1018FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D831E206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 20:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="BmY4+PFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgCSUKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 16:10:25 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32962 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgCSUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:10:25 -0400
Received: from zn.tnic (p200300EC2F0A85001D12B79F4268FE9A.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:1d12:b79f:4268:fe9a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25F441EC0C89;
        Thu, 19 Mar 2020 21:10:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584648623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=+HS0izfSYQQOnipoPaapcyspiM739Lng58jOQDsrp1s=;
        b=BmY4+PFyddycgep4N1QRA69Ah/4jgqcJGG8qR5Z1zqJ3e14DF8mf95hySlRL7G7UWNtz41
        EJiDhpHGju+qM+gSbrECSngmwzKiahVMnzGBQAzH2w9x8ci0lnmpzj+CA3c+ERzAacVC+j
        T5+HWwgbmeA84FVXdZVuQ/gztW5jy80=
Date:   Thu, 19 Mar 2020 21:10:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: timers/core] Revert "tick/common: Make tick_periodic()
 check for missing ticks"
Message-ID: <20200319201028.GF13073@zn.tnic>
References: <158464406295.28353.3230662958771714087.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <158464406295.28353.3230662958771714087.tip-bot2@tip-bot2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 06:54:22PM -0000, tip-bot2 for Thomas Gleixner wrote:
> The following commit has been merged into the timers/core branch of tip:
> 
> Commit-ID:     52da479a9aee630d2cdf37d05edfe5bcfff3e17f
> Gitweb:        https://git.kernel.org/tip/52da479a9aee630d2cdf37d05edfe5bcfff3e17f
> Author:        Thomas Gleixner <tglx@linutronix.de>
> AuthorDate:    Thu, 19 Mar 2020 19:47:06 +01:00
> Committer:     Thomas Gleixner <tglx@linutronix.de>
> CommitterDate: Thu, 19 Mar 2020 19:47:48 +01:00
> 
> Revert "tick/common: Make tick_periodic() check for missing ticks"
> 
> This reverts commit d441dceb5dce71150f28add80d36d91bbfccba99 due to
> boot failures.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Waiman Long <longman@redhat.com>
> ---
>  kernel/time/tick-common.c | 36 +++---------------------------------
>  1 file changed, 3 insertions(+), 33 deletions(-)

ACK, this fixes an early boot freeze on one of my boxes too.

Tested-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
