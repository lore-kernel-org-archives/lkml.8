Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D000FC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0DCC21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wd1ymYRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729787AbgBYIYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:24:07 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:38138 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbgBYIYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:24:07 -0500
Received: by mail-lj1-f178.google.com with SMTP id w1so13014788ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 00:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KBmyMZAeqjL/dWehJYWIZj/HK+sTTg1x4dJjtWNJz4=;
        b=Wd1ymYRw9ghLg/v6CP8+SveZ4OsVVukkCJXUZ+7SUt/vxJsv4eaS/BLi0CELES5LvM
         u+/5grfOt1wKhyrfkyIMNumcHaIsS/tUhp7iedp58BWEj9mKJf9q6edsZseaFujO/J4v
         vFK+l9T1tlyC4e1Z+oXvztoTGVSB9/eTRDALR35uR10+F6mqe6PqCelVTTZItYMW/TH2
         6vbJnSD2DsMY6074zMOVSqSZnGve+cPA4QB9rI6piJ+EHbuQrknS8NdnTxQjF5TGYjfl
         Oa2EzmUjgPGCTm+2M+zdwtZWMq555nr4lUMRqirC+hurQ8IW6s8rJO6WJlegs6yfrV9a
         nN8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KBmyMZAeqjL/dWehJYWIZj/HK+sTTg1x4dJjtWNJz4=;
        b=Lb1unyNe8Br188ljcmp3Xho/dKEtZxQNGXZM8sdnffRdD8jQZ1q7ZEVac8CiW4qiFB
         xl7kqWZ6UJ/BgdjTcqulhziw7WqIkt/e5suq2xCHJt000TAnlAEl1tHFHbf8OAS/2kcf
         piNziAcUhWd2ARyzl22BlyD0j1NpHIhyB6RMmorTUqtO7UKFlqnzGIyJEo7Q3w2liglf
         ghQGy+gzlfM1Zh0g6WtEb/+IvzXENn/CTlhDWvpttaqQa6BzbpSCEE9mwWgyhT2nRjdm
         V8qyt3dNy+fwJBtVMUqvyky6+ICzhsMYpOSUe/VQsI0WI46Skf1b2Y1tyMkPIOvR0q2S
         HPEg==
X-Gm-Message-State: APjAAAXRis/AtRjM3meakS/TBZBZbibU8BmtzC80RDjrQYTTkmSF8yc+
        oBNOLddoteDJgkVicpgwd63bq5FpVNbi5EImyY3aKA==
X-Google-Smtp-Source: APXvYqy8RsIavee13RX2Ng/Iy0dV1rVHxkrrl/x6+fmkPYOKcK8Y0NEg8xCGCBuHo+/9wPVTBt/y2eFuiRQQ6SmYM7o=
X-Received: by 2002:a2e:9596:: with SMTP id w22mr30879694ljh.21.1582619045157;
 Tue, 25 Feb 2020 00:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20200224095223.13361-9-mgorman@techsingularity.net>
 <158255763157.28353.3693734020236686000.tip-bot2@tip-bot2> <jhj36b06klb.fsf@arm.com>
In-Reply-To: <jhj36b06klb.fsf@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 25 Feb 2020 09:23:53 +0100
Message-ID: <CAKfTPtDSYRaLsxBLi4+=Z8zT4mpXo269MX3TYdxkjD1GSq5d7A@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/pelt: Add a new runnable average signal
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 at 17:01, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> tip-bot2 for Vincent Guittot writes:
>
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > Reviewed-by: "Dietmar Eggemann <dietmar.eggemann@arm.com>"
> > Acked-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
>
> With the fork time initialization thing being sorted out, the rest of the
> runnable series can claim my
>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Thanks

>
> but I doubt any of that is worth the hassle since it's in tip already. Just
> figured I'd mention it, being in Cc and all :-)
