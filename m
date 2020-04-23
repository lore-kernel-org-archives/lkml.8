Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A7C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8444F2098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQ7SwGEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730185AbgDWSGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729901AbgDWSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:06:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2EFC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:06:16 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so3351263pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aMzN8y43RzIeS+hGOjJQmVpyCdPMVYWSbPwa9BUqxsk=;
        b=KQ7SwGEE7BGDgi9nQDxn5/Qf+DVEwwXSpISshGAQFVxxqcofFWkLXI2M6EXYPngQWU
         PgnOirdnEL39LbXQdRpmdcipOkqc+kLm9yJ78NGGM14K3bEqEODuH4goJXgV5DrYzMPN
         9J4hHpHGb1j4OqNvtIKczFHBEXOJQ3JNKWMyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aMzN8y43RzIeS+hGOjJQmVpyCdPMVYWSbPwa9BUqxsk=;
        b=t4EXBeiOQjUV9D+VtvCix5+BhVMTX2riTkZfx3fu0HUS2KbWlX3WuBkLhKQE5AykJR
         Oq+aALgy+iuJcnarDDY/vN4SM0I4byubpWlHrFOUJCU0sFziunDvPJS/DDpuT6Jr+EVx
         Fu0Q535T/vASk0jp9u38bf2M5zjcoX+AjTPQxdb+Pew5VRomWjOuE689lDKhdwo/DExT
         hO8lWorygUWXeOvnKmavCFq+ID8kdza0u65LEUQ8FG2l9FVZLVJmCRbKaMIrJ1bx/3GK
         eOL7wVk2MhXMcZxjFIo4GRvocTDbyCLf95DyWP7GtJJobNRF1QV3mQChCdtJuredrAdQ
         Qjog==
X-Gm-Message-State: AGi0PuZxhVThku11YEqnqkZx29E4vbwjzaaeuXp7gl5BrVVJ+oP7KfiH
        ggYpgujKbkf5fEieWtzKuBbJL3hu9+E=
X-Google-Smtp-Source: APiQypK4H47IY7ViPrvh6uL0870HFLX9QoJ2ivL8CiGjHoztWNMxnsStpejcK6W/BX8+xQ7ExE8XJA==
X-Received: by 2002:a63:48a:: with SMTP id 132mr5156238pge.380.1587665176255;
        Thu, 23 Apr 2020 11:06:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f76sm3118222pfa.167.2020.04.23.11.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 11:06:15 -0700 (PDT)
Date:   Thu, 23 Apr 2020 11:06:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Apr 22 (objtool warnings)
Message-ID: <202004231053.5E4F16C3E8@keescook>
References: <20200422171016.484b031d@canb.auug.org.au>
 <2bf0635d-1406-23db-28c7-e55da9a07e05@infradead.org>
 <20200422164406.qhvd2my35wnjlzyg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422164406.qhvd2my35wnjlzyg@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 11:44:06AM -0500, Josh Poimboeuf wrote:
> On Wed, Apr 22, 2020 at 08:35:29AM -0700, Randy Dunlap wrote:
> > On 4/22/20 12:10 AM, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Changes since 20200421:
> > > 
> > 
> > on x86_64:
> 
> In both cases the unreachable instruction happens immediately after a
> call to a function which is truncated with a UD2 (because of
> UBSAN_TRAP).
> 
> When I remove UBSAN_TRAP, the UD2s are replaced with calls to
> __ubsan_handle_type_mismatch_v1().

Hrm, these are coming out of CONFIG_UBSAN_MISC, yes? It seems that the
UBSAN checks that are non-recoverable all inject unreachable checks
afterwards, from what I can see.

> Kees, any idea?

Isn't this another version of the earlier unreachable-ud2 issue?

Regardless, the type_mismatch it triggered for misalignment and
object-size checks, and the alignment check is likely going to always
misfire on x86. The randconfig includes that config:

CONFIG_UBSAN_ALIGNMENT=y

So perhaps the config should be strengthened to disallow it under
COMPILE_TEST?

config UBSAN_ALIGNMENT
        def_bool !UBSAN_NO_ALIGNMENT
	depends on !COMPILE_TEST


-- 
Kees Cook
