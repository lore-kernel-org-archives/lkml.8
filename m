Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6151C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF48121973
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="rQU9Z3DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD2SMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:12:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44908 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgD2SL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:11:57 -0400
Received: from zn.tnic (p200300EC2F0B95002CAA38EA2C11A9F5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:9500:2caa:38ea:2c11:a9f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D90501EC0CDA;
        Wed, 29 Apr 2020 20:11:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588183916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=axjw/GEGANJFfy0IqY7WI3SgF7XxKuwgsDRnXRuS/xQ=;
        b=rQU9Z3DMooY4/X/btqU5GD2O/BH5NqyzC0k7gABxrR/LLlGL07EPpUgD5Tio+9fwSyiktH
        pZGUidOuc93OTm6stOJp2V98adImUyIsQb3HdHJlZoHsHr5J0fFyrznk+AL/mi3ZmxtXRQ
        Yt1UmMn0hY2VpsmNYOxzGknldchMg5E=
Date:   Wed, 29 Apr 2020 20:11:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, babu.moger@amd.com,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] x86/resctrl: Support CPUID enumeration of MBM
 counter width
Message-ID: <20200429181149.GE16407@zn.tnic>
References: <cover.1585763047.git.reinette.chatre@intel.com>
 <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76dc65631c373e0c1c9f3e8aaa768f022a2c989c.1585763047.git.reinette.chatre@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 10:51:02AM -0700, Reinette Chatre wrote:
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 4cdb123ff66a..8552d2fadc15 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -856,6 +856,8 @@ static void init_speculation_control(struct cpuinfo_x86 *c)
>  
>  static void init_cqm(struct cpuinfo_x86 *c)
>  {
> +	c->x86_cache_mbm_width_offset = -1;
> +
>  	if (!cpu_has(c, X86_FEATURE_CQM_LLC)) {
>  		c->x86_cache_max_rmid  = -1;
>  		c->x86_cache_occ_scale = -1;
> @@ -875,6 +877,9 @@ static void init_cqm(struct cpuinfo_x86 *c)
>  
>  		c->x86_cache_max_rmid  = ecx;
>  		c->x86_cache_occ_scale = ebx;
> +		/* EAX contents is only defined for Intel CPUs */
> +		if (c->x86_vendor == X86_VENDOR_INTEL)
> +			c->x86_cache_mbm_width_offset = eax & 0xff;

Remind me again pls why is all this RDT stuff replicated per CPU instead
of it being properly detected somewhere down in resctrl_late_init()?

Looking at get_rdt_resources(), it kinda wants to have that in there
too?

IOW, how about moving all that gunk in init_cqm() to resctrl/ where it
truly belongs? Doesn't have to be this patchset but this patchset can
start moving it...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
