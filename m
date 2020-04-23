Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5F9C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 971F82076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 19:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JcNVt9Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgDWTcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgDWTcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 15:32:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F238C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:32:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a7so2924489pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AucMh0ksuApTqmSqz5uKzvpEi+vb6lou60a9nNWAoyY=;
        b=JcNVt9SgBBGF/iiJ+iTb7pgfG/HtP9LQZMxtcyICmGMV+91NN1urybM6ySCRx1pAy6
         M73lK2+sWzMVD6+EIsbYrm78d3qnaIFI7ZbQDp7EdeZiICSxMtVsTo3exn35pfVqfFf8
         QboNgKKhlds8A9465okRu9CbZdmhuAPD0MrMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AucMh0ksuApTqmSqz5uKzvpEi+vb6lou60a9nNWAoyY=;
        b=JlTbDqoGtftacHUDZpUCr12XY2/7myAl37fFhk+teYKTRDm4dxhZb6GIi64oC9vY/i
         2tB5f6ukv/IyHdsZPMDUHQ6uOtD77TIRCksmAReYabQgyG+yuI5d7YHW9PWblLkm/AEH
         qbNu2rDOe5RjA4tLpI8QL+ZbfLSEENRnnVs9CP24ieAL5ggWrtL3dPSf5UYAOiE5+WAo
         GiDSNv3+sillATzgKzR+5KN3HUx6OnGQiTJhWyhnlMMBEAS9AHracbLvq1hNCvPeUS+g
         0+K5N5iihiLwAuLW9M7o+8H8xVb2sjdsWKNWqqV+XMCeyJUCEgwlEs3MjHORAe5XuQZ6
         CDkQ==
X-Gm-Message-State: AGi0PuZ/9it03SGlW0ASjCa5qNnPVE+stUDNwJk9Jqz3J2+iy9ckJ7+D
        9XT9Ejz/Iod6tA06EVUiXmig00s2LFg=
X-Google-Smtp-Source: APiQypLoCaK1dpkgXIdK2bb8q6JF5fwJMvbBdzyg7f0LPP9wDXuonKyVpUdhhE4j06sdwpZVpvGKWQ==
X-Received: by 2002:a17:90a:1da6:: with SMTP id v35mr2507161pjv.44.1587670354690;
        Thu, 23 Apr 2020 12:32:34 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h31sm3174915pjb.33.2020.04.23.12.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 12:32:33 -0700 (PDT)
Date:   Thu, 23 Apr 2020 12:32:32 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: linux-next: Tree for Apr 22 (objtool warnings)
Message-ID: <202004231224.D6B3B650@keescook>
References: <20200422171016.484b031d@canb.auug.org.au>
 <2bf0635d-1406-23db-28c7-e55da9a07e05@infradead.org>
 <20200422164406.qhvd2my35wnjlzyg@treble>
 <202004231053.5E4F16C3E8@keescook>
 <20200423182845.u7rthm67mqdqtuq5@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423182845.u7rthm67mqdqtuq5@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 01:28:45PM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 23, 2020 at 11:06:14AM -0700, Kees Cook wrote:
> > Regardless, the type_mismatch it triggered for misalignment and
> > object-size checks, and the alignment check is likely going to always
> > misfire on x86. The randconfig includes that config:
> > 
> > CONFIG_UBSAN_ALIGNMENT=y
> > 
> > So perhaps the config should be strengthened to disallow it under
> > COMPILE_TEST?
> > 
> > config UBSAN_ALIGNMENT
> >         def_bool !UBSAN_NO_ALIGNMENT
> > 	depends on !COMPILE_TEST
> 
> But this issue basically makes UBSAN_TRAP unusable, right?  Should
> UBSAN_ALIGNMENT and UBSAN_TRAP be made mutually exclusive?

Well, no, not UBSAN_TRAP alone. It seems that -fsanitize=alignment (and
possibly -fsanitize=object-size) is likely to produce false positives. And
that was already well understood. With UBSAN_TRAP, though, those functions
become unusable. Part of the goal of adding UBSAN_TRAP was to be able to
extract the non-false-positive sanitizer options out of UBSAN_MISC so
they could be used in production without the large debug text overhead.
(And the "alignment" checker had long since already been separate and
set to false by default on x86, since it's going to trip over everything
since it shouldn't get run on such hardware for any sane reason that
I know of.) So, while UBSAN_TRAP with UBSAN_ALIGNMENT is going to be
especially bad, UBSAN_ALIGNMENT at all is likely bad enough on x86, so
I think it'd be best to make it a negative depends on COMPILE_TEST (but
leave it available if someone is doing some really unusual UBSAN work).

-Kees

-- 
Kees Cook
