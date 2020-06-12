Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B70AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077E12065C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPNXJErK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbgFLLFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgFLLFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:05:03 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD00C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:05:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so9314432wru.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4En2rY+Trq8fwrO7NokOMzjPoiMghC3ekaWth9n3B6Q=;
        b=JPNXJErKT/cjpj8ltHI1jaCXDNxFs5XtEaWpt77hEMm46kC6UZQN/GZdxE88a2wa76
         6t4dZN+bAFmu/Igf13onzzf7sJJqW7DBucS9dWWUYI/RK0DBmfGs83Yg6DY3jkjwqn+B
         0VR1ngkS0zgLw+Tqzl9rqRYjiRAAMoAA/R8emWwWCdshumWIBtVKLrug/ho/bqRFrSzk
         0hPa8zsZADANpHL7WVx3JGA8DLEmzaHaOpyrdP5WpF3YicINFgq0e6LazvPzzWVpMRON
         hdidtG49V7SMb0CT7BHcmNaErTEfxCZMvDFYADfi2ShrkNKzmEbtmNw9pY64tdkh0mYY
         Cntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4En2rY+Trq8fwrO7NokOMzjPoiMghC3ekaWth9n3B6Q=;
        b=hOr2UqcvVmEGeeWyXVqdLvV44NCjzbkmCuwfgowsKyi3pmjalCqhVgd52VxvCeH3Ye
         hYoz9TzBLHqsK8XCpPw3+ObsnvyFrpu6KBJZkAYpv8w30768y85OKWepHQVewSjxFdk9
         isrp9cInjE/V6kzSKp29kZ39eu3Po+E5++JZFlmbXbhhgwy2l7cRCspu6XiCm/TQiAU5
         Hll6gTrmWwWdiuwJAKYHRNd95gaSsL7sn9xE/VhgPodc1tblCYSmXf3TCJoXQ/9QfFNt
         9olwcOCMoKhUzfe03d669Rtj+LoBcJ8AdqnGhXfeuxRUH+MZINcXf3EfoALPXB/V3Ola
         es5Q==
X-Gm-Message-State: AOAM533a5qKpvDy9bTP+IWkKK/tXBPUL02TUEXkgxGx0FJAvOFsFSShf
        opYbKAXyu1pVyNkUhDKc+0eJVA==
X-Google-Smtp-Source: ABdhPJzK3S/OPHk7E1CTtQcB7tS2Juv2s9mmyUfyUs1f+ieL5Bvns2LzCG1smBoHmFViuB1ZYkouOA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr14045380wru.422.1591959899288;
        Fri, 12 Jun 2020 04:04:59 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s8sm9455155wrm.96.2020.06.12.04.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:04:58 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:04:56 +0100
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
Message-ID: <20200612110456.ysfee4g46gv7lucl@holly.lan>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
 <20200605142953.GP2750@hirez.programming.kicks-ass.net>
 <20200611214209.bd8fcd290d745ae50d898e69@kernel.org>
 <20200611143240.u77kxdbhepaazx3j@holly.lan>
 <20200612191349.9774d101681b9f8e7ada0200@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612191349.9774d101681b9f8e7ada0200@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 07:13:49PM +0900, Masami Hiramatsu wrote:
> On Thu, 11 Jun 2020 15:32:40 +0100
> Daniel Thompson <daniel.thompson@linaro.org> wrote:
> 
> > On Thu, Jun 11, 2020 at 09:42:09PM +0900, Masami Hiramatsu wrote:
> > > On Fri, 5 Jun 2020 16:29:53 +0200
> > > Peter Zijlstra <peterz@infradead.org> wrote:
> > > 
> > > > On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > > > > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > > > > placement. If the debugger is commanded to place a breakpoint at an
> > > > > address then it will do so even if that breakpoint results in kgdb
> > > > > becoming inoperable.
> > > > > 
> > > > > A stop-the-world debugger with memory peek/poke does intrinsically
> > > > > provide its operator with the means to hose their system in all manner
> > > > > of exciting ways (not least because stopping-the-world is already a DoS
> > > > > attack ;-) ) but the current no safety rail approach is not easy to
> > > > > defend, especially given kprobes provides us with plenty of machinery to
> > > > > mark parts of the kernel where breakpointing is discouraged.
> > > > > 
> > > > > This patchset introduces some safety rails by using the existing
> > > > > kprobes infrastructure. It does not cover all locations where
> > > > > breakpoints can cause trouble but it will definitely block off several
> > > > > avenues, including the architecture specific parts that are handled by
> > > > > arch_within_kprobe_blacklist().
> > > > > 
> > > > > This patch is an RFC because:
> > > > > 
> > > > > 1. My workstation is still chugging through the compile testing.
> > > > > 
> > > > > 2. Patch 4 needs more runtime testing.
> > > > > 
> > > > > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> > > > >    more review especially for its impact on arch specific code.
> > > > > 
> > > > > To be clear I do plan to do the detailed review of the kprobe blacklist
> > > > > stuff but would like to check the direction of travel first since the
> > > > > change is already surprisingly big and maybe there's a better way to
> > > > > organise things.
> > > > 
> > > > Thanks for doing these patches, esp 1-3 look very good to me.
> > > > 
> > > > I've taken the liberty to bounce the entire set to Masami-San, who is
> > > > the kprobes maintainer for comments as well.
> > > 
> > > Thanks Peter to Cc me.
> > > 
> > > Reusing kprobe blacklist is good to me as far as it doesn't expand it
> > > only for kgdb. For example, if a function which can cause a recursive
> > > trap issue only when the kgdb puts a breakpoint, it should be covered
> > > by kgdb blacklist, or we should make a "noinstr-list" including
> > > both :)
> > 
> > Recursion is what focuses the mind but I don't think we'd need
> > recursion for there to be problems.
> > 
> > For example taking a kprobe trap whilst executing the kgdb trap handler
> > (or vice versa) is already likely to be fragile and is almost certainly
> > untested on most or all architectures.
> 
> Ah, OK. Actually, on x86 that is not a problem (it can handle recursive int3
> if software handles it correctly), but other arch may not accept it.
> Hmm, then using NOKPROBE_SYMBOL() is reasonable.
> 
> > Further if I understood Peter's
> > original nudge correctly then, in addition, x86 plans to explicitly
> > prohibit this anyway.
> > 
> > On other words I think there will only be one blacklist.
> 
> Agreed.
> 
> > > Thus, Nack for PATCH 4/4, that seems a bit selfish change. If kgdb wants
> > > to use the "kprobes blacklist", we should make CONFIG_KGDB depending on
> > > CONFIG_KPROBES.
> > 
> > Some of the architectures currently have kgdb support but do not have
> > kprobes...
> 
> "depends on KPROBES if HAVE_KPROBES" ? :-)

I'm personally be OK with something like:

#ifndef CONFIG_KGDB_ALLOW_UNSAFE_BREAKPOINTS
  if (within_kprobe_blacklist())
    ...
#endif

And then setup Kconfig so that KGDB_ALLOW_UNSAFE_BREAKPOINTS
defaults to n and add a extra check to put a warning in dmesg
that breakpoints are disabled.


> (Anyway, it is a good chance to port kprobe on such arch...)

I like kprobes very much... but not quite enough to want to
implement it on architectures I don't use ;-).


Daniel.
