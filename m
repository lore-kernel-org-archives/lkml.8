Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F2C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19C6204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOzQ2918"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392215AbgHQTQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389932AbgHQTQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:16:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F2CC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:16:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id r11so8684688pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGRzfPyw7ESx9wXeagb3xJwksI9OtPsVQy2m4SGV5Xo=;
        b=AOzQ2918L26XOqNuhI39UDWiFl/NgEDi3gEqKcXm3SjCQrlCrHzQxyDSNBU4MoqN6P
         hbt6hn1pjWmdyPvmuxZjEyngCGtz3/+LXbmmkYLhR8X/zsnHL+lm13Oud9WWBnuyL5DQ
         Rit2cIThg2WcXHH36RfxlFSgTAvF1/H288vBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGRzfPyw7ESx9wXeagb3xJwksI9OtPsVQy2m4SGV5Xo=;
        b=FarHlfbQnYekQtdw8IS+CsbJHxEJjyvZQVr/cYxwW9OqBfYIA1EetPXWCO++wDtJaI
         8IcmZ0gZrIAgvzmoWJIedp6eTJ/SIzOJp8u3/f7Upwow75TK1zOIjOjpPCTALSdDLCMX
         K406OPH25TR0VIbRAWB1Uuz63zHbnH/yII/NZ9G2apn+7fVRJucGg1xIiVPsBg0o5NEB
         KpSNywAYnpI7MddYKwXO/PlhddghM6eDAKo5VufMyDWFYPKvMRNVI0TvKtazlH/SdO4G
         SRYiAgZf/p0Tqd/N5k41eW4aJgUD0+BvPi0mnbG7n0jEe6WP30xokXPeg/aYOcGJrzP0
         vdmg==
X-Gm-Message-State: AOAM531//SftzeHDl/AqzrQHRRxOOEztvkP3luUTgVvpMYh6GJA7bu94
        z/wI9MZmnqFjrbl8eWoll/TOmg==
X-Google-Smtp-Source: ABdhPJwx6+0uQ9KiWoyCEx/3rDJPN+0vrjL39vxdhLZ+1kK3upxTaoDjH7lVLlGZ1b6tyDYJ3RYrfg==
X-Received: by 2002:a63:ff5f:: with SMTP id s31mr4115897pgk.333.1597691799926;
        Mon, 17 Aug 2020 12:16:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm20767427pfh.128.2020.08.17.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 12:16:38 -0700 (PDT)
Date:   Mon, 17 Aug 2020 12:16:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2] lib/string.c: implement stpcpy
Message-ID: <202008171216.945D6D7D11@keescook>
References: <202008150921.B70721A359@keescook>
 <CAKwvOdnyHfx6ayqEoOr3pb_ibKBAG9vj31LuKE+f712W=7LFKA@mail.gmail.com>
 <457a91183581509abfa00575d0392be543acbe07.camel@perches.com>
 <CAKwvOdk4PRi45MXCtg4kmeN6c1AK5w9EJ1XFBJ5GyUjwEtRj1g@mail.gmail.com>
 <ccacb2a860151fdd6ce95371f1e0cd7658a308d1.camel@perches.com>
 <CAKwvOd=QkpmdWHAvWVFtogsDom2z_fA4XmDF6aLqz1czjSgZbQ@mail.gmail.com>
 <20200816001917.4krsnrik7hxxfqfm@google.com>
 <CA+icZUW=rQ-e=mmYWsgVns8jDoQ=FJ7kdem1fWnW_i5jx-6JzQ@mail.gmail.com>
 <20200816150217.GA1306483@rani.riverdale.lan>
 <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABCJKucsXufD6rmv7qQZ=9kLC7XrngCJkKA_WzGOAn-KfcObeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 10:14:43AM -0700, Sami Tolvanen wrote:
> I just confirmed that adding -fno-builtin-stpcpy to KBUILD_CFLAGS does
> work with LTO as well.

Oh, I read this out of order; sorry! Yes, if -fno-builtin-stpcpy works,
let's use that instead. Doesn't that solve it too?

-- 
Kees Cook
