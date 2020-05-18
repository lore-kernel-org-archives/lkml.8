Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFE2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6DA20826
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589820592;
	bh=xRjB/5JpqW83G+oMZxIS+hA+0CPCV7b4cUhUnzEu5xo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XIOJKi2JYK47c/yhLpF3fM49Rlrf3gDTKqjGb50ViRkzttgfpuo+ZHXidBZX4grg6
	 MLCVkxwlSHHVg8vOEkweUj2vSe9Ay9emAlxQCx5asd/xnkvPHj+/kAwTfJFPICP6PR
	 MfBr7DyvG94xCe20UVLHY5qKiNz5JqKuvg3nJ80o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgERQtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgERQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:49:50 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B15EC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:49:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z18so2397987lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KygdLUcTs6knBX0F3T/JLZYcVgSrVEzt6jZyrJ+boZQ=;
        b=S9bunU4mXjCTchqmsktCwiUzwrjCVNgd8YdFx6fqrfQbJSITfJ3Gfe0UZSPKy1COMq
         XgtV3MuVzYZ10FDt3fKxp2DI4i0KU99M1qsxjthk3kmKU65B8LYjZ+6gpdV3oGSJtrEX
         CvNN34lX+RlxUFi8ZDs+UvDfbUaWrrsJnAN1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KygdLUcTs6knBX0F3T/JLZYcVgSrVEzt6jZyrJ+boZQ=;
        b=GcOBtPFhDGF0kWP28Di/lSCJjiZ+r5+5W8fDCconW+TIjV/KTT4edWWcFINUJH4Vn0
         A8lUheeZQWoOol/OHGwyfvwhifsNuXYGualSuVIVppnl/z93+yTkITpq+RkNVaghqW6e
         6t2cnAXGmqNvR9J1qXc/0z9vJd/q6sY5jvHjQTvRqwyVsfkJ6OHUAnOiev3VVCr/AzUo
         SNC4Ej9p1rkcaUs8WhGu4VHx16cKpA8Wiqldh+pEqwgwEZGVJ+0hCJt6100noKqrTUii
         eSuFgJIX9xFYxsSb1YtJQs3aj+YzpfllgASHrN577dzKQZCntE3E7m9MwWH+olAdHWR/
         ZCsg==
X-Gm-Message-State: AOAM5321cqhj71tc794/UTpyMYbAR47u2jr1NsYltVnOG8snALw90baw
        Ll3l0trVJIHIHkY5u6Ivm3brnUPTKqM=
X-Google-Smtp-Source: ABdhPJw/Q+aDT4utOIuzhRRU/TPFw3qRnpuZAEIvRDiq7ybUqCTndff0hIFJdGnuDQ40rZ/younkhA==
X-Received: by 2002:a2e:7807:: with SMTP id t7mr11108457ljc.151.1589820588381;
        Mon, 18 May 2020 09:49:48 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id s12sm4145008ljo.70.2020.05.18.09.49.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 09:49:47 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id v5so8648774lfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 09:49:47 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr3329357lfo.152.1589820586909;
 Mon, 18 May 2020 09:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200518145723.65b89375@canb.auug.org.au> <968394.1589817650@warthog.procyon.org.uk>
In-Reply-To: <968394.1589817650@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 May 2020 09:49:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6J-iqrCr_7oLDCbS8qXQ69EF=nPLWmvBiDmgdNWZ6KA@mail.gmail.com>
Message-ID: <CAHk-=wj6J-iqrCr_7oLDCbS8qXQ69EF=nPLWmvBiDmgdNWZ6KA@mail.gmail.com>
Subject: Re: How should we handle a bool depending on a tristate?
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 9:01 AM David Howells <dhowells@redhat.com> wrote:
>
>
> Blech.  Yeah.  "depends on" doesn't work either.  The problem actually lies
> within the Kconfig framework.  It doesn't know how to handle a bool depending
> on a tristate.

No problem with Kconfig. It knows exactly how to let a bool depend on
a tristate.

It's just that there are two different kinds of dependencies.

For example, the dependency can be a hard and absolute dependency
(linking doesn't work, or whatever), and then obviously built-in code
cannot be enabled if the thing it depends on is a loadable module.

But the dependency can also be a conceptual one: "This option doesn't
make sense unless that option is set". Then a bool can make sense even
if the other config is a modular one.

And Kconfig can deal with either situation just fine.

Do

    depends on XYZ = y

or

    depends on XYZ != n

to clarify the choice. One requires a hard dependency, the other
requires that the  option just be enabled.

Now, if you just do "depends on XYZ", it allows a bool to be enabled
even for just a module (ie that second case). That makes sense for a
lot of "allow this feature in the module" kind of options, where it
would be pointless to even ask about a boolean feature if the parent
module isn't even enabled.

But that "depends on XYZ=y" is not uncommon. It basically says "this
option makes sense only when built in". Either because it requires it
for linking, or just because it doesn't work or make sense without it.

                     Linus
