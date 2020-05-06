Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C80C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D83720A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft34+Tuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbgEFPcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgEFPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:31:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97471C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:31:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so1682292otp.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HGob2W+jtJ1wxr5TyUwXRK5f3ACyssA5mwEkdojnzSc=;
        b=ft34+Tuj1/EXggzTdLuevyBjykqE8Mo6BrUQeaVcw0R26trAW03x2IpOBwVX+aWtN+
         zenPFzWx92ITkR0k2zz/kScA82yz+x+GJpQQ9bjvzKrl+llIb59Dw88EiShplEqNKGf5
         QV7Zgmr9AiRNNRkhp257Q9EbG7UA/k8IA8smqoPoLeMlZc14E9IEsR446khqN8j0PzOz
         e3enOxOtzg7qzTWl/NJv4tgCCBvCOMn0EwZl57xNr4a7I9QvqhNlM8UHOyPCxZP/4fu9
         32fEWgM1q4dPoIPW9Mp/d3xx/l1PdjgM4oJGfPC+ZWvtFbKFgWr9sHtxu9ffO85zcG4X
         50oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HGob2W+jtJ1wxr5TyUwXRK5f3ACyssA5mwEkdojnzSc=;
        b=aN8NEYy+Z8YgpFLw98rG4StbgWixw4uNu6YuTv3o49lamtZYNQ5I+tWCyHqZXc9mbP
         ttElam/zahfpsWLfUZXWn0BaItdIgW4C7FF47j/KNK807jUl3AP+eayXtTt12VM2Ptr7
         Owj/W9PUsBvzzom+A5lXyJPn+RQa1GeIBb5mgmN+F2DUw6pkOIKlK3bSOdtIdzEpVXUA
         qMe9CtiWWHBd80AF+tbddGj9OdjGIsqirC4UFTJDYyW4gcr8/9MsDXIUSuiQiUmKWLI8
         x6dLnPFrE0p7+N16mvVsWyLyWKei9W1sYH7GglnbjNz11DJwpGDzcCoC/IILByllw5yq
         L/VA==
X-Gm-Message-State: AGi0PubQeQqGVpiVVRV1ZRgUXN2X5Zkl7KTdotJgKJmrV4zk04C77wIU
        t5Q0TnfVftE1HpH4bpMDCs0OxGkYJzg=
X-Google-Smtp-Source: APiQypLu+rugV5iMHAMDUMStivxbyqze+0IvgUKVeYPMJwAz9l+XPCxlS3esB3VFosY4NfT4vVb8qA==
X-Received: by 2002:a05:6830:1d9c:: with SMTP id y28mr7465935oti.280.1588779118864;
        Wed, 06 May 2020 08:31:58 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m189sm600819oig.12.2020.05.06.08.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:31:58 -0700 (PDT)
Date:   Wed, 6 May 2020 08:31:56 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Torsten Duwe <duwe@lst.de>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
Message-ID: <20200506153156.GA1213645@ubuntu-s3-xlarge-x86>
References: <20200505141257.707945-1-arnd@arndb.de>
 <20200505142556.GF82823@C02TD0UTHF1T.local>
 <20200505194243.5bfc6ec6@blackhole>
 <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
 <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a24EiEvGAenL0FdgGakmwWi=giReOJuiisnzkgC_SuhZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:22:58PM +0200, Arnd Bergmann wrote:
> On Wed, May 6, 2020 at 5:45 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> > On Tue, May 05, 2020 at 07:42:43PM +0200, Torsten Duwe wrote:
> > > On Tue, 5 May 2020 15:25:56 +0100 Mark Rutland <mark.rutland@arm.com> wrote:
> > > > On Tue, May 05, 2020 at 04:12:36PM +0200, Arnd Bergmann wrote:
> > > > This practically rules out a BE distro kernel with things like PAC,
> > > > which isn't ideal.
> >
> > To be fair, are there big endian AArch64 distros?
> >
> > https://wiki.debian.org/Arm64Port: "There is also a big-endian version
> > of the architecture/ABI: aarch64_be-linux-gnu but we're not supporting
> > that in Debian (so there is no corresponding Debian architecture name)
> > and hopefully will never have to. Nevertheless you might want to check
> > for this by way of completeness in upstream code."
> >
> > OpenSUSE and Fedora don't appear to have support for big endian.
> 
> I don't think any of the binary distros ship big endian ARM64. There are
> a couple of users that tend to build everything from source using Yocto
> or similar embedded distros, but as far as I can tell this is getting less
> common over time as applications get ported to be compatible with
> big-endian, or get phased out and replaced by code running on regular
> little-endian systems.
> 
> The users we see today are likely in telco, military or aerospace
> settings (While earth is mostly little-endian these days, space is
> definitely big-endian) that got ported from big-endian hardware, but
> often with a high degree of customization and long service life.

Ah yes, that makes sense, thanks for the information and background.
Helps orient myself for the future.

> My policy for Arm specific kernel code submissions is generally that
> it should be written so it can work on either big-endian or little-endian
> using the available abstractions (just like any architecture independent
> code), but I don't normally expect it to be tested on big endian.
> 
> There are some important examples of code that just doesn't work
> on big-endian because it's far too hard, e.g. the UEFI runtime services.
> That is also ok, if anyone really needs it, they can do the work.
> 
> > > I suggest to get a quote from clang folks first about their schedule and
> > > regarded importance of patchable-function-entries on BE, and leave it as
> > > is: broken on certain clang configurations. It's not the kernel's fault.
> >
> > We can file an upstream PR (https://bugs.llvm.org) to talk about this
> > (although I've CC'd Fangrui) but you would rather the kernel fail to
> > work properly than prevent the user from being able to select that
> > option? Why even have the "select" or "depends on" keyword then?
> 
> I definitely want all randconfig kernels to build without warnings,
> and I agree with you that making it just fail at build time is not
> a good solution.
> 
> > That said, I do think we should hold off on this patch until we hear
> > from the LLVM developers.
> 
> +1
> 
>       Arnd

Glad we are on the same page.

Cheers,
Nathan
