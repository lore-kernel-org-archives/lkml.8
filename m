Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD53C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A872071C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pl+Pce2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgCMABw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:01:52 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34517 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgCMABv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:01:51 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so3344399plm.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 17:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rmEnGedJS8sxU6HnCpV+Q7c12k0Ug1fpGwxF+f1yIUU=;
        b=Pl+Pce2CQX2Wi8HakEByaZJ4V1r/N63/wl+7RIrmZoKQhGGn2F42JBBI4IUgM/BOmb
         A9VQ3xP3ckXlPZZmhQYQ04iCw4Mh77vtilJ5/a+JLuWfCRqQVbjbTH+r8p+VoSHRvpiK
         uTYRf5M6Fl03wmZyFwKy/znFMKao215IA4kmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rmEnGedJS8sxU6HnCpV+Q7c12k0Ug1fpGwxF+f1yIUU=;
        b=sMF9jqo8jXR/uztmTK5ol6uvlzkDMsZ6Jd885CCsrLCi75c98MjW33nly0Dhupxk7Y
         qpcJHfONG5QC/t4NuIi/4ZTJ7DIoeOLcGBQbAvjzs8kh7LbGwL4wMAunmVdt6L80eoiU
         GKnK5YiECKuuf5s+eJWWZLaVAodL1/RcwMZ8ZrW98L2cVGGvm2iJS5MTsnZ1tVIbMgQB
         uwsHJAJBNd+9MPJ6Lu4ixUv5RCXv0C/vbpSC5OCaiU6jmzQ91yxbiuIJujRLEP2CwaZ6
         BwBrm/lgT6KlWN1RGl4KgFOPETXd3EQHBiku3sLSenjQEu/m0hXIEOghWduZpz7FIB6z
         VqHw==
X-Gm-Message-State: ANhLgQ22WrkpKXvizxB5C8D3dwijclnbvrgULmHlly46Ln1cZhyhvuNS
        M+qPBhpDn7N191x8l4zAWI7tLw==
X-Google-Smtp-Source: ADFU+vsQ94Kp0d98Pbb4MXZarpMHv6ibuFITYGGF7X16YL0Ee3aFcR+8dzYWKYGKsg7cimIUlM5axg==
X-Received: by 2002:a17:902:d684:: with SMTP id v4mr10568065ply.112.1584057709967;
        Thu, 12 Mar 2020 17:01:49 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm55113197pfn.113.2020.03.12.17.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:01:49 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:01:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v9 13/13] arm64: BTI: Add Kconfig entry for userspace BTI
Message-ID: <202003121700.9260E027@keescook>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-14-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311192608.40095-14-broonie@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:26:08PM +0000, Mark Brown wrote:
> From: Dave Martin <Dave.Martin@arm.com>
> 
> Now that the code for userspace BTI support is in the kernel add the
> Kconfig entry so that it can be built and used.
> 
> [Split out of "arm64: Basic Branch Target Identification support" --
> broonie]
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/Kconfig | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 8a15bc68dadd..d65d226a77ec 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -1522,6 +1522,28 @@ endmenu
>  
>  menu "ARMv8.5 architectural features"
>  
> +config ARM64_BTI
> +	bool "Branch Target Identification support"
> +	default y
> +	help
> +	  Branch Target Identification (part of the ARMv8.5 Extensions)
> +	  provides a mechanism to limit the set of locations to which computed
> +	  branch instructions such as BR or BLR can jump.
> +
> +	  To make use of BTI on CPUs that support it, say Y.
> +
> +	  BTI is intended to provide complementary protection to other control
> +	  flow integrity protection mechanisms, such as the Pointer
> +	  authentication mechanism provided as part of the ARMv8.3 Extensions.
> +	  For this reason, it does not make sense to enable this option without
> +	  also enabling support for pointer authentication.  Thus, when
> +	  enabling this option you should also select ARM64_PTR_AUTH=y.
> +
> +	  Userspace binaries must also be specifically compiled to make use of
> +	  this mechanism.  If you say N here or the hardware does not support
> +	  BTI, such binaries can still run, but you get no additional
> +	  enforcement of branch destinations.
> +
>  config ARM64_E0PD
>  	bool "Enable support for E0PD"
>  	default y
> -- 
> 2.20.1
> 

-- 
Kees Cook
