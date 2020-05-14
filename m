Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE92BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A04E2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 13:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdVVIS5B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgENNXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 09:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726011AbgENNXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:23:46 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7FFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:23:46 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id l1so2782820qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qnupApv5pkb3p9+KuaT8kkxlkX8ng/B6sPGXw6pdnyA=;
        b=JdVVIS5BfSM6y5F2HNvLEyXenCiZjo6XkO0YrqO2Xt3LTAy4xjUqhOiEb2UVaWSoru
         ZE3dGL7lGhNzX4+0abCcjjz7EbrKcmbi+V2AjYWjclfecfJ334Joa3f/aWf788IMN287
         MslcK1TtTQ2X7msIMQbB6jF8USREdlGBRz62VmwrvgOmc8DQkUzN0JMxxq2Z/V3RE7/c
         DrP3aODLLqlf/+kZtwkVgk95WJrkbAY6VRTrNWttsHCHApGNd7/4zehrWCvLal7iATLc
         7IiQv2qnoFRhbPciewdnAb7/3vgFHpSexMyBpqPZXn+oVz23fv9kBIItekG+BdR4lqkc
         OrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnupApv5pkb3p9+KuaT8kkxlkX8ng/B6sPGXw6pdnyA=;
        b=e8WCxbm5c4kjkpQ8WNflYlHz/+gw1Vgh5DctT/s0qYA7vSS4oNDJwUnomSJCcRtOsZ
         ZdmQ91wvdRrVyn7O0ga/ShdFBgPT61rIJacyC43AvSlxhNsU7ODoKKi+iCMCfDhUx3K8
         MTWdMleT+dmsX5JOYCwEqBjGCLMhyWrtKj2ugnXTPuwArK8o3hjQVNOlkfNnCVmTrKhR
         dJVAGK6S7NJJczK4nEH/9wMaQZtVreEMF8sgMPDP3G8fwA2sGSICJflH6Nl94zhmUwAh
         6taGVyochGfzWO8D1goZ7weP7EF+nD+IUhZBGSOCvUhTCcR29Bi86efVFCy2vXrUQ7+o
         IjsQ==
X-Gm-Message-State: AOAM531lUeKbojzEPK+T9GW+LkmXq7jpn9lxONoagYHlVhipZfHlTuvl
        cSUdr0G2uNlkTnScFhxBJyU=
X-Google-Smtp-Source: ABdhPJy4iooFuYpNo5CWVsJR/PkitVytJ3esQ1zEkosFdrjA+XzGCa1s9GCQFoD5USze+uD4g0TYrQ==
X-Received: by 2002:aed:3c61:: with SMTP id u30mr4332814qte.209.1589462621233;
        Thu, 14 May 2020 06:23:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d7sm2408711qkk.26.2020.05.14.06.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 06:23:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 76A5540AFD; Thu, 14 May 2020 10:23:37 -0300 (-03)
Date:   Thu, 14 May 2020 10:23:37 -0300
To:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Nick Gasson <nick.gasson@arm.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] perf jvmti: Various fixes to JVMTI agent
Message-ID: <20200514132337.GM5583@kernel.org>
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427103505.GA1476763@krava>
 <85lflu7v4o.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85lflu7v4o.fsf@arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 14, 2020 at 04:56:07PM +0800, Nick Gasson escreveu:
> On 04/27/20 18:35 pm, Jiri Olsa wrote:
> >
> > adding Stephane to the loop

Stephane, Ian, can you guys please take a look at this one and provide a
Reviewed-by or Acked-by?

Thanks,

- Arnaldo


> > jirka
> >
> >> 
> >> These three patches fix a couple of issues I ran into while using the
> >> jitdump JVMTI agent to profile the SPECjbb benchmark.
> >> 
> 
> Hi, any feedback on these patches?
> 
> Thanks,
> Nick
> 
> >> 
> >> 
> >> Nick Gasson (3):
> >>   perf jvmti: Fix jitdump for methods without debug info
> >>   perf jvmti: Do not report error when missing debug information
> >>   perf jvmti: Fix demangling Java symbols
> >> 
> >>  tools/perf/jvmti/libjvmti.c           | 24 +++++++--------
> >>  tools/perf/tests/Build                |  1 +
> >>  tools/perf/tests/builtin-test.c       |  4 +++
> >>  tools/perf/tests/demangle-java-test.c | 42 +++++++++++++++++++++++++++
> >>  tools/perf/tests/tests.h              |  1 +
> >>  tools/perf/util/demangle-java.c       | 13 +++++----
> >>  6 files changed, 66 insertions(+), 19 deletions(-)
> >>  create mode 100644 tools/perf/tests/demangle-java-test.c
> >> 
> >> -- 
> >> 2.26.1
> >> 
> 

-- 

- Arnaldo
