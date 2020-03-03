Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460E7C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2316220CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywYBJW8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgCCIKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:10:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgCCIKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:10:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id f10so611083ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IrpN0Khyn8F1w21hxzWH/afGTVD23TpSjjqucFl7FDw=;
        b=ywYBJW8uLDNL42qTQ9U0JspTdFYKPpfxz72SXdAOUhpjlgUd7wxjhMY5iXgaLa678Q
         HUFAyVWZbqi3NiWcOrc2Hcu3uKjRWhQ1AvpWF8WhXsOT9IflBiCK7D16gHYx9Ig++426
         Ltwj7ZkihrH+xDKNSfnx9gJ8auSEPilIdxbHYdLca3Qms+l1Zt6zD55cGgEQ9xaCqM5x
         aGah8U5cvou12zbmi/ewmL75AZJytjxtCSC0hO13KIL7MbMHObhI8djdmbWUnyb+qlP7
         SZ80cPbgyoyO++/N/5+eusOi9zApdk4kGurWR5YnU/fsQUrOa53AAB4c0GtRy9I2VFap
         ZV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IrpN0Khyn8F1w21hxzWH/afGTVD23TpSjjqucFl7FDw=;
        b=pvyfzEfV5uxs+B1aS+NevT7A9gCbUwATTiPV/ORBwBPlUU5YLXvCD6KuzxiSBU3bhR
         qbygKJtbBud9wDWo/LCbTfLUfnoZWCfP5nW5LeGrgJmn0EKivZQ9WMguJZuND//Bu2Vo
         IRVWgx2agM+a+rSCo7WeKO59s8hcn2UAi2zE9BJI2cCYTyaLUfsQfz9Hdn4GZlaTI2ve
         Y5KUlujB+OylcwJTrgdp7Xl9St5LPqb/7veIO/cp48PfbiVXiXKMGl/4AB9T8Wr+H2vt
         xww+S/1qdH0pUMCP40LQMvV8ecxL0qM/JNeyCnJYojmSCAEUhbcJUzoOSydZ3Y0qY5Rg
         QNdQ==
X-Gm-Message-State: ANhLgQ0P1U3hvacNCBkTH8VSvDD2J/T1+p5cYKYlbE0YxTLnjrkudVBo
        z57yKxPr1obif2YHjuuaoRTf7bKnVJvtEcqUrucg5Q==
X-Google-Smtp-Source: ADFU+vtcf2XGPFtkahhGncITxSY967rhTlnPD1S9kyV1c/Dr1He9t9FKOVYN3msBIiEPycAaIXOvebfpwBgQ6K3phDo=
X-Received: by 2002:a05:651c:203:: with SMTP id y3mr1677654ljn.151.1583223014795;
 Tue, 03 Mar 2020 00:10:14 -0800 (PST)
MIME-Version: 1.0
References: <1583209826-28853-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1583209826-28853-1-git-send-email-anshuman.khandual@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 3 Mar 2020 09:10:02 +0100
Message-ID: <CAKfTPtB8sfJaOXL9D98ydxWZ76_8FLw4Z5KWWn73fcfkdiB-Vg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Conditionally enable test_idle_cores()
 forward declaration
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Tue, 3 Mar 2020 at 05:30, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
> test_idle_cores()'s definition and all it's call sites are enclosed withi=
n
> CONFIG_SCHED_SMT. Hence the forward declaration needs to be conditionally
> enabled in order to prevent build warnings like the following.
>
> kernel/sched/fair.c:1524:20: warning: =E2=80=98test_idle_cores=E2=80=99 d=
eclared =E2=80=98static=E2=80=99
> but never defined [-Wunused-function]
>  static inline bool test_idle_cores(int cpu, bool def);
>                     ^~~~~~~~~~~~~~~

similar patches has already been sent:
https://lore.kernel.org/lkml/20200226121244.7524-1-valentin.schneider@arm.c=
om/
https://lore.kernel.org/patchwork/patch/1201059/

>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: sfr@canb.auug.org.au
> Cc: linux-next@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This patch solves a build problem that exists on next-20200302.
>
>  kernel/sched/fair.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 84594f8..827087f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1521,7 +1521,9 @@ static inline bool is_core_idle(int cpu)
>  }
>
>  /* Forward declarations of select_idle_sibling helpers */
> +#ifdef CONFIG_SCHED_SMT
>  static inline bool test_idle_cores(int cpu, bool def);
> +#endif
>
>  struct task_numa_env {
>         struct task_struct *p;
> --
> 2.7.4
>
