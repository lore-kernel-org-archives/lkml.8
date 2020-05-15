Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2593206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZSiksqD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgEOCdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgEOCdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:33:10 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8980C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:33:08 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g7so231563uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VpAp2g9upL2rOYKmKkLTm26YtCXwPgkFjRfp1ZdcwU=;
        b=ZSiksqD70itmOtA5/mpFhEaFKroOkzqNz3C1bV0CEeEaMfImp3frbdNt0Xmo/fLo86
         EaBKCnfB2TMo6CxQPvx7x/TXnN5x0PQFqpDO4bQZVe1Yv90UVWYDCPOmTUsM84lslDxW
         5bXAnGx7C+3/YYnVyEp/BXt3BUGPBxircdhSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VpAp2g9upL2rOYKmKkLTm26YtCXwPgkFjRfp1ZdcwU=;
        b=Uxx8Ar4YDlaXlqh/kRuRlpdkrTci9oKYek5OhFfmj8kl6HU5yLA7O/au7nuarg+Y5n
         Bn4CB7y4mnwKvZfZkTnPsLUDBGYbhokcliBo0V+5mFJ4S5t5eeaLlRX7PdHFUIdctviL
         gunQtC9BZwOG+vHTm/JGLo3dlXvzECEjOaXseVZ6uEOF9jb2OOEcZP5HCNoVus0ckntF
         4eRXEIm7lKBLCVjkP9E8R59zAIH912wGD6uou161rusK+kS7ALEinlX0skP1SjbEANwc
         Fa+j+KoyWTY94S4zMUeBL1BzKYw561bRkLQ/SkMSvthS2Oo/GFzFo+Z1JnbnYEu8drS0
         xIGg==
X-Gm-Message-State: AOAM531DlM5kIFJpoQw1UOWdG9ob/AqzTunydP3SgISu5m4a0d/ZzzFD
        KHIbbprXovGQW5+g4iMm5J/Yr1TP9HE=
X-Google-Smtp-Source: ABdhPJzixWefnTKx+zcUL7VnxB5is4BCzecOQWjo71U2IL5lRztzygspC9KayCGdGyojxwcqUWzEKg==
X-Received: by 2002:ab0:705:: with SMTP id h5mr1306266uah.74.1589509987699;
        Thu, 14 May 2020 19:33:07 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a2sm219660uae.10.2020.05.14.19.33.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 19:33:06 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id z1so312933vsn.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:33:06 -0700 (PDT)
X-Received: by 2002:a67:f5d6:: with SMTP id t22mr996043vso.73.1589509985541;
 Thu, 14 May 2020 19:33:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
In-Reply-To: <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 14 May 2020 19:32:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
Message-ID: <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, May 4, 2020 at 10:50 AM Douglas Anderson <dianders@chromium.org> wrote:
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
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> This seems to be an ownerless file.  I'm hoping this patch can just go
> through the Qualcomm tree.  It would be nice if we could get an Ack
> from Rafael or Greg KH though.

Greg / Rafael: any thoughts on this patch?  Care to give it an Ack so
it could go through the Qualcomm tree?

Andrew: I think you are the adopter or orphan patches, usually.  If
nobody else will take this patch, will you consider taking it into
your tree?  It should be a super straightforward bugfix.  I'm happy to
re-post it CCing you if need be.

Thanks!

-Doug
