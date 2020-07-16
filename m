Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480CDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC8C207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USvIahWD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGPBRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgGPBRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:17:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34770C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:17:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id s189so3980676pgc.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zaNhy7jKEUTeXPCFJVaXdjqKRf1wA9n3kEWdA7kmaCg=;
        b=USvIahWDGxeeJCtcRexeqgdqTHbk9VetJrZufYtnSHY22VZkaCVi6y2CQDfOuA/dQd
         IskadzGmkejaxVeyVNuajhux2kU4WuW6sUbNXOCLKU79C/49RycBgyNMJXhWijqsLeHV
         TnuzSwGuaMzBub7SanKN/tgeCaI61A/gAZL4iZNraXzntPXY1QoPBDPdBXUBWpCE4bdV
         MrKBPBQH8E4DKcoMEeg+Vse2n/lkQY3cNlppeT82UQWFj5wloZhVFZ5xtaHkId89dA8O
         F8jZDiPtb4kfjHHUpWMtJf0dS06Nst6edh8rSet3HeeOnNyU4XupczkZkaaITgSYGB6q
         /gJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zaNhy7jKEUTeXPCFJVaXdjqKRf1wA9n3kEWdA7kmaCg=;
        b=Oo68HOrIPjuSpKCkSS4XAz+2otG+8h2jHuVU2CWqf4jMRxIyE51//KLLseqibpUOdx
         fStbOmvesj54P3y39NK1q3oN1+z/WQWnoYbUoO4hITIXqwkxl2jC3s+ObFPHtS5aRYRJ
         r4GRszRJKHPiIcbu9Xvda+g7ErfpQFCAINzHL7i+T2bzDvSZWcnrrZ5tfpXj4zSkTtUM
         e479VEyRCsICyMkTIgnVTVx5WMG6GAKaBOtUhtYCEIwcJK6kjbosPH/30zTg9Fo6ofVn
         RC+Ay+lejAa6SaJ2VjivUwQ/fIUwb49VpMZScJ6WZIME+DQMsPUFK3hV7SnUPzTyROCV
         q91Q==
X-Gm-Message-State: AOAM5326U2F5DNemDmhldfbgHv8zDYenvQAok+UOSoEmrKcDm1Y/BqRw
        5kPRh4D3f2/r5L5EAZ39TfEQSnftXK8UWA==
X-Google-Smtp-Source: ABdhPJwYZygRURnD2JrMEthJce6dZK/3rCVSCW34kL8wdrrm18D2z5RwTR1TAzZuDJi+Ng+4ZhFNFw==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr2197019pgp.333.1594862260490;
        Wed, 15 Jul 2020 18:17:40 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id kx3sm3058517pjb.32.2020.07.15.18.17.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 18:17:39 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:17:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/3] Perf tool: Enable Arm arch timer counter and
 arm-spe's timestamp
Message-ID: <20200716011738.GA17312@leoy-ThinkPad-X240s>
References: <20200715023401.23988-1-leo.yan@linaro.org>
 <CAP-5=fVaLA8C5Cd=jLR1TeCe9ktF5eqMmE++Wb4JHmJxrcfsJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fVaLA8C5Cd=jLR1TeCe9ktF5eqMmE++Wb4JHmJxrcfsJg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Wed, Jul 15, 2020 at 09:31:14AM -0700, Ian Rogers wrote:
> On Tue, Jul 14, 2020 at 7:34 PM Leo Yan <leo.yan@linaro.org> wrote:
> >
> > This patch set is to enable Arm arch timer counter and Arm SPE is the
> > first customer to use arch timer counter for its timestamp.
> >
> > The patch 01 is to retrieve arch timer's parameters from mmaped page;
> > patch 02 provides APIs for the conversion between arch timer's counter
> > and time; patch 03 is to enable timestamp based on the new introduced
> > APIs for timestamp related calculation.
> >
> > Note, this patch set is depend on the kernel changes for "arm64: perf:
> > Proper cap_user_time* support" [1].
> >
> > This patch set has been rebased on mainline kernel with the latest
> > commit 11ba468877bb ("Linux 5.8-rc5") and also applied on top of patch
> > set [1].  After enabling the timestamp, the samples can show the
> > timestamp, and the timestamp is consistent with the kernel's timestamp
> > by checking the kernel log:
> >
> >   $ perf script -F,+time
> >     dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >     dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
> >
> > [1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=318401
> 
> This looks good to me! Would it be possible to add a test on the
> functionality? It's possible to add a C test in
> tools/perf/arch/arm64/tests or something related to you perf script
> command line in tools/perf/tests/shell.

Yeah, will look into testing and it's good add two testing cases,
one is for arch timer testing in C, another is for SPE testing
with shell script.

Thanks for suggestions,
Leo
