Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CDA2C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 199D020873
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgBKPIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:08:45 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49440 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727668AbgBKPIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:08:44 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-101.corp.google.com [104.133.0.101] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01BF7pYW001934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 10:07:52 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D3E46420324; Tue, 11 Feb 2020 10:07:50 -0500 (EST)
Date:   Tue, 11 Feb 2020 10:07:50 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
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
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <20200211150750.GA3630@mit.edu>
References: <20200207150809.19329-1-salyzyn@android.com>
 <20200207155828.GB122530@mit.edu>
 <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
 <20200208004922.GE122530@mit.edu>
 <20200210121325.GA7685@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210121325.GA7685@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 12:13:25PM +0000, Mark Brown wrote:
> > The second is that we're treating rng_seed as being magic, and if
> > someone tries to pass in something like rng_seed=0x7932dca76b51
> > because they didn't understand how rng_seed was going to work, it
> > would be surprising.
> 
> We already have a kaslr-seed property on arm64 since we need a seed for
> KASLR *super* early, we could generalize that I guess but it's not clear
> to me that it's a good idea.  One fun thing here is that the kernel
> command line is visible to userspace so we go and erase the seed from
> the command line after reading it.

This is exactly what this patch is doing, in fact (it is erasing the
seed from the command line).

> > My preference would be to pass in the random seed *not* on the
> > command-line at all, but as a separate parameter which is passed to
> > the bootloader, just as we pass in the device-tree, the initrd and the
> > command-line as separate things.  The problem is that how we pass in
> > extra boot parameters is architecture specific, and how we might do it
> > for x86 is different than for arm64.  So yeah, it's a bit more
> > inconvenient to do things that way; but I think it's also much
> > cleaner.
> 
> Anything that requires boot protocol updates is going to be rather
> difficult to deploy for the use it'll likely get - as far as I can see
> we're basically just talking about the cases where there's some entropy
> source available to the bootloader that the kernel can't get at
> directly.  With the arm64 kaslr-seed it's not clear that people are
> feeding actual entropy in there, they could be using something like the
> device serial number to give different layouts on different devices even
> if they can't get any useful entropy for boot to boot variation.

So here's one thing we could do; we could require something like:

rng_seed=<nr_bits>,<base-64 encoded string of 32 bytes>

... where the kernel parses rng_seed, and errors out if nr_bits is
greater than 256, and errors out if the base-64 encoded string is not
valid, and then replaces it with the SHA-256 hash of the rng seed,
base-64 encoded.

That way if there is a crappy handset which is just encoding the
device serial number, it becomes painfully obvious that someone is
cheating.

Is that overkill?  Well, from my perspective, we're talking about an
industry that was willing to turn the CPU thermal safety limits when
certain benchmark applications were detected to be running, just to
gain a commercial advantage.  So trust doesn't come easily to me, when
it comes to corporate desires of expediency.  :-)

	       	     	     	  	    - Ted
