Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056E1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAC8C2082F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 16:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxcnFhtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgDHQAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 12:00:11 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:40815 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgDHQAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 12:00:10 -0400
Received: by mail-io1-f66.google.com with SMTP id w1so587411iot.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBgudGsrLZ+TDScEKcorJpGh0gEkG8ZAnpRrRFDsG38=;
        b=rxcnFhtxDIt8Py8z0ni7LEk9HIXreuu8sDgwnsMq0QQpb9Eyctal58xsa1R2NR6Ybp
         PXkQPtnFlJpuoGhXmcbBpy8GGwUXBoerGdQvMFLvHZQ2PVF2CICMN5QbxSyF1k57y1CF
         FXXIqCeuVmkzFhJOU+OHSFjZgjH+9UVYGBRse870CyNHNeMExFE2eeOyyz0161m85uyi
         ARsNc9aTOTiy68zr282xOEY5qRYjzxLGPf/ievoqEd7kr9aqD3m18bYE7E1oN4a4JYi4
         5+JNZB1g8ka0CujXw6zDn7BRo5Efh/TFLDz+kjqyq1a9JvVQx4d4gR8bTkVKqmuxC5DK
         ir4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBgudGsrLZ+TDScEKcorJpGh0gEkG8ZAnpRrRFDsG38=;
        b=bQwJf3cNrdc7pAwkKw0w/FAykj77NOoCwQVIhFZMVZCSF4mAc6JpzHGs7h/48TqawY
         o5UkokQxqV+KvpsHhUhDuo1mu4/9i2D2DxrqV4PYToerbvpJ2PA7G+ZVs2a0fTZ5bSXD
         hvlibz/0N1BC8QWUYB386csgKIEtWBVF7wpK5f/k2HJXa81p9O8QFRXd2zOQ6kkfY7G4
         fUEPxqaOUGvCxd3GwuRKW8lSez3BWUek2e58wBKUY0fcKX+BrobtSc/oNVHdtnKMyhow
         DcFfqIONy3uQKuF9QPs4QtJZQH0U9Q0oYaKUnGtEU//EZntAFfNasQlQ6+danVRTn734
         3srA==
X-Gm-Message-State: AGi0PuY+km1ifKWlJvsc1zsH4Fvrn021v1FVZ7DF/8HP45UvkP1s6ibY
        uRMJDow7AMx73nWQeSPmamMCBR60riC3ElATd88FKQ==
X-Google-Smtp-Source: APiQypLxgVDOFKmALnYEXFlwsYIboWx3KPvL9/CwCdQ/v/NGeUfm3pUVWeG9CxNiC/aD2avNcl6gqUSSpj130cXuLAI=
X-Received: by 2002:a05:6638:186:: with SMTP id a6mr7273559jaq.36.1586361608649;
 Wed, 08 Apr 2020 09:00:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200310155058.1607-1-mathieu.poirier@linaro.org>
 <591bd727-32af-9ea2-8c46-98f46ee3711e@ti.com> <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
 <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com> <CANLsYkz8iqiperjdQVcwAC3YGT5cmEvJcu8fPFGF5-X6eKVUDQ@mail.gmail.com>
 <34d1277f-c35e-5df8-7d0c-ea1e961a127f@st.com> <20200327193602.GA22939@xps15> <77cba22f-5911-e88a-ec25-50cbe9b8fbbe@ti.com>
