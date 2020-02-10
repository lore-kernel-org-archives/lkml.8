Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFF3C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D70D21739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 05:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEsht3Ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbgBJFrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 00:47:10 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36130 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgBJFrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 00:47:10 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so3727406pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 21:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N250XzNFcXGssP4jZpuO4maoc80G4uYsrWErXgHkfUw=;
        b=UEsht3AxOIeYxhd5r3fH/MuXjVu5nQcB3xWBzECPsd9emhQsi+ceOuj97Z9ZYDlFh4
         IfJQnEPLTqi+iHVF11sQPcG0zi/sMoH1VHQViizdqai0NIw/n55AtdN0aqXdOTrknMs0
         UAj4I1aNgt3WKsdVtHuaMI7baWGsuM6blPWkfrWsSx3HJtcRZzVMcuKGMUI3jLS59tTr
         prEMBy99N2CGo9YHZPL6+Mre6FX4IZCvUAHbC5R1ShDHLhfhWla/C/uORtLntmn4lrLa
         7k1sy0qiDRJ7WkLBL+A3yymlsI7a4jQZ3Gl/AS3WOfKSMHJJ6kD7znsyFQf7q9j0uMpr
         eW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N250XzNFcXGssP4jZpuO4maoc80G4uYsrWErXgHkfUw=;
        b=BMN5cNqjJuKrMhvSqIlYhlFYvRaMl8Ly/6CBoXINvCUoB+F5+ai0daeQXujCYjYvZr
         g8Uzu4peEPNzwrjpOahSZFEGIfAUgHob17luFu3fPNBLa0XtCHBUo2vJCopvfWDBa/AL
         U1kYp3A2QdOz7Bbgf8hhvOT4ojiCk4gwTBDDpDcxl8pkerBaEtAi91RbglN5nTxEzFei
         t8lnY8GKjB9SXvAw2gB3YHhiKkk+nvtoCSWmvMYl0Ug303361Y/vmnSkPcZGsiFasPpP
         eNPJQwVzR+N7tldQWeC/yKJJHid4mDaq6Mn0piIkfgRF1VEPrM2VB/vQOD562a1zM/qF
         wMYA==
X-Gm-Message-State: APjAAAXbw65ZAVy+GqovpU1hPNFzVQw/wdfxP5n7jSrpn9Q04o2DEVrg
        cIGoZ0pXXwFor1GY/M1QsqFi3w==
X-Google-Smtp-Source: APXvYqzM6Age8nEEkvn6vJ/0/2T8pa+DjK6Vy+Hhy72SxDF/EHbs/7r4P7zkbFqUQpP8Jw74LMa9Ww==
X-Received: by 2002:a17:90a:f88:: with SMTP id 8mr19436591pjz.72.1581313628411;
        Sun, 09 Feb 2020 21:47:08 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([2400:8902::f03c:91ff:fe3f:ee42])
        by smtp.gmail.com with ESMTPSA id s13sm18453774pjp.1.2020.02.09.21.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Feb 2020 21:47:07 -0800 (PST)
Date:   Mon, 10 Feb 2020 13:46:53 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org,
        Robert Walker <robert.walker@arm.com>,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v4 1/5] perf cs-etm: Refactor instruction size handling
Message-ID: <20200210054653.GB10753@leoy-ThinkPad-X240s>
References: <20200203020716.31832-1-leo.yan@linaro.org>
 <20200203020716.31832-2-leo.yan@linaro.org>
 <CAJ9a7Vi37DAZ0q78MahmMQqSxD68Rphaw0t5cMsX3gDk8PA3DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vi37DAZ0q78MahmMQqSxD68Rphaw0t5cMsX3gDk8PA3DA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Feb 06, 2020 at 12:36:43PM +0000, Mike Leach wrote:
> Hi Leo,
> 
> On Mon, 3 Feb 2020 at 02:07, Leo Yan <leo.yan@linaro.org> wrote:
> >
> > cs-etm.c has several functions which need to know instruction size
> > based on address, e.g. cs_etm__instr_addr() and cs_etm__copy_insn()
> > two functions both calculate the instruction size separately with its
> > duplicated code.  Furthermore, adding new features later which might
> > require to calculate instruction size as well.
> >
> > For this reason, this patch refactors the code to introduce a new
> > function cs_etm__instr_size(), this function is central place to
> > calculate the instruction size based on ISA type and instruction
> > address.
> >
> > For a neat implementation, cs_etm__instr_addr() will always execute the
> > loop without checking ISA type, this allows cs_etm__instr_size() and
> > cs_etm__instr_addr() have no any duplicate code with each other and both
> > functions are independent and can be changed separately without breaking
> > anything.  As a side effect, cs_etm__instr_addr() will do a few more
> > iterations for A32/A64 instructions, this would be fine if consider perf
> > is a tool running in the user space.
> >
> 
> I prefer to take the optimisation win where I can - I always do in the
> trace decoder when counting instructions over a range.
> Consider that you can be processing MB of trace data, and most likely
> that will be A64/A32 on a lot of the current and future platforms.
> 
> Therefore I would keep the useful cs_etm__instr_size() function, but
> also keep a single ISA check in cs_etm__instr_addr() to do
> the (addr + offset * 4) calculation for non T32.

Understand.  Will refine the code by following this suggestion.

Thanks,
Leo Yan
