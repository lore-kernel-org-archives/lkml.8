Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B420AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8571E206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XI5vMf0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgFOSPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:15:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43662 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgFOSPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:15:37 -0400
Received: from zn.tnic (p200300ec2f063c00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C17341EC030F;
        Mon, 15 Jun 2020 20:15:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592244935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=HQgUkcOmlhmAPhWQIMKIm6lRADK00BxDKdbxGm+VDVY=;
        b=XI5vMf0QLlyS1bZAgkFctHq1l4/IKsnX50EqLtugdeXTJvkGGEalTfvMCxC/ROoRwuvvIE
        HwrI2s/sFstShwDj3b1Me+KG0cE0deo0vqDBNT25VTRq1tH2oi/ge30WlaHd2K7f6/MFCj
        /FfW5xjRkXSmeuz4xdXsR+RC8XcboaE=
Date:   Mon, 15 Jun 2020 20:15:27 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        ak@linux.intel.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [RFC PATCH 1/3] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Message-ID: <20200615181527.GM14668@zn.tnic>
References: <20200610200701.16757-1-kyung.min.park@intel.com>
 <20200610200701.16757-2-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610200701.16757-2-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:06:59PM -0700, Kyung Min Park wrote:
> Add documentation for /proc/cpuinfo feature flags enumeration.
> Document how and when x86 feature flags are used. Also discuss what
> their presence or absence mean for the kernel, users, and applications.
> 
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Co-developed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> Signed-off-by: Kyung Min Park <kyung.min.park@intel.com>
> ---
>  Documentation/x86/cpuinfo.rst | 152 ++++++++++++++++++++++++++++++++++
>  Documentation/x86/index.rst   |   1 +
>  2 files changed, 153 insertions(+)
>  create mode 100644 Documentation/x86/cpuinfo.rst

I guess, although if we ever change how all that works, we need to
update the documentation but this is the usual thing with documentation.
Maybe it should not be documented in such a detail. :)

> diff --git a/Documentation/x86/cpuinfo.rst b/Documentation/x86/cpuinfo.rst
> new file mode 100644
> index 000000000000..d01d2c03a4d7
> --- /dev/null
> +++ b/Documentation/x86/cpuinfo.rst
> @@ -0,0 +1,152 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +x86 Feature Flags
> +=================
> +
> +Introduction
> +============
> +
> +On x86, flags appearing in /proc/cpuinfo have an X86_FEATURE definition
> +in arch/x86/include/asm/cpufeatures.h. If the kernel, any application,
> +or an end user

The kernel yes - the other two, not really. Userspace simply does CPUID
directly.

> might care about a feature, it can and should have
> +X86_FEATURE_* defined. These flags represent hardware features as
> +well as software features.
> +
> +If users want to know if a feature is available on a given system, they
> +try to find the flag in /proc/cpuinfo. If a given flag is present, it
> +means that the kernel supports it and is currently making it available.
> +If such flag represents a hardware feature, it also means that the
> +hardware supports it.
> +
> +If the expected flag does not appear in /proc/cpuinfo, things are murkier.
> +Users need to find out the reason why the flag is missing and find the way
> +how to enable it, which is not always easy.

This needs to say:

It can be that the kernel doesn't support that feature and thus hasn't
enabled it.

> There are several factors that
> +can explain missing flags: the expected feature failed to enable, the feature
> +is missing in hardware, platform firmware did not enable it, the feature is
> +disabled at build or run time, or an old kernel is in use. In such cases,
> +the users need to rely on tools like http://www.etallen.com/cpuid.html
> +(which is not updated with kernel releases) or other custom tools that
> +read CPUID.

In general, this should say something along the lines that /proc/cpuinfo
shows features which the kernel supports.

"For a full list of CPUID flags which the CPU supports, use
tools/arch/x86/tools/cpuid/cpuid"

:-)

> +
> +How are feature flags created?
> +==============================
> +
> +a: Feature flags can be derived from the contents of CPUID leaves.
> +------------------------------------------------------------------
> +These feature definitions are organized mirroring the layout of CPUID
> +leaves and grouped in words with offsets as mapped in enum cpuid_leafs
> +in cpufeatures.h (see arch/x86/include/asm/cpufeatures.h for details).
> +If a feature is defined with a X86_FEATURE_<name> definition in
> +cpufeatures.h, and if it is detected at run time, the flags will be
> +displayed accordingly in /proc/cpuinfo. For example, the flag "avx2"
> +comes from X86_FEATURE_AVX2 in cpufeatures.h.
> +
> +b: Flags can be from scattered CPUID-based features.
> +----------------------------------------------------
> +Hardware features enumerated in sparsely populated CPUID leaves get
> +software-defined values. Still, CPUID needs to be queried to determine
> +if a given feature is present. This is done in init_scattered_cpuid_features().
> +For instance, X86_FEATURE_CQM_LLC is defined as 11*32 + 0 and its presence is
> +checked at runtime in the respective CPUID leaf [EAX=f, ECX=0] bit EDX[1].
> +
> +The intent of scattering CPUID leaves is to not bloat struct
> +cpuinfo_x86.x86_capability[] unnecessarily. For instance, the CPUID leaf
> +[EAX=7, ECX=0] has 30 features and is dense, but the CPUID leaf [EAX=7, EAX=1]
> +has only one feature and would waste 31 bits of space in the x86_capability[]
> +array.

... and that per-CPU.

> +
> +c: Flags can be created synthetically under certain conditions for hardware features.
> +-------------------------------------------------------------------------------------
> +Examples of conditions include whether certain features are present in
> +MSR_IA32_CORE_CAPS or specific CPU models are identified. If the needed
> +conditions are met, the features are enabled by the macro set_cpu_cap or
> +setup_force_cpu_cap macro.

... by the ... macros.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
