Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA452C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC6902067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmkevgLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgFDU1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgFDU1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:27:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B9CC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 13:27:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id s18so7884011ioe.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 13:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cIgVS8ggkjhxB0JoJojRceUX9GryrMeDRowoa0T2ICw=;
        b=PmkevgLVw0MJkySoUuAV4KjwhxjrSugxZVs3t7ZgLbW+hH6bGVCkDpHNCQOp3dzFRn
         59sEJdR8Ilwa/jfy9rErHPpp4lr5TDsowJRUdgab+6o7x7X4YDxyTROH1vSRKXXJmRt5
         ai86SvPojqS2mw90PUpX1D/anPL9xfbtHr254pasWlf4hLzV/NEJRe200wNIuWFEImhd
         0CaTPDx74hKuyopOCTc7cxjpxxTXgc4EYjSbzJglWsHVEhvpSEtlCzf+luwwDgMkcB3+
         pemWmzfJeatJQ2XMNd2bjltqSNtD1xqWNThs1yzSikgadfUaVOSXWT/p/94BuM+DSjjT
         s6Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cIgVS8ggkjhxB0JoJojRceUX9GryrMeDRowoa0T2ICw=;
        b=KonKYO5cJEciLYfIPAxrvaYbYM+NhptzZDgmvVbDQXdf16XIbe4/YfT5JBQXOmJJDX
         J1/7G7E9iQHaWzjULcPbZEf25p0nKx4+sqIAOf7PZ1qbPvYBuwDOQfil1pdOXgLlMSgY
         QBZXx91BQJWnp0qB2oDMU4Bjr00B+xo2J1nrL4OZNA3W/qGsqsAj8E8VHDQGcLRQkjwo
         oROQs5RRZ7ki/f/xC9rgJ3EO38yjVbQiQelMkHQcVkAaeARKaNM2Ry9b82dasyeTSgaM
         yJVYGZjGOalRaRYOSodWKtMbH/FOdA2aozaJp/VQbplAQe1L9q6/cDKo2m+4FExIAE+6
         BuOQ==
X-Gm-Message-State: AOAM531uyv3HZrOfBSQ5aoK5LYSEss792eJpJISmq8FRUi83O8L6msQR
        NHg2ujjS249ornxTPEvHKwiTMmJ2xV8dpyjNKPWGFw==
X-Google-Smtp-Source: ABdhPJzpThlPYBYmjbj75PgXV76QN3HOlHcq6JbnftNLq7+6HWjg+EJisZsywxEQ5wQs0Dn47n7F1bJh1xikj8I2bZ4=
X-Received: by 2002:a05:6602:224a:: with SMTP id o10mr5387683ioo.90.1591302452004;
 Thu, 04 Jun 2020 13:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200601175139.22097-1-mathieu.poirier@linaro.org> <0780724c-4fc0-9f98-023e-aa1245b01888@st.com>
In-Reply-To: <0780724c-4fc0-9f98-023e-aa1245b01888@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 4 Jun 2020 14:27:21 -0600
Message-ID: <CANLsYkwsBSaVJCi7xDXC6E+E_UzwKmZqDtzZUWTDusuQKjKiQA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] remoteproc: Add support for attaching with rproc
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jun 2020 at 08:24, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu,
>
> On 6/1/20 7:51 PM, Mathieu Poirier wrote:
> > This fourth iteration implements a solution that is fairly different from
> > what was proposed in V3 and earlier versions.  Three aspects have been
> > revisited:
> >
> > 1) Only the scenario where the remoteproc core is attaching to the remote
> >    processor is implemented.  Other scenarios where actions need to be
> >    taken when the remote processor is stopped or crashes will be
> >    considered in subsequent versions.
> >
> > 2) The introduction of a new RPROC_DETACHED state to be set by platform
> >    drivers when needing to attach to an already running remote processor.
> >
> > 3) New functions are introduced to replicate the functionality provided by
> >    rproc_fw_boot() and rproc_start(), minus operations related to firmware
> >    management.
> >
> > Enhancement to the documentation has been left out intentionally until it
> > is agreed to move forward with this implementation.
>
> Look good to me, i have only a minor concerns about the code duplication
> introduced by the point 3)
>

This is an idea Bjorn and I have decided to try in the hope of making
the state machine, and the feature as a whole, easier to understand.
It might be one of those rare cases where more code is better.

> If you are agree with that, I plan to do a new review on the stm32 series
> when you will start the documentation :-)

A wise decision...

Thanks for taking the time to look at this,
Mathieu

>
> Regards,
> Arnaud
>
> >
> > Applies cleanly on rproc-next(7dcef3988eed) and will be rebased on v5.8-rc1
> > when it comes out in two weeks.
> >
> > Thanks,
> > Mathieu
> >
> > Mathieu Poirier (9):
> >   remoteproc: Add new RPROC_DETACHED state
> >   remoteproc: Add new attach() remoteproc operation
> >   remoteproc: Introducing function rproc_attach()
> >   remoteproc: Introducing function rproc_actuate()
> >   remoteproc: Introducing function rproc_validate()
> >   remoteproc: Refactor function rproc_boot()
> >   remoteproc: Refactor function rproc_trigger_auto_boot()
> >   remoteproc: Refactor function rproc_free_vring()
> >   remoteproc: Properly handle firmware name when attaching
> >
> >  drivers/remoteproc/remoteproc_core.c     | 226 +++++++++++++++++++++--
> >  drivers/remoteproc/remoteproc_internal.h |   8 +
> >  drivers/remoteproc/remoteproc_sysfs.c    |  17 +-
> >  include/linux/remoteproc.h               |   9 +-
> >  4 files changed, 243 insertions(+), 17 deletions(-)
> >
