Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4443EC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F06B22525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 19:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w7NkbXTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATTK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 14:10:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37248 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgATTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 14:10:55 -0500
Received: by mail-pj1-f65.google.com with SMTP id m13so196915pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 11:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rXtzpxRBIE54NbCvNgdaKsPlCWBPoiNnJLPrJ2Xtl5w=;
        b=w7NkbXTdYBjDcf7yBd6WBO3d6v8S1fSy+5cYHvqfrcYXtYwCT34+z88oysaHaUlmZP
         LWkIgy9UGkm87o5PBEeb+vzN9b2gm1MLm+hKmXvugptbqcp6boKa5yC4EPZ+cESZOP/l
         yqfa4ewjlcWUYKXyKBAJUFqcFtVEpM+4GRJ1JUqlTF89aNqjGIjlApOuGXyCeyATmCtt
         HQw+tmAETpJUta0vfkqOF1oeqdEmWDlBQoNbZAOLjlMOb8MX7hpWICOg9sDNf7rr0twd
         VmHfF0QcxORxk20SUjJ9LQTOw7uQVm53bMX4agFqe0uQ0QrDXgTMCQPpogxuJt/svx87
         3n6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rXtzpxRBIE54NbCvNgdaKsPlCWBPoiNnJLPrJ2Xtl5w=;
        b=DUov3E6clkNe9PWaBEDG4lgo8f6bjc1fkHLJ9fEpBNRosOgLTvoW6adAWWSEs1q1L4
         1tuniqntSvHZQT8wl0o7xvLqZgks1/zLWMs/n4eh27fiHs75BlsCmS9z+3Wlsh9xMe1E
         uVPgnLpamFp+mQZgPlWZOingOtbzEE+MWp5AAfzUkOUtsupCoao11M6V2I+d/srjdycb
         6XIU3s8q8WXXJ00Jzs8YelAIh5myiHdufCP7Vn5ImY7f4dwYGmKJBt+as6oNbq6qhzeI
         gRzhyIcBuu4wLtV/cYLSGa7xbyZl2v4Bd9hVv92Dx1+M6xVu+amf/ggdo3x46cflglKN
         vocQ==
X-Gm-Message-State: APjAAAXnPrcxes2EGiFxW4uR1uW9kP6PIVhu29aKMBh0AxlF/j2YJiA/
        ISMjZrtnRwshM/aa/jD9wzuv7w==
X-Google-Smtp-Source: APXvYqzQaP2gKO6EjHWzGpIEGeHTIlbgpKefn/FSwJBuYvq/6nSexiHXscfYNT96GGWIYNjisjzAzQ==
X-Received: by 2002:a17:90a:ac0e:: with SMTP id o14mr529997pjq.11.1579547454760;
        Mon, 20 Jan 2020 11:10:54 -0800 (PST)
Received: from yoga (wsip-184-181-24-67.sd.sd.cox.net. [184.181.24.67])
        by smtp.gmail.com with ESMTPSA id b24sm39900195pfo.55.2020.01.20.11.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 11:10:54 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:10:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Cl?ment Leger <cleger@kalray.eu>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
Message-ID: <20200120191047.GI1511@yoga>
References: <20200115102142.11229-1-cleger@kalray.eu>
 <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
 <79048597.12371594.1579098506802.JavaMail.zimbra@kalray.eu>
 <a1116656-cf2e-c1a1-7cc3-0fe2a79f076e@st.com>
 <612100872.12377996.1579101063237.JavaMail.zimbra@kalray.eu>
 <20200117225217.GA27535@xps15>
 <377421261.12898679.1579462834671.JavaMail.zimbra@kalray.eu>
 <CANLsYky-dp3=J__x9d7BJtu1=ppEiFMfuJnRQ7ZTVn6X43BJ_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANLsYky-dp3=J__x9d7BJtu1=ppEiFMfuJnRQ7ZTVn6X43BJ_g@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20 Jan 08:28 PST 2020, Mathieu Poirier wrote:

