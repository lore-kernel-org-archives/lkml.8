Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0689C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A920D2072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1ULEvkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgFHMni (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgFHMnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:43:37 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E498EC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 05:43:36 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c71so15177506wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OnT205P+Q9ExcEEivUSebKDFNf0i4UfVrNiNXILSir4=;
        b=S1ULEvkPVLdl7+HUPl+/XXL5M1NFP/GaiAuNCbCi57rh3L6BKfVw6ceUIPW2qrC4UZ
         3duKjga+IN3TmxRo8schydvUJ3X3maD5P8eU2C9vbYcYlGhARdUAHSwXB37O046n7Ucw
         taGXyrZoNAwtnc/zKdtbW+83nurquibXu8b8TCjEaira/VpoOuakEA7Kn6QoPmmhiBIk
         73bqZaYgJbRIyva9gUbJG8IhhrNjiWdOgJkuJhEKelzcnGPwLa3XY9vYDtqd50diaNH/
         7E4wQmACp5f5AcRWKf9JTvuwzh+NNDp0QKe8XIe1gNveRK3+VJVX/NXRzzZHhH/h1nUe
         nbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OnT205P+Q9ExcEEivUSebKDFNf0i4UfVrNiNXILSir4=;
        b=H0DNmI4POpMRPYEBurtVZ97Q2SLe87H0+3YUSZMUWE2RCXA8UQ1CZFrADSnT07e/w6
         xRncQ208BcFDdV9f7gpzd9vQh+ntRLEI+0ZNS+kzgOHRUQ9zbqYA2u6yNye8oevqR49q
         uJ+UvdIQojXNYmS2zWyn5XdvGxd8bol1zmBJGTRTNEFxqVMr4fzErPLNsNrecVmMs8Id
         xT5yWDtCjwwKA6LatqWOatMVIe6pzJISZS8qPjPQlLK101lbsP5iiCkYy/7np3gGvwhL
         m1FPfdlvP85E6qDC77J+WZpWApdTRhRHRvC+FN2titiizWq66bUACXJyo1NVxpJNQat6
         7Lmg==
X-Gm-Message-State: AOAM532TESvZQHmW3ZGwiohsOaAHRR4/bRm94wrfjQjuXme3zj5/sToP
        nsKyKJpRNeLimSX5fUYCn9LbDw==
X-Google-Smtp-Source: ABdhPJx+7QzV+Jtitmm3hlNM56KPb2eBH9iZ9cIJDY4H4CUVnxl+GEds1CPcDVPg+D3E5Mfdwdb4ZA==
X-Received: by 2002:a1c:6006:: with SMTP id u6mr15373622wmb.39.1591620215530;
        Mon, 08 Jun 2020 05:43:35 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id l17sm23442506wrq.17.2020.06.08.05.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:43:34 -0700 (PDT)
Date:   Mon, 8 Jun 2020 13:43:32 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-ID: <20200608124332.mzamwmdowu6dlh6k@holly.lan>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
 <20200605142953.GP2750@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605142953.GP2750@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 04:29:53PM +0200, Peter Zijlstra wrote:
> On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > placement. If the debugger is commanded to place a breakpoint at an
> > address then it will do so even if that breakpoint results in kgdb
> > becoming inoperable.
> > 
> > A stop-the-world debugger with memory peek/poke does intrinsically
> > provide its operator with the means to hose their system in all manner
> > of exciting ways (not least because stopping-the-world is already a DoS
> > attack ;-) ) but the current no safety rail approach is not easy to
> > defend, especially given kprobes provides us with plenty of machinery to
> > mark parts of the kernel where breakpointing is discouraged.
> > 
> > This patchset introduces some safety rails by using the existing
> > kprobes infrastructure. It does not cover all locations where
> > breakpoints can cause trouble but it will definitely block off several
> > avenues, including the architecture specific parts that are handled by
> > arch_within_kprobe_blacklist().
> > 
> > This patch is an RFC because:
> > 
> > 1. My workstation is still chugging through the compile testing.
> > 
> > 2. Patch 4 needs more runtime testing.
> > 
> > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> >    more review especially for its impact on arch specific code.
> > 
> > To be clear I do plan to do the detailed review of the kprobe blacklist
> > stuff but would like to check the direction of travel first since the
> > change is already surprisingly big and maybe there's a better way to
> > organise things.
> 
> Thanks for doing these patches, esp 1-3 look very good to me.
> 
> I've taken the liberty to bounce the entire set to Masami-San, who is
> the kprobes maintainer for comments as well.

Not a liberty... leaving out Masami-san was an oversight on my part.
Thanks for connecting!


Daniel.
