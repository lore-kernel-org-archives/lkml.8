Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70313C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EC06206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592589644;
	bh=98DGxvFoHFgsKvqx9DTtEKTRoQzHCAa0f0KAENZkuW0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HF9DWsL8fTonzva/+IIrrM8JH18tz+9QCnyeV/PdsacRVywcjKmKAOXUV9UTmWs94
	 Zthfo9oUg/qXu6feTV1MH2FPc7xKGiObuIbXRYhrkncj9MlQI85YLIY7I1n+3N6+7q
	 u7cu4ODRn+qwByie6IUFXCuc05KDFbiIjtSRZYQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733069AbgFSSAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbgFSSAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:00:42 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7588207E8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592589641;
        bh=98DGxvFoHFgsKvqx9DTtEKTRoQzHCAa0f0KAENZkuW0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eCWHLtm/IqwPE4GyNMiwRTQx9UjW33nvYHCDBX/GH3R8wCBiMGuxmNWkHpWZW7/St
         tcIaPJ8WbMfjWoBklXwCjrc3R6U+umgpW+wa9rhNRcGLk8YoUUS7uuN43iBkbmXoZx
         GUCPPPSS/iuquWQ4tFpPmqU0wkKYSzmtwaeqJjQM=
Received: by mail-wm1-f49.google.com with SMTP id a6so281846wmm.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 11:00:41 -0700 (PDT)
X-Gm-Message-State: AOAM533YQBz2eQNMQ7N8KMoMZarOHMxILScCSH34tCghMmt7Uz9wAevM
        jdLZm+g6v1K9s8oSPRBDCCoSUwtsSHx3f4octEQp1Q==
X-Google-Smtp-Source: ABdhPJzCaqBJSCHMo8HvCX7tdm9LvZEItuvmRc6O+fGb5+NiAG4B7b/5++i7zP7RinKPSRsdm/tXHxfZAqabkYrMgSE=
X-Received: by 2002:a1c:46c3:: with SMTP id t186mr4716059wma.36.1592589640290;
 Fri, 19 Jun 2020 11:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200619174127.22304-1-bp@alien8.de> <20200619174127.22304-3-bp@alien8.de>
In-Reply-To: <20200619174127.22304-3-bp@alien8.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jun 2020 11:00:28 -0700
X-Gmail-Original-Message-ID: <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com>
Message-ID: <CALCETrXXzt8WZMs3dsReCJ5wdF3zhxFmUtGnmdCgV7_exFUKKQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, jpa@kernelbug.mail.kapsi.fi,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 10:41 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Petteri Aimonen <jpa@git.mail.kapsi.fi>
>
> Add a selftest for the usage of FPU code in kernel mode.
>
> Currently only implemented for x86. In the future, kernel FPU testing
> could be unified between the different architectures supporting it.

Acked-by: Andy Lutomirski <luto@kernel.org>

except:

> +#
> +# CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
> +# off the generation of FPU/SSE* instructions for kernel proper but FPU_FLAGS
> +# get appended last to CFLAGS and thus override those previous compiler options.
> +#
> +FPU_CFLAGS += -mhard-float -msse
> +ifdef CONFIG_CC_IS_GCC
> +  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
> +    # Stack alignment mismatch, proceed with caution.
> +    # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
> +    # (8B stack alignment).
> +    FPU_CFLAGS += -mpreferred-stack-boundary=4
> +  else
> +    FPU_CFLAGS += -msse2
> +  endif
> +endif

This should be cc-option, not cc-ifversion, I think.  But maybe we
should consider dropping the problematic GCC version instead?  The old
GCC versions with stack alignment problems are seriously problematic
for x86 kernels, and I don't really trust kernels built with them.
