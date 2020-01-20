Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79654C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D775217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579528681;
	bh=jnnF84fgJtgeCqx69CsQ36Qp3+mscVwDExYuio4XtV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j4VpKnZXuu2/nH1x41wIUdr6bXfGvjAqPvc+JZ397uQqncEJEaOp+btxVgZEHfl5Z
	 YhhPpnNP6lgRJ/JH/ycb8FefNd0JLpSq/QlsTr3HkKroylaG7BZhLKYZpl41Z9RMZt
	 RmBPXMEtar1pwZ6WCvYcgN2sOwCEOZNjKeDhFBEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgATN6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:58:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33714 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATN6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:58:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so29715566wrq.0;
        Mon, 20 Jan 2020 05:57:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qSVOOxhYGahh1e9eNAUZ87d182C6ZMh03WZHn+HCe4=;
        b=risoJQ//zQtWzaYnpMR0NgUQllPmmAfi7hBToylrRGfzsF+S+QsAmF4mYtdgVU+URq
         T4mQz1uH25LeoZtp+uCPDhJi22vW0JnFcN1pUafZc+CSFVzRXb3cs46oQVGMy8BzUd0D
         6P5S2iXqNloCr5If8pcGdjf3iUfieYdVINQIy22gMWBxu4+CPmGv2j8/oBqO+AcYTT9c
         09rXEh74zN7lxVuzbW0/8ktDiNNGdWMAvl2aJPnCS3OeP/fcNTNF7jRfvpC5zrDov6wY
         ZSh0sJcVLmJFt3+z88oZDhszGUIOKn1IafzqBmFxdxfBileCTeA7Ml5OVqCdNsEgK+2q
         nFYg==
X-Gm-Message-State: APjAAAVV81l17JMtYD6xaK9g0nJqU7nhcRnmyPO90GL62UDdF+GtWWWE
        ZfSbCrfyM5c85LKRMSroaqzYNl6ZVinHPw8Se+g=
X-Google-Smtp-Source: APXvYqw2DINSuLa2sOER+BIkhcIWGxYhAPB7fB1LHJUkoQgZgX/vY+QRFRqRX5OjUhhp0qGgRVf78+B6/qrdVebQ964=
X-Received: by 2002:adf:82e7:: with SMTP id 94mr19659222wrc.60.1579528678250;
 Mon, 20 Jan 2020 05:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20200107133501.327117-1-namhyung@kernel.org> <20200107133501.327117-5-namhyung@kernel.org>
 <20200108215235.GA12995@krava> <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
In-Reply-To: <CAM9d7cifgLKbu5KM+QF6ZK9DGbN=8g1oj+vzU3HcTfrUQHP5jg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Jan 2020 22:57:47 +0900
Message-ID: <CAM9d7chWNyFx6vBNZZea7exiwKhU+cwTY-Yaf2_cSXoJ1jSgcQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] perf tools: Maintain cgroup hierarchy
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jan 9, 2020 at 9:51 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Jiri,
>
> On Thu, Jan 9, 2020 at 6:52 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Tue, Jan 07, 2020 at 10:34:56PM +0900, Namhyung Kim wrote:
> > > Each cgroup is kept in the global cgroup_tree sorted by the cgroup id.
> > > Hist entries have cgroup id can compare it directly and later it can
> > > be used to find a group name using this tree.
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/cgroup.c  | 72 +++++++++++++++++++++++++++++++++++++++
> > >  tools/perf/util/cgroup.h  | 15 +++++---
> > >  tools/perf/util/machine.c |  7 ++++
> > >  tools/perf/util/session.c |  4 +++
> > >  4 files changed, 94 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
> > > index 4881d4af3381..4e8ef1db0c94 100644
> > > --- a/tools/perf/util/cgroup.c
> > > +++ b/tools/perf/util/cgroup.c
> > > @@ -13,6 +13,8 @@
> > >
> > >  int nr_cgroups;
> > >
> > > +static struct rb_root cgroup_tree = RB_ROOT;
> >
> > I think we shoud carry that in 'struct perf_env'
>
> OK, will move.

So I tried this but then realized that it's hard to get the perf_env later
when it needs to convert a cgroup id to name (ie. in sort_entry.se_snprintf).
I also checked maybe I can resolve it when a hist entry is added,
but it doesn't have the pointer there too.

Thanks
Namhyung
