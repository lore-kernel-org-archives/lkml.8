Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6369BC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29DC524125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deYP7rvl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgAWEVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 23:21:38 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34310 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgAWEVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 23:21:37 -0500
Received: by mail-qk1-f195.google.com with SMTP id d10so2199263qke.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 20:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NJZYXNkYKZkhdbjX5VTpNG7GvBHLD7E4tbdC/yVx8LU=;
        b=deYP7rvlgkx32IcJceLZuj0sSiWVHVRHUx7qZ4xGiLi9L5FYOjJUzHAs/SPDn3vvpQ
         kPfuhw2DNt22KCx4y11E5O8Tphht2L86e8yUJWrTo0prf+Edu1wD6ooygvkZjKoXbDsR
         IvZI8ZuSBY3Y0z/KOTZnNv4AXBMUtOe7EqUZSL2RWiCym3BKq/QO0KF8YCEjfLhSaaOP
         OsXjGeZeVPopBghrhCaKnSa/EUrk6Bbd0gRGraq4G+7fa0AgXKUp6SkozaILFlA+npTU
         RkgOnNPgdTqIS59KehVsg2KhTQAmuWtdze/rKsATGkB8McGBVFTIM7yDvUbrYNXmcKoJ
         rpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NJZYXNkYKZkhdbjX5VTpNG7GvBHLD7E4tbdC/yVx8LU=;
        b=BT2rtgKrwVHf/CkJURo+Ts5rmkPWkgbuNaSwCFGLyxTUYl6q/EWOjBSxUJefg/DrTa
         Pfndy2iBXvKPhxwmgxefwpfSDHBaeE3wzhczVWNi9J5LwuqKXWbQrIaAeQloaail6fXB
         AvehPYLGF+HnlEnCea2Hj59h6tTsT6g+f7eseuK2h0h8Om9o/6+hH5250cqREjhau0tn
         mkGvUH4rqivKIFk+kT5aue1MBdgMxDfgsTp2SOz1d3wJgW8ygHD1YOPSRm2KoNbAD+ov
         1+nTsw4MunPGxGPNsPfLVeTfgDFaBO8qbUUVth91A89MmTfsGQH4+iGLuknHW1tEcw0W
         N7HQ==
X-Gm-Message-State: APjAAAXvDAYrdbu+aSkzKJjv3a6X6Vj8slDnr+IK8NrnAhsHZmInwEuk
        IDhfnOn2Bg3fBMJfayOls1M=
X-Google-Smtp-Source: APXvYqxAUasEVTs8HL635O+YWvWJJt0sYi2Li/KE/B/s8GBq9nMjPz6HsJr3dHnh55aFS8P3lR6F7A==
X-Received: by 2002:a05:620a:110c:: with SMTP id o12mr12806521qkk.66.1579753296212;
        Wed, 22 Jan 2020 20:21:36 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id b35sm409399qtc.9.2020.01.22.20.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 20:21:35 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 22 Jan 2020 23:21:33 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200123042132.GA2448175@rani.riverdale.lan>
References: <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
 <20200122224245.GA2331824@rani.riverdale.lan>
 <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123012317.GA21843@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200123012317.GA21843@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 05:23:17PM -0800, Luck, Tony wrote:
> On Wed, Jan 22, 2020 at 07:45:08PM -0500, Arvind Sankar wrote:
> > On Wed, Jan 22, 2020 at 11:24:34PM +0000, Luck, Tony wrote:
> > > >> +static enum split_lock_detect_state sld_state = sld_warn;
> > > >> +
> > > >
> > > > This sets sld_state to sld_warn even on CPUs that don't support
> > > > split-lock detection. split_lock_init will then try to read/write the
> > > > MSR to turn it on. Would it be better to initialize it to sld_off and
> > > > set it to sld_warn in split_lock_setup instead, which is only called if
> > > > the CPU supports the feature?
> > > 
> > > I've lost some bits of this patch series somewhere along the way :-(  There
> > > was once code to decide whether the feature was supported (either with
> > > x86_match_cpu() for a couple of models, or using the architectural test
> > > based on some MSR bits.  I need to dig that out and put it back in. Then
> > > stuff can check X86_FEATURE_SPLIT_LOCK before wandering into code
> > > that messes with MSRs
> > 
> > That code is still there (cpu_set_core_cap_bits). The issue is that with
> > the initialization here, nothing ever sets sld_state to sld_off if the
> > feature isn't supported.
> > 
> > v10 had a corresponding split_lock_detect_enabled that was
> > 0-initialized, but Peter's patch as he sent out had the flag initialized
> > to sld_warn.
> 
> Ah yes. Maybe the problem is that split_lock_init() is only
> called on systems that support split loc detect, while we call
> split_lock_init() unconditionally.

It was unconditional in v10 too?

> 
> What if we start with sld_state = sld_off, and then have split_lock_setup
> set it to either sld_warn, or whatever the user chose on the command
> line.  Patch below (on top of patch so you can see what I'm saying,
> but will just merge it in for next version.

Yep, that's what I suggested.

> 
> -Tony
> 
> 
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index 7478bebcd735..b6046ccfa372 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -39,7 +39,13 @@ enum split_lock_detect_state {
>  	sld_fatal,
>  };
>  
> -static enum split_lock_detect_state sld_state = sld_warn;
> +/*
> + * Default to sld_off because most systems do not support
> + * split lock detection. split_lock_setup() will switch this
> + * to sld_warn, and then check to see if there is a command
> + * line override.
> + */
> +static enum split_lock_detect_state sld_state = sld_off;
>  
>  /*
>   * Just in case our CPU detection goes bad, or you have a weird system,
> @@ -1017,10 +1023,11 @@ static inline bool match_option(const char *arg, int arglen, const char *opt)
>  
>  static void __init split_lock_setup(void)
>  {
> -	enum split_lock_detect_state sld = sld_state;
> +	enum split_lock_detect_state sld;

This is bike-shedding, but initializing sld = sld_warn here would have
been enough with no other changes to the patch I think?
