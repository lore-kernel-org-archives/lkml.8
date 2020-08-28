Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF7DC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 899BF20737
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="M6BJPzQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgH1SmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 14:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgH1SmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 14:42:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346D1C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 11:42:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ba60078cbaf9a215c2e9d.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:a600:78cb:af9a:215c:2e9d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 22E7F1EC0469;
        Fri, 28 Aug 2020 20:42:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598640132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=c+gSHKbW1aWMtClpSkkXAXcT1KL6VRQ2/DEedEWHVno=;
        b=M6BJPzQhS6SSDO2Xu+jjvdBmYSL/f5BO1Xqt5KB0K1OXjEcnLxDV4H0p3+tAbsd+ai5La1
        yQzKULx/KTOSvovqCSx/bXDArUc9deKl9CbxMHOGtggM1Ra1w22senmRwJXs71jCTfNEn4
        kB+Szb5qiRUxTnoi5p7LZ6FSNby8QJw=
Date:   Fri, 28 Aug 2020 20:42:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, dave.hansen@intel.com, ricardo.neri@intel.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ak@linux.intel.com,
        ravi.v.shankar@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Message-ID: <20200828184209.GC19342@zn.tnic>
References: <20200824180412.9440-1-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824180412.9440-1-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:04:12AM -0700, Kyung Min Park wrote:
> +If the expected flag does not appear in /proc/cpuinfo, things are murkier.
> +Users need to find out the reason why the flag is missing and find the way
> +how to enable it, which is not always easy. There are several factors that
> +can explain missing flags: the expected feature failed to enable, the feature
> +is missing in hardware, platform firmware did not enable it, the feature is
> +disabled at build or run time, an old kernel is in use, or the kernel does
> +not support the feature and thus has not enabled it. In general, /proc/cpuinfo
> +shows features which the kernel supports.
> +
> +For a full list of CPUID flags which the CPU supports, the users may use
> +tools like http://www.etallen.com/cpuid.html (which is not updated with
> +kernel releases) or other custom tools that read CPUID.

I guess this should talk only about our own kcpuid tool since we wanna
do that now, right?

...

> +c: The kernel disabled support for it at compile-time.
> +------------------------------------------------------
> +For example, if 5-level-paging is not enabled when building (i.e.,
> +CONFIG_X86_5LEVEL is not selected) the flag "la57" will not show up [#f1]_.
> +Even though the feature will still be detected via CPUID, the kernel disables
> +it via cleared by setup_clear_cpu_cap(X86_FEATURE_LA57).

"... disables it by clearing... "

> +d: The feature is disabled at boot-time.
> +----------------------------------------
> +A feature can be disabled either using a command-line parameter or because
> +it failed to be enabled. The command-line parameter clearcpuid= can be used
> +to disable features using the feature number as defined in
> +/arch/x86/include/asm/cpufeatures.h. For instance, User Mode Instruction
> +Protection can be disabled using clearcpuid=514. The number 514 is calculated
> +from #define X86_FEATURE_UMIP (16*32 + 2).
> +
> +In addition, there exists a variety of custom command-line parameters that
> +disable specific features. The list of parameters includes, but is not limited
> +to, no5lvl, nosmap, and nosmep.

You already give the separate example for "no5lvl" below so use something else
above, say, "nofsgsbase", for example.

> 5-level paging can also be disabled using
> +"no5lvl". SMAP and SMEP are disabled with the aforementioned parameters,
> +respectively.
> +
> +e: The feature was known to be non-functional.
> +----------------------------------------------
> +The feature was known to be non-functional because a dependency was
> +missing at runtime. For example, AVX flags will not show up if XSAVE feature
> +is disabled since they depend on XSAVE feature.

Another example would be: broken CPUs and them missing microcode patches
and due to that the kernel deciding not to enable a feature.

But yap, all in all looks like a good idea. I'll take the next version
after you've fixed those nitpicks.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
