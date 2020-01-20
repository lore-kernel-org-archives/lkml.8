Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 083C5C35241
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93F72087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQWfSSaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgATQ3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:29:02 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:38842 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729210AbgATQ3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:29:01 -0500
Received: by mail-il1-f195.google.com with SMTP id f5so27704043ilq.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WhDafEfpWxCZW7N1ekgfBlfxmyFi2MY1suCA9Nt8g4g=;
        b=dQWfSSaAoPOHR9zlU3AQWP+N+8XjUaOZog2voCI3BigUAoKt6IwPkXnmWjCUSujnhy
         YGa8UPh9uxPhxWMvLZ3AGlafundnFv9d0pBpbAXKur7asg77zkQoTyVzyHvT1YwOLj8r
         OvuMcYJi6YELFbOHDMdZLFdSUSTYqdB9PXiIG3gv0gfqOOyYYdqn4wq2ZrpKJD7X8ewt
         uDCa93APw5k6rwdRrf9k5nHIXKSm+sMr/L0Z/bE7xA6q60hUoKma2D472uwBBN8nRocE
         KwzaytgrF5c56O7X4gVj/3QzyQhnUiUHdV1Vp/+7mWwchTd/vYNQPyBJpy1Nicxge4Uo
         VLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WhDafEfpWxCZW7N1ekgfBlfxmyFi2MY1suCA9Nt8g4g=;
        b=O0OP1eAWIuTc3ZF3kwsenrmOd2z6SQtkupZVaKSAlL4udNA6RENy63JY4EkZvwA4w4
         MoYUY8QItenQrJPAbPKK0iPE9GTHrVXF8EdPjo285O5ASFQlOr230swrI48ZSb6h/vYd
         wC0BwDp5y9ajYHKT8d46Y68KC3rLiyy2ri7OBmGjjxhe+Q7NF6mlN/ukHMqOhX+WT2JK
         tevx6zTvBTHUGJxiPSlimpO9udqjvcktkkzWQnlK7WKjQpUtviXDFt8jEaKBEHXs8KFE
         2hLO72/fDWs+hRb0gKAbOSVADb/65vyqOeN7zuO6KslvTkhUWILa46To+MLOt2fWOn1K
         f4PA==
X-Gm-Message-State: APjAAAWK3aKwHzgHBRcWDDeaLNIzOAAoPQHekPIdXA7vqnhh/vwSR4oH
        QWoef30JLLIXuW2v2zDDRcoA+50VuwVLkiC6pZ4LsQ==
X-Google-Smtp-Source: APXvYqwGOlg/bZzzVUqCT7xHmwP5mV9QXmWru21WXXC0v+hMyrf3Myr2Ep5G40vm+zE7B1I2Tme02g61dWoubr/dvfo=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr11955936ili.72.1579537739870;
 Mon, 20 Jan 2020 08:28:59 -0800 (PST)
MIME-Version: 1.0
References: <20200115102142.11229-1-cleger@kalray.eu> <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
 <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
 <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com> <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
 <20200117225217.GA27535@xps15> <377421261.12898679.1579462834671.JavaMail.zimbra@kalray.eu>
In-Reply-To: <377421261.12898679.1579462834671.JavaMail.zimbra@kalray.eu>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 20 Jan 2020 09:28:49 -0700
Message-ID: <CANLsYky-dp3=J__x9d7BJtu1=ppEiFMfuJnRQ7ZTVn6X43BJ_g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
To:     =?UTF-8?Q?Cl=C3=A9ment_Leger?= <cleger@kalray.eu>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 at 12:40, Cl=C3=A9ment Leger <cleger@kalray.eu> wrote:
>
> Hi Mathieu,
>
> ----- On 17 Jan, 2020, at 23:52, Mathieu Poirier mathieu.poirier@linaro.o=
rg wrote:
>
> > Hey guys,
> >
> > On Wed, Jan 15, 2020 at 04:11:03PM +0100, Cl=C3=A9ment Leger wrote:
> >>
> >>
> >> ----- On 15 Jan, 2020, at 16:09, Arnaud Pouliquen arnaud.pouliquen@st.=
com wrote:
> >>
> >> > On 1/15/20 3:28 PM, Cl=C3=A9ment Leger wrote:
> >> >> Hi Arnaud,
> >> >>
> >> >> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@=
st.com wrote:
> >> >>
> >> >>> Hi Cl=C3=A9ment,
> >> >>>
> >> >>> On 1/15/20 11:21 AM, Clement Leger wrote:
> >> >>>> In order to support preallocated notify ids, if their value is
> >> >>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
> >> >>>> dynamically but try to allocate the requested one. This is useful=
 when
