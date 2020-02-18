Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE2EC3404B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE9A20801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBRRQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:16:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35770 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726475AbgBRRQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:16:59 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01IHEs2F021040
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 12:14:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AF6994211EF; Tue, 18 Feb 2020 12:14:53 -0500 (EST)
Date:   Tue, 18 Feb 2020 12:14:53 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mark Salyzyn <salyzyn@android.com>
Cc:     Rob Herring <robh@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
Message-ID: <20200218171453.GE147128@mit.edu>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <158166062748.9887.15284887096084339722.stgit@devnote2>
 <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
 <20200214224744.GC439135@mit.edu>
 <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
 <20200215005336.GD439135@mit.edu>
 <243ab5a8-2ce1-1465-0175-3f5d483cbde1@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <243ab5a8-2ce1-1465-0175-3f5d483cbde1@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:01:51AM -0800, Mark Salyzyn wrote:
> I am additionally concerned about add_bootloader_randomness() because it is
> possible for it to sleep because of add_hwgenerator_randomness() as once it
> hits the entropy threshold. As-is it can not be used inside start_kernel()
> because the sleep would result in a kernel panic, and I suspect its use
> inside early_init_dt_scan_chosen() for the commit "fdt: add support for
> rng-seed" might also be problematic since it is effectively called
> underneath start_kernel() is it not?
> 
> If add_bootloader_randomness was rewritten to call add_device_randomness()
> always, and when trusted also called the functionality of the new
> credit_trusted_entropy_bits (no longer needing to be exported if so), then
> the function could be used in both start_kernel() and
> early_init_dt_scan_chosen().

That's a good point, and it's a bug in add_bootloader_randomness().
That should be easily fixed by simply having it call mix_pool_bytes()
and credit_entropy_bits() directly.  I'll create a patch...

    			  	     	  	   - Ted
