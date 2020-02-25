Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6624C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 953EF20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jpmh+RNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgBYS3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:29:55 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]:34630 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgBYS3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:29:55 -0500
Received: by mail-qt1-f180.google.com with SMTP id l16so367230qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 10:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dcyqLzOqexgUYT665cSkM8WWwCRhPRScopxtXSuIwhE=;
        b=Jpmh+RNFwunTVE54TkNAMpIsJMC14pvYiihY2wibmIpVX0RbbLKqd+eRY+qLo+5dMX
         SX/9q41bGSyzvt8Pwk0COP3eLMg2ZuR8i3keXR/Ugag06NeXPkgJ++b/DqwsqlDv6h7+
         dJaE04Hrv00OVzAXInk6W742RND5wYHL7IHyjiVU9HtD+l9sgmi/BIP9DZuGBiHDIzVV
         Rl4hgFqlbrS9uGoF/YYTKpoMUsz8acQVTVOIgh91x4yI55/FFGIeh7pE/6+FAYAlirwH
         yPRpZ3lT1j/DlxMhxVX5gxm7z6uk+L9PQ0ggSo1OmHOQfC4eMGwm53EBmu/xPLat2a7M
         jmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=dcyqLzOqexgUYT665cSkM8WWwCRhPRScopxtXSuIwhE=;
        b=soZxjU0yVck9VZZhsQ8G5lJERbJmWeCy3onvl6YZCHlp80UzjiNtT9IJwZ1L6alGJn
         kI9srOfLAATUomEbrKmUHzqVoRea3Pp0wfkB2q7Xuqb5B3A8tRLrXmS6zjDBk7CZuFPF
         U5PB+bHB//MYHG7X1HOxWjkPfgE/ZKEcmNeXYFs/al+Jk4W2CZYmrSxGFpqZB1G7y9qS
         vfskjiTnIBbrsxpPK9XWGdJaHnB7V8FwKWzpVi4Ko8TTo1eDQzwGv+OqXLgA8N1drQfm
         LmGTaBf5GXtFTXHLqciK98bOFNyFFiWDspIUHXB4br8UOflB3baM7ThohZi1+dR7M1dx
         iLiA==
X-Gm-Message-State: APjAAAVvuT5wuTQ5+cAgtLM71TzBwHRL7kvFMeCnxAl/4IXVJ8FsrFlT
        vIwttxu7yo06mVa3RArctIg=
X-Google-Smtp-Source: APXvYqyBzz8PIiE4DMeQoSS0UbMGeYfXX70NFgGSlsN335mu/Ia42Q1kv7+TZ9UcbD3LmRz8jwx0yQ==
X-Received: by 2002:ac8:1e90:: with SMTP id c16mr54660410qtm.265.1582655393994;
        Tue, 25 Feb 2020 10:29:53 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o25sm7843946qkk.7.2020.02.25.10.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 10:29:53 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 25 Feb 2020 13:29:51 -0500
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>
Subject: Re: --orphan-handling=warn
Message-ID: <20200225182951.GA1179890@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
 <20200109150218.16544-2-nivedita@alum.mit.edu>
 <20200222050845.GA19912@ubuntu-m2-xlarge-x86>
 <20200222065521.GA11284@zn.tnic>
 <20200222070218.GA27571@ubuntu-m2-xlarge-x86>
 <20200222072144.asqaxlv364s6ezbv@google.com>
 <20200222074254.GB11284@zn.tnic>
 <20200222162225.GA3326744@rani.riverdale.lan>
 <CAKwvOdnvMS21s9gLp5nUpDAOu=c7-iWYuKTeFUq+PMhsJOKUgw@mail.gmail.com>
 <202002242122.AA4D1B8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202002242122.AA4D1B8@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 09:35:04PM -0800, Kees Cook wrote:
> 
> Actually, it's rather opposed to the FGKASLR series, as for that, I need
> some kind of linker script directive like this:
> 
> 	/PASSTHRU/ : {
> 		*(.text.*)
> 	}
> 
> Where "PASSTHRU" would create a 1-to-1 input-section to output-section
> with the same name, flags, etc.
> 
> ld.bfd's handling of orphan sections named .text.* is to put them each
> as a separate output section, after the existing .text output section.
> 
> ld.lld's handling of orphan sections named .text.* is to put them into
> the .text output section.

This doesn't match ld's documentation [1] of how orphan sections are to
be handled, it's supposed to append it into an existing output section
only if the names match exactly, creating a new one if that isn't so. If
ld.lld is to be a drop-in replacement for ld.bfd, this probably needs to
change?

Also ld.lld doesn't seem to support the --unique option, I think you'll
also want that for FGKASLR to avoid merging static functions with the
same name from unrelated source files.

[1] https://sourceware.org/binutils/docs/ld/Orphan-Sections.html

> 
> For FGKASLR (as it is currently implemented[2]), the sections need to be
> individually named output sections (as bfd does it). *However*, with the
> "warn on orphans" patch, FGKASLR's intentional orphaning will backfire
> (I guess the warning could be turned off, but I'd like lld to handle
> FGKASLR at some point.)
> 
> Note that cheating and doing the 1-to-1 mapping by handy with a 40,000
> entry linker script ... made ld.lld take about 15 minutes to do the
> final link. :(

Out of curiosity, how long does ld.bfd take on that linker script :)
