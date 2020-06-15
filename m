Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E06C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7632208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gdHCBuPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgFOSr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731332AbgFOSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:47:24 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39DCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:47:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k2so216087pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z30H0Qxf7KSPQ6BN5/irrwQjH65QOzZKJjP0gLp4z7g=;
        b=gdHCBuPrKnl/TRBfkFZubK5Uo5+n8gz7oaaq3rFP6EfkFPpcYITIG5o0tcbfMe2V4K
         D9W3BIw1eqKbke/hnOSRgUBuvSG3DZLMUHhiJ55Zf6pzdDMAzewIxvFV9Wo+WHTEPc0q
         RzhapmD6JJ+dz1WI/eagPudg6hmkl/UgIMyzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z30H0Qxf7KSPQ6BN5/irrwQjH65QOzZKJjP0gLp4z7g=;
        b=ads2MiKcgQ9ii+mUjNgGYePblwHeSMCoQoxA13sqADif87ksUtaihG+nls3ia2pXQM
         iiw21ucLj+dIHuEsY1ucXooJmm8uQ8HkPcfjG85TRvv68Az1dpbmKXCneHbJFqT5/Zzx
         0TbVrgGTRxWZKdKOLSzifvKkJsseVCOtdZ9UABN4n5YjpBDUngQiQpc/l0wB68c424W5
         vOnQdaj/hvfB/17PI4lyJ6SbGMAS2N0lllWt9gAph4uB/3BF6pB1koVIpSrmEi5IeDmn
         yfONe/SNqV1Qt8scHF2sK+ds8B/H7QMSGmtn2evL3zNhzauQvj8OsNLeKG3RULJGG/M/
         Rj8g==
X-Gm-Message-State: AOAM533PUuDDKt+wikmUwEUHkxhExZdGH1VRrFdX0dFuMDcEhhQTekOu
        TMIzluBcAEYmaeohf5I9MmRy8A==
X-Google-Smtp-Source: ABdhPJwuJ3h8uMqJezEgda4cA0v7s7m4i1tn76r+wnSCQxkWCNz4cW/GRZPksfQYqti3CBoayiD0RA==
X-Received: by 2002:a17:90a:ea05:: with SMTP id w5mr672654pjy.37.1592246843289;
        Mon, 15 Jun 2020 11:47:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x77sm14582163pfc.4.2020.06.15.11.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 11:47:22 -0700 (PDT)
Date:   Mon, 15 Jun 2020 11:47:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        KP Singh <kpsingh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Thomas Cedeno <thomascedeno@google.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] security: fix the key_permission LSM hook function type
Message-ID: <202006151144.C9E5EA2C76@keescook>
References: <20200615181232.119491-1-samitolvanen@google.com>
 <202006151113.7A2F638A7@keescook>
 <CAKwvOdkdy10K+6Jw=Sd4PxrvQgc=HssoJqJN9q8NVWkWiuZtRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdkdy10K+6Jw=Sd4PxrvQgc=HssoJqJN9q8NVWkWiuZtRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:23:44AM -0700, Nick Desaulniers wrote:
> On Mon, Jun 15, 2020 at 11:21 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 15, 2020 at 11:12:32AM -0700, Sami Tolvanen wrote:
> > > Commit 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than
> > > a mask") changed the type of the key_permission callback functions, but
> > > didn't change the type of the hook, which trips indirect call checking with
> > > Control-Flow Integrity (CFI). This change fixes the issue by changing the
> > > hook type to match the functions.
> > >
> > > Fixes: 8c0637e950d6 ("keys: Make the KEY_NEED_* perms an enum rather than a mask")
> > > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> >
> > Thanks for fixing this!
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > I wonder if there is any compiler option we can turn on to catch the
> > implicit enum/int casting that would help for these kinds of things
> > without absolutely exploding the build warnings.
> >
> > I see -Wenum-conversion, but that seems to be between enums, not between
> > int.
> >
> > I see this, but it's external:
> > https://noamlewis.wordpress.com/2017/10/05/type-safe-enums-in-c-using-a-clang-plugin/
> 
> Unfortunately, using a looser integral type is the typical workaround
> for -Wenum-conversion warnings (which is on by default, GCC recently
> added that flag, too).  For warning on enum to int, the kernel would
> probably blow up with warnings. I don't know of any such existing
> warning flag.

Yeah, I couldn't find anything either. The closest I could find to avoid
one of the common classes of enum -> int conversion is the bitwise
operations, which is covered by __attribute__((flag_enum)):
https://clang.llvm.org/docs/AttributeReference.html#flag-enum

Ah well. We'll let CFI find them. ;)

-- 
Kees Cook
