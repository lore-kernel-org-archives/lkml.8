Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497FAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12187207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 20:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YrIcM+oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgFIUmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 16:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727098AbgFIUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 16:42:04 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC97FC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 13:42:02 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id m2so1914958pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 13:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S1vBKT0yWnLuB7U8YX8ngGZwmaPvDRzzZCxacO5i+2o=;
        b=YrIcM+oZzwpQaYRF0+ivYfdkE5+At1SGS3X9EkfMcFYnQ+ao3zSFVraPEM6FbJ8twK
         HBHi4qmnExk02NZLB0ffAs8BamSKAcrwlwQAzlslHSqCzDpn7ILTkQUhPepWDwTN7hgf
         AxufcJX6gK90h1RBevEPiDUscn+AdlZoV56is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S1vBKT0yWnLuB7U8YX8ngGZwmaPvDRzzZCxacO5i+2o=;
        b=LiJEK9UnXU+nDeN9BTzySOdXv9k9TuA/WbFAxZ+JxvtMrnK/SGJepXhZCv2+scG3LW
         RMrCwodTkf8HQicvZ9VjWcff5xLPECVfMyu9uzdGzuyQ6pIVsAPUr9FjXQCEn2P6k+DA
         Vdh1YccXdz/akrcOH15aQE3KCRxSgsahRIzbBXoDL0i8Cv7MpjTjDatJhmb8A9PBChiG
         2o9/QbMdKPgHmn83QdPtzDSP6tGNn+MzwfaXiVUrZv622zU23eIaQWcIOAi1ImEk25aB
         72/aafSwl8k1E0XnM6Yoc4JZZcdUpkM13NfJ6kRUuC1tCuzKWQENs50TbqSJCOlaz2gr
         Dq7w==
X-Gm-Message-State: AOAM533bqx9ugn5W2vf1B03kZZIqUSXs+DhtWCB7WL2yoFjU9O5ZU4XG
        er0spB1IFPD0ykGXXVtyA3i2zQ==
X-Google-Smtp-Source: ABdhPJzO1L5JcpjNQ1QE9BAOCAjYufkWhpqSvVnXwQlzZodQAiLOBVJh8pc1XAtAd6P8ACdRXXCBKA==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr180863ple.52.1591735322434;
        Tue, 09 Jun 2020 13:42:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u17sm9394329pgo.90.2020.06.09.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 13:42:01 -0700 (PDT)
Date:   Tue, 9 Jun 2020 13:42:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jessica Yu <jeyu@kernel.org>,
        arjan@linux.intel.com, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH v2 9/9] module: Reorder functions
Message-ID: <202006091331.A94BB0DA@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <20200521165641.15940-10-kristen@linux.intel.com>
 <202005211415.5A1ECC638@keescook>
 <9fdea0bc0008eccd6dfcad496b37930cf5bd364a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdea0bc0008eccd6dfcad496b37930cf5bd364a.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:14:04PM -0700, Kristen Carlson Accardi wrote:
> On Thu, 2020-05-21 at 14:33 -0700, Kees Cook wrote:
> > Oh! And I am reminded suddenly about CONFIG_FG_KASLR needing to
> > interact
> > correctly with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION in that we do NOT
> > want the sections to be collapsed at link time:
> 
> sorry - I'm a little confused and was wondering if you could clarify
> something. Does this mean you expect CONFIG_FG_KASLR=y and
> CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y to be a valid config? I am not

Yes, I don't see a reason they can't be used together.

> familiar with the option, but it seems like you are saying that it
> requires sections to be collapsed, in which case both of these options
> as yes would not be allowed? Should I actively prevent this in the
> Kconfig?

No, I'm saying that CONFIG_LD_DEAD_CODE_DATA_ELIMINATION does _not_
actually require that the sections be collapsed, but the Makefile
currently does this just to keep the resulting ELF "tidy". We want
that disabled (for the .text parts) in the case of CONFIG_FG_KASLR. The
dead code elimination step, is, IIUC, done at link time before the
output sections are written.

-- 
Kees Cook
