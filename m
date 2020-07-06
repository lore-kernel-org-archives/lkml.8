Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B517C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D53E42073E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 15:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594048356;
	bh=qLeOQlR1gi1XG8zWliK/pcJNtO5OYtFmuIyxns4wrEQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UEeW89SMdiHDGZLMj6ksymDQnVs1FbKqpwIj/tvlGYxRBohXdScNOFNwuhHhsAc2X
	 1NOmkPer4iRWpdCW6YAK/FGGxj6SPiUolaMy+v4BvsLLPf0DylcKQRT6j/7Z+q/swE
	 rBNohC085kEIHPcZXeHArdAzsmopNVaVys+a9L8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgGFPMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 11:12:36 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:41638 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729368AbgGFPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 11:12:34 -0400
Received: by mail-wr1-f50.google.com with SMTP id z15so30090974wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 08:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7/gB1q7zWrapgdKVmrGBTTlLmPD50J8i+SU3GVx9zNM=;
        b=gCjZ2A/8g2FavxagrVaf75NOWZyOSGXt8ShVShwhVd+Zjj2DFUY4O1deXT0bvsyhdJ
         4q8JvYO6mFH6jgO6fTYiBQdeyt+ck0MQtE4nJ24bPEd8GT8jFfR3dJmIuehLGwdIALuc
         Hp2Tr8QJrbrLPfXaBOhtVx/smkTvmu1eKBCl94WgPrYpbEHJMu3444mdsFYh5EoPIqJa
         NAeiGIP3t5imls3ayFWJa/Y7RQOMmqFbDHcmmZkZINZO7YAtH/6ozxgGyidY3oJTZR0k
         94QM99l+Y4xIB3cg7n7vAFeF4Px1pTSQxKXhIU0NsegsDTTChXt/HNqW5D1QAYWUb3sW
         M0vQ==
X-Gm-Message-State: AOAM530EIUswk8yf9YCefd/OlbENfVbjbUVpWw71/tLjcyxvFy8GYPoq
        v9S/G5lH6NDgUY82mprY7j2M1g0dPkgQNYzxHcY=
X-Google-Smtp-Source: ABdhPJxQJi7FEgymzf4WIuhML3z70sSWrfWAJZ1VA8sS4Qtctze4xc9bU8Rhpq5GPDVHb8TQsupUkQlgK9Kx/J+gn/Q=
X-Received: by 2002:adf:fcc5:: with SMTP id f5mr54671708wrs.60.1594048352477;
 Mon, 06 Jul 2020 08:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200703123431.GG1320@kernel.org> <CAM9d7cgGcpnX+cSY0UvYjRkG9PF8X3Yyf_AOy+nGxbPjtjDvxw@mail.gmail.com>
 <20200706115452.GA2772@redhat.com>
In-Reply-To: <20200706115452.GA2772@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Jul 2020 00:12:21 +0900
Message-ID: <CAM9d7chmV5itD-2K50qFcktJ2JPWdf=quDX_YL8HTYiHgzByXA@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf report TUI: Remove needless 'dummy' event from menu
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 8:55 PM Arnaldo Carvalho de Melo <acme@redhat.com> wrote:
>
> Em Fri, Jul 03, 2020 at 10:44:28PM +0900, Namhyung Kim escreveu:
> > > @@ -3613,7 +3630,7 @@ int perf_evlist__tui_browse_hists(struct evlist *evlist, const char *help,
> > >         int nr_entries = evlist->core.nr_entries;
> > >
> > >  single_entry:
> > > -       if (nr_entries == 1) {
> > > +       if (perf_evlist__single_entry(evlist)) {
> >
> > But I think it cannot cover the event group case below..
>
> Right, we can fix that later, I think, my worry at this point was that
> the simplest case, which is:
>
>    # perf record
>    ^C
>    # perf report
>
> Would get that annoyance :-)

Right, then I suggest moving the 'single_entry' label to inside of the
if statement.
With that applied,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung
