Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA9E2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ALBgDOjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389267AbgE0Oa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389033AbgE0Oaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:30:55 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325EDC05BD1E;
        Wed, 27 May 2020 07:30:55 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0b870090dfd18f578962de.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:90df:d18f:5789:62de])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77CFD1EC0318;
        Wed, 27 May 2020 16:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590589852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2LqA16cllcM9c+jwERRurW+RQE4oqz+AcFxnY1Ja6Rs=;
        b=ALBgDOjCCDNNPxAuvrg15Iz6Xx0Qb1XkjF/HdK4hSLHLhTzg2V9sr4JF2PRPXfpLxANBCJ
        9AajydRV7HDSivfoFQ9lSu/OKXe+Kth1J+xvSr78tXIBWUlieckIcX8bSkv4RI5V0BZxfv
        YKcTlsPdylVRZL5SQWVkfPHfRHBn8sk=
Date:   Wed, 27 May 2020 16:30:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/2] x86: Hide the archdata.iommu field behind generic
 IOMMU_API
Message-ID: <20200527143046.GB1721@zn.tnic>
References: <20200518120855.27822-1-krzk@kernel.org>
 <20200518120855.27822-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200518120855.27822-2-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:08:55PM +0200, Krzysztof Kozlowski wrote:
> There is a generic, kernel wide configuration symbol for enabling the
> IOMMU specific bits: CONFIG_IOMMU_API.  Implementations (including
> INTEL_IOMMU and AMD_IOMMU driver) select it so use it here as well.
> 
> This makes the conditional archdata.iommu field consistent with other
> platforms and also fixes any compile test builds of other IOMMU drivers,
> when INTEL_IOMMU or AMD_IOMMU are not selected).
> 
> For the case when INTEL_IOMMU/AMD_IOMMU and COMPILE_TEST are not
> selected, this should create functionally equivalent code/choice.  With
> COMPILE_TEST this field could appear if other IOMMU drivers are chosen
> but neither INTEL_IOMMU nor AMD_IOMMU are not.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  arch/x86/include/asm/device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/device.h b/arch/x86/include/asm/device.h
> index 7e31f7f1bb06..49bd6cf3eec9 100644
> --- a/arch/x86/include/asm/device.h
> +++ b/arch/x86/include/asm/device.h
> @@ -3,7 +3,7 @@
>  #define _ASM_X86_DEVICE_H
>  
>  struct dev_archdata {
> -#if defined(CONFIG_INTEL_IOMMU) || defined(CONFIG_AMD_IOMMU)
> +#ifdef CONFIG_IOMMU_API
>  	void *iommu; /* hook for IOMMU specific extension */
>  #endif
>  };

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
