Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301C1C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BFA8206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBHAuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 19:50:18 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53822 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727131AbgBHAuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 19:50:18 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0180nMPw011787
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Feb 2020 19:49:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 88C16420324; Fri,  7 Feb 2020 19:49:22 -0500 (EST)
Date:   Fri, 7 Feb 2020 19:49:22 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <20200208004922.GE122530@mit.edu>
References: <20200207150809.19329-1-salyzyn@android.com>
 <20200207155828.GB122530@mit.edu>
 <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 09:49:17AM -0800, Mark Salyzyn wrote:
> > > It is preferred to add rng-seed to the Device Tree, but some
> > > platforms do not have this option, so this adds the ability to
> > > provide some command-line-limited data to the entropy through this
> > > alternate mechanism.  Expect all 8 bits to be used, but must exclude
> > > space to be accounted in the command line.
> > "all 8 bits"?
> 
> Command line (and Device Tree for that matter) can provide 8-bits of data,
> and specifically for the command line as long as they skip space and nul
> characters, we will be stripping the content out of the command line because
> we strip it from view, so that no one gets hot and bothered.

What wasn't obvious to me initially (and should be clearly documented
in the commit description as well as elsewhere) is that we are already
adding the entire boot command-line string using
"add_device_randomness()" and so what this commit is doing is simply
counting the length of xxx in "rng_seed=xxx" and assuming that those
bytes are 100% entropy and simply crediting the trusted entropy by
length of xxx.  If xxx happened to be a hex string, or worse, was
hard-coded in /etc/grub.conf as "rng_seed=supercalifragilisticexpialidocious"
with this commit (and CONFIG_RANDOM_TRUST_BOOTLOADER), it would assume
that it is safe to credit the boot command line has having sufficient
entropy to fully initialize the CRNG.

> I expected this to be contentious, this is why I call it out. Does _anyone_
> have a disagreement with allowing raw data (minus nul and space characters)
> to be part of the rng-seed?

There are two parts of this that might be controverisial.  The first
is that there isn't actually *fully* eight bits; it's really
log_2(254) bits per caharacter, since NUL and SPC aren't valid.

The second is that we're treating rng_seed as being magic, and if
someone tries to pass in something like rng_seed=0x7932dca76b51
because they didn't understand how rng_seed was going to work, it
would be surprising.

My preference would be to pass in the random seed *not* on the
command-line at all, but as a separate parameter which is passed to
the bootloader, just as we pass in the device-tree, the initrd and the
command-line as separate things.  The problem is that how we pass in
extra boot parameters is architecture specific, and how we might do it
for x86 is different than for arm64.  So yeah, it's a bit more
inconvenient to do things that way; but I think it's also much
cleaner.

					- Ted
