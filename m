Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC716C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C50F6206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKh5i2w+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgDWOYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726119AbgDWOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:24:35 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7F7C08E934;
        Thu, 23 Apr 2020 07:24:35 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id h6so2935275qvz.8;
        Thu, 23 Apr 2020 07:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xd6yffwd4vSoqtLrrM8ZfIryfm3GpMsJV/9YC+jtP4s=;
        b=dKh5i2w+rpkn+EuzyKFN19shcxAXHjXqm3Ze3mvGP2FB70HGbpS+m823x7KF8CGcEE
         RWY7jFsvYtnAczGHNj8nZkRTNBgxcVJMqQGsTdBPA5Lkbhqd0NjYs5F7DHKntbD5BS6f
         SDrtkHKzAE3PElLMkWHw8qe1g5+QqWM95GEeRI4W0GE7UD8f1y9RVsXm46XZhotlLYhx
         XKiBuxCjGVuMioJkkgJYcOAYT3VI+NCKeR9Cq70IlYzh3Fv8LRfQeun11lNmrj3jtNMD
         2gTCn7ek1L7Wd1PtFL5eid2A5NxjJTK2IphhpR//CcTFspuvjm3L2VvXpfjwDnFvnuxU
         gZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xd6yffwd4vSoqtLrrM8ZfIryfm3GpMsJV/9YC+jtP4s=;
        b=jS9oa2HMeDBy1uhrBsPcCJcuoQ1p4CPLCdWASO6bPEWFo03wE2FGL373tPGDKGUn1E
         aDxiIs16Ku2M8f/as2R25LIoLy8W7tjSoL0utZUW8GjUhK89dBCKHueDeDFKYQ43WQMF
         XoR4RyJ1m3bCoCx6hScdPZh/zxjmcZ5nnXO7M77cs+7cU6gLVbXpI3uVztE9g0LDjOnp
         AROj986Vqqn/OTWGHcROB3HSGiQ+OFFednf5oRZepkd7CpFtFJFoxyJyr61rmh8ZVNh6
         aS6LgQppJtMvJnR4/BepmrK66VqKND0SwR2ipkUflJv1lP8T1G0jmpQYGR+otrAhrRoL
         Zrfg==
X-Gm-Message-State: AGi0PuZvJzCGV8xh5HuhbwNiiYS8neGhvdsKIvauSMDAICB0VvIaf1NW
        bbiee6rAt7t7oPqqs+KySfw=
X-Google-Smtp-Source: APiQypIpYOStqJVFPFRt1jFzSmG2LjoChmgXgCo91yyUcIiYFovZB+AmC/XEO6IffJVsu+mLqzY9kA==
X-Received: by 2002:a05:6214:158b:: with SMTP id m11mr3201202qvw.168.1587651874865;
        Thu, 23 Apr 2020 07:24:34 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id 190sm1639258qkj.87.2020.04.23.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 07:24:34 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CCDEB409A3; Thu, 23 Apr 2020 11:24:31 -0300 (-03)
Date:   Thu, 23 Apr 2020 11:24:31 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrey Zhizhikin <andrey.z@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v5 0/3] perf synthetic events
Message-ID: <20200423142431.GJ19437@kernel.org>
References: <20200415054050.31645-1-irogers@google.com>
 <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cj4fMsnDLgq0rHwqb6_ZLKP-AOzyyAP4kd=b=P5-t5NGQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 16, 2020 at 11:19:19PM +0900, Namhyung Kim escreveu:
> On Wed, Apr 15, 2020 at 2:40 PM Ian Rogers <irogers@google.com> wrote:
> > v4 added a missing test file
> > v3 improved documenation, return values and added testing to the io framework
> >    following feedback from namhyung@kernel.org.
> > v2 addressed single threaded synthesize benchmark issues from jolsa@redhat.com
> > https://lore.kernel.org/lkml/20200402154357.107873-1-irogers@google.com/
> >
> > Ian Rogers (3):
> >   perf bench: add a multi-threaded synthesize benchmark
> >   tools api: add a lightweight buffered reading api
> >   perf synthetic events: Remove use of sscanf from /proc reading
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Jiri, you seem to be ok with it, can I get your Acked-by or Reviewed-by
as well?

- Arnaldo
