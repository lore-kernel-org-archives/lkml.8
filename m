Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FFB2075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slRu6H7n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgETBkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:40:05 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68729C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:40:04 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id b6so2017501qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GmglJO6qCW3EO3VU2pXKLFHvUqK1Lzi8wB5jA0danw4=;
        b=slRu6H7nt8HAd65WdVhkz1X8ZLZBdsiVGjgP9LP16c+3888VV8w3SVu66AA9fLNJAP
         UZwHWC0TbfsVbUShcSr7daHNilnTQrK3cBQxruj73cXuvY2KVV3lujFpGReuU/KK7bGE
         Ezom8tOs17UKu4aXEoaifHjPD5aL6cgBKAIJWDevDOXY1yo4+bwDtrK5BiEbAzUOUlcd
         UWG2JJbjmL2wJH3/QWBwCfqzM77BWTOULJ59FrY+T/39mIvSUWYnMkMehnNYSr4gTCsT
         1z63oeZQ/BQQeP3Y+RpW0I/gufmoec4vac7j5ihYs51sC0Ys0mw/GLDnhiNiZEtvryiW
         yLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GmglJO6qCW3EO3VU2pXKLFHvUqK1Lzi8wB5jA0danw4=;
        b=CTn9oCeeEodSLpeRVFLfdUo3WXMXpAcihPKxC/q3YAgkses8a75eoIlEgwnAKQ5ynK
         tC53k/zuDhlf9h3cIm4GIO+ky4Ww2O84caDO5Jo0Di7QS4x+lCZNHM9Gg4hj7U6M/kj+
         lV0cLuLuttf20Qtav70o/a+9y0lJoao8jwB8S3AQo64kGAE6Ga91rbIfTKAEXSZDLMX1
         KNdhCsWPPqkYOuUnNajGw8azrp18OA1JN8eKz+QDrtmuKYTcnaDlbih3wSc7bwrmLGuj
         T7U/aATlIuaWPuW/Lo2trrSyBxbGJe5MKPjfJn2g8ZGm9tX6RDBme4xe2J/ar+iTh4zB
         stVg==
X-Gm-Message-State: AOAM532pG7GyB3TdIwFVuzG5MJcIp/0I2d9JB4+ULXzJ6JS4b3yQhoNn
        G5m2sekARq2Sa9sNLsumtao=
X-Google-Smtp-Source: ABdhPJzMD8tvmIr0Mtast3BInqY1c5C+5umg6s7m6vnSlvJYpGcFaUquy9FZDW29YDOvjz6PZDknow==
X-Received: by 2002:ae9:ed05:: with SMTP id c5mr2507460qkg.250.1589938803583;
        Tue, 19 May 2020 18:40:03 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 132sm1065028qkj.117.2020.05.19.18.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:40:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1754B40AFD; Tue, 19 May 2020 22:40:01 -0300 (-03)
Date:   Tue, 19 May 2020 22:40:01 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 00/15] perf/x86: Add perf text poke events
Message-ID: <20200520014001.GF28228@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bee04840-143c-18bb-df82-5aa58d70730e@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, May 17, 2020 at 04:16:50PM +0300, Adrian Hunter escreveu:
> On 12/05/20 3:19 pm, Adrian Hunter wrote:
> > Hi
> > 
> > Here are patches to add a text poke event to record changes to kernel text
> > (i.e. self-modifying code) in order to support tracers like Intel PT
> > decoding through jump labels, kprobes and ftrace trampolines.
> > 
> > The first 8 patches make the kernel changes and the subsequent patches are
> > tools changes.
> > 
> > The next 4 patches add support for updating perf tools' data cache
> > with the changed bytes.
> > 
> > The next patch is an Intel PT specific tools change.
> > 
> > The final 2 patches add perf script --show-text-poke-events option
> > 
> > Patches also here:
> > 
> > 	git://git.infradead.org/users/ahunter/linux-perf.git text_poke
> > 
> > Changes in V7
> > 
> >   perf: Add perf text poke event
> >   perf/x86: Add support for perf text poke event for text_poke_bp_batch() callers
> >   kprobes: Add symbols for kprobe insn pages
> >   kprobes: Add perf ksymbol events for kprobe insn pages
> >   perf/x86: Add perf text poke events for kprobes
> >   ftrace: Add symbols for ftrace trampolines
> >   ftrace: Add perf ksymbol events for ftrace trampolines
> >   ftrace: Add perf text poke events for ftrace trampolines
> > 
> > 	Added Peter's Ack
> > 	Improved commit message for text_poke events for ftrace trampolines
> > 
> >   perf kcore_copy: Fix module map when there are no modules loaded
> >   perf evlist: Disable 'immediate' events last
> >   perf tools: Add support for PERF_RECORD_TEXT_POKE
> >   perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
> >   perf intel-pt: Add support for text poke events
> >   perf script: Add option --show-text-poke-events
> >   perf script: Show text poke address symbol
> > 
> > 	Re-based on Arnaldo's perf/core branch
> > 
> 
> Arnaldo, any comments on the tools patches?

I couldn't get to this yet, sorry, but from a quick look I saw just the
ordering of some args to perf_event__ functions, and I can quickly fix
it.

PeterZ, from what we discussed for the next merge Window, perhaps we
should route the kernel bits via the tip tree while I will push the
tooling bits on my 5.8 merge request to Linus, Ok?

- Arnaldo
