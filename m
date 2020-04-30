Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC575C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80D42206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G8GiJdfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgD3VPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726549AbgD3VPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:15:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C2CC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:15:39 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b18so2792218ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Pdnm8ECqM7H2/FerxXYY1DLktzf8E2C2MPAJfYGqwg=;
        b=G8GiJdfHpnTbi20l6WjboM8fWS9MDkmILsCZdX6YcONkf5Mw5cq4K+lkQFt3cocXvK
         fRo+fZnwFl8QaZKqxyvSlEPmv1+eU3d/8algZm64/PfUUUvnGkAwRQRrV2jz5+b0c8O8
         oL0k3NV50QL2JiSs4KqsmlQuuJogbjB6OaLoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Pdnm8ECqM7H2/FerxXYY1DLktzf8E2C2MPAJfYGqwg=;
        b=R3FaeoPGiNB/wIRshbSlvqHLNT3hvkEYsZQvnA6m/BDdEcJE+UvdVpBX36wkWGM7DL
         q21l30fhdUdDTJ7S2RAJdbPUSrVjiKV3o1On9P8yOw1rk1iAGUyQqpJ/7DcskoYmsgbc
         nDTlrUv7wScbSgFSnyGW/QNME4cGaa5ZOqasjq5dp+Pql4pHnvXk8sZby0brCOogyerl
         PR8RtJlhLIMVqBZnlXO7w8CGpfmFju+I5YyVjAZ8BNOeG8rS+9D1McCdOULAO9zsasWz
         C+Cgc+DDrxRvLJyDKUuC7Ngrt4rVU/432OPJQJmXin290BiqcJdzvhsQQNEJK4/bcfcd
         szhw==
X-Gm-Message-State: AGi0PuYzkSeu7jDT+RZ1A73b6gpy9jPZzfk7y56V3gPDAgc6Va51Q5mm
        jN5jq+NF7NT3df6PdpEHwnevqPDLrz4=
X-Google-Smtp-Source: APiQypIaeF/e1vgdrYzmKxE7OZAw91LMy5eUca4rO+/H/nQ1XbQpO6FhKabo7CPwW5ZDqtOTtVaILw==
X-Received: by 2002:a92:79c6:: with SMTP id u189mr401991ilc.172.1588281337863;
        Thu, 30 Apr 2020 14:15:37 -0700 (PDT)
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com. [209.85.166.172])
        by smtp.gmail.com with ESMTPSA id g22sm205242ioc.41.2020.04.30.14.15.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 14:15:37 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id b18so2792091ilf.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:15:36 -0700 (PDT)
X-Received: by 2002:a92:6b04:: with SMTP id g4mr435576ilc.82.1588281335690;
 Thu, 30 Apr 2020 14:15:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200424094610.v5.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200424094610.v5.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
In-Reply-To: <20200424094610.v5.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Apr 2020 14:15:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WyMVoFz8wM6tJznosNF9-6-ser__tOY1uqrHBrPk5U+Q@mail.gmail.com>
Message-ID: <CAD=FV=WyMVoFz8wM6tJznosNF9-6-ser__tOY1uqrHBrPk5U+Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Colin Cross <ccross@android.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 9:47 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> cpu_pm_notify() is basically a wrapper of notifier_call_chain().
> notifier_call_chain() doesn't initialize *nr_calls to 0 before it
> starts incrementing it--presumably it's up to the callers to do this.
>
> Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
> This potentially means you could get too many or two few calls to
> CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
> luck of the stack.
>
> Let's fix this.
>
> Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
>
> Changes in v5: None
> Changes in v4: None
> Changes in v3: None
> Changes in v2:
> - ("Fix uninitted local in cpu_pm") new for v2.
>
>  kernel/cpu_pm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm hoping at least the first 3 patches in this series can land soon
so they can make it into v5.7.  The first 2 patches "Fix" a patch that
was introduced in v5.7 and the 3rd patch fixes a longstanding bug that
could also affect the same code.

Ideally all 3 patches could go through the Qualcomm tree to keep
things happy working there.  get_maintainer doesn't really identify an
owner for "kernel/cpu_pm.c" so maybe nobody would mind if patch 3
lands in the Qualcomm tree?  It looks like the most recent bugfixes to
it (back in 2017) were landed by Rafael, though.  Rafael: would you be
willing to Ack patch #3 for it to go in the Qualcomm tree?

---

If patches #4 and #5 look OK you could certainly also land them in
5.7, but the safer option for those two would be to target 5.8.

Thanks!

-Doug

>
> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index cbca6879ab7d..44a259338e33 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -80,7 +80,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_unregister_notifier);
>   */
>  int cpu_pm_enter(void)
>  {
> -       int nr_calls;
> +       int nr_calls = 0;
>         int ret = 0;
>
>         ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
> @@ -131,7 +131,7 @@ EXPORT_SYMBOL_GPL(cpu_pm_exit);
>   */
>  int cpu_cluster_pm_enter(void)
>  {
> -       int nr_calls;
> +       int nr_calls = 0;
>         int ret = 0;
>
>         ret = cpu_pm_notify(CPU_CLUSTER_PM_ENTER, -1, &nr_calls);
> --
> 2.26.2.303.gf8c07b1a785-goog
>
