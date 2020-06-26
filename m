Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247AC206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kaoCNqPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgFZUNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgFZUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:13:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79219C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so4652022pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Az9RFFYtn5C7TmV4P2ySXpJMS+ldXmIwmwoLtzgDuS8=;
        b=kaoCNqPS1QsSCdQvqaSVaEOAXbalmo1arka1el0o4zpvk3N0TP8c2fV2jYdsRreLMw
         yDtrumERCVizvepxpfw0Om38FWisWAy7daOjrh8Lu/hU7IK5N8OAn4TVfHcuv2OMpEg9
         Jcmvj2f2b1QJUPjV3veR2dZlYeqosz3ojrmq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Az9RFFYtn5C7TmV4P2ySXpJMS+ldXmIwmwoLtzgDuS8=;
        b=HyRjeR3/CiR//VE5IdoqUMsjSd9r8Yxo3r0n7Uos+nJ9GXm82T24np2KK1D47+Pxq1
         E8pElPrB5DyIZTxCn/pHVm0SC7xqfgER4kkrCRs+xkxVBI3mtaG+P9uyXpMlC9VdEBkL
         Z7DBdEU/zkz/KihTS4eqQOfIZ3pA2az3oWUT8o6gE3wk7jzoNZXC+XvwKkpHefIfoA7m
         hGQ8LADVnRfouc8hJinAupAeT2jHU/NYXA6frnb41nzm4lqmQhEFZvQG7bb+8PSskM59
         7wXvKg/lDKp+SrGY1a0KhsHbj7lghl8Ek8uetvaEfjFHlis8eUs0L63jCfYwxAPSZHrl
         Lacw==
X-Gm-Message-State: AOAM531vYe7vDgBWDsUolngsSn86Xmow6ligLQs465jEUbCBwsjpanaP
        /roksF09a1vVDcPYsTVt+ZsdVQ==
X-Google-Smtp-Source: ABdhPJyboLRCHhlEE16WjSu4BWalicgOTCnBMXYn0MvwG2mprXGsrY/REL8KRMtW3BQoaNUGnfaC+g==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr5328566pjq.145.1593202400000;
        Fri, 26 Jun 2020 13:13:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y187sm26950121pfb.46.2020.06.26.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 13:13:19 -0700 (PDT)
Date:   Fri, 26 Jun 2020 13:13:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] kbuild: remove cc-option test of -fno-stack-protector
Message-ID: <202006261312.560B045E@keescook>
References: <20200626185913.92890-1-masahiroy@kernel.org>
 <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnK4KZaE=D40UyKHN-nB1Y-oXXJUcVv08cGJNsExOs-Pw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 12:09:37PM -0700, Nick Desaulniers wrote:
> On Fri, Jun 26, 2020 at 12:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >  CFLAGS_NO_HARDENING := $(call cc-option, -fno-PIC,) $(call cc-option, -fno-pic,) \
> > -       $(call cc-option, -fno-stack-protector,) \
> > -       $(call cc-option, -fno-stack-protector-all,)
> > +       -fno-stack-protector $(call cc-option, -fno-stack-protector-all)
> 
> Just curious, looks like we could do the same for
> `-fno-stack-protector-all`, here or tree-wide, right?  Wait, what
> compiler recognizes -fno-stack-protector-all?
> https://godbolt.org/z/QFQKE_

That is from ancient times, IIRC. -fno-stack-protector should be
sufficient.

-- 
Kees Cook
