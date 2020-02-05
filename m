Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C739C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614AA21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580916047;
	bh=NjMtCH7e1lEgkw+UMOfnxM45wLLuwDnPbf87CRI+yiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sG899fqdf1Y1rKN4yQDJC6wzqR+CqPe80C5vCMKOcDuCh9jyvTYQv/AjRUmwNRSDW
	 3+QvZbAOpQ629SMIaDMfO4rIvx07k0frRq8ehCj0K1kBzjhDwT4sgc3YZxppg2sxYA
	 GaWu6gN+7ZqYC5njf1PyfVNO3Ppd25m5y+QZgO38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBEPUq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:20:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:53676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgBEPUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:20:46 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DEF921927;
        Wed,  5 Feb 2020 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580915887;
        bh=NjMtCH7e1lEgkw+UMOfnxM45wLLuwDnPbf87CRI+yiM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pk1qMj98DbqsrY9zinX98tPIosYlQDmFJUfNGjO3f6+6PUDmBrZ3KqEah87F3scC0
         A1zO+7lBUSwfFGjGeEKJJwsFgqbdslcWmf+Hb9mMb3wLN0DG1KOztvq+G+MxaIkyjZ
         LVqEpHPTFP1i9aw0NG1O15O7yOs2MJCHGlvPwQ8o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1izMRJ-0039cd-Dy; Wed, 05 Feb 2020 15:18:05 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 05 Feb 2020 15:18:05 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm/arm64: Fix up includes for trace.h
In-Reply-To: <20200205134146.82678-1-jcline@redhat.com>
References: <20200205134146.82678-1-jcline@redhat.com>
Message-ID: <e3446187abb20eb2a95eae1f51b36ca1@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: jcline@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05 13:41, Jeremy Cline wrote:
> Fedora kernel builds on armv7hl began failing recently because
> kvm_arm_exception_type and kvm_arm_exception_class were undeclared in
> trace.h. Add the missing include.
> 
> Signed-off-by: Jeremy Cline <jcline@redhat.com>
> ---
> 
> I've not dug very deeply into what exactly changed between commit
> b3a608222336 (the last build that succeeded) and commit 14cd0bd04907,
> but my guess was commit 0e20f5e25556 ("KVM: arm/arm64: Cleanup MMIO
> handling").
> 
> Fedora's build config is available at
> https://src.fedoraproject.org/rpms/kernel/blob/master/f/kernel-armv7hl-fedora.config

This config doesn't have KVM enabled.

> 
>  virt/kvm/arm/trace.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
> index 204d210d01c2..cc94ccc68821 100644
> --- a/virt/kvm/arm/trace.h
> +++ b/virt/kvm/arm/trace.h
> @@ -4,6 +4,7 @@
> 
>  #include <kvm/arm_arch_timer.h>
>  #include <linux/tracepoint.h>
> +#include <asm/kvm_arm.h>
> 
>  #undef TRACE_SYSTEM
>  #define TRACE_SYSTEM kvm

After enabling KVM in the above config (which requires LPAE), I've 
managed to reproduce
the problem.

Fix now queued, thanks.

         M.
-- 
Jazz is not dead. It just smells funny...