In-Reply-To: <77cba22f-5911-e88a-ec25-50cbe9b8fbbe@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 8 Apr 2020 09:59:57 -0600
Message-ID: <CANLsYkxWSQNA0SqP5p1d_EK6am5rV-ONrvou1UyuNMnMjGW71Q@mail.gmail.com>
Subject: Re: [PATCH v2] rpmsg: core: Add wildcard match for name service
To:     Suman Anna <s-anna@ti.com>
Cc:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Apr 2020 at 17:07, Suman Anna <s-anna@ti.com> wrote:
>
> Hi Mathieu, Arnaud,
>
> On 3/27/20 2:36 PM, Mathieu Poirier wrote:
> > On Fri, Mar 27, 2020 at 10:35:34AM +0100, Arnaud POULIQUEN wrote:
> >> Hi
> >>
> >> On 3/26/20 11:01 PM, Mathieu Poirier wrote:
> >>> On Thu, 26 Mar 2020 at 14:42, Suman Anna <s-anna@ti.com> wrote:
> >>>>
> >>>> On 3/26/20 3:21 PM, Mathieu Poirier wrote:
> >>>>> On Thu, 26 Mar 2020 at 09:06, Suman Anna <s-anna@ti.com> wrote:
> >>>>>>
> >>>>>> Hi Mathieu,
> >>>>>>
> >>>>>> On 3/10/20 10:50 AM, Mathieu Poirier wrote:
> >>>>>>> Adding the capability to supplement the base definition published
> >>>>>>> by an rpmsg_driver with a postfix description so that it is possible
> >>>>>>> for several entity to use the same service.
> >>>>>>>
> >>>>>>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>>>>>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >>>>>>
> >>>>>> So, the concern I have here is that we are retrofitting this into the
> >>>>>> existing 32-byte name field, and the question is if it is going to be
> >>>>>> enough in general. That's the reason I went with the additional 32-byte
> >>>>>> field with the "rpmsg: add a description field" patch.
> >>>>>>
> >>>>>
> >>>>> That's a valid concern.
> >>>>>
> >>>>> Did you consider increasing the size of RPMSG_NAME_SIZE to 64? Have
> >>>>> you found cases where that wouldn't work?  I did a survey of all the
> >>>>> places the #define is used and all destination buffers are also using
> >>>>> the same #define in their definition.  It would also be backward
> >>>>> compatible with firmware implementations that use 32 byte.
> >>>>
> >>>> You can't directly bump the size without breaking the compatibility on
> >>>> the existing rpmsg_ns_msg in firmwares right? All the Linux-side drivers
> >>>> will be ok since they use the same macro but rpmsg_ns_msg has presence
> >>>> on both kernel and firmware-sides.
> >>>
> >>> Ah yes yes... The amount of bytes coming out of the pipe won't match.
> >>> Let me think a little...
> >>
> >> +1 for Suman's concern.
> >>
> >> Anyway i would like to challenge the need of more than 32 bytes to
> >> differentiate service instances.
> >> "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA", seems to me enough if we only need
> >> to differentiate the instances.
>
> Remember that the rpmsg_device_id name takes some space within here. So,
> the shorter the rpmsg_device_id table name, the more room you have.
>
> >>
> >> But perhaps the need is also to provide a short description of the service?
>
> I am mostly using it to provide a unique instantiation name. In anycase,
> I have cross-checked against my current firmwares, and so far all of
> them happen to have the name + desc < 31 bytes.
>
>
> >>
> >> Suman, could you share some examples of your need?
> >
> > Looking at things further it is possible to extend the name of the service to
> > 64 byte while keeping backward compatibility by looking up the size of @len
> > in function rpmsg_ns_cb().  From there work with an rpmsg_ns_msg or a new
> > rpmsg_ns_msg64, pretty much the way you did in your patch[1].  In fact the
> > approach is the same except you are using 2 arrays of 32 byte and I'm using one
> > of 64.
> >
> > As Arnaud mentioned, is there an immediate need to support a 64-byte name?  If
> > not than I suggest to move forward with this patch and address the issue when we
> > get there - at least we know there is room for extention. Otherwise I'll spin
> > off another revision but it will be bigger and more complex.
>
> Yeah ok. I have managed to get my downstream drivers that use the desc
> field working with this patch after modifying the firmwares to publish
> using combined name, and adding logic in probe to get the trailing
> portion of the name.

Perfect

>
> So, the only thing that is missing or content for another patch is if we
> need to add some tooling/helper stuff for giving the trailing stuff to
> rpmsg drivers?

So that all rpmsg drivers don't come up with their own parsing that
ends up doing the same thing.  Let me think about that - I may have to
get back to you...

>
> regards
> Suman
>
> >
> > Thanks,
> > Mathieu
> >
> > [1]. https://patchwork.kernel.org/patch/11096599/
> >
> >>>>>>
> >>>>>>> ---
> >>>>>>> Changes for V2:
> >>>>>>> - Added Arnaud's Acked-by.
> >>>>>>> - Rebased to latest rproc-next.
> >>>>>>>
> >>>>>>>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
> >>>>>>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> >>>>>>> index e330ec4dfc33..bfd25978fa35 100644
> >>>>>>> --- a/drivers/rpmsg/rpmsg_core.c
> >>>>>>> +++ b/drivers/rpmsg/rpmsg_core.c
> >>>>>>> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
> >>>>>>>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
> >>>>>>>                                 const struct rpmsg_device_id *id)
> >>>>>>>  {
> >>>>>>> -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
> >>>>>>> +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
> >>>>>>> +
> >>>>>>> +     /*
> >>>>>>> +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
> >>>>>>> +      * is:
> >>>>>>> +      *
> >>>>>>> +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> >>>>>>> +      *      { .name = "rpmsg-client-sample" },
> >>>>>>> +      *      { },
> >>>>>>> +      * }
> >>>>>>> +      *
> >>>>>>> +      * Then it is possible to support "rpmsg-client-sample*", i.e:
> >>>>>>> +      *      rpmsg-client-sample
> >>>>>>> +      *      rpmsg-client-sample_instance0
> >>>>>>> +      *      rpmsg-client-sample_instance1
> >>>>>>> +      *      ...
> >>>>>>> +      *      rpmsg-client-sample_instanceX
> >>>>>>> +      */
> >>>>>>> +     return strncmp(id->name, rpdev->id.name, len) == 0;
> >>>>>>>  }
> >>>>>>>
> >>>>>>>  /* match rpmsg channel and rpmsg driver */
> >>>>>>>
> >>>>>>
> >>>>
>
