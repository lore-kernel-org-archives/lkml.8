Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A040BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECD5206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594425274;
	bh=TkM/NINEbbSlnGL6XD2eTgP3hCGIMLsg1Wflup+glc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t8pYLz5B1PZ9i2B6rmFXbdQSaPBPxgejK064uqt7ta/+f0BCSA1XU2Rgxx01/DNxo
	 TTTKFDbMDtCJWcQTiiCZXOrbsAMMAH8zN/4GeIb08gKBSetACc0c/yhco2it1OnuHV
	 hiubW/8fIAeMQTqogFs8NgzRPFKIe2zKPqjbmuPI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGJXyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgGJXyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:54:32 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FB5C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:54:31 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d21so4101176lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yPDc4YWgWbGk7IZLwT7LmgyK3OX3orfZrqhUS49J9i0=;
        b=LA1CntXRcKmQW83MPwHEZBbcDVUsBDDKQRWXDlDwoPSEqy01AQ0676tLb6oG5OQ76x
         8uXsgj3zVfAjePe0l1S9asa/XRPrJGIK9E3tqhBVaJLonFG1dnxkWRMIiYF9G8F1IGhX
         11FkXxAr9F84B3gaxK1y7mnLddz1mJhnBVFbE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPDc4YWgWbGk7IZLwT7LmgyK3OX3orfZrqhUS49J9i0=;
        b=MdwCOvQn2xKeZ/lNJTDZqzX3aYVCBpI9lx2dHJqvQxtodm1IxyV0HlgPMzbwlmFVy2
         3FP52FQHrdAhFYTQd4hZgCEnr3ou137BxOzA7WXYMBjYPW7IvbKX58tgOFGtVstoti4Z
         vgh/jewVFbxpNplFKBZkUDKdasAQQ8aWceSVw+5pqNdz2sdg3pwJ4nl42VZfTWtmLDKp
         QTpBwOupBeeRJYp4pBLrVuS5Al9obLMulIdkdL14g+Qa+fzEqJlLJliEizx2pMbXDkai
         lqO/vJ0F20REqoI3CHeFFwx2eHupmuwo9cY+VkzN14MoOsYfYajwtHri8exynbNIRTW8
         nQlw==
X-Gm-Message-State: AOAM531ej/7LPv+ZDXoPZyiQFqUJ58rhT04ZqlQMDG0kiOerm9GBtikx
        Xq39glNgzzileuNQB2Xs+lhaWaZJitM=
X-Google-Smtp-Source: ABdhPJy3zPScNAlaDX2C1SnWjNslLbmhOjOLaYG6QNAkJ6/sbcDpWWpvwoAwQJQMg/cSJr4CHG9elg==
X-Received: by 2002:a05:6512:52a:: with SMTP id o10mr45127417lfc.137.1594425269844;
        Fri, 10 Jul 2020 16:54:29 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r19sm2378557ljm.32.2020.07.10.16.54.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 16:54:28 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e8so8306594ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:54:28 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr36528941ljn.421.1594425267920;
 Fri, 10 Jul 2020 16:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com> <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <20200710225934.GA16881@localhost>
In-Reply-To: <20200710225934.GA16881@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 16:54:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
Message-ID: <CAHk-=wipXqemHbVnK1kQsFzGOOZ8FUXn3PKrZb5WC=KkgAjRRw@mail.gmail.com>
Subject: Re: Linux kernel in-tree Rust support
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        alex.gaynor@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 3:59 PM Josh Triplett <josh@joshtriplett.org> wrote:
>
> As I recall, Greg's biggest condition for initial introduction of this
> was to do the same kind of "turn this Kconfig option on and turn an
> option under it off" trick that LTO uses, so that neither "make
> allnoconfig" nor "make allyesconfig" would require Rust until we've had
> plenty of time to experiment with it.

No, please make it a "is rust available" automatic config option. The
exact same way we already do the compiler versions and check for
various availability of compiler flags at config time.

See init/Kconfig for things like

  config LD_IS_LLD
          def_bool $(success,$(LD) -v | head -n 1 | grep -q LLD)

and the rust support should be similar. Something like

  config RUST_IS_AVAILABLE
          def_bool $(success,$(RUST) ..sometest..)

because I _don't_ want us to be in the situation where any new rust
support isn't even build-tested by default.

Quite the reverse. I'd want the first rust driver (or whatever) to be
introduced in such a simple format that failures will be obvious and
simple.

The _worst_ situation to be in is that s (small) group of people start
testing their very special situation, and do bad and crazy things
because "nobody else cares, it's hidden".

No, thank you.

             Linus
