Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795512072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqtEbpKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389030AbgFXFaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389021AbgFXFap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:30:45 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA92AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 22:30:44 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k6so561227pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AblS5WrjyJMgnznkFBkF2GKSBo5MmuL1G6F8BwHXeHU=;
        b=oqtEbpKemfXPO2FVCAZvOcjGa868wColw/w7N0/yn1PF29yObXn8tzs3OSrkgXiLpi
         LcPeGnm4YkEzRAFbHhKXwuU3ULzEVIicC/I+gMx0QzQ6amybRVLjmTgycXMnj1rFx3o7
         LQ/DPmnuFeIwg4eTFAsMbrfmc7Oj3NjYk0K5qMkebCw838Eaz8Ba5GkENK87fJTZmm8x
         Y456j7fT9fg1TOA8hbMMBjcxXrjWa0C+n93sWs5LI9rk7UceWECyEGWoqDoWtADzHVjV
         r0IpBYbuuoUKn76+TBnwvw5OxXNXelrJaddFFC8T342w/At3WuVGLzu9tOgPX+zBXbr0
         2a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AblS5WrjyJMgnznkFBkF2GKSBo5MmuL1G6F8BwHXeHU=;
        b=fgdpPreZcwcXPXS+1WO55F5PGBoX3AwThkGMKYYWVNTdzK1KrwZOkoe8DwVdEE6/mr
         K8zqzMxMgA++KnoXN/N2C+l/ZDMMt8CChwjSceAWugJWg33spsq5fBLyx6xZy53XfXvZ
         I2rpJumLiKi6KoXDPCMERNrocElQIp3WI1BFufIQT6L2lzg+h8H0lcQsVTFNO6kOHTJ8
         xHTOdCmj4hAY8RAq2hBMMLBzZKG8atnlt57CxG7aDJKMXRl1kYsaNwBj7cgLPD9JpRo/
         E9N+sxNRY7WJM6n2xmhe99QL5jIjAPq87cRAJjXIKbD7mvPBCEN0sDAFTmjYt9CPXy1A
         u/pQ==
X-Gm-Message-State: AOAM532DM0ChnPoEM2DHEKHvet2glqUH6qOOY3OkOnUeUwJhyRHRP7el
        jl3AD8jTNiTZBa9ZbQNg3zdjgg==
X-Google-Smtp-Source: ABdhPJwUa5UccNgom3SX6tJgM3PGNd4oZV4WMtpb21CaWdbbeGvZlwQm1FwLDDx0gewj6Zuz8U+RzQ==
X-Received: by 2002:a17:90b:23c8:: with SMTP id md8mr28079444pjb.72.1592976644282;
        Tue, 23 Jun 2020 22:30:44 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d25sm15203124pgn.2.2020.06.23.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 22:30:43 -0700 (PDT)
Date:   Tue, 23 Jun 2020 22:28:01 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     rishabhb@codeaurora.org
Cc:     Alex Elder <elder@ieee.org>, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org,
        linux-remoteproc-owner@vger.kernel.org
Subject: Re: [PATCH v5 1/2] remoteproc: qcom: Add per subsystem SSR
 notification
Message-ID: <20200624052801.GB407764@builder.lan>
References: <1592874271-26697-1-git-send-email-rishabhb@codeaurora.org>
 <1592874271-26697-2-git-send-email-rishabhb@codeaurora.org>
 <8ed72321-6f6a-1083-9af9-a80aa945edeb@ieee.org>
 <cb31dfb50079a1377cf27807a7b2eb3e@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb31dfb50079a1377cf27807a7b2eb3e@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 18:41 PDT 2020, rishabhb@codeaurora.org wrote:

> On 2020-06-23 14:45, Alex Elder wrote:
> > On 6/22/20 8:04 PM, Rishabh Bhatnagar wrote:
> > > Currently there is a single notification chain which is called
> > > whenever any
> > > remoteproc shuts down. This leads to all the listeners being
> > > notified, and
> > > is not an optimal design as kernel drivers might only be interested in
> > > listening to notifications from a particular remoteproc. Create a
> > > global
> > > list of remoteproc notification info data structures. This will hold
> > > the
> > > name and notifier_list information for a particular remoteproc. The
> > > API
> > > to register for notifications will use name argument to retrieve the
> > > notification info data structure and the notifier block will be
> > > added to
> > > that data structure's notification chain. Also move from blocking
> > > notifier
> > > to srcu notifer based implementation to support dynamic notifier head
> > > creation.
> > > 
> > > Signed-off-by: Siddharth Gupta <sidgup@codeaurora.org>
> > > Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> > 
> > Sorry, a few more comments, but I think your next one will
> > likely be fine.
> > 
> > General:
> > - SSR subsystems are added but never removed.  Note that
> >   "qcom_common.o" can be built as a module, and if that
> >   module were ever removed, memory allocated for these
> >   subsystems would be leaked.
> Hi Alex,
> Thank you for reviewing this patchset quickly. This point was
> brought up by Bjorn and it was decided that I will push another patch on
> top in which I'll do the cleanup during module exit.
> > - Will a remoteproc subdev (and in particular, an SSR subdev)
> >   ever be removed?  What happens to entities that have
> >   registered for SSR notifications in that case?
> In practice it should never be removed. If it is clients will
> never get notification about subsystem shutdown/powerup.

Given that clients make direct function calls into qcom_common.ko,
qcom_common.ko would not be possible to rmmod until all clients has been
rmmod'ed. As such there shouldn't be any remaining listeners, or
subdevices, when this happens.

Regards,
Bjorn
