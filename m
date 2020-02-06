Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16154C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB2D20730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NeZA00Zg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgBFMGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:06:21 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43794 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBFMGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:06:20 -0500
Received: by mail-ot1-f66.google.com with SMTP id p8so5201247oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YOaPcVEE5NfGq9wvnq0/vJzrPpGVkSOEyM+hIny1xiQ=;
        b=NeZA00ZgkpYbb57jZICxPQwzEkO47PnrZTJc74accDmoslXdCg9Y9+DDYQf85OELqc
         lM4Z7OJJMutdJRHHEeXLZhqvP/cJfQggycs1Ntn64XJm3iZNaCua1c1VTPNlxnc1/8MC
         KIcZ5PKTsO8DuOObuGbYqhYjNbgIGt5wFXzQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YOaPcVEE5NfGq9wvnq0/vJzrPpGVkSOEyM+hIny1xiQ=;
        b=LDcZIQHJOEqp4tEv54H54KDJC8XCTvCXgrpdLqaeZnWwef7yIZ2SS51drLljWY2/IK
         GBbuRlymABg02PXuQlQqTa7fldis+IPgStRABWg5oIicjnzD5pmCZOiZRkQtYFwlGCRu
         CDTss9fMkTNsSYt20UbS0DnoVz8fuN9YTmIc1C5k6/MMGWG2Kh7+M5T9k8XLU4NETLVd
         yFNHZPaL1nxSlbSK7hXEJDToi4+qnA0m+4TW+kx55GO5Zp90iUkz3pOcEF3Z/9Uc8Dkt
         B/WsRrXOGkf6AsFprA5di3VcLoCW3cg5F6KxEG1JBOaJOoW+3kSyRf+yUFeDXb7Ypnfl
         mh1A==
X-Gm-Message-State: APjAAAWFNvr8B5w4NEHpgBYvb+6T0CcX3jePTfJSBSljS9MIIUiA3VJF
        0H1THiZ2d/QrYwRnOD6glJ/N8g==
X-Google-Smtp-Source: APXvYqxsX0xPKqXQ7FVbpOoF15/VUVG/NtfVZJQgYeMcBk/FwIaTRc4RuSWgy1tRMM+d4SxNSL/VDA==
X-Received: by 2002:a9d:6290:: with SMTP id x16mr29107620otk.343.1580990779855;
        Thu, 06 Feb 2020 04:06:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm1037734otr.54.2020.02.06.04.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:06:18 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:06:17 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/11] x86: Add support for finer grained KASLR
Message-ID: <202002060356.BDFEEEFB6C@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-9-kristen@linux.intel.com>
 <20200206103830.GW14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206103830.GW14879@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:38:30AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 05, 2020 at 02:39:47PM -0800, Kristen Carlson Accardi wrote:
> > +static long __start___ex_table_addr;
> > +static long __stop___ex_table_addr;
> > +static long _stext;
> > +static long _etext;
> > +static long _sinittext;
> > +static long _einittext;
> 
> Should you not also adjust __jump_table, __mcount_loc,
> __kprobe_blacklist and possibly others that include text addresses?

These don't appear to be sorted at build time. AIUI, the problem with
ex_table and kallsyms is that they're preprocessed at build time and
opaque to the linker's relocation generation.

For example, looking at __jump_table, it gets sorted at runtime:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/jump_label.c#n474

As you're likely aware, we have a number of "special"
sections like this, currently collected manually, see *_TEXT:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/vmlinux.lds.S#n128

I think we can actually add (most of) these to fg-kaslr's awareness (at
which point their order will be shuffled respective to other sections,
but with their content order unchanged), but it'll require a bit of
linker work. I'll mention this series's dependency on the linker's
orphaned section handling in another thread...

-- 
Kees Cook
