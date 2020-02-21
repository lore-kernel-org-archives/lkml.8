Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B205C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CE6222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cje4o0gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgBULrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:47:52 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37934 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgBULrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:47:51 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so1272978lfm.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 03:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+0DXDQC4PSdbGf9Pveh1mXtQ4AEBvLtlHWHBl3nZk4=;
        b=cje4o0gr9878CZnZBPlek0YbZ4348Bfnnrasdx4MzpEGFBGd04rCnExlhCNsdTm37p
         MoaYVf6B9PSnR0fB9iYxopLEyUOtH87COidRAzw300rdYoMHGEVsH/IwoA/4RwrY3SGn
         KtHkK8217BbNcftVxtNOkdvGaTCw7DtAT85IyMBHxTSQgBfPGcCFSIwdDz+ysp9WHFpl
         4L57kOi43X0NBbEJ71fPNVwP3/tT2k7mEJBjFrrGAk4KRm417t7w0LZLRhXQHbHq/IHL
         fab7mjg69gzOJBNO/t45Fx6aVde2y3MHG9DARreBrousRWpsLxJ5UkcTH5PCIOFqLwX8
         FErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+0DXDQC4PSdbGf9Pveh1mXtQ4AEBvLtlHWHBl3nZk4=;
        b=MBF01QNf8QZS6n3FPllcFqQffIcPTpQwBTnCQFu8KbfXMR2c1qy2HI+lK8rVV1wn+s
         pLdM9iqrkN5dZTeoZfaq/8LvAgcXdUCTK5QAj/TUdcxeM8r7ds/Si2djkDuQ56+iiSGo
         po0iHJWSqIVfee5rBGlV3eoXV4ddneni65dV2YLJ6FOr9VrGhOmXDAi+CI803376A5xH
         LSdHAj9V1UmlJ6vInt348KimVGYEtcf+GD7viQmqViuaNg2wK37kqWhPmaqx/cULiLha
         pu/elistQq5VIrijam4nWhBDAC8MyN4OQ+V0nNcyrDrnnWNqf90o1s5RiJtllbfg6Lhb
         W85w==
X-Gm-Message-State: APjAAAU4NRHQ/P46jUQor3x7CGjx5/+rM1TfNmwM8oEJFfKutEvThU9h
        3IVNMn0YjU9wVqoNrm283yKIC6dGN7O07GqRciGWlA==
X-Google-Smtp-Source: APXvYqxaHpR0d8dRAx6vXF4ZbAjZjXLUgDelk2CdK8hqc66hWq6gY2dtxVbfmoylqUgJ9KRjYq270pK1gjkQ143vvxQ=
X-Received: by 2002:ac2:4add:: with SMTP id m29mr19649122lfp.190.1582285667764;
 Fri, 21 Feb 2020 03:47:47 -0800 (PST)
MIME-Version: 1.0
References: <20200214152729.6059-5-vincent.guittot@linaro.org>
 <20200219125513.8953-1-vincent.guittot@linaro.org> <e6b4bcbb-82a2-137f-8801-bab561cb7343@arm.com>
In-Reply-To: <e6b4bcbb-82a2-137f-8801-bab561cb7343@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 21 Feb 2020 12:47:36 +0100
Message-ID: <CAKfTPtCJ4ARMeypmmNRasdrPaPynbvuKraQA4Q6A=AA1g-iG3Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] sched/pelt: Add a new runnable average signal
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 10:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 19/02/2020 13:55, Vincent Guittot wrote:
>
> [...]
>
> > +static inline long se_runnable(struct sched_entity *se)
> > +{
>
> Why returning long here? sched_entity::runnable_weight is unsigned long
> but could be unsigned int (cfs_rq::h_nr_running is unsigned int).

I have reused the same prototype as for runnable_laod_avg

>
> ___update_load_sum() has 'unsigned long runnable' as parameter.
