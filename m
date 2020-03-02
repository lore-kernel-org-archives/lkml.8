Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCB92468D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 06:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S3k4A2r7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCBGAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 01:00:35 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:33318 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBGAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 01:00:35 -0500
Received: by mail-ed1-f66.google.com with SMTP id c62so10346355edf.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 22:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b65o4uogATjrw8/GyC+v0wLM9MZOYS7Mnz1iwDvvMyw=;
        b=S3k4A2r7I9b3h6d7tXnS0nqsU5i5vnL8F1HIg955wg3T+MenThPx76f9zVkGKpOo/P
         2T3PM/56pZWDRDh6RhYVXY/kr3IcK6Vm15vJWGwtylfNrxvibnebMJ8DbqZKQ3gWy8rh
         qy1Zpmw0IIs8HL8gry9DbOU//PV8BjhGf2PGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b65o4uogATjrw8/GyC+v0wLM9MZOYS7Mnz1iwDvvMyw=;
        b=UfOsXDcePlx4IV8ebWb46ezgHgPK8Ewr+tXE7eEdZyLoxmvkwIHhhh9ObbOkaDyeXU
         uDpDbS5ugCoERM7JbgWYFRiyWlmPM4Uo7/mPH5oMStvgTDu/w8ai/eJ+dtQ/nfvLktaz
         DYqwMoHEriFlpuktPdBiXMDc73KPfF2ErF4H9PnBe4c0TvKJQcyNBgzmu5GL6hTPEkjp
         E7U8JLTlMirrFrtS4uxZPafVyQKRVdFrzqEK1rVYM7bQJL5vE8OsWAWyj9p9NR8CFWGM
         bBEZ5NJWd3KwQuMk0sWxiGDyNHyP0uW+4YJ8CCa+PmA4RN8RaOE/15KtDaLED7Uc7POo
         bTmg==
X-Gm-Message-State: APjAAAX2FwDQBAHq+TgpRVbsc4AzilqnUm6fLIu7uZi0gmQP607Klpey
        46PYIkuzip0Me/QceJRnJEPnIjctRFK/bXgDLDmzPQ==
X-Google-Smtp-Source: APXvYqzyYK9j0pVYN56K+luH6+BpIZCzBuLPWpS7r2qTYvVjXzklmvSJ6eTBiJfMXh2D47t6+2GwPxGVEnAD4va9lTU=
X-Received: by 2002:a05:6402:125a:: with SMTP id l26mr14716694edw.315.1583128832706;
 Sun, 01 Mar 2020 22:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20200214082638.92070-1-pihsun@chromium.org> <83b03af1-5518-599a-3f82-ee204992edbf@collabora.com>
 <CANdKZ0fuK1Nm_fPNKAss29pqghCcwjN3acYHi6Ez5==envgKgA@mail.gmail.com>
 <84a66ac1-c36a-fa72-a406-9c3396c1bdf2@collabora.com> <6c78727d-8a65-097d-224d-48d93f6ceaa7@collabora.com>
In-Reply-To: <6c78727d-8a65-097d-224d-48d93f6ceaa7@collabora.com>
From:   Pi-Hsun Shih <pihsun@chromium.org>
Date:   Mon, 2 Mar 2020 13:59:56 +0800
Message-ID: <CANdKZ0dkAcgWLEc6_k9gXWv53Cm-FV0bZdTiRjws8L6S9w-Tcw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Fix race with host event.
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resending since I forgot to use plain text mode in the previous mail,
and got blocked by mailing lists. Sorry for the duplicate email.)

Hi Enric,

