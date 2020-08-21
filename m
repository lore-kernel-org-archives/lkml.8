Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A07CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6F0207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OCwxbdk0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbgHUNNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:13:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47518 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgHUNNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:13:25 -0400
Received: from zn.tnic (p200300ec2f0eda00b8d46e5d5e13d656.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:da00:b8d4:6e5d:5e13:d656])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 860911EC03D5;
        Fri, 21 Aug 2020 15:13:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598015603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nHemKtTBp+NM9oPdX0rXMY4JjMfETVe/fnjU5artibA=;
        b=OCwxbdk0CrCVF9l2onxaXcC7nVpa1AE7JgfgabYTAhUXR26PcokdTRKhVdgwWUvHe/NLkd
        bkPoj2f8cVRoMQ7pkEFQtOct+hxDgxuoyQgRPoKNzY6kZ+MXndJtDIGKVGK4pN+Y7ACFYF
        tZvMDSgt50g96fNGf2O/3BJob9RVYyI=
Date:   Fri, 21 Aug 2020 15:13:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Kuo-Lang Tseng <kuo-lang.tsenng@intel.com>,
        Babu Moger <babu.moger@amd.com>, H Peter Anvin <hpa@zytor.com>,
        x86 <x86@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/resctrl: Enable user to view thread or core
 throttling mode
Message-ID: <20200821131306.GH12181@zn.tnic>
References: <1594921994-66192-1-git-send-email-fenghua.yu@intel.com>
 <1594921994-66192-3-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1594921994-66192-3-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:53:14AM -0700, Fenghua Yu wrote:
>  struct rdt_membw {
> -	u32		max_delay;
> -	u32		min_bw;
> -	u32		bw_gran;
> -	u32		delay_linear;
> -	bool		mba_sc;
> -	u32		*mb_map;
> +	u32				max_delay;
> +	u32				min_bw;
> +	u32				bw_gran;
> +	u32				delay_linear;
> +	enum membw_throttle_mode	arch_throttle_mode;

I guess "arch" is implicit so you can

s/arch_throttle_mode/throttle_mode/g

...

> +static struct rftype *rdtgroup_rftype_by_name(const char *name)

That function name needs a verb.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
