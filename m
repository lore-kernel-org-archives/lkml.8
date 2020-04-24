Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB11C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1749120728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M00uHRus"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgDXQsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgDXQsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:48:08 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDFFC09B046
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:48:08 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t12so9874248ile.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jGR5b4CYjzj+dlNOrZUmUN+I+i/ahso5PtIAgCkta7I=;
        b=M00uHRusU+dXSuMJVALSpKV5JaUvdWHHIMqmbEMDoOB0IyqiK0+6uWbyRgp3NNoAmv
         6+TbsJeOswcbqspQs023mTIlEVc7rtNsKdieuRW7d36FE1oY3DSuPWdjon1I+cMNh16K
         Z/4+izNZe6sx32aYDXaIkXORoKOMlzZso7234=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGR5b4CYjzj+dlNOrZUmUN+I+i/ahso5PtIAgCkta7I=;
        b=Hwhzxy+fpZncxcjlL7pQUnelL1+xTQMaye8aRyHl1UgmaTAAcVPzDwQwfV2a4XugQ7
         373e7teKPWZx37N1gH4QmWdlJPkiM4EmwRWn2yMap65CB1UGSMillU2Xs/BZR7DDvCIp
         CeYv8NhF/K7ZJwjCMXvZC80y5iuWdQDqu68moC3ZzuNpbRA++szt6wCrp2rJAl3hwAdb
         ZDUuD8hfWBHNx76D7qHxTALyT/ZAQrRO5udt7GFOaHm+/2S66+kffPqkuOmQeIlAn5ZV
         U+KB2TzApuTEFVQoJOuL3PWKGGYUGbwYMKfBpYCn8lfmbQ2At/f64Iz5qXsUFSAIgJy9
         gw7w==
X-Gm-Message-State: AGi0PuZ+S+ObPMRJ5BK4hJSe7Ar9uYglElT5lb7c9EcZcLBNrqdVY2kp
        bPpYfUXQ/YHL2pMlKJ5J1DF/cvWuyMs=
X-Google-Smtp-Source: APiQypLm14/ejtAqo2E7rBb6wzbhv7v2AYG9l2bi5yTIyT1VMnvm4P5tB5QJDoWPsSyifogWnxd/+A==
X-Received: by 2002:a92:9f18:: with SMTP id u24mr7116476ili.217.1587746887674;
        Fri, 24 Apr 2020 09:48:07 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id d141sm1933793iof.19.2020.04.24.09.48.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:48:06 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id s10so9860308iln.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:48:06 -0700 (PDT)
X-Received: by 2002:a92:794f:: with SMTP id u76mr9662889ilc.269.1587746885633;
 Fri, 24 Apr 2020 09:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200422145408.v4.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200422145408.v4.4.Ib8dccfdb10bf6b1fb1d600ca1c21d9c0db1ef746@changeid> <158769651085.135303.5206480555792176636@swboyd.mtv.corp.google.com>
In-Reply-To: <158769651085.135303.5206480555792176636@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 09:47:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFE6it066_EHe2wTNnCkRX30Tp0teehOCDRzU0dk=q4w@mail.gmail.com>
Message-ID: <CAD=FV=XFE6it066_EHe2wTNnCkRX30Tp0teehOCDRzU0dk=q4w@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] soc: qcom: rpmh-rsc: Simplify locking by
 eliminating the per-TCS lock
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Apr 23, 2020 at 7:48 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-04-22 14:55:02)
> > The rpmh-rsc code had both a driver-level lock (sometimes referred to
> > in comments as drv->lock) and a lock per-TCS.  The idea was supposed
> > to be that there would be times where you could get by with just
> > locking a TCS lock and therefor other RPMH users wouldn't be blocked.
> >
> > The above didn't work out so well.
> >
> > Looking at tcs_write() the bigger drv->lock was held for most of the
> > function anyway.  Only the __tcs_buffer_write() and
> > __tcs_set_trigger() calls were called without it the drv->lock.  It
>
> without holding the drv->lock
>
> > actually turns out that in tcs_write() we don't need to hold the
> > drv->lock for those function calls anyway even if the per-TCS lock
> > isn't there anymore.
>
> Why?

