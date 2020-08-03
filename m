Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB89DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8D22075A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HeAvcOEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHCULa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgHCULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:11:30 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:11:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g19so8921814plq.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TfiyLaiiytHrMlT6oh4IsfhQ9YFyy5wx3zu6IU7BZNY=;
        b=HeAvcOEzYgF+GPngOCTfUbepzuEHkx+8qRmbejrCRY0MMmgn7UeyBWYdJzytoGD/Ta
         qJv07CPlJcF29ETgPuWONUktPZBp3nwXCAW6eRZRISbnRUQRb/KL+l6+49U1G00uxaJ2
         G8Xq9iIuiiHpWvLKYqRaN87kEr5QcIdg7wdbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TfiyLaiiytHrMlT6oh4IsfhQ9YFyy5wx3zu6IU7BZNY=;
        b=YEa7rx7THGfkEcSk+PyVnuHk+o26UpPepgoYK8N/hSt3dtRYGmOLl9Ys7G+53LbyW2
         6zrq7ARdkMRbULrg9TTNu0/Ag+xjOCd4YFtO8PVUJuWXL7q9Q7sJ7EXWCS6XRme04Phx
         32tK8J2JjtTO6pBxdL+4zKsDniXt1Lf7D9flVRgbji5zmCRxQAXoe+y9KRdnTG3UU863
         b7OICAGO7BOPw+0/0ChB2dAIa80t4IpAwAgWDyqgZRYC5I8RhbT7BrrpJ343O3Nk5k7N
         OSWqyjsUif0aOrRzj8LjoyDoZAU/9tSvsHWRXfy7taFTu9mOcfn4HypEpX8F9XUH7yae
         EKyQ==
X-Gm-Message-State: AOAM530KOYDD0f+bcovi5cF8Gc2aHYabdKVlOg5ascIrIpAfYj5bEprt
        comyjQXN2Et2EAt3rLYoAOlWjw==
X-Google-Smtp-Source: ABdhPJx5soepBCB5jCgc7HTF/4STC+NuKiuSvs2LauZE/NK7WGz7+MhS+gn47Q/oX5PA+CVBiIyxZw==
X-Received: by 2002:a17:90a:7f02:: with SMTP id k2mr942128pjl.196.1596485489540;
        Mon, 03 Aug 2020 13:11:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d2sm18527244pgp.17.2020.08.03.13.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:11:28 -0700 (PDT)
Date:   Mon, 3 Aug 2020 13:11:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        live-patching@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202008031310.4F8DAA20@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
 <e9c4d88b-86db-47e9-4299-3fac45a7e3fd@virtuozzo.com>
 <202008031043.FE182E9@keescook>
 <fc6d2289-af97-5cf8-a4bb-77c2b0b8375c@redhat.com>
 <20200803193837.GB30810@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803193837.GB30810@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 03:38:37PM -0400, Frank Ch. Eigler wrote:
> Hi -
> 
> > > While this does seem to be the right solution for the extant problem, I
> > > do want to take a moment and ask if the function sections need to be
> > > exposed at all? What tools use this information, and do they just want
> > > to see the bounds of the code region? (i.e. the start/end of all the
> > > .text* sections) Perhaps .text.* could be excluded from the sysfs
> > > section list?
> 
> > [[cc += FChE, see [0] for Evgenii's full mail ]]
> 
> Thanks!
> 
> > It looks like debugging tools like systemtap [1], gdb [2] and its
> > add-symbol-file cmd, etc. peek at the /sys/module/<MOD>/section/ info.
> > But yeah, it would be preferable if we didn't export a long sysfs
> > representation if nobody actually needs it.
> 
> Systemtap needs to know base addresses of loaded text & data sections,
> in order to perform relocation of probe point PCs and context data
> addresses.  It uses /sys/module/...., kind of under protest, because
> there seems to exist no MODULE_EXPORT'd API to get at that information
> some other way.

Wouldn't /proc/kallsysms entries cover this? I must be missing
something...

-- 
Kees Cook
