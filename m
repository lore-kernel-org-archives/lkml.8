Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14255C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B412176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RrJsXoLA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgBYTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:43:02 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:37785 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBYTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:43:02 -0500
Received: by mail-pl1-f170.google.com with SMTP id q4so223268pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3YfOF9RdWClbkrgasFARaQYtBEE4BEedB2tPnWISAw=;
        b=RrJsXoLAHw+G5clxtlauuLY1hjIS6S8ZYT7r/W0RP0UckpF8t6OgXk/qJuKXZDstfS
         7b6XDUaQIOB5ARE2h/mtV5LdX6MMevzPzjPyTGm9uDUOYN8/f2t27TW8KCeyk1SzU3uk
         vpdo+upjSaggvemoA98wyofX22yAisydyYYSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3YfOF9RdWClbkrgasFARaQYtBEE4BEedB2tPnWISAw=;
        b=Gi5w/lkaFDL9nm4pLZb5mEhK/RA6rR1xUmPxbwla8+Mpnk2pXg8LSL2uKbcpXu+SVP
         yPbtDsQCp++GmZYLLsK/EE20qZHHp8X5zScVMhsEygKF/8vMx/hyVPwzc1xLKjG2q4B9
         czts4nZGnHRTM331oump/IZA6K055/t8vmr4dICqlrqNTcB1cF9syDfqARkKomyUoxT/
         Y9/O6E57urg5v9D1GvUKpHAjR/G43sL42KgOzTKY3m0x231z3VRDLCZnzcSxCuCoaWM9
         fYcpCNQUoBOKhxa2AZ9rn8UqoI/tySwP+PQ4Tr5OnonkppCN/lh8CLMflstbDQ2ai8NV
         PAww==
X-Gm-Message-State: APjAAAUeWkd24fjGbpgjdszaZOyd8F7YZJ9+E0xUQbS3kNtkT9ku5Rel
        oW6/VehdjKj5uTyu8nYxhq1BSQ==
X-Google-Smtp-Source: APXvYqw1LZ9yzb/P46yAhpDHbOCbKWST/UnkgU320jp8lDY5lb35PBmB0rj0HID9gKrvf2M9hQvt/Q==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr157561plr.42.1582659779668;
        Tue, 25 Feb 2020 11:42:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w18sm17647703pge.4.2020.02.25.11.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 11:42:58 -0800 (PST)
Date:   Tue, 25 Feb 2020 11:42:58 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: --orphan-handling=warn
Message-ID: <202002251140.4F28F0A4F@keescook>
References: <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
 <20200225182951.GA1179890@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225182951.GA1179890@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 01:29:51PM -0500, Arvind Sankar wrote:
> On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
> > Actually, it's rather opposed to the FGKASLR series, as for that, I need
> > some kind of linker script directive like this:
> > 
> > 	/PASSTHRU/ : {
> > 		*(.text.*)
> > 	}
> > 
> > Where "PASSTHRU" would create a 1-to-1 input-section to output-section
> > with the same name, flags, etc.
> > 
> > ld.bfd's handling of orphan sections named .text.* is to put them each
> > as a separate output section, after the existing .text output section.
> > 
> > ld.lld's handling of orphan sections named .text.* is to put them into
> > the .text output section.
> 
> This doesn't match ld's documentation [1] of how orphan sections are to
> be handled, it's supposed to append it into an existing output section
> only if the names match exactly, creating a new one if that isn't so. If
> ld.lld is to be a drop-in replacement for ld.bfd, this probably needs to
> change?

That would be lovely! :P

> Also ld.lld doesn't seem to support the --unique option, I think you'll
> also want that for FGKASLR to avoid merging static functions with the
> same name from unrelated source files.

Right, yes, that seems like something we have to depend on.

> 
> [1] https://sourceware.org/binutils/docs/ld/Orphan-Sections.html
> 
> > 
> > For FGKASLR (as it is currently implemented[2]), the sections need to be
> > individually named output sections (as bfd does it). *However*, with the
> > "warn on orphans" patch, FGKASLR's intentional orphaning will backfire
> > (I guess the warning could be turned off, but I'd like lld to handle
> > FGKASLR at some point.)
> > 
> > Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> > entry linker script ... made ld.lld take about 15 minutes to do the
> > final link. :(
> 
> Out of curiosity, how long does ld.bfd take on that linker script :)

A single CPU at 100% for 15 minutes. :)

-- 
Kees Cook