On Fri, Feb 28, 2020 at 4:52 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Pi-Hsun,
>
> On 17/2/20 16:55, Enric Balletbo i Serra wrote:
> > Dear remoteproc experts,
> >
> > cc'ing you for if we can have your feedback on this change.
> >
> > Thanks Pi-Hsun, for your quick answer, makes sense but I'm still feeling that I
> > miss something (probably because I'm not a remoteproc expert), so I added the
> > Remoteproc people for if they can comment this patch. We have time as we're in
> > rc2 only, so I'd like to wait a bit in case they can take a look.
> >
> > If no answer is received I'll take a second look and apply the patch.
> >
>
> I'll pick this patch, just I want to request a minor change.
>
> > Thanks,
> >  Enric
> >
> > On 15/2/20 4:56, Pi-Hsun Shih wrote:
> >> Hi Enric,
> >>
> >> On Fri, Feb 14, 2020 at 11:10 PM Enric Balletbo i Serra
> >> <enric.balletbo@collabora.com> wrote:
> >>>
> >>> Hi Pi-Hsun,
> >>>
> >>> On 14/2/20 9:26, Pi-Hsun Shih wrote:
> >>>> Host event can be sent by remoteproc by any time, and
> >>>> cros_ec_rpmsg_callback would be called after cros_ec_rpmsg_create_ept.
> >>>> But the cros_ec_device is initialized after that, which cause host event
> >>>> handler to use cros_ec_device that are not initialized properly yet.
> >>>>
> >>>
> >>> I don't have the hardware to test but, can't we call first cros_ec_register and
> >>> then cros_ec_rpmsg_create_ept?
> >>>
> >>> Start receiving driver callbacks before finishing to probe the drivers itself
> >>> sounds weird to me.
> >>>
> >>> Thanks,
> >>>  Enric
> >>
> >> Since cros_ec_register calls cros_ec_query_all, which sends message to
> >> remoteproc using cros_ec_pkt_xfer_rpmsg (to query protocol version),
> >> the ec_rpmsg->ept need to be ready before calling cros_ec_register.
> >>
> >>>
> >>>> Fix this by don't schedule host event handler before cros_ec_register
> >>>> returns. Instead, remember that we have a pending host event, and
> >>>> schedule host event handler after cros_ec_register.
> >>>>
> >>>> Fixes: 71cddb7097e2 ("platform/chrome: cros_ec_rpmsg: Fix race with host command when probe failed.")
> >>>> Signed-off-by: Pi-Hsun Shih <pihsun@chromium.org>
> >>>> ---
> >>>>  drivers/platform/chrome/cros_ec_rpmsg.c | 16 +++++++++++++++-
> >>>>  1 file changed, 15 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> >>>> index dbc3f5523b83..7e8629e3db74 100644
> >>>> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> >>>> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> >>>> @@ -44,6 +44,8 @@ struct cros_ec_rpmsg {
> >>>>       struct completion xfer_ack;
> >>>>       struct work_struct host_event_work;
> >>>>       struct rpmsg_endpoint *ept;
> >>>> +     bool has_pending_host_event;
> >>>> +     bool probe_done;
>
>
> Could you try if just calling driver_probe_done() when needed works, so we don't
> need to add a new boolean flag for this?

Changing from "if (ec_rpmsg->probe_done)" to "if (driver_probe_done()
== 0)" works in my testing.

But since driver_probe_done() returns 0 after all driver probes are
done, not after the probe of cros_ec_rpmsg driver, I think it's
possible that we got a host event after the cros_ec_rpmsg driver probe
is done (ec_rpmsg->probe_done is true), but before all driver probe
done (driver_probe_done() is still -EBUSY). In this case the host
event would be lost since we would set the has_pending_host_event flag
but no one would be processing it.

>
> Thanks,
>  Enric
>
> >>>>  };
> >>>>
> >>>>  /**
> >>>> @@ -177,7 +179,14 @@ static int cros_ec_rpmsg_callback(struct rpmsg_device *rpdev, void *data,
> >>>>               memcpy(ec_dev->din, resp->data, len);
> >>>>               complete(&ec_rpmsg->xfer_ack);
> >>>>       } else if (resp->type == HOST_EVENT_MARK) {
> >>>> -             schedule_work(&ec_rpmsg->host_event_work);
> >>>> +             /*
> >>>> +              * If the host event is sent before cros_ec_register is
> >>>> +              * finished, queue the host event.
> >>>> +              */
> >>>> +             if (ec_rpmsg->probe_done)
> >>>> +                     schedule_work(&ec_rpmsg->host_event_work);
> >>>> +             else
> >>>> +                     ec_rpmsg->has_pending_host_event = true;
> >>>>       } else {
> >>>>               dev_warn(ec_dev->dev, "rpmsg received invalid type = %d",
> >>>>                        resp->type);
> >>>> @@ -240,6 +249,11 @@ static int cros_ec_rpmsg_probe(struct rpmsg_device *rpdev)
> >>>>               return ret;
> >>>>       }
> >>>>
> >>>> +     ec_rpmsg->probe_done = true;
> >>>> +
> >>>> +     if (ec_rpmsg->has_pending_host_event)
> >>>> +             schedule_work(&ec_rpmsg->host_event_work);
> >>>> +
> >>>>       return 0;
> >>>>  }
> >>>>
> >>>>
> >>>> base-commit: b19e8c68470385dd2c5440876591fddb02c8c402
> >>>>
