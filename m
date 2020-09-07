Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 00:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E42080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 00:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599438443;
	bh=Ax0HqV8yGt6FdghBfoqW0Okgd26oSIhbORa6W7WTJDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TyIrcq5Mv5PitxWZHUOnPZrvioVCI6yN74jDee3ePl8hvUyc0vxbfs6IF86ZgsXfE
	 TniNoCJI47rcph9NG8gj4UTq9N4P+7PLDjepAJRm7JW81j1iRo4qcqdgYLM5wEl0lg
	 oU7Ca+jLQBRHLoWW/9NFO+gk1GgsYr1rE7WxWVng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIGA1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 20:27:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45404 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgIGA1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 20:27:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x14so13932825wrl.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 17:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yj+JC2Bsv3jKzFuICxwCmAyDpr3FU6Ft9Q4UyeDiS3k=;
        b=Sy92IMOccBo5t7QUFo37pvDlbvjrkmH+W2+v5iie2xnHkrFFYUwuXXGSg/7bl0vGou
         miptcBU7eKxLbkRxHTdECK5l++mB55DUP1VnUvJ1zIbpNNRsSo/vvNaT5wgjPc8OQeyW
         jx68TCjO7wjUHRY1P29pS2N3BNp7DDsUQ7L2IpjQAOFYQnKhgPOzoMa2+52gszFF3ih0
         cyDv8ZKfiK75oKgd88e9rbNrnPZGFv8oieQFVvXzuWescTDY1mpzf631z/uP6eXK4iQe
         MU2zE+V+fmtgZwx3ecI+oFSL1vSo8bpcZxsSdH1aqwvVbffXJYGvXS09fsOi6SHI4uYH
         LQ2w==
X-Gm-Message-State: AOAM530O1dZXEQGmZWyLfZyvdHEp5+weEFI35b7gnOb5hhpGdUY5TO8u
        DAV12eLdghfLN5J7tTQ5SKwwDPz0sfuvVxqQtpE=
X-Google-Smtp-Source: ABdhPJwLxqZgDb9+BhvA5D/7lq3Cg34ZSvaaaDeCR8rydWEI4smD9KQMpAOaHiS91TcEP0emiblQlIPah4rQxzXlrjc=
X-Received: by 2002:adf:e481:: with SMTP id i1mr18609311wrm.391.1599438435332;
 Sun, 06 Sep 2020 17:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200905021912.621388-1-namhyung@kernel.org> <20200906124118.GA1199773@krava>
In-Reply-To: <20200906124118.GA1199773@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Sep 2020 09:27:04 +0900
Message-ID: <CAM9d7cijN4YRtYdOC1_yRc4YerFGV1ob-MYw2ssVQDJUEWOheg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf metric: Fix some memory leaks
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Sun, Sep 6, 2020 at 9:41 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Sat, Sep 05, 2020 at 11:19:11AM +0900, Namhyung Kim wrote:
> > I found some memory leaks while reading the metric code.  Some are
> > real and others only occur in the error path.  When it failed during
> > metric or event parsing, it should release all resources properly.
> >
> > Cc: Kajol Jain <kjain@linux.ibm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Fixes: b18f3e365019d ("perf stat: Support JSON metrics in perf stat")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks for the review.  Actually I have another batch of leakage fixes
for the metric code found by ASAN.  Will post it soon..

Thanks
Namhyung
