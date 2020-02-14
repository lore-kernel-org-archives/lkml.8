Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9074BC3B1B7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659CB222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581704111;
	bh=EgUf06AnxJMKKDD9vyJH7e9zyuboRGgH8QAWwfCzsDE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qyespCNS3VJsjfZgL1LFHdQY00O3qN8ESzWF3G7MqkqF4Q+4YPdVleb6zSIAOKzj7
	 L4gvG6zavNKIi2v8cgxFe1AO7Jp9MfM3xawPtZjP1m29UxIEep4mboCue1lMbMIRGX
	 4AnNejPdmXpEsSWbD/Yxi9U4NfQ1wvCuKJi5hltI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbgBNSPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:15:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403889AbgBNSPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:15:07 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84D7D2468D;
        Fri, 14 Feb 2020 18:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581704106;
        bh=EgUf06AnxJMKKDD9vyJH7e9zyuboRGgH8QAWwfCzsDE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nZm10juJDfo2Yj82liZpPmIrIhwcXj3fMK4wNQ63R5sKqZahT0J541opn6Y9KxtqM
         ZtnTUYYvsGLLcmxPXiE+lRyUBJSF/VWm6e9ozUt8Eu7GEq7sWz0L6cpWbZ9F+js8M/
         nvXSd+CB4UnQkmhAAWv07+BbOiNFFWKPj18wiZPE=
Received: by mail-qt1-f176.google.com with SMTP id d18so7568169qtj.10;
        Fri, 14 Feb 2020 10:15:06 -0800 (PST)
X-Gm-Message-State: APjAAAVP49jSHFKzyjF1pc1JoIzvGE9oo7avw605O41P9X930rrPejwf
        WCYRZPjEpNkz7tn5zGPTNnJE79JAfrl+S4cXFg==
X-Google-Smtp-Source: APXvYqxw+F4z1ZYq1QXrq+yJXzMLC4EqWE0yp7S40U2pHrAhLEMwW0jmuZvKNd4LOAWn0VfF1Z6wh3ZcM0sed4WWACc=
X-Received: by 2002:aed:2344:: with SMTP id i4mr3684530qtc.136.1581704105492;
 Fri, 14 Feb 2020 10:15:05 -0800 (PST)
MIME-Version: 1.0
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com> <1694f42c-bfc9-570a-64d2-3984965c8940@android.com>
In-Reply-To: <1694f42c-bfc9-570a-64d2-3984965c8940@android.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Feb 2020 12:14:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
Message-ID: <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 11:00 AM Mark Salyzyn <salyzyn@android.com> wrote:
>
> On 2/14/20 5:49 AM, Rob Herring wrote:
> > On Fri, Feb 14, 2020 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >> Hi,
> >>
> >> The following series is bootconfig based implementation of
> >> the rng_seed option patch originally from Mark Salyzyn.
> >> Note that I removed unrelated command line fixes from this
> >> series.
> > Why do we need this? There's already multiple other ways to pass
> > random seed and this doesn't pass the "too complex for the command
> > line" argument you had for needing bootconfig.
> >
> > Rob
>
> Android is the use case I can vouch for. But also KVM.
>
> Android Cuttlefish is an emulated device used extensively in the testing
> and development infrastructure for In-house, partner, and system and
> application developers for Android. There is no bootloader, per-se.
> Because of the Android GKI distribution, there is also no rng virtual
> driver built in, it is loaded later as a module, too late for many
> aspects of KASLR and networking. There is no Device Tree, it does
> however have access to the content of the initrd image, and to the
> command line for the kernel. The only convenient way to get early
> entropy is going to have to be one of those two places.

I'm familiar with Cuttlefish somewhat. Guess who got virtio-gpu
working on Android[1]. :) I assume DT doesn't work for you because you
need x86 builds, but doesn't QEMU use UEFI in that case which also has
a mechanism for passing entropy.

To clarify my question: Why do we need random seed in bootconfig
rather than just the kernel command line? I'm not understanding why
things changed from your original patch.

> In addition, 2B Android devices on the planet, especially in light of
> the Android GKI distribution were everything that is vendor created is
> in a module, needs a way to collect early entropy prior to module load
> and pass it to the kernel. Yes, they do have access to the recently
> added Device Tree approach, and we expect them to use it, as I have an
> active backport for the mechanism into the Android 4.19 and 5.4 kernels.
> There may also be some benefit to allowing the 13000 different
> bootloaders an option to use bootconfig as a way of propagating the much
> needed entropy to their kernels. I could make a case to also allow them
> command line as another option to relieve their development stress to
> deliver product, but we can stop there. Regardless, this early entropy
> has the benefit of greatly improving security and precious boot time.

We're going to update 13000 bootloaders to understand bootconfig
rather than use the infrastructure already in place (DT and/or command
line)?

bootconfig is an ftrace feature only IMO. If it's more than that, I
imagine there will be some opinions about that. Adding new
bootloader-kernel interfaces is painful and not something to just add
without much review.

Rob
