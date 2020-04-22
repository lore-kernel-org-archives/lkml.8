Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FAC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3950621D79
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TUd4rJqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgDVVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgDVVz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:55:59 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA334C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:58 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id c24so3592087uap.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee+zATalvFDSHsDJhhon2QlCCkUj/d0VudmLHXnBmsM=;
        b=TUd4rJqLQZsjq6KLXtPQcP3sPAG8zMj1ACMMw0j6JpLd66ThrMzdO2Q6cwbu7nRl/O
         YbMYQ1NFClJK2gnsolCt/ewAhNbddIrazAl3MHUOx8excckMfhPbqY8ihcky+e7LVQ/e
         9go05fP/WOtdAH34H5vTlfDfGvX8gSYH9ZHCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee+zATalvFDSHsDJhhon2QlCCkUj/d0VudmLHXnBmsM=;
        b=WNMQ43Eigdxy3TL1SGe584kdjqw9UvPESZoelXmneUSUjdFVOCRfE4uzjde/TkfQWA
         8YaYE/vUfLQPWKDOeQMxYI9/7ttdG/PCeW97+OUgWFvtvBKxg/VwkRjSUf4JEmliMsMl
         d+sac0evFA1uvk5dHocOTtAQWZNW78yFk9WLLZujPLhTr0FSd7tw64ivDb+UeuL3PppE
         e3nMwquj2z/VeOwCZeOPqgxNLb3BMpBsxJV25GywqbHkxUccpxdTyXnps4zwq0TE874G
         F4KKokl+DH6EA3kbW5BNbqoRBrUrVbBAhohOhl2ZMMQXWM4AAqdhUXrJgE2U6fIhPlub
         6Eag==
X-Gm-Message-State: AGi0Pub41YpVuAidF/KjCLPhdeMkyS88EtBzmHXTPM0Kl3ay8AnXs+SR
        aEVii7VImqQwKwegkSMyIUeTZy20qXo=
X-Google-Smtp-Source: APiQypIvvUcDcwxUCLo4b7s/rmmbJjxPKfdtBSf+9a9k1uc5wRRQUsxq9E+stHYXa3Ue4tWKgynJBA==
X-Received: by 2002:a67:80d6:: with SMTP id b205mr805744vsd.57.1587592557703;
        Wed, 22 Apr 2020 14:55:57 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id n193sm200039vkf.43.2020.04.22.14.55.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 14:55:56 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id z16so3587109uae.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:55:56 -0700 (PDT)
X-Received: by 2002:a67:bd07:: with SMTP id y7mr808727vsq.109.1587592555835;
 Wed, 22 Apr 2020 14:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200421102745.v3.1.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
 <20200421102745.v3.3.I295cb72bc5334a2af80313cbe97cb5c9dcb1442c@changeid> <158755160722.163502.9129728895530548942@swboyd.mtv.corp.google.com>
In-Reply-To: <158755160722.163502.9129728895530548942@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 22 Apr 2020 14:55:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UKAVSsk=4NtqgsdR3MVTtTQiJVHGaLnu+WLt5mWCZXtQ@mail.gmail.com>
Message-ID: <CAD=FV=UKAVSsk=4NtqgsdR3MVTtTQiJVHGaLnu+WLt5mWCZXtQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] soc: qcom: rpmh-rsc: Remove the pm_lock
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 22, 2020 at 3:33 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-04-21 10:29:08)
> >         case CPU_PM_ENTER_FAILED:
> >         case CPU_PM_EXIT:
> > -               cpumask_clear_cpu(smp_processor_id(), &drv->cpus_entered_pm);
> > -               goto exit;
> > +               atomic_dec(&drv->cpus_in_pm);
> > +               return NOTIFY_OK;
> > +       default:
> > +               return NOTIFY_DONE;
>
> Can this be split out and merged now? It's a bugfix for code that is in
> -next.

Sure.  I guess I had visions that the removal of the pm_lock would
make it into -next soon-ish too...

Interestingly, when testing the split-out patch I found that it wasn't
nearly as important as it appears.  Specifically we don't appear to
get cluster notifications except for a final one at the end of full
system suspend.  Grepping for cpu_cluster_pm_enter() the only calls
(other than the one from cpu_pm_suspend()) I see are in "arch/arm",
not arm64.

I've also split out my own bugfix about not getting notified about our
own failure.

v4 posted now...


-Doug
