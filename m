Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB57C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB0B920663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="R4v171xj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCLOOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:14:11 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59750 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgCLOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:14:10 -0400
Received: from zn.tnic (p200300EC2F0DBF00E89CA278D0B3F041.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:bf00:e89c:a278:d0b3:f041])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 924FD1EC0273;
        Thu, 12 Mar 2020 15:14:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584022448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=U8QChw7og9LTeoz8DUEqg0pLvscwUyCM23XggWulPh0=;
        b=R4v171xj/zuHfNV2GL6gnD42au1c87Flqz5AZwsGbrKRlLh1f3PuavQC3U+VQYO6ic9bp/
        nL8ickip2Jmpw0OFkb/IER0QYe9jo2Xe5v83wiReE6sbXQEG3BY8FCVYCJ2Get5pBAu0iO
        yga6b4En4p/KLiGQoPuOmERR1vqahqk=
Date:   Thu, 12 Mar 2020 15:14:18 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kim Phillips <kim.phillips@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 3/3 RESEND] perf/amd/uncore: Add support for Family 19h
 L3 PMU
Message-ID: <20200312141418.GE15619@zn.tnic>
References: <20200311191323.13124-1-kim.phillips@amd.com>
 <20200311191323.13124-3-kim.phillips@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311191323.13124-3-kim.phillips@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:13:23PM -0500, Kim Phillips wrote:
> Family 19h introduces a change in slice, core and thread specification
> in its L3 Performance Event Select (ChL3PmcCfg) register. We implement
> the new bitmask conversions in a new path in l3_thread_slice_mask()
> based on a family 19h-and-above check.
> 
> We also change the uncore_init() family check to 19h-and-above, so as
> to not revert to the Family 16h-or-below L2/NB code paths in the driver.

Pls use passive voice in your commit message: no "we" or "I", etc, and
describe your changes in imperative mood.

Also, pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
