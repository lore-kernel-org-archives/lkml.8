Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45965C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C22C2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxKKEZdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYVmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:42:24 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41717 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:42:24 -0400
Received: by mail-io1-f67.google.com with SMTP id y24so3918491ioa.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=buU5ko9WYyQLxe4W65aArJ2mzLoua7+RSvDwL1OmNEg=;
        b=ZxKKEZdmuoacpoKH0XbpR+refRSDkns4jbDBtRk3JBWdJYvtlvzH6zeRmYxRLnwPbi
         T/4W8v5h5MF9MulUBGCkY2+MwNYQjo8TfX2xlOniViVAQb0jIWN+mAdHMumMG5HeUR7H
         zjNLM/E84YwbKbrbKsC9VXmfZbDz1PBdA+pJH83LVHFtMeDAfzI+/LahfbYioLaq2JEI
         7PS3spkJriaL0il5nrd72TkAuqckgC3/sFB5nIsMQiuO+ad0T8cYZPG/frekt36Rtnm4
         KiUUiigbVxzt/Ok/p0Vv1tttxwvpzs4lbm69D/UyZ+2o+1a14+oC3DEgDQrkasMx/SI2
         x7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=buU5ko9WYyQLxe4W65aArJ2mzLoua7+RSvDwL1OmNEg=;
        b=a0fiep8bFj0NfMqkgoNcl9AMNsHqoW1G9aJuOs84o1M9jnlvfS/ecRsgDCTjpEVIA5
         zX2coqYzYgc6BNo8Xyf149q4Pis4YG++LWQaKCi6TU7in8UrrOqMPYRZ52KV2fvi/lf+
         wdJqT/SxHjk01GiiY9gQgpdLHS84M5f2dlmkO/sRamgYZnyARWmxLXUIciy35q1fXA/c
         VINCEBCCsxOOtA+h9fb7VZ9COPGlbbGmYf4L+d6AhRRgiewwz46LUysWqSGnWKXGCiB/
         6w4RQnWsW5/SaqVuaDUdcXLW27Hve2UAfV0WzGIKzug1FuiFHpWRBePpm1DxIQBMH12l
         0XBA==
X-Gm-Message-State: ANhLgQ1S0OcPgKRqg0kPzKQS4l1RpIDYhICPBwoljiHIBXb45Y9wcOGu
        GF4LP9dwxUE2/gckR/dAVtofHz7HqA5zZnY59R+exw==
X-Google-Smtp-Source: ADFU+vt03WS4BPLmvug6jXuKwDLorGSYjYXta09fqhNCu8gA1XPd34yufhSVjMQhRmWDUWIsP5tpTpqujEWgIhFdPJM=
X-Received: by 2002:a02:8405:: with SMTP id k5mr5081184jah.52.1585172541443;
 Wed, 25 Mar 2020 14:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
 <1583924072-20648-2-git-send-email-loic.pallardy@st.com> <20200325175746.GA6227@xps15>
 <9a089cba07f7454ea0fc0f2d09bd9bf0@SFHDAG7NODE2.st.com>
In-Reply-To: <9a089cba07f7454ea0fc0f2d09bd9bf0@SFHDAG7NODE2.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 25 Mar 2020 15:42:10 -0600
Message-ID: <CANLsYkwMOD-AY5WXkUkNz_A1ZeQRdNC4WAV3PHLxXUq5Rg5Yvg@mail.gmail.com>
Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when rproc
 is crashed
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        "s-anna@ti.com" <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 at 12:30, Loic PALLARDY <loic.pallardy@st.com> wrote:
>
> Hi Mathieu,
>
> > -----Original Message-----
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Sent: mercredi 25 mars 2020 18:58
> > To: Loic PALLARDY <loic.pallardy@st.com>
> > Cc: bjorn.andersson@linaro.org; ohad@wizery.com; linux-
> > remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; Arnaud
> > POULIQUEN <arnaud.pouliquen@st.com>; benjamin.gaignard@linaro.org;
> > Fabien DESSENNE <fabien.dessenne@st.com>; s-anna@ti.com
> > Subject: Re: [RFC 1/2] remoteproc: sysfs: authorize rproc shutdown when
> > rproc is crashed
> >
> > Hi Loic,
> >
> > On Wed, Mar 11, 2020 at 11:54:31AM +0100, Loic Pallardy wrote:
> > > When remoteproc recovery is disabled and rproc crashed, user space
> > > client has no way to reboot co-processor except by a complete platform
> > > reboot.
> > > Indeed rproc_shutdown() is called by sysfs state_store() only is rproc
> > > state is RPROC_RUNNING.
> > >
> > > This patch offers the possibility to shutdown the co-processor if
> > > it is in RPROC_CRASHED state and so to restart properly co-processor
> > > from sysfs interface.
> >
> > If recovery is disabled on an rproc the platform likely intended to have a hard
> > reboot and as such we should not be concerned about this case.
> I disagree with your view. In fact, we can have a configuration for which
> we don't want a silent recovery. Application layer can be involved to stop and
> restart some services because it is the simplest way to resync with the coprocessor.
> What's missing today is an event to notify user space application that coprocessor state
> has changed. (even if we can rely on rpmsg services closure)

