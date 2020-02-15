Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA0CC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB817217F4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 00:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581725848;
	bh=0TKEdWN6SIgbxXSKWc4lndzp4gWiftZNNLwKKtQQyF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ba0dLoIQa6k3KTkwDxOm6swcUJf2Gm4uD5iBC5CA2uUC9pv5Lwa9igd1XYxVN9cNl
	 06IbrP8+SO3TZ1oVJ8NQQ86o70QnKSgZlWxu7X71xaxPzTWc8P19QI9F0Ug0+QFMm8
	 1sZlv6uXXTybHg4UmTsxJYWSsK0MBVM9Migc1Kr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBOAR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 19:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgBOAR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 19:17:27 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9D93207FF;
        Sat, 15 Feb 2020 00:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581725846;
        bh=0TKEdWN6SIgbxXSKWc4lndzp4gWiftZNNLwKKtQQyF4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQAwE8iBhkKbW2wIezXRYLdvtYyBnfKcGq5xfMtirqsljp5zJjd4urdXNOvxfGGEk
         mnET3Wm7ehwMqXNv49e/b+0M59o6q8mtdASEHsfuOLbno/BsvX+fwfXljZmWZCjyxe
         Q7udDoqFD9xNFG3s+hEZ51hz3LV5oic0zuYXcX7g=
Date:   Sat, 15 Feb 2020 09:17:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Salyzyn <salyzyn@android.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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
Subject: Re: [PATCH 0/3] random: add random.rng_seed to bootconfig entry
Message-Id: <20200215091718.129eecc9b65a9c41c91027b0@kernel.org>
In-Reply-To: <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
        <CAL_JsqJ_VwHdpQ_WnQHu5J-bfs1vRPd5HQwVekR+5kKdVi4sXw@mail.gmail.com>
        <1694f42c-bfc9-570a-64d2-3984965c8940@android.com>
        <CAL_JsqKb=qBH6QXphEZi7vMS+2K5kNj1riXQiUWma=bidAjN5A@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 14 Feb 2020 12:14:53 -0600
Rob Herring <robh@kernel.org> wrote:

> To clarify my question: Why do we need random seed in bootconfig
> rather than just the kernel command line? I'm not understanding why
> things changed from your original patch.

I recommended to use it in the previous thread, because of simplicity.
Since it has to hide from userspace and modules, it needs to modify
kernel command line. But the bootconfig can make it simple, and it
also architecture independent.

> > In addition, 2B Android devices on the planet, especially in light of
> > the Android GKI distribution were everything that is vendor created is
> > in a module, needs a way to collect early entropy prior to module load
> > and pass it to the kernel. Yes, they do have access to the recently
> > added Device Tree approach, and we expect them to use it, as I have an
> > active backport for the mechanism into the Android 4.19 and 5.4 kernels.

FYI, I backported bootconfig with boot-time tracer for 4.19 stable kernel
recently.

https://github.com/mhiramat/linux/commits/ftrace-boottrace-4.19

You can check what commits are related.

> > There may also be some benefit to allowing the 13000 different
> > bootloaders an option to use bootconfig as a way of propagating the much
> > needed entropy to their kernels. I could make a case to also allow them
> > command line as another option to relieve their development stress to
> > deliver product, but we can stop there. Regardless, this early entropy
> > has the benefit of greatly improving security and precious boot time.
> 
> We're going to update 13000 bootloaders to understand bootconfig
> rather than use the infrastructure already in place (DT and/or command
> line)?
> 
> bootconfig is an ftrace feature only IMO. If it's more than that, I
> imagine there will be some opinions about that. Adding new
> bootloader-kernel interfaces is painful and not something to just add
> without much review.

The bootconfig itself is designed as a generic feature. I had tried to use
devicetree, but that was rejected. Thus I made it as a "software
configuration tree" (but far simpler.)
 
If you have any review comment on the bootconfig, always welcome!
Seriously, I would like to have more comments. I want to make it better.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
