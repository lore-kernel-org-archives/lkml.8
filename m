Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29E9C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A385020708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AnssK3oQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgEAPOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgEAPOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:14:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63F8C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 08:14:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so1686606pfn.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 08:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yQtu6NmXor3q3T6BriJjM2xAXvKakbFot/IDS62A53k=;
        b=AnssK3oQX/IfypkPcOHYRgC5b2ILRpf7weo3QvCU8osdrQ4UixwDziPlE9sq6IADSJ
         WsuvtzehOhBQmcjvezEcByHhKPwpgRb8JS3SrcfeDXASJcsoqmU1vy3q+zvAYT4cFWYi
         23b8KP7xmlQAa+U6M+x+E7rjc7x4yhdgn/GxUr5Q848vDqjfzV2nVg/m+CwYK43lEwx9
         yTfw9/cKw/+L/07rZgKXViH/+s69gk8q8jz4EGh7et2U4rzxJ25yJLDKRSeuDMtuIuNE
         kdJpFfYT+Of61eVBIovgQs6uiUYouJxCPWa9iyd0MEGbF9ub6iosy7onTNvNfw8c26Qi
         EsGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yQtu6NmXor3q3T6BriJjM2xAXvKakbFot/IDS62A53k=;
        b=W3RwvZyfrxDYVelUpsaSsoH+uwSLupn6l1RrHfws4mV3dyQfk5Zx4/9+fMTLmm+QA9
         dV57a+GFfIrsgLJwZf+s11wHIyX9sa//evz2Gh+cmb3XTEnFAnIEWtxQOfrJoRaqupcY
         uI+7s1f6XPIwLcabJnbATMgw+Febr64Za1zJhPBL2zXeMAzZRvFCEnGJD2BiWPPX26nR
         lbi95TK1dS0UsxN6JtGhX6X7iMrIy8jAf8mgUx1HTdVuV0XS+mDBEjx7UzgBc8yO1m9y
         hf+ea/RxBt0JxfsBwQ7X7uKBGm+wklT2tVsyLYXq7qIVpFG6nxptAMjbLd+Gxveg9C25
         LZOQ==
X-Gm-Message-State: AGi0PubY6Jn9UgMySm7BL7bg+a9ysGNvaYTt7ti7eC5rJUNrsYZzCaEH
        I2KXVvVcgETEMv6NCAN6/S8dIQ==
X-Google-Smtp-Source: APiQypJEAT6s/4NmYITjEAj0Q1DJtgRXvDxJ9r5Z9c09X9UlRpF8ugS3SZBoEk4catarH+S94Jx7uA==
X-Received: by 2002:a62:ab16:: with SMTP id p22mr4439784pff.216.1588346093263;
        Fri, 01 May 2020 08:14:53 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id z190sm2502141pfz.84.2020.05.01.08.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 May 2020 08:14:52 -0700 (PDT)
Date:   Fri, 1 May 2020 23:14:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Al Grant <Al.Grant@arm.com>, James Clark <James.Clark@arm.com>,
        tglx@linutronix.de
Subject: Re: [PATCH] arm64: perf_event: Fix time_offset for arch timer
Message-ID: <20200501151448.GA9650@leoy-ThinkPad-X240s>
References: <20200320093545.28227-1-leo.yan@linaro.org>
 <20200430145823.GA25258@willie-the-truck>
 <4d924f705245c797a19d3a73eb0c1ba0@kernel.org>
 <20200430160436.GC13575@hirez.programming.kicks-ass.net>
 <20200430161815.GE25258@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430161815.GE25258@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Thu, Apr 30, 2020 at 05:18:15PM +0100, Will Deacon wrote:
> On Thu, Apr 30, 2020 at 06:04:36PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 30, 2020 at 04:29:23PM +0100, Marc Zyngier wrote:
> > 
> > > I wonder if we could/should make __sched_clock_offset available even when
> > > CONFIG_HAVE_UNSTABLE_SCHED_CLOCK isn't defined. It feels like it would
> > > help with this particular can or worm...
> > 
> > Errrgh. __sched_clock_offset is only needed on x86 because we transition
> > from one clock device to another on boot. It really shouldn't exist on
> > anything sane.
> 
> I think we still transition from jiffies on arm64, because we don't register
> with sched_clock until the timer driver probes. Marc, is that right?
> 
> > Let me try and understand your particular problem better.
> 
> I think the long and short of it is that userspace needs a way to convert
> the raw counter cycles into a ns value that can be compared against values
> coming out of sched_clock. To do this accurately, I think it needs the
> cycles value at the point when sched_clock was initialised.

Will's understanding is exactly what I want to resolve in this patch.

The background info is for the ARM SPE [1] decoding with perf tool, if
the timestamp is enabled, it uses the generic timer's counter as
timestamp source.  SPE trace data only contains the raw counter cycles,
as Will mentioned, the perf tool needs to convert it to a coordinate
value with sched_clock.  This is why this patch tries to calculate the
offset between the raw counter's ns value and sched_clock, eventually
this offset value will be used by SPE's decoding code in Perf tool to
calibrate a 'correct' timestamp.

Based on your suggestions, I will use __sched_clock_offset to resolve
the accuracy issue in patch v2.  (I noticed Peter suggested to use a
new API for wrapping clock_data structure, IIUC, __sched_clock_offset
is more straightforward for this case).

Please correct if I miss anything.  Thank you for reviewing and
suggestions!

Thanks,
Leo

[1] https://lkml.org/lkml/2020/1/23/571