It's in the commit as comments, but I'll copy it here too for clarity.


> > Thus, from a tcs_write() point of view, the
> > per-TCS lock was useless.
> >
> > Looking at rpmh_rsc_write_ctrl_data(), only the per-TCS lock was held.
> > It turns out, though, that this function already needs to be called
> > with the equivalent of the drv->lock held anyway (we either need to
> > hold drv->lock as we will in a future patch or we need to know no
> > other CPUs could be running as happens today).  Specifically
> > rpmh_rsc_write_ctrl_data() might be writing to a TCS that has been
> > borrowed for writing an active transation but it never checks this.
> >
> > Let's eliminate this extra overhead and avoid possible AB BA locking
> > headaches.
> >
> > Suggested-by: Maulik Shah <mkshah@codeaurora.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index e540e49fd61c..71cebe7fd452 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -581,24 +575,19 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
> >         if (IS_ERR(tcs))
> >                 return PTR_ERR(tcs);
> >
> > -       spin_lock_irqsave(&tcs->lock, flags);
> > -       spin_lock(&drv->lock);
> > +       spin_lock_irqsave(&drv->lock, flags);
> >         /*
> >          * The h/w does not like if we send a request to the same address,
> >          * when one is already in-flight or being processed.
> >          */
> >         ret = check_for_req_inflight(drv, tcs, msg);
> > -       if (ret) {
> > -               spin_unlock(&drv->lock);
> > -               goto done_write;
> > -       }
> > +       if (ret)
> > +               goto err;
>
> Nitpick: Usually 'goto err' is used for error paths, not unlock paths.
> Use 'goto unlock' for that.

I'm confused why this isn't an error path.  We're about to return a
non-zero value from the function (indicating an error) and we didn't
actually do the write.  Isn't this an error path?

In any case, "unlock" is fine with me so I'll change it, but maybe you
can help clarify so I don't make the same mistake next time.


> > -       tcs_id = find_free_tcs(tcs);
> > -       if (tcs_id < 0) {
> > -               ret = tcs_id;
> > -               spin_unlock(&drv->lock);
> > -               goto done_write;
> > -       }
> > +       ret = find_free_tcs(tcs);
> > +       if (ret < 0)
> > +               goto err;
> > +       tcs_id = ret;
> >
> >         tcs->req[tcs_id - tcs->offset] = msg;
> >         set_bit(tcs_id, drv->tcs_in_use);
> > @@ -612,13 +601,21 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
> >                 write_tcs_reg_sync(drv, RSC_DRV_CMD_WAIT_FOR_CMPL, tcs_id, 0);
> >                 enable_tcs_irq(drv, tcs_id, true);
> >         }
> > -       spin_unlock(&drv->lock);
> > +       spin_unlock_irqrestore(&drv->lock, flags);
> >
> > +       /*
> > +        * These two can be done after the lock is released because:
> > +        * - We marked "tcs_in_use" under lock.
> > +        * - Once "tcs_in_use" has been marked nobody else could be writing
> > +        *   to these registers until the interrupt goes off.
> > +        * - The interrupt can't go off until we trigger.
>
> trigger via some function?

I was referring to the __tcs_set_trigger() function call two lines
below.  I'll clarify.



> > +        */
> >         __tcs_buffer_write(drv, tcs_id, 0, msg);
> >         __tcs_set_trigger(drv, tcs_id, true);
> >
> > -done_write:
> > -       spin_unlock_irqrestore(&tcs->lock, flags);
> > +       return 0;
> > +err:
> > +       spin_unlock_irqrestore(&drv->lock, flags);
> >         return ret;
> >  }
> >