I have a better understanding of the scenario now.

>
> >
> > Where I think we have a problem, something that is asserted by looking at
> > your 2
> > patches, is cases where rproc_trigger_recovery() fails.  That leaves the
> > system
> > in a state where it can't be recovered, something the remoteproc core
> > should not
> > allow.
> >
> Right this is a second use case we faced when user space application which provided
> firmware file crashed before coprocessor. In that case firmware file may be removed
> from /lib/firmware directory and coprocessor recovery failed.
> Application, when restarting, can't anymore control coprocessor.

This is a very specific use case.  It seems to me that fixing the
problem with the availability of files under /lib/firmware is where
the solution really lies.

>
> Regards,
> Loic
>
> > >
> > > Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
> > > ---
> > >  drivers/remoteproc/remoteproc_core.c  | 2 +-
> > >  drivers/remoteproc/remoteproc_sysfs.c | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/remoteproc/remoteproc_core.c
> > b/drivers/remoteproc/remoteproc_core.c
> > > index 097f33e4f1f3..7ac87a75cd1b 100644
> > > --- a/drivers/remoteproc/remoteproc_core.c
> > > +++ b/drivers/remoteproc/remoteproc_core.c
> > > @@ -1812,7 +1812,7 @@ void rproc_shutdown(struct rproc *rproc)
> > >     if (!atomic_dec_and_test(&rproc->power))
> > >             goto out;
> > >
> > > -   ret = rproc_stop(rproc, false);
> > > +   ret = rproc_stop(rproc, rproc->state == RPROC_CRASHED);
> >
> > Please add a comment that explains how we can be in rproc_shutdown()
> > when the
> > processor has crashed and point to rproc_trigger_recovery().  See below for
> > more
> > details.
> >
> > >     if (ret) {
> > >             atomic_inc(&rproc->power);
> > >             goto out;
> > > diff --git a/drivers/remoteproc/remoteproc_sysfs.c
> > b/drivers/remoteproc/remoteproc_sysfs.c
> > > index 7f8536b73295..1029458a4678 100644
> > > --- a/drivers/remoteproc/remoteproc_sysfs.c
> > > +++ b/drivers/remoteproc/remoteproc_sysfs.c
> > > @@ -101,7 +101,7 @@ static ssize_t state_store(struct device *dev,
> > >             if (ret)
> > >                     dev_err(&rproc->dev, "Boot failed: %d\n", ret);
> > >     } else if (sysfs_streq(buf, "stop")) {
> > > -           if (rproc->state != RPROC_RUNNING)
> > > +           if (rproc->state != RPROC_RUNNING && rproc->state !=
> > RPROC_CRASHED)
> > >                     return -EINVAL;
> >
> > Wouldn't it be better to just prevent the MCU to stay in a crashed state
> > (when
> > recovery is not disabled)?
> >
> > I like what you did in the next patch where the state of the MCU is set to
> > RPROC_CRASHED in case of failure, so that we keep.  I also think the hunk
> > above is correct.  All that is left is to call rproc_shutdown() directly in
> > rproc_trigger_recovery() when something goes wrong.  I would also add a
> > dev_err() so that users have a clue of what happened.
> >
> > That would leave the system in a stable state without having to add
> > intelligence
> > to state_store().
> It is a solution we debate internally. Should rproc_shutdown() called directly in
> rproc_trigger_recovery() or not? If we go in such direction, that clearly simplify
> coprocessor control as it will always be in a "stable" state. But that means user
> will lost information that coprocessor crashed (mainly when recovery is disabled).
> We just know that coprocessor is stopped but not why? Crashed or client action?
> For debug purpose, it could be an issue from my pov.

That is why I suggested to add a dev_err() so that users know recovery
of the MCU has failed.  Moreover I expect users to be aware of what is
happening on their platform, i.e if application did not switch off the
MCU and it is in the offline state, then it is fair to assume it
crashed.

>
> Regards,
> Loic
> >
> > Let me know that you think...
> >
> > Mathieu
> >
> > >
> > >             rproc_shutdown(rproc);
> > > --
> > > 2.7.4
> > >
