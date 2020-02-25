Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E948C35DF7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70D024656
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lvy1ps8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgBYFfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:35:09 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39169 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:35:08 -0500
Received: by mail-pg1-f196.google.com with SMTP id j15so6312578pgm.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w5F0TAnwoqyiRFFX6FnhAISLjzmCHL8nrpmKA4Sv/Wc=;
        b=lvy1ps8N9HL3Ky3pEQ3XVs1eeSEuZyfcgf9ogpLzwGj+ytlBxeQVL6JVLMFbjhCA82
         QX+RhtbEh788PMcuPDWVwYBVBxT5xAzl3HvHGWzOGMSTn4LIZBtSrmOojoM0+/pYZ2tV
         ax+XYeybsRpOoFTSxp19VISls9yIYwEB7NyMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5F0TAnwoqyiRFFX6FnhAISLjzmCHL8nrpmKA4Sv/Wc=;
        b=sDgqG7WXxexXum2fOdgstW7/Z2zN03PXwzl5cytcK+4jEBzbupMmEm3TigWzeaY5xN
         EDqwEAdkQWUZyZ0xZHk00tgyS5onq9IKg5JuaOcfhnuM7WUQfrR2vAc7ARRYYnipAj27
         7BDT1Cd5CG2l5QjjORagATlqVvGBAxc3Ef7M7DljHWa0yAIrW8tleOQU1fnRLGwNNfsq
         mbnILq5au+Gb0nn9kAdb4ZbvaNl4aR41uN6fxNvNvqifN1XIQVTWzt6c2XAi7kUXBN5K
         pet61b3lXjAqjGk0finz0940sQXrZ4Z4iLJq80Qi95KGDtByUt+C2iMVSUjZ/kyEJXo7
         4oJw==
X-Gm-Message-State: APjAAAWT/Pk7lYZA6bAuvSbBKUsnUHXWaCWpnE67Nzx6WCYZ/fJ7byQR
        CjkivWYhx+UlHmwf3oHNO6gw2w==
X-Google-Smtp-Source: APXvYqyI7bEXnfF4ZNGpTzMtWwxXGP29xbiD8F+7Oc1sUPjZw3B++TcJuN/6uS66PmSnDDIu99N/xQ==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr37952913pfi.210.1582608906597;
        Mon, 24 Feb 2020 21:35:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l10sm1414942pjy.5.2020.02.24.21.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:35:05 -0800 (PST)
Date:   Mon, 24 Feb 2020 21:35:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>
Subject: Re: --orphan-handling=warn (was Re: [PATCH 2/2] x86/boot/compressed:
 Remove unnecessary sections) from bzImage
Message-ID: <202002242122.AA4D1B8@keescook>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 03:20:39PM -0800, Nick Desaulniers wrote:
> Kees is working on a series to just be explicit about what sections
> are ordered where, and what's discarded, which should better handle
> incompatibilities between linkers in regards to orphan section
> placement and "what does `*` mean."  Kees, that series can't come soon

So, with my series[1] applied, ld.bfd builds clean. With ld.lld, I get a
TON of warnings, such as:

(.bss.rel.ro) is being placed in '.bss.rel.ro'
(.iplt) is being placed in '.iplt'
(.plt) is being placed in '.plt'
(.rela.altinstr_aux) is being placed in '.rela.altinstr_aux'
(.rela.altinstr_replacement) is being placed in
'.rela.altinstr_replacement'
(.rela.altinstructions) is being placed in '.rela.altinstructions'
(.rela.apicdrivers) is being placed in '.rela.apicdrivers'
(.rela__bug_table) is being placed in '.rela__bug_table'
(.rela.con_initcall.init) is being placed in '.rela.init.data'
(.rela.cpuidle.text) is being placed in '.rela.text'
(.rela.data..cacheline_aligned) is being placed in '.rela.data'
(.rela.data) is being placed in '.rela.data'
(.rela.data..percpu) is being placed in '.rela.data..percpu'
(.rela.data..percpu..page_aligned) is being placed in '.rela.data..percpu'
...

But as you can see in the /DISCARD/, these (and all the others), should
be getting caught:

        /DISCARD/ : {
                *(.eh_frame)
+               *(.rela.*) *(.rela_*)
+               *(.rel.*) *(.rel_*)
+               *(.got) *(.got.*)
+               *(.igot.*) *(.iplt)
        }

I don't understand what's happening here. I haven't minimized this case
nor opened an lld bug yet.

> enough. ;) (I think it's intended to help "fine grain" (per function)
> KASLR).  More comments in the other thread.

Actually, it's rather opposed to the FGKASLR series, as for that, I need
some kind of linker script directive like this:

	/PASSTHRU/ : {
		*(.text.*)
	}

Where "PASSTHRU" would create a 1-to-1 input-section to output-section
with the same name, flags, etc.

ld.bfd's handling of orphan sections named .text.* is to put them each
as a separate output section, after the existing .text output section.

ld.lld's handling of orphan sections named .text.* is to put them into
the .text output section.

For FGKASLR (as it is currently implemented[2]), the sections need to be
individually named output sections (as bfd does it). *However*, with the
"warn on orphans" patch, FGKASLR's intentional orphaning will backfire
(I guess the warning could be turned off, but I'd like lld to handle
FGKASLR at some point.)

Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
entry linker script ... made ld.lld take about 15 minutes to do the
final link. :(

> Taken from the Zen of Python, but in regards to sections in linker
> scripts, "explicit is better than implicit."

Totally agreed. I just hope there's a good solution for this PASSTHRU
idea...

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=linker/orphans/x86-arm
[2]
https://github.com/kaccardi/linux/commit/127111e8c6170a130d8d12d73728e74acbe05e13

-- 
Kees Cook
