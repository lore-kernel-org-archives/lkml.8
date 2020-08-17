Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BCA204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aX4E0LFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbgHQTPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgHQTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:15:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71B3C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:15:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so8116174pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tmBgqfU+29UH3A8gIAUsMUZvU1W2cHudzSZ0yYhvH2g=;
        b=aX4E0LFgDJUJNb9coXJEVWiFmcjetcbxAVRPFlHU+DPwMWC+xVxGVFwkAMuaLx8U84
         po7x1kjGihO1o2YsEEtX4D5mdlIDO5HlKqYEVeRBXBKxpG/GAuuxSuPH95iP77RlnFmG
         LfNgJRnCT9dWldE3WzaTTcQFgdaUSAl3IuBpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tmBgqfU+29UH3A8gIAUsMUZvU1W2cHudzSZ0yYhvH2g=;
        b=pk9ZIDCdw/v5Kzy05VstXSafj+W34caKSmFubK9xxUOq5ThNuaiGdVGMSP74XN3dmQ
         xWMDMjBTlAI1Y67jbN0dvt98U6k8yfdjvnnwJon9zL2Fff3GQ7i0ICVTus3B+Kl1UWNn
         oLqjZLY78iTJEUDYmZcYLckYDk8slojjGRhjZdhMW2SzV5W07W/IBSlFHA5cfHT27XHM
         MGiIYLYKs9usfq+UgyeJOlm4i4IIU/CBZkLCPZr6aeNGK9WMz7N/vxbCG5OOxT/yQCeU
         Buhcl6CXkf8BGLnRJTiat8TenMIteOJyO6sn4kRnfEXcUGr0Lr48vW6A7nppr08vpd7S
         jm+g==
X-Gm-Message-State: AOAM531z4bCPxy38IBeKbfllOey6FNJYE4X2ZlsfFJ0jSb/In5b3joWP
        5sKuZUjpqPI4DcQXHQ1UkkH6UA==
X-Google-Smtp-Source: ABdhPJw8/sMKSS0IvyS3CfDbpG7kKz1MmBn08NvHr5WPVkZ+puU1nQqC5SLXkU6uzhSgG0dVNngF+g==
X-Received: by 2002:a17:902:7293:: with SMTP id d19mr12778333pll.303.1597691724086;
        Mon, 17 Aug 2020 12:15:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm18109334pgv.1.2020.08.17.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:15:21 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:15:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
Message-ID: <202008171213.CBCFF5D67@keescook>
References: <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
 <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
 <ccacb2a860151fdd6ce95371f1e0cd7658a308d1.camel@perches.com>
 <CAKwvOd=QkpmdWHAvWVFtogsDom2z_fA4XmDF6aLqz1czjSgZbQ@mail.gmail.com>
 <20200816001917.4krsnrik7hxxfqfm@google.com>
 <CA+icZUW=rQ-e=mmYWsgVns8jDoQ=FJ7kdem1fWnW_i5jx-6JzQ@mail.gmail.com>
 <20200816150217.GA1306483@rani.riverdale.lan>
 <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
 <CAKwvOd=Ns4_+amT8P-7yQ56xUdDmL=1zDUThF-OmFKhexhJPdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Ns4_+amT8P-7yQ56xUdDmL=1zDUThF-OmFKhexhJPdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:36:49AM -0700, Nick Desaulniers wrote:
> That said, this libcall optimization/transformation (sprintf->stpcpy)
> does look useful to me.  Kees, do you have thoughts on me providing
> the implementation without exposing it in a header vs using
> -fno-builtin-stpcpy?  (I would need to add the missing EXPORT_SYMBOL,
> as pointed out by 0day bot and on the github thread).  I don't care
> either way; I'd just like your input before sending a V+1.  Maybe
> better to just not implement it and never implement it?

I think I would ultimately prefer -fno-builtin-stpcpy, but for now,
sure, an implementation without a header (and a biiig comment above it
detailing why and a reference to the bug) would be fine by me.

-- 
Kees Cook
