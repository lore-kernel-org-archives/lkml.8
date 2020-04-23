Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A827BC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFBA20728
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 21:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRM7j3i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDWV3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 17:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgDWV3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:29:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B671EC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:28:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so5969458lfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 14:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cJ/om21QoE8YFkcgeObkzd003C+ydlysJG+0dh0Xm7U=;
        b=cRM7j3i31IVtCOYSO4JpoY/gBS1E9C7bcDbvpqA2p0f9GR8LArQPjkRswWuEK5Cozj
         raO/qrEdY8JxnsEV8iui8zoPoS1G/uHQncBD3RZB0/z8QgWuHR5AkN/qx9JKIs6l3fNl
         LwOz/XG/7qINkoFExwR/wcEObLOJFVJy74qvMBskEcV8FuiO3h25e7Rw1GxTfwc9bJA1
         uussKz6tbYA8DxWVcyNKcMb1eXVKel5Xk1dWLrjj90Hi+mx4pQof/VjRVLv3mddYSCVi
         /bav8proMa49Rd8hu7UPoUK31Cxu/28XjiYGjKKn2AyXg+Z2CCBDQ0uuF0yaR4ATwltH
         mJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cJ/om21QoE8YFkcgeObkzd003C+ydlysJG+0dh0Xm7U=;
        b=nhTeKesZvQNFA8XRAjLpWpAnDX5itt45oTdaW+ztA1MMkmPRvsFrSeBsE6x0WGehPu
         A4pBNUmZpo6CRggYIsqCX4YdG8/zK5bewd4vVAWbb93zHhbZGn94RKfueZIDYMVAdyvK
         8EA9D/TWBnNTAnXIZhdLsvldqZ/vHA3Oo9nANZ+rgmG6Q6jCP2CCBWsKiBLa++bk59PV
         7cytPTACmdW0EZdEGvEvwjKcJx4EhuuQRx8bSTc83sjrghs4iiV6h7dfgsh6VXkN+pKj
         7tYpFp3VW5HgdQGojyybWpVK9FPULWfZyYYYJOX2nI8G7ggliQMEayWqTjZcZfZZuwjj
         7ZuQ==
X-Gm-Message-State: AGi0Pua/+xCXZcKzQ12TUwSj+WNUBJzJK7vOXb6myXvX3C1baJ9DUk5a
        WSzd6J6fplZhrqtX6i2Sd4S0/MeyHhD6WqiKhdQTIA==
X-Google-Smtp-Source: APiQypIL6+XCC6KRY6QeQ1RaOw/nm6pbb466MVleUrH+09A+DCHH2xEXlFGHadEXklatSoeHVl3ZnPoL4/mXRPYPdrQ=
X-Received: by 2002:a19:b10:: with SMTP id 16mr3773184lfl.133.1587677338172;
 Thu, 23 Apr 2020 14:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200420115316.18781-1-acme@kernel.org> <20200422120943.GA110748@gmail.com>
In-Reply-To: <20200422120943.GA110748@gmail.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 23 Apr 2020 16:28:46 -0500
Message-ID: <CAEUSe7_wmKS361mKLTB1eYbzYXcKkXdU26BX5BojdKRz8MfPCw@mail.gmail.com>
Subject: Re: [GIT PULL] perf/core improvements and fixes
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        He Zhe <zhe.he@windriver.com>, Ian Rogers <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Konstantin Kharlamov <hi-angel@yandex.ru>,
        Stephane Eranian <eranian@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 22 Apr 2020 at 07:09, Ingo Molnar <mingo@kernel.org> wrote:
> * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > Hi Ingo/Thomas,
> >
> >       Please consider pulling,
> >
> > Best regards,
> >
> > - Arnaldo
> >
> > Test results at the end of this message, as usual.
> >
> > The following changes since commit cd0943357bc7570f081701d005318c209821=
78b8:
> >
> >   Merge tag 'perf-urgent-for-mingo-5.7-20200414' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-04-16 10:21:31=
 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/per=
f-core-for-mingo-5.8-20200420
> >
> > for you to fetch changes up to 12e89e65f446476951f42aedeef56b6bd6f7f1e6=
:
> >
> >   perf hist: Add fast path for duplicate entries check (2020-04-18 09:0=
5:01 -0300)
>
> >  85 files changed, 1851 insertions(+), 513 deletions(-)
>
> Pulled, thanks a lot Arnaldo!

Our OpenEmbedded builds detected an issue with 5287f9269206 ("perf
script: Add flamegraph.py script"):
  ERROR: perf-1.0-r9 do_package_qa: QA Issue:
/usr/libexec/perf-core/scripts/python/bin/flamegraph-report contained
in package perf-python requires /usr/bin/sh, but no providers found in
RDEPENDS_perf-python? [file-rdeps]

This means that there is a new binary pulled in in the shebang line
which was unaccounted for: `/usr/bin/sh`. I don't see any other usage
of /usr/bin/sh in the kernel tree (does not even exist on my Ubuntu
dev machine) but plenty of /bin/sh. This patch is needed:
-----8<----------8<----------8<-----
diff --git a/tools/perf/scripts/python/bin/flamegraph-record
b/tools/perf/scripts/python/bin/flamegraph-record
index 725d66e71570..a2f3fa25ef81 100755
--- a/tools/perf/scripts/python/bin/flamegraph-record
+++ b/tools/perf/scripts/python/bin/flamegraph-record
@@ -1,2 +1,2 @@
-#!/usr/bin/sh
+#!/bin/sh
 perf record -g "$@"
diff --git a/tools/perf/scripts/python/bin/flamegraph-report
b/tools/perf/scripts/python/bin/flamegraph-report
index b1a79afd903b..b0177355619b 100755
--- a/tools/perf/scripts/python/bin/flamegraph-report
+++ b/tools/perf/scripts/python/bin/flamegraph-report
@@ -1,3 +1,3 @@
-#!/usr/bin/sh
+#!/bin/sh
 # description: create flame graphs
 perf script -s "$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
----->8---------->8---------->8-----

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
