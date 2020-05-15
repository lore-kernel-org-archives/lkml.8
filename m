Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC2D206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZC9+WMS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgEOSvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgEOSvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:51:52 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B72CC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:51:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g11so1271264plp.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Eb5cwHLliZRLZBurI99Btoz2BSvs/B+LB6BGuH6pjrc=;
        b=ZC9+WMS9eUE0ec/Wnuj10ar+NP2CeNqLkIBJQrqqNkrGtMDN57qN91wmOKRmqf/cyS
         SXZ8a+4U0nZ1vSQtrkOeGOeKNb+EkPD+aEnSC6iy9LQi046txejYoA+webr4zJND7LHF
         UYIPC6IsiunTDWRtY0RhQv8LYyMe8FIPvbHZTaXgn+wGnYncbnZ5rszCTVZ1rIyCcvH8
         2L+rBUxpQYVZp2bBI0IcnVZ4ZgEGsT5MBtaX+UAMXBgmFv9YG4XX2f1LxqAdxf1DxHrR
         Y6pQkSmbTnsGw6Moztj2FInOmM8VVmLcGHOCmLi4zBCa4l/lsu4yiZqfqcmJZfxb84jM
         m+dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eb5cwHLliZRLZBurI99Btoz2BSvs/B+LB6BGuH6pjrc=;
        b=kww7uPP7U2RRiWBHciuTcEaHhlV7xn70enUpYNBZPRlwd0uZe8ay7OXjh84zId6vMa
         CtaRPaRjAUpze82Ol4/COcceNn0J7seoK74p6ZdgOPOkDUjCtpX6BTkr6w+J4MKs0sBw
         Mkx8W4jC82NGN+/cyWD4oa0bUJNYkp8zPObYFWDTmDON17C83mrdFWhwB8mJCO7nbYTz
         YtMchE1c0CvAZ/LFnSvS5a8v58y4TxRDuZEZ+h2SggArQ88SYgpRmfYxMOUH74mZ480g
         6sir6jZk2qUbksM+3dhGxWPve+1TDuB9KQHzP+veyyw5PMuGyLwTPBmnSW9T8OQN0MR1
         0cnw==
X-Gm-Message-State: AOAM532AlJZNnJAkgofaEp0826LCB08xTf3767Ou5LQZK8qTESki8YeI
        o/fsPzktjTe7xGg6SlkVHgb7Gg==
X-Google-Smtp-Source: ABdhPJzfO5/bmKaV7u9vIvrtJvs+osN0UqN5IHnY5MTAwYLy8swzG1OWBRtVrWEOyOAeRTbP2OFluQ==
X-Received: by 2002:a17:902:207:: with SMTP id 7mr4766081plc.331.1589568710834;
        Fri, 15 May 2020 11:51:50 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d126sm2657391pfc.81.2020.05.15.11.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 11:51:50 -0700 (PDT)
Date:   Fri, 15 May 2020 11:50:22 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Gross <agross@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Evan Green <evgreen@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Colin Cross <ccross@android.com>,
        Kevin Hilman <khilman@ti.com>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] kernel/cpu_pm: Fix uninitted local in cpu_pm
Message-ID: <20200515185022.GZ2165@builder.lan>
References: <20200504104917.v6.1.Ic7096b3b9b7828cdd41cd5469a6dee5eb6abf549@changeid>
 <20200504104917.v6.3.I2d44fc0053d019f239527a4e5829416714b7e299@changeid>
 <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WpYm=1gUW2Tu4YMwDvn8r7_4xYQD2_bQFU=Po76xyowA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14 May 19:32 PDT 2020, Doug Anderson wrote:

> Hi,
> 
> On Mon, May 4, 2020 at 10:50 AM Douglas Anderson <dianders@chromium.org> wrote:
> >
> > cpu_pm_notify() is basically a wrapper of notifier_call_chain().
> > notifier_call_chain() doesn't initialize *nr_calls to 0 before it
> > starts incrementing it--presumably it's up to the callers to do this.
> >
> > Unfortunately the callers of cpu_pm_notify() don't init *nr_calls.
> > This potentially means you could get too many or two few calls to
> > CPU_PM_ENTER_FAILED or CPU_CLUSTER_PM_ENTER_FAILED depending on the
> > luck of the stack.
> >
> > Let's fix this.
> >
> > Fixes: ab10023e0088 ("cpu_pm: Add cpu power management notifiers")
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> > This seems to be an ownerless file.  I'm hoping this patch can just go
> > through the Qualcomm tree.  It would be nice if we could get an Ack
> > from Rafael or Greg KH though.
> 
> Greg / Rafael: any thoughts on this patch?  Care to give it an Ack so
> it could go through the Qualcomm tree?
> 
> Andrew: I think you are the adopter or orphan patches, usually.  If
> nobody else will take this patch, will you consider taking it into
> your tree?  It should be a super straightforward bugfix.  I'm happy to
> re-post it CCing you if need be.
> 

Thanks for the patch and the reviews. I've picked all 5 patches through
my tree, with the added stable@ Cc on this one.

Regards,
Bjorn
