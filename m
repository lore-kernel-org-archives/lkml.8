Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF88C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F392177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VRbLv045"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHFT1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFT1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:27:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD53C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:27:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i92so5142793pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eXpUXCboa1iboXL0krzV2/Rr3Jeb/snQcwOxIp/4Dfc=;
        b=VRbLv045DWIuz8DLew94VGvDSVErpo6jn4nvSzw0t7K7QnTc3umT6i53NWb1LP/jF0
         VYzRuv6ew+G0jWbCr06tDw0B0AwLkTE9uV4u7R0p3VhkEcSPWnNxsCZS9qwEThWGqRYf
         BtImZHYpWLIfRfelG5j1Ui4Z6C2DXjTCalbpY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eXpUXCboa1iboXL0krzV2/Rr3Jeb/snQcwOxIp/4Dfc=;
        b=rYW+42wGJr0V5TA04Ct0ufsPi2G0vt1ydUwfuoPrrwRzu7DoFs3GDSSmhk3kvXfZDW
         aYl5OvJQFZEMpjmwAihjt1xRmPIJkB94m9wfJE8CTtG7sIiOPubUmCDu440EZ9dGAUgu
         z5YdVJLdAMg6S6ZGnKJn1ajggm7Z6DsEzf2wmz8U3UqKH6HZ6k+NlAADRNg0hBD/rGt9
         7Vki8oNmgPCWKm0Zy/CTS6ZE0R2Pu6qE/0WaMh0Jta7FmzmhBeAmgwVEXwqNGkEpO5OE
         eV2pAC5k57iRCS5AHipG81W3091UVcIoMPKBIntzLCGmLFfhRA9GaPgzcKu0c1lqc9IM
         8d2Q==
X-Gm-Message-State: AOAM532qhMQtzkHAZluj0MpebVzc8DpyePZ0LE2t4PE9U0pSPHGamXMp
        a9eipmz3GdIk99zyku2hTW2ufA==
X-Google-Smtp-Source: ABdhPJyGGpXe0mD6tJaO+rovKFGQgiUeb/vs5z8wLn89skFqmXdsz2fgHIgqZ28K2zBb/xj6F/qkZQ==
X-Received: by 2002:a17:90b:3597:: with SMTP id mm23mr9564700pjb.3.1596742072173;
        Thu, 06 Aug 2020 12:27:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm9sm7733975pjb.12.2020.08.06.12.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:27:51 -0700 (PDT)
Date:   Thu, 6 Aug 2020 12:27:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202008061052.DA6F3AA2@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <20200806153258.GB2131635@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806153258.GB2131635@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 05:32:58PM +0200, Ingo Molnar wrote:
> * Kristen Carlson Accardi <kristen@linux.intel.com> wrote:
> > [...]
> > Performance Impact
> > ------------------
> 
> > * Run time
> > The performance impact at run-time of function reordering varies by workload.
> > Using kcbench, a kernel compilation benchmark, the performance of a kernel
> > build with finer grained KASLR was about 1% slower than a kernel with standard
> > KASLR. Analysis with perf showed a slightly higher percentage of 
> > L1-icache-load-misses. Other workloads were examined as well, with varied
> > results. Some workloads performed significantly worse under FGKASLR, while
> > others stayed the same or were mysteriously better. In general, it will
> > depend on the code flow whether or not finer grained KASLR will impact
> > your workload, and how the underlying code was designed. Because the layout
> > changes per boot, each time a system is rebooted the performance of a workload
> > may change.
> 
> I'd guess that the biggest performance impact comes from tearing apart 
> 'groups' of functions that particular workloads are using.
> 
> In that sense it might be worthwile to add a '__kaslr_group' function 
> tag to key functions, which would keep certain performance critical 
> functions next to each other.

We kind of already do this manually for things like the scheduler, etc,
using macros like ".whatever.text", so we might be able to create a more
generalized approach for those. Right now they require a "section" macro
usage and a linker script __start* and __end* marker, etc:

#define SCHED_TEXT						\
                ALIGN_FUNCTION();				\
                __sched_text_start = .;				\
                *(.sched.text)					\
                __sched_text_end = .;

Manually collected each whatever_TEXT define and building out each
__whatever_start, etc is annoying. It'd be really cool to have linker
script have wildcard replacements for build a syntax like this, based
on the presences of matching input sections:

	.%.text : {
		__%_start = .;
		*(.%.text.hot)
		*(.%.text)
		*(.%.text.*)
		*(.%.text.unlikely)
		__%_end = .;
		}

> I'd also suggest allowing the passing in of a boot-time pseudo-random 
> generator seed number, which would allow the creation of a 
> pseudo-randomized but repeatable layout across reboots.

This was present in earlier versions of the series.

-- 
Kees Cook
