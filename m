Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB476C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A592A2065C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:32:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTqlfkb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgFKOcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgFKOco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:32:44 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5688AC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:32:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r9so5177895wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 07:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pi9l9jRV1ZGjNyEOBE//QxW0cXJlApW1liZwwSNeTyk=;
        b=ZTqlfkb93KT/yNN/1Mzmjr77ZcsvDex++EjP1mbAOtttopJRmAB5U+KmgyldiGepdp
         U+jIWf7dzkiWB6U/RqJB4L1Zz8V36BcFM6O6Gc1vyzY+tIe1jyswltjGZunr8aR1WboW
         TBLBXnCxhzdWmJAN5CQhoBQF3kWxnE5mQqy6oXZly+SDtAX7DHdhLY+qNgTX7ZGDjBn3
         eCEG14eZxYbA3NJfl0I0JSVGKZHgcNHHC83Y9roqn6ZzEelYlQT3YXdIk0QEubCJj5MM
         TKMBVIo8ev6d9S9pFYGZIj6OxAqaw4+9PuF+5qmBiajJX3ojpQxnj943adrNUofm+Ri6
         wXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pi9l9jRV1ZGjNyEOBE//QxW0cXJlApW1liZwwSNeTyk=;
        b=mCF3bJpxlAoqSnX9vvZP9wROvzgEpB0Ya0qpAQvVZ5w4NdjkEQR1Q/hJ6AxM9/12cl
         IDEBlQ3teWVbZz/F140LdkdJ/1A99286C1rt71x3fo7UoBVIrEBi3MNUaEcceA92hyTl
         eozY6rnzasaLU/vFrPTd0EoEmiE1VkTkk4XNTcpRyXVIPoH6WlmdFCDstyf/dH43cUQX
         otMdMh9WPFpkqBMoomzsm6Hf7LAqb8CzG408unpV0jPcx7qW8GZW36AE4/Y9isbE5gpx
         eUA49QW5FFX0wC5vgvy5fRCsPO5SY4Hf//8rIivAfCfiQNUs2yLx+BmYelFwMHN4Y4ok
         FVuQ==
X-Gm-Message-State: AOAM531SLKYmTkLtP6xWpntwdtd+6Se9gs11v8CcepB5Ry5TjvdeaE8i
        Pb8L9u7UDbAtb17+KG9VKZt3C8obdPk=
X-Google-Smtp-Source: ABdhPJwkD/nii6gyKXo+P/17pv8qNbDSXx3d/bnB2jiZ7qUjhYSGDepjtS+BNmDtxxHjX5R1n/lGOg==
X-Received: by 2002:a7b:c951:: with SMTP id i17mr8139999wml.44.1591885962877;
        Thu, 11 Jun 2020 07:32:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id y37sm5884173wrd.55.2020.06.11.07.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 07:32:42 -0700 (PDT)
Date:   Thu, 11 Jun 2020 15:32:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-ID: <20200611143240.u77kxdbhepaazx3j@holly.lan>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
 <20200605142953.GP2750@hirez.programming.kicks-ass.net>
 <20200611214209.bd8fcd290d745ae50d898e69@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611214209.bd8fcd290d745ae50d898e69@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 09:42:09PM +0900, Masami Hiramatsu wrote:
> On Fri, 5 Jun 2020 16:29:53 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > > placement. If the debugger is commanded to place a breakpoint at an
> > > address then it will do so even if that breakpoint results in kgdb
> > > becoming inoperable.
> > > 
> > > A stop-the-world debugger with memory peek/poke does intrinsically
> > > provide its operator with the means to hose their system in all manner
> > > of exciting ways (not least because stopping-the-world is already a DoS
> > > attack ;-) ) but the current no safety rail approach is not easy to
> > > defend, especially given kprobes provides us with plenty of machinery to
> > > mark parts of the kernel where breakpointing is discouraged.
> > > 
> > > This patchset introduces some safety rails by using the existing
> > > kprobes infrastructure. It does not cover all locations where
> > > breakpoints can cause trouble but it will definitely block off several
> > > avenues, including the architecture specific parts that are handled by
> > > arch_within_kprobe_blacklist().
> > > 
> > > This patch is an RFC because:
> > > 
> > > 1. My workstation is still chugging through the compile testing.
> > > 
> > > 2. Patch 4 needs more runtime testing.
> > > 
> > > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> > >    more review especially for its impact on arch specific code.
> > > 
> > > To be clear I do plan to do the detailed review of the kprobe blacklist
> > > stuff but would like to check the direction of travel first since the
> > > change is already surprisingly big and maybe there's a better way to
> > > organise things.
> > 
> > Thanks for doing these patches, esp 1-3 look very good to me.
> > 
> > I've taken the liberty to bounce the entire set to Masami-San, who is
> > the kprobes maintainer for comments as well.
> 
> Thanks Peter to Cc me.
> 
> Reusing kprobe blacklist is good to me as far as it doesn't expand it
> only for kgdb. For example, if a function which can cause a recursive
> trap issue only when the kgdb puts a breakpoint, it should be covered
> by kgdb blacklist, or we should make a "noinstr-list" including
> both :)

Recursion is what focuses the mind but I don't think we'd need
recursion for there to be problems.

For example taking a kprobe trap whilst executing the kgdb trap handler
(or vice versa) is already likely to be fragile and is almost certainly
untested on most or all architectures. Further if I understood Peter's
original nudge correctly then, in addition, x86 plans to explicitly
prohibit this anyway.

On other words I think there will only be one blacklist.


> Thus, Nack for PATCH 4/4, that seems a bit selfish change. If kgdb wants
> to use the "kprobes blacklist", we should make CONFIG_KGDB depending on
> CONFIG_KPROBES.

Some of the architectures currently have kgdb support but do not have
kprobes...


> Or, (as I pointed) we should make independent "noinstr-list"
> and use it from both.

This sounds like this wouldn't really be a functional change over
what I have proposed. More like augmenting it with a massive symbol
rename (and maybe a little bit of extra code movement in the headers
to give us linux/noinstr.h).

Taking my cues from things like set_fs() I originally decided to keep
away from such a big rename ;-) .

Personally I'm open to a rename. I could write PATCH 4/4 assuming a
rename will come (e.g. different naming for new files and Kconfig
options) and follow that with an automatically generated
rename patch (or patches).


Daniel.