> >> >>>> using custom ids to bind them to custom vendor resources. For ins=
tance,
> >> >>>> it allow to assign a group of queues to a specific interrupti in =
order
> >> >>>> to dispatch notifications.
> >> >>>>
> >> >>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
> >> >>>> ---
> >> >>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++---=
-----
> >> >>>>  include/linux/remoteproc.h           |  1 +
> >> >>>>  2 files changed, 20 insertions(+), 8 deletions(-)
> >> >>>>
> >> >>>> diff --git a/drivers/remoteproc/remoteproc_core.c
> >> >>>> b/drivers/remoteproc/remoteproc_core.c
> >> >>>> index 307df98347ba..b1485fcd0f11 100644
> >> >>>> --- a/drivers/remoteproc/remoteproc_core.c
> >> >>>> +++ b/drivers/remoteproc/remoteproc_core.c
> >> >>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rv=
dev, int i)
> >> >>>>         /*
> >> >>>>          * Assign an rproc-wide unique index for this vring
> >> >>>>          * TODO: assign a notifyid for rvdev updates as well
> >> >>>> -        * TODO: support predefined notifyids (via resource table=
)
> >> >>>>          */
> >> >>>> -       ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KE=
RNEL);
> >> >>>> -       if (ret < 0) {
> >> >>>> -               dev_err(dev, "idr_alloc failed: %d\n", ret);
> >> >>>> -               return ret;
> >> >>>> +       if (rsc->vring[i].notifyid =3D=3D FW_RSC_NOTIFY_ID_ANY) {
> >> >>>> +               ret =3D idr_alloc(&rproc->notifyids, rvring, 0, 0=
, GFP_KERNEL);
> >> >>>> +               if (ret < 0) {
> >> >>>> +                       dev_err(dev, "idr_alloc failed: %d\n", re=
t);
> >> >>>> +                       return ret;
> >> >>>> +               }
> >> >>>> +               notifyid =3D ret;
> >> >>>> +
> >> >>>> +               /* Let the rproc know the notifyid of this vring.=
*/
> >> >>>> +               rsc->vring[i].notifyid =3D notifyid;
> >> >>>> +       } else {
> >> >>>> +               /* Reserve requested notify_id */
> >> >>>> +               notifyid =3D rsc->vring[i].notifyid;
> >> >>>> +               ret =3D idr_alloc(&rproc->notifyids, rvring, noti=
fyid,
> >> >>>> +                               notifyid + 1, GFP_KERNEL);
> >> >>>> +               if (ret < 0) {
> >> >>>> +                       dev_err(dev, "idr_alloc failed: %d\n", re=
t);
> >> >>>> +                       return ret;
> >> >>>> +               }
> >> >>>>         }
> >> >>>> -       notifyid =3D ret;
> >> >>>>
> >> >>>>         /* Potentially bump max_notifyid */
> >> >>>>         if (notifyid > rproc->max_notifyid)
> >> >>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvde=
v, int i)
> >> >>>>
> >> >>>>         rvring->notifyid =3D notifyid;
> >> >>>>
> >> >>>> -       /* Let the rproc know the notifyid of this vring.*/
> >> >>>> -       rsc->vring[i].notifyid =3D notifyid;
> >> >>>>         return 0;
> >> >>>>  }
> >> >>> The rproc_free_vring function resets the notifyid to -1 on free.
> >> >>> This could generate a side effect if the resource table is not rel=
oaded.
> >> >>
> >> >> Oh indeed, I did not thought of that. What would you recommend ?
> >> >> If using -1 in free vring, notify ids will be reallocated at next
> >> >> round.
> >> > Regarding the code i'm not sure that it is useful to reset the notif=
yID to -1 on
> >> > free.
> >
> > I'm not sure setting notifyid to -1 in rproc_free_vring() is such a big=
 problem.
