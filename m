Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6DC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071C920857
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBjnWT1t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgDWObj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728220AbgDWObi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:31:38 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0730DC08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:31:38 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id n188so3251096ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 07:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7Pl1PwnvbMpR0U57xizz7g55/sueu6YZnbMx+knRbQ=;
        b=VBjnWT1twFFJ2rUJDqslmecuNXGR2e5mZpmJ02LzDFSHU9fHsoKhZiRhkU37W0fdos
         wlFEVrtTMC83E7S6g8odI2dp8NIBmaH5N3bOa6UHTjO8LLw0ImCXix2PxL34bXECbHFc
         MoOc4WGMsFCllWejjaObKYjqEKHvhrM0mvpC3v/hxIdeWBire91gTtpHJS0FZusixbqO
         S/4V5uACp7iYqFhBgx190DfkkToyP/Sif/leydgJCgjrcnxFMKLvliHN8WUuznDeoqkG
         Fk3/ItqvH78DDosvsKLsbUvnGaZw0Ih2ZVAjQqa+AnpwCLK+5MKB5owS/UzfnBRkINp+
         OL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7Pl1PwnvbMpR0U57xizz7g55/sueu6YZnbMx+knRbQ=;
        b=I5z3bZZts7u4YzzFIS6QmRPhyj4fnqBn+bsURB4hfL3W26kxf/0UsYHXRY0YYLYnbc
         wfEQZ8tyGvkj3x51bE5qJtkS3YqiPdITxLlGSzMkFIP6JvuGI2y6Nw6/3Y0ABSqPhUB7
         hZawpPv2lBouk4RF/lMvnNpsyTYhkcK5rZfH9QVXoJHwL7IyRlnOt+akc30Wx3EYFOQU
         Gv6+PS3DMnbLGoNFDvH3dqPRmkcYn8EejJl63OA8cfjyTmCurCqWkIWhAQsrc2ctGshj
         LloW5XVW4A65+ThLb4xMbQNieMRMJiGcGPaGMSdLYpX64Z3killlgwYrF2ZE2gKBIamA
         jDDw==
X-Gm-Message-State: AGi0PuYJWQYfvF6jHO7v3F57riI7yxLGLELUFt2WGH21ewqVJQPPYObU
        KCgF+cQZyWqojFT+MgstnKqtSHVCqv9z2xsMhdKcqQ==
X-Google-Smtp-Source: APiQypK14N4sb98SPria4Jb5pUitFHNgGf2H9nQz7fGaDGZGJlza8IBwU80iTE3hdxE9vZ90xvXUYJ3DiujX4Wnjf4w=
X-Received: by 2002:a25:d688:: with SMTP id n130mr6700712ybg.324.1587652296940;
 Thu, 23 Apr 2020 07:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200423112825.GD1136647@krava>
 <1dd2e280-d711-2dda-61b1-b81609af6467@linux.intel.com> <20200423140249.GA1199027@krava>
In-Reply-To: <20200423140249.GA1199027@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 23 Apr 2020 07:31:25 -0700
Message-ID: <CAP-5=fUO5sA8g2qv=Bg5LSSbG3nnhm57cBR7PsraH9+thph5qQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf metric fixes and test
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Apr 23, 2020 at 09:44:24PM +0800, Jin, Yao wrote:
> > Hi Jiri,
> >
> > On 4/23/2020 7:28 PM, Jiri Olsa wrote:
> > > On Wed, Apr 22, 2020 at 03:04:19PM -0700, Ian Rogers wrote:
> > > > Add a test that all perf metrics (for your architecture) are
> > > > parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
> > > > architectures other than x86.
> > > >
> > > > v2 adds Fixes tags to commit messages for when broken metrics were
> > > >    first added. Adds a debug warning for division by zero in expr, and
> > > >    adds a workaround for id values in the expr test necessary for
> > > >    powerpc. It also fixes broken power8 and power9 metrics.
> > >
> > > looks good to me
> > >
> > > Jin Yao, is there a metric that's not working for you with this patchset
> > > applied?
> > >
> > > thanks,
> > > jirka
> > >
> >
> > Let me look for a CLX for testing, but maybe need some time.
> >
> > BTW, suppose this patchset can work well, does it mean we will change the
> > json file format in future?
> >
> > For example,
> >
> > before:
> > cha@event\\=0x36\\\\\\
> >
> > after:
> > cha@event\\=0x36\\
> >
> > "\\\\" are removed.
> >
> > If so, we need to change our event generation script.
>
> ok, maybe I got the wrong idea that the extra \\\\ were just
> superfluous, what was the actual error there? and what's the
> reason for that many '\' in there?

I believe they are superfluous and break even before the flex change.
I commented on it here with a reproduction of a parse events error on
skylake:
https://lore.kernel.org/lkml/CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com/

Fixing the script that generates this would be great! With the test
landed it should be much harder for this to be broken in the future.

Thanks,
Ian


> jirka
>
