Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC3FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69AD2074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599227489;
	bh=el/KmqFc8f3GdvnpdNRE/cNKFzWqZ6G9M8jRv8DfkBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lEw0DXA7wZrntxa1FKrAmNta8wdwz7oyIUh+vtGX1m2kYi0DHAln61nzPEqsosJWO
	 B6Du9+lWww6vk9QdxSH+T5DPPLqHPyG0TFqwgL7SsgW1wEzA+MSrPw3OXJl7izsfI4
	 VRBYCVkumyxGOPdw4JbJHNHVoSHo3y5H20lkoBQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgIDNv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:51:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45896 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730443AbgIDNr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:47:29 -0400
Received: by mail-ed1-f66.google.com with SMTP id l17so6107389edq.12
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RW0o+OIL0Vm4OhMexQgpiD/wZOFMn7Fo3sHj5t3ae9Y=;
        b=CUhGqRQcyg6gyaVRiEthFefx/hVmdbUaRF9S81bOqGsSQVqsrO8sHJvW1/N0dEmB14
         8uxHTNPftulUNENrVcqrefByj3cUFDK8rcoc4/OGFD42hDZfAc1paPpwE0wFS1l99xvR
         ZBo6gtkD3xUgH5TAqt2K5mwnQ3VdfS8gznycAUM0oGi9nvYRN1bemsU1CMHMQnMytPUN
         AUKSHzIO8rF6xFhwT2B/0WWaxu1qB7JOf2FVATG4Q7PZPN2hJv0Ge/7ENqY8NdrodKNg
         dFMaAkppoZtaeZUJFLewvrGVDPqFvKeFL57fWEICSbj01AQNzuM0ZR38UbarZnhbh7CM
         xeIA==
X-Gm-Message-State: AOAM531vNvavtOqkwhUOoYTmbz97Wdw+w8taiuhufsuqty6c/+SsBh86
        EiAaovJvznZazQ/IafiTmQjR3WZ5YI3J43kIq0w/NGJkDts=
X-Google-Smtp-Source: ABdhPJwF+NSTkWtm8P293dISyySn6474njU02dR24YDqr49uaT//i8EA0wGna2BqpTfZm2sD12/ITZIo/EKteek6E6o=
X-Received: by 2002:adf:a3c9:: with SMTP id m9mr7698455wrb.80.1599226801443;
 Fri, 04 Sep 2020 06:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200904032142.516333-1-namhyung@kernel.org> <CAP-5=fXjeCBemNivMb6+9AH-PETTqTghaZHniOohd_1ms1rU2A@mail.gmail.com>
In-Reply-To: <CAP-5=fXjeCBemNivMb6+9AH-PETTqTghaZHniOohd_1ms1rU2A@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 4 Sep 2020 22:39:50 +0900
Message-ID: <CAM9d7cgQAj-md=ZPKGD7iHEBYDnFqCfB1CO8moRih52MFoP6XQ@mail.gmail.com>
Subject: Re: [PATCH] perf metric: Fix some memory leaks
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 1:02 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Sep 3, 2020 at 8:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > I found some memory leaks while reading the metric code.  Some are
> > real and others only occur in the error path.
>
> Thanks Namhyung! Is it possible to get test coverage?
> Ian

Not sure what you want..

As I found it from code inspection I don't know if there's a test covering this.

But as far as I can see, 2 of them are on the error path so maybe not easy
to add a test, other one is called from perf list code, and the last one is on
the normal code path so any test should cover it.

Thanks
Namhyung