> On Sun, 19 Jan 2020 at 12:40, Clément Leger <cleger@kalray.eu> wrote:
> >
> > Hi Mathieu,
> >
> > ----- On 17 Jan, 2020, at 23:52, Mathieu Poirier mathieu.poirier@linaro.org wrote:
> >
> > > Hey guys,
> > >
> > > On Wed, Jan 15, 2020 at 04:11:03PM +0100, Clément Leger wrote:
> > >>
> > >>
> > >> ----- On 15 Jan, 2020, at 16:09, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
> > >>
> > >> > On 1/15/20 3:28 PM, Clément Leger wrote:
> > >> >> Hi Arnaud,
> > >> >>
> > >> >> ----- On 15 Jan, 2020, at 15:06, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
> > >> >>
> > >> >>> Hi Clément,
> > >> >>>
> > >> >>> On 1/15/20 11:21 AM, Clement Leger wrote:
> > >> >>>> In order to support preallocated notify ids, if their value is
> > >> >>>> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
> > >> >>>> dynamically but try to allocate the requested one. This is useful when
> > >> >>>> using custom ids to bind them to custom vendor resources. For instance,
> > >> >>>> it allow to assign a group of queues to a specific interrupti in order
> > >> >>>> to dispatch notifications.
> > >> >>>>
> > >> >>>> Signed-off-by: Clement Leger <cleger@kalray.eu>
> > >> >>>> ---
> > >> >>>>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
> > >> >>>>  include/linux/remoteproc.h           |  1 +
> > >> >>>>  2 files changed, 20 insertions(+), 8 deletions(-)
> > >> >>>>
> > >> >>>> diff --git a/drivers/remoteproc/remoteproc_core.c
> > >> >>>> b/drivers/remoteproc/remoteproc_core.c
> > >> >>>> index 307df98347ba..b1485fcd0f11 100644
> > >> >>>> --- a/drivers/remoteproc/remoteproc_core.c
> > >> >>>> +++ b/drivers/remoteproc/remoteproc_core.c
> > >> >>>> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> > >> >>>>         /*
> > >> >>>>          * Assign an rproc-wide unique index for this vring
> > >> >>>>          * TODO: assign a notifyid for rvdev updates as well
> > >> >>>> -        * TODO: support predefined notifyids (via resource table)
> > >> >>>>          */
> > >> >>>> -       ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> > >> >>>> -       if (ret < 0) {
> > >> >>>> -               dev_err(dev, "idr_alloc failed: %d\n", ret);
> > >> >>>> -               return ret;
> > >> >>>> +       if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
> > >> >>>> +               ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> > >> >>>> +               if (ret < 0) {
> > >> >>>> +                       dev_err(dev, "idr_alloc failed: %d\n", ret);
> > >> >>>> +                       return ret;
> > >> >>>> +               }
> > >> >>>> +               notifyid = ret;
> > >> >>>> +
> > >> >>>> +               /* Let the rproc know the notifyid of this vring.*/
> > >> >>>> +               rsc->vring[i].notifyid = notifyid;
> > >> >>>> +       } else {
> > >> >>>> +               /* Reserve requested notify_id */
> > >> >>>> +               notifyid = rsc->vring[i].notifyid;
> > >> >>>> +               ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
> > >> >>>> +                               notifyid + 1, GFP_KERNEL);
> > >> >>>> +               if (ret < 0) {
> > >> >>>> +                       dev_err(dev, "idr_alloc failed: %d\n", ret);
> > >> >>>> +                       return ret;
> > >> >>>> +               }
> > >> >>>>         }
> > >> >>>> -       notifyid = ret;
> > >> >>>>
> > >> >>>>         /* Potentially bump max_notifyid */
> > >> >>>>         if (notifyid > rproc->max_notifyid)
> > >> >>>> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
> > >> >>>>
> > >> >>>>         rvring->notifyid = notifyid;
> > >> >>>>
> > >> >>>> -       /* Let the rproc know the notifyid of this vring.*/
> > >> >>>> -       rsc->vring[i].notifyid = notifyid;
> > >> >>>>         return 0;
> > >> >>>>  }
> > >> >>> The rproc_free_vring function resets the notifyid to -1 on free.
> > >> >>> This could generate a side effect if the resource table is not reloaded.
> > >> >>
> > >> >> Oh indeed, I did not thought of that. What would you recommend ?
> > >> >> If using -1 in free vring, notify ids will be reallocated at next
> > >> >> round.
> > >> > Regarding the code i'm not sure that it is useful to reset the notifyID to -1 on
> > >> > free.
> > >
> > > I'm not sure setting notifyid to -1 in rproc_free_vring() is such a big problem.
> > > No matter the code path I look at, if rproc_free_vring() is called something
> > > serious has happened and the resource table will be reloaded if another attempt
> > > at booting the remote processor is done.  It can also be that a graceful
> > > shutdown is underway, in which case the resource table will be reloaded anyway
> > > if/when the slave is brought back in service.
> > >
> > > Let me know if I'm missing a scenario.
> >
> > No, you are actually right
> >
> > >
> > > To me the real problem is if a FW image has set the notifyids in the resource
> > > table to 0xffffffff, thinking they will be overwritten.  In that case things
> > > will really south.
> >
> > Hum, if set to 0xFFFFFFFF, then they will be assigned dynamically and updated
> > in the resource table (with this patch). But your probably mean existing code,
> > right ?
> 
> My apologies for not expressing myself clearly here - let me try again.
> 
> At this time notifyids in the firmware's resource table can be set to
> anything because the code will overwrite them.  With this patch
> firmware images that don't have their notifyids set to -1 will see a
> change in how ids are assigned, something that has the potential to
> break user space.
> 

Right, we should have had a check in place to ensure that we only
accepted -1 here, as that's what the code relies upon.

If a conclusion on the new resource table format is imminent it sounds
reasonable to document the behaviour for the current version and make it
behave as as expected in the new one.

Regards,
Bjorn
