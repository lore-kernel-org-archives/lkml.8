Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A6CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468B420733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 07:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s6dTIH8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgBJHlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 02:41:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36873 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 02:41:42 -0500
Received: by mail-lj1-f195.google.com with SMTP id v17so5947087ljg.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 23:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQAMqZgLfT0wJRD/FDyGI9iiUds9Vgum3AdT3P7c+Pk=;
        b=s6dTIH8nR1EDDkvxfT1FBQ8tPW7iSPSDaPQ6E+N3gYuGm2w528c9yPiIj9GXYfGTNU
         ji5dy54Tbk2OAM0Fth+NzdaZQp1HMORcpbbftO5yu/4g9rqaofEQpZLbQtmfJa1tTgIY
         h19tTFVFoX38vPV5o3xBf+5Qchx1ltxsvTwdFiiG5wfBEUvX6Cx7ypL7H4pL77IAB0Xg
         XgXXgxtWzeOvY0GrwtsbbGHfUQW6DAo7jcgQVjiKhavXn8EpUtE3ga8wC+VW2utJ20hq
         1ePeUN0vhOMYdXtqWxtab3jPppZ9AL6dVQpwvMsb6wBh3EI4mJnV/sNWFjY7Gy2llxee
         uChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQAMqZgLfT0wJRD/FDyGI9iiUds9Vgum3AdT3P7c+Pk=;
        b=hagZZMgcKwvBOw+o2dt7Kt/OO1+nR9UzAUDMipJJwgbCnt0aUKFRhqVu43pN/E55aH
         e+bk/QwDAhT2gOEEp9xKjxph7GKRWpJ63r/bMG8dj3suM8/alC9jG1fY1EiRQE8tx+k0
         cNtBrwiaeDYLD2PzZc+1Db2vFPZ2F2rse5TTB8+giF4N85V5fTYJugZUdEpV3IIfCAkT
         yozynRReFspkLYKJaf7x2E+1w4jZZCQK1bAGzTYp0Ln1NldO0SuTazmBVrOHxuVup8Ow
         bZ9OTyZzERu+8yubiNFk9QD0O/RjsahDJWzqQ1G+j8DdK4O0cQ3nHCld5E1EWeJW3Tk4
         LuLQ==
X-Gm-Message-State: APjAAAVv+CI+daZb5aoc9lZxFtbUV213IBghAL8B3ssxSBG+uSQQobSR
        LPuDmoBen9oks1Hz31P6sxktpESAq3ZDLqGzotxs4Q==
X-Google-Smtp-Source: APXvYqz2STzBhlOw3uR6zIIOfr03gzozPSja2i9wC+uvdgfObt/xm1FF3AW3JPTgkc2nOng/9dN4TXFfdIdWrDqp9KQ=
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr37451ljl.65.1581320499988;
 Sun, 09 Feb 2020 23:41:39 -0800 (PST)
MIME-Version: 1.0
References: <cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org>
In-Reply-To: <cbe964e4-6879-fd08-41c9-ef1917414af4@infradead.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 10 Feb 2020 08:41:28 +0100
Message-ID: <CAKfTPtAmG7WnZCZLKpK2SLG24W-Azr7P2E=41kz=1R9CJLwkvg@mail.gmail.com>
Subject: Re: [PATCH RESEND] sched: fix kernel-doc warning in attach_entity_load_avg()
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 at 04:29, Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix kernel-doc warning in kernel/sched/fair.c, caused by a recent
> function parameter removal:
>
> ../kernel/sched/fair.c:3526: warning: Excess function parameter 'flags' description in 'attach_entity_load_avg'
>
> Fixes: a4f9a0e51bbf ("sched/fair: Remove redundant call to cpufreq_update_util()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org> (SCHED_NORMAL)
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
>  kernel/sched/fair.c |    1 -
>  1 file changed, 1 deletion(-)
>
> --- lnx-56-rc1.orig/kernel/sched/fair.c
> +++ lnx-56-rc1/kernel/sched/fair.c
> @@ -3516,7 +3516,6 @@ update_cfs_rq_load_avg(u64 now, struct c
>   * attach_entity_load_avg - attach this entity to its cfs_rq load avg
>   * @cfs_rq: cfs_rq to attach to
>   * @se: sched_entity to attach
> - * @flags: migration hints
>   *
>   * Must call update_cfs_rq_load_avg() before this, since we rely on
>   * cfs_rq->avg.last_update_time being current.
>
>
