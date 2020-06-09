Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC75DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:29:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA462072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxxFU62u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbgFIP3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730789AbgFIP3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:29:49 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA51C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 08:29:49 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id e125so12754712lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9IVxxdE18kyf3He9rGpIj1hCmIn48AUOA8lzG/AI2M=;
        b=PxxFU62uc9/YdDEGEwgsByTKQ1jYCPZ7jusRIZFSG9pvy3hsq+s/8Co9l3kPBq+4yb
         KSRZFG/bZGi2PSSRoGLJ5Cs1ziGss5k51YEgFmxM0cZSSP2YBULLKSWQWnXeUe+ry7M0
         pmdxRok/GD324+n8jxEzje9XDjAhqTS4tP2jNjR9p58TsKTFZ1Q0pqviupSfy2DL5L+n
         7qYTWPPKYacrcZzgJW6T0l7OpvpGx6LcnQzcGeHghM46NVOZGYzohckpdayCzJreUymH
         2sPKOcYFglPVEWN7/5Q6fmaE5HiV/SMWHUGi6dYPRxP2zvErMdFv9OAIWyUK4rbJspnW
         nnMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9IVxxdE18kyf3He9rGpIj1hCmIn48AUOA8lzG/AI2M=;
        b=bh4uikniMBRGhzvy8XiktJ/sZz2EXfen3zt/Iez7IDRDlxbMsnrUZP27KRz37TYbqM
         Ser3vE+ee1HfdlQUHg9xsrtybSdA0T3yb5vDKfR2pdjyugsiDIoIXAbAxnaRQvMSk8G3
         cSeHnz8aPqbBsuqz0QjHdMaRGDhj7kY8LJq3Q3LyMCUxbDZqRZMUzDT56bsPLhGiyCm7
         fRNfj324obL2tWC10R5Rd3lwr38WfUPxONrb/RPvZg+5KbbXnCJcIHSAS1wUZxKhU1Wv
         4ADp7jpCciKvo1JOWBg4x2bH3p6uGqkF1bve9jO5tU/eoYpqHUdzfUTEiOuGSHOvpe7f
         Qf0g==
X-Gm-Message-State: AOAM530AqtaAKuNgJLZqhpC5WFSnozX8h8FGzrALnDJyS8KujqlXM1Ch
        nCb0saEWT1IAYvSKL4LNAS6VZSpILuHaPZYfU8ZjiQ==
X-Google-Smtp-Source: ABdhPJxdls+n5VYYUq0Wc3bhGAoi+RcxAxDptX5ze7i/Z0PrfNr4h3k3pU9Hw0QalwWSUOwrg+Rh/AgPlcWHQM4Ipb4=
X-Received: by 2002:a19:4854:: with SMTP id v81mr15493723lfa.189.1591716587413;
 Tue, 09 Jun 2020 08:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net> <20200529100806.GA3070@suse.de>
 <edd80c0d-b7c8-4314-74da-08590170e6f5@arm.com> <87v9k84knx.derkling@matbug.net>
 <20200603101022.GG3070@suse.de> <CAKfTPtAvMvPk5Ea2kaxXE8GzQ+Nc_PS+EKB1jAa03iJwQORSqA@mail.gmail.com>
 <20200603165200.v2ypeagziht7kxdw@e107158-lin.cambridge.arm.com>
 <CAKfTPtC6TvUL83VdWuGfbKm0CkXB85YQ5qkagK9aiDB8Hqrn_Q@mail.gmail.com> <20200605104517.r65dqhzavnnrnfb2@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200605104517.r65dqhzavnnrnfb2@e107158-lin.cambridge.arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 9 Jun 2020 17:29:35 +0200
Message-ID: <CAKfTPtC6arfWP==0LbtsfK9BE3xVoXd5CZsMHw6760o3q8MKfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fs <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Qais,

Sorry for the late reply.

On Fri, 5 Jun 2020 at 12:45, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/04/20 14:14, Vincent Guittot wrote:
> > I have tried your patch and I don't see any difference compared to
> > previous tests. Let me give you more details of my setup:
> > I create 3 levels of cgroups and usually run the tests in the 4 levels
> > (which includes root). The result above are for the root level
> >
> > But I see a difference at other levels:
> >
> >                            root           level 1       level 2       level 3
> >
> > /w patch uclamp disable     50097         46615         43806         41078
> > tip uclamp enable           48706(-2.78%) 45583(-2.21%) 42851(-2.18%)
> > 40313(-1.86%)
> > /w patch uclamp enable      48882(-2.43%) 45774(-1.80%) 43108(-1.59%)
> > 40667(-1.00%)
> >
> > Whereas tip with uclamp stays around 2% behind tip without uclamp, the
> > diff of uclamp with your patch tends to decrease when we increase the
> > number of level
>
> Thanks for the extra info. Let me try this.
>
> If you can run perf and verify that you see activate/deactivate_task showing up
> as overhead I'd appreciate it. Just to confirm that indeed what we're seeing
> here are symptoms of the same problem Mel is seeing.

I see call to  activate_task() for each wakeup of the sched-pipi thread

>
> > Beside this, that's also interesting to notice the ~6% of perf impact
> > between each level for the same image
>
> Interesting indeed.
>
> Thanks
>
> --
> Qais Yousef