> > No matter the code path I look at, if rproc_free_vring() is called some=
thing
> > serious has happened and the resource table will be reloaded if another=
 attempt
> > at booting the remote processor is done.  It can also be that a gracefu=
l
> > shutdown is underway, in which case the resource table will be reloaded=
 anyway
> > if/when the slave is brought back in service.
> >
> > Let me know if I'm missing a scenario.
>
> No, you are actually right
>
> >
> > To me the real problem is if a FW image has set the notifyids in the re=
source
> > table to 0xffffffff, thinking they will be overwritten.  In that case t=
hings
> > will really south.
>
> Hum, if set to 0xFFFFFFFF, then they will be assigned dynamically and upd=
ated
> in the resource table (with this patch). But your probably mean existing =
code,
> right ?

My apologies for not expressing myself clearly here - let me try again.

At this time notifyids in the firmware's resource table can be set to
anything because the code will overwrite them.  With this patch
firmware images that don't have their notifyids set to -1 will see a
change in how ids are assigned, something that has the potential to
break user space.

Regards,
Mathieu

>
> >
> >> > In current version, on alloc, the notifyID is overwriten without che=
ck.
> >> > And as vdev status is updated, vring struct in resource table should=
 be
> >> > considered as invalid
> >> > Except if i missed a usecase/race condition...
> >> >
> >> >>
> >> >> I was also worried that it would break some existing user applicati=
ons
> >> >> which uses "0" as a notify id in vring but expect the id to be
> >> >> allocated dynamically. With my modification, it means it will try t=
o
> >> >> use "0" as a predefined id, leading to allocation failure.
> >
> > From my point of view they will have been lucky for all this time.  Eve=
n with
> > a new version of the resource table (which I think is the right way go)
> > cases like this will break.
>
> Agreed, and actually, I may have missread some code. I can't find were I =
read
> that. By the way, is there any documentation which state the allowed valu=
es of
> notify ids ?
>
> >
> > Thanks,
> > Mathieu
> >
> >> >>
> >> > Yes this could introduce regression for firmware that sets 0 as defa=
ult value.
> >> > Probably better to introduce this patch with a new version of the re=
source table
> >> > :)
> >>
> >> Understood ;)
> >>
> >> Regards,
> >>
> >> Cl=C3=A9ment
> >>
> >> >
> >> > Regards
> >> > Arnaud
> >> >>>
> >> >>>>
> >> >>>> diff --git a/include/linux/remoteproc.h b/include/linux/remotepro=
c.h
> >> >>>> index 16ad66683ad0..dcae3394243e 100644
> >> >>>> --- a/include/linux/remoteproc.h
> >> >>>> +++ b/include/linux/remoteproc.h
> >> >>>> @@ -123,6 +123,7 @@ enum fw_resource_type {
> >> >>>>  };
> >> >>>>
> >> >>>>  #define FW_RSC_ADDR_ANY (-1)
> >> >>>> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in
> >> >>>> rproc_free_vring
> >> >>
> >> >> Indeed.
> >> >>
> >> >> Thanks for your review.
> >> >>
> >> >> Regards,
> >> >>
> >> >> Cl=C3=A9ment
> >> >>
> >> >>>
> >> >>> Regards,
> >> >>> Arnaud
> >> >>>>
> >> >>>>  /**
> > > > >>>   * struct fw_rsc_carveout - physically contiguous memory reque=
st
