Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96365C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C00C215A4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 06:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U7wNYsYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgDWGJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWGJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 02:09:24 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF084C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:09:23 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id h205so2547927ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 23:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrE4KKFTdzZAODRsf0iRvpS449bChhBAlCxKgsDfMv4=;
        b=U7wNYsYb7GLwNYtEY39aq//g5FCqhxwzUssRFVir5TOdM9g1tzUbYksuV+2kWI+n2y
         iZpJQoqKhffNiNfQB5A7iA0Mql17gEw3jbshKx8ad4y8dINipu4h3olXN+uiv97GlVER
         XP0HtaM/mScXUVJYRVJw80lB/ilvNSRb8na7DfKIQfPwIRGmQdxb7zmQabbHPgwBzkFz
         gbF25bxGJSGNBU1B1IbgMcy2Ef0ZKMACFZuAD4RJ/+EW8i0ri7z72YuHPTIbS/BHK6qz
         55NXdLL9cPiun1Q7doJ8AcdVH1xyqXMFT59aJStdYJDZCwMmH4ETswD2a5Fce9JfYhLU
         w4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrE4KKFTdzZAODRsf0iRvpS449bChhBAlCxKgsDfMv4=;
        b=ieyczLxDodboQvfarWmPoOzW6ZhVycYfofTu4+B1BEzHObe7KGalpOrsF5XkEVLvhd
         vN1qR4rlaf39TzsPFSUMEvq+uHKC/Mrs7mjtVqdlyblCw4oKLzjCG6SiUq9t4c3YgRnE
         rDlb3SfNT7/mS7D64wYPcs9DRHMqXzggfsGeyHEEXfiIIIchjDiCjXa5znEq6FEiBA6z
         uDmVoIzW7CZPTg9B/4nG3cOPL1U8tEz/c6k/P/e1EXfxe7HxsDwkDXYqPdy/Tx1O/kCy
         BbhOBtTT+nDs8Cd01nkwf96Qix1c9ibDysZPcF9ofpW3gGKsZ8ph79/qcq8RirijXHZD
         Wb1g==
X-Gm-Message-State: AGi0PuZhT8YFZuaEhi2EKxswuPdFtsVaRPWf6ZRQh4IOKJmQsIuMzo9n
        xdj+mJOjq8oc5p8rmH2JyLT17wtdMRch0RwNwGCF6g==
X-Google-Smtp-Source: APiQypLd8bChmUKTyL6TkmgbOYfrCSG+TdAeNavHsinwPWlRtsg1zAbaCqnaUSFP4YmuqDbX/UDcTVTRScX6X8BeY7o=
X-Received: by 2002:a5b:9cb:: with SMTP id y11mr4252129ybq.177.1587622162585;
 Wed, 22 Apr 2020 23:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200422074809.160248-1-irogers@google.com> <20200422074809.160248-3-irogers@google.com>
 <20200422143840.GJ608746@tassilo.jf.intel.com> <CAP-5=fUnWAycQehCJ9=btquV2c3DVDX+tTEc85H8py9Kfehq4w@mail.gmail.com>
 <CAP-5=fUMFqiSFLbKA-XWStrePwxiYfq7Jk6mS9=F56Q9y-KVsA@mail.gmail.com>
 <46e803f3-80a4-0d37-9d39-b625b947ac7f@linux.intel.com> <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
In-Reply-To: <cb5fcb4b-3ac6-66b5-9f9e-7943f4a6dadf@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 23:09:11 -0700
Message-ID: <CAP-5=fXVF_ExxVuiivF0JY3MwgxrQZqyFoPwn-p7DPf6Gbdh0g@mail.gmail.com>
Subject: Re: [PATCH 2/8] perf metrics: fix parse errors in cascade lake metrics
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 10:54 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Jiri,
>
> Bisected to this commit which introduced the regression.
>
> 26226a97724d ("perf expr: Move expr lexer to flex")
>
> Would you like to look at that?

Hi Jin,

that commit breaks parsing of things like ','. See fixes in this patch
set such as:
https://lore.kernel.org/lkml/20200422220430.254014-5-irogers@google.com/
Fixing the lex issues then exposes other bugs that need to be
corrected in the json. I've added Fixes to the commit message of:
https://lore.kernel.org/lkml/20200422220430.254014-3-irogers@google.com/
https://lore.kernel.org/lkml/20200422220430.254014-4-irogers@google.com/
and would be glad of a review. If we can land:
https://lore.kernel.org/lkml/20200422220430.254014-12-irogers@google.com/
then expr as the source of parse errors can go away :-) The next
problem is the parse events code, but some of that logic is dependent
on the machine it is running on. It'd be good to add a test that
parsed events code can handle the events in metrics too, filtering out
things like duration_time that are special to metrics.

Thanks,
Ian

> Thanks
> Jin Yao
>
> On 4/23/2020 9:08 AM, Jin, Yao wrote:
> >
> >
> > On 4/23/2020 12:18 AM, Ian Rogers wrote:
> >> On Wed, Apr 22, 2020 at 8:34 AM Ian Rogers <irogers@google.com> wrote:
> >>>
> >>> On Wed, Apr 22, 2020 at 7:38 AM Andi Kleen <ak@linux.intel.com> wrote:
> >>>>
> >>>> On Wed, Apr 22, 2020 at 12:48:03AM -0700, Ian Rogers wrote:
> >>>>> Remove over escaping with \\.
> >>>>> Remove extraneous if 1 if 0 == 1 else 0 else 0.
> >>>>
> >>>> So where do these parse errors happen exactly? Some earlier
> >>>> patches introduced them as regressions?
> >>>
> >>> I'll work to track down a Fixes tag. I can repro the Skylakex errors
> >>> without the test in this series, by doing:
> >>>
> >>> $ perf stat -M DRAM_Read_Latency sleep 1
> >>> Error:
> >>> The sys_perf_event_open() syscall returned with 22 (Invalid argument)
> >>> for event (cha/event=0x36\,uma
> >>> sk=0x21/).
> >>> /bin/dmesg | grep -i perf may provide additional information.
> >>>
> >
> > I also think some patches introduced this regression. When we rollback
> > to commit 61ec07f5917e (perf vendor events intel: Update all the Intel
> > JSON metrics from TMAM 3.6.), there is no this error on CLX.
> >
> > Thanks
> > Jin Yao
> >
> >>> This was just the escaping issue. I'm less clear on the other cascade
> >>> lake issue, and it is a bit more work for me to test on cascade lake.
> >>> What is "if 1 if 0 == 1 else 0 else 0" trying to do? Perhaps hunting
> >>> for the Fixes will let me know, but it looks like a copy-paste error.
> >>>
> >>>> The original metrics worked without parse errors as far as I know.
> >>>
> >>> The skylake issue above repros on 5.2.17 and so it seems like it is
> >>> broken for a while. The test in this series will prevent this in the
> >>> future, but without this patch that test fails.
> >>
> >> The parse errors were introduced with the metrics, so they've never
> >> worked:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=fd5500989c8f3c3944ac0a144be04bae2506f7ba
> >>
> >>
> >> I will send out a v2 with Fixes in the commit message but wanted to
> >> wait in case there was any more feedback. In particular the fixes to
> >> the new test and expr parser lex code. The lex code wasn't broken at
> >> the time the metrics were added and should be working again after this
> >> patch set.
> >>
> >> Thanks,
> >> Ian
> >>
> >>>> If it fixes something earlier it would need Fixes: tags.
> >>>
> >>> Working on it. Thanks for the input!
> >>>
> >>> Ian
> >>>
> >>>> -Andi
