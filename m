Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64079C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3564120721
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9xOnYjN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403857AbgDCMgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:36:13 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43490 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgDCMgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:36:12 -0400
Received: by mail-qv1-f68.google.com with SMTP id c28so3424365qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/UIQ6cCz6/xPuMLPWGcywGCrwVngPK40EuPV4gXPVrg=;
        b=G9xOnYjNwulboqxCx81yN1IIkK+Qt1i9yxPkPaBg0zRTstOZeFZPjUdhn7ibIQLAgk
         XxxVKC9WdbOIWEGV6WDUCMUpttj2rdrk1zivYDaP90amGTclDD4ry6PBzORrnaWq0JJU
         EOu+i//xhhpUhE+tQUDtFJaLtG3mw78bNqG0x/6Nwn/XvP/bWSXRwKOutGPvEMkClBX9
         gSqAFTS6xtASEGigsC8wSPI+2LNaH5QiCxLr5FO89bL1SvhBqx1qYIjU4fplBboUF0Z0
         SPraTa+dG6IEi3LOxLVm7HZklL3svPzdTRjTIWf8L6czdkrS7jmREK346b3fgG/pPEML
         dpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/UIQ6cCz6/xPuMLPWGcywGCrwVngPK40EuPV4gXPVrg=;
        b=TUWR4pLYYuaCbZSML0LSJ1xpS8ZEhIpseJPsPGnzQ0t6bVGIVP9Sx/NHJpR5b8GWWm
         tvAKyuSVlG9v2Dp5iTIjNJoVqmvctvGCjsF1Ip4qwE34qHGDe/3O9ftfM3px3K5cjNeQ
         Wguo6GhosptsMTSoP6LWR+44ucoLNOHgnSSa0n0TYIswBXqR0/HHQ9ZSN5LP/MeihWXe
         l2X8IvWy2pfNWTSiq+oPIjdprIdOpIjfza4z3mD6T3+XNCyi84m1q/j5PUEV1eUQGJjW
         ZGtZxHtlFTzEQLLLdjDVSPwNBqDAFEOy9BrpAJSs2f4hf4vjyPUCbuqgFhhV8TWP93ZP
         JM2A==
X-Gm-Message-State: AGi0PuZzuKar/o0ta7nEJ7d62/+hKhRRL+gK2RvQD6dq53DF/WYLiq9Q
        AunoVlm0mbCRbUO+SBqpcpw=
X-Google-Smtp-Source: APiQypI7PsH7snM6jdOXd2HKBLWUe9bvS5FDXTaIY281QuZkO+vPIsI5Vs8/2oWe95MNI5epqMg68Q==
X-Received: by 2002:a0c:e902:: with SMTP id a2mr8154150qvo.103.1585917369743;
        Fri, 03 Apr 2020 05:36:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e16sm4514719qtq.78.2020.04.03.05.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 05:36:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 889BB409A3; Fri,  3 Apr 2020 09:36:06 -0300 (-03)
Date:   Fri, 3 Apr 2020 09:36:06 -0300
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
Message-ID: <20200403123606.GC23243@kernel.org>
References: <20200325124536.2800725-1-namhyung@kernel.org>
 <20200325124536.2800725-5-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325124536.2800725-5-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:45:31PM +0900, Namhyung Kim escreveu:
> Each cgroup is kept in the perf_env's cgroup_tree sorted by the cgroup
> id.  Hist entries have cgroup id can compare it directly and later it
> can be used to find a group name using this tree.

This one breaks the 'perf test python' test, I fixed it adding this
patch before your series:


From ea3c4ab73cb2ea2960bba6894560b1ef91e69737 Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Fri, 3 Apr 2020 09:29:52 -0300
Subject: [PATCH 1/1] perf python: Include rwsem.c in the pythong biding

We'll need it for the cgroup patches, and its better to have it in a
separate patch in case we need to later revert the cgroup patches.

I.e. without this we have:

  [root@five ~]# perf test -v python
  19: 'import perf' in python                               :
  --- start ---
  test child forked, pid 148447
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so: undefined symbol: down_write
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  [root@five ~]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python-ext-sources | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index e7279ea6043a..a9d9c142eb7c 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -34,3 +34,4 @@ util/string.c
 util/symbol_fprintf.c
 util/units.c
 util/affinity.c
+util/rwsem.c
-- 
2.25.1

