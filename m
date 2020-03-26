Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A43C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9482320714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 22:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4u3kjGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCZWBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 18:01:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46989 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZWBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 18:01:40 -0400
Received: by mail-io1-f67.google.com with SMTP id a20so7732274ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 15:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ISbVB5srUWw1bhkhok8TYQ7qrAB84hjy8Fy+SBhK3C0=;
        b=s4u3kjGDBYAuAM6qUFtp8G8ss4WatVKqCcMt78E48lxMcOWE1yTAFWY0+ycb35xkIe
         HuoICAH47f/u44LDqTVZvOcHvFeSbKb97y8hSU8SFoKTt7DbRNMMgvJXp2nsmdK3LQiT
         XwT2hEWUA3W0Ucwv0hgkRLLBokW4pP5E+ymMomjioTA47ht1My3G6iJzrpbVVt0zA9lT
         yrP/bMNmRGXMMeZI78A3iiNVA6p2sAXLS5GraXToA9uFXiz4PrSaOofyuO/lrJdLpCLM
         Ndy1uUiphFCAInoqVPuH8e7qwN3L+Hz/VyluPRlWYtdmAjQCVCnccZkMliTIJU0bYfgn
         isHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ISbVB5srUWw1bhkhok8TYQ7qrAB84hjy8Fy+SBhK3C0=;
        b=j2OVz28lESINi4VBUoJ/e8iezNHcHIFVmOtOmGp/0OjVS8E8enYsOxU1t1uPxTeWo9
         eO8BRzIU10dW5QWCw9dghNKP2PM92YZYyyM+30x7Qt4JK8mtCs07f/SqrJYOwa5CrdnF
         dM+UQUAyXtjv1GAmFhPhmH7E0gnsYtK+8vvk+ceWdt/HeIdEvjNTeyRap6yD4tyGbtts
         bQAI6RzZ+lPVwJhDiK/5PYB0jFBUNAg2BTSQcrbvW9Ss/G6dfYTV3XHw7FBAjmcGvUSq
         qB256EmN7z/mQzeS95u1JiybpiPo2SZEA/nVO+aaRaSvI+wIWoZ93Jvf2VLU9baZTGMF
         rJgQ==
X-Gm-Message-State: ANhLgQ0dv0vkNbYFqdzdtmbg26IkkdTNt9XlBDZ3BDIi/q8e+eDZxvTH
        rxwo1+hljS6P8JPuKWlodRcrFiTrOIsDiV5u07A0P8Nv
X-Google-Smtp-Source: ADFU+vtp/KiZJmHHrxJjU1Oy7p7j+zRULpjHZhROUkj3dew7B2ihJiCj3WL21rq0EJvTwMoHjpfXe7lBBAhHtBCSUNQ=
X-Received: by 2002:a05:6602:2ace:: with SMTP id m14mr10049943iov.131.1585260099096;
 Thu, 26 Mar 2020 15:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200310155058.1607-1-mathieu.poirier@linaro.org>
 <591bd727-32af-9ea2-8c46-98f46ee3711e@ti.com> <CANLsYkyv+4cSCY27kA6qfo2XMzXy_h+DmXTe0nVZuUkC0kyRUQ@mail.gmail.com>
 <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com>
In-Reply-To: <ca77fe73-3baf-64ff-c9e2-b2f35f96ffe3@ti.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 26 Mar 2020 16:01:28 -0600
Message-ID: <CANLsYkz8iqiperjdQVcwAC3YGT5cmEvJcu8fPFGF5-X6eKVUDQ@mail.gmail.com>
Subject: Re: [PATCH v2] rpmsg: core: Add wildcard match for name service
To:     Suman Anna <s-anna@ti.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Mar 2020 at 14:42, Suman Anna <s-anna@ti.com> wrote:
>
> On 3/26/20 3:21 PM, Mathieu Poirier wrote:
> > On Thu, 26 Mar 2020 at 09:06, Suman Anna <s-anna@ti.com> wrote:
> >>
> >> Hi Mathieu,
> >>
> >> On 3/10/20 10:50 AM, Mathieu Poirier wrote:
> >>> Adding the capability to supplement the base definition published
> >>> by an rpmsg_driver with a postfix description so that it is possible
> >>> for several entity to use the same service.
> >>>
> >>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> >>
> >> So, the concern I have here is that we are retrofitting this into the
> >> existing 32-byte name field, and the question is if it is going to be
> >> enough in general. That's the reason I went with the additional 32-byte
> >> field with the "rpmsg: add a description field" patch.
> >>
> >
> > That's a valid concern.
> >
> > Did you consider increasing the size of RPMSG_NAME_SIZE to 64? Have
> > you found cases where that wouldn't work?  I did a survey of all the
> > places the #define is used and all destination buffers are also using
> > the same #define in their definition.  It would also be backward
> > compatible with firmware implementations that use 32 byte.
>
> You can't directly bump the size without breaking the compatibility on
> the existing rpmsg_ns_msg in firmwares right? All the Linux-side drivers
> will be ok since they use the same macro but rpmsg_ns_msg has presence
> on both kernel and firmware-sides.

Ah yes yes... The amount of bytes coming out of the pipe won't match.
Let me think a little...

>
> regards
> Suman
>
> >
> > Thanks,
> > Mathieu
> >
> >> regards
> >> Suman
> >>
> >>> ---
> >>> Changes for V2:
> >>> - Added Arnaud's Acked-by.
> >>> - Rebased to latest rproc-next.
> >>>
> >>>  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
> >>>  1 file changed, 19 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> >>> index e330ec4dfc33..bfd25978fa35 100644
> >>> --- a/drivers/rpmsg/rpmsg_core.c
> >>> +++ b/drivers/rpmsg/rpmsg_core.c
> >>> @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
> >>>  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
> >>>                                 const struct rpmsg_device_id *id)
> >>>  {
> >>> -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
> >>> +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
> >>> +
> >>> +     /*
> >>> +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
> >>> +      * is:
> >>> +      *
> >>> +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> >>> +      *      { .name = "rpmsg-client-sample" },
> >>> +      *      { },
> >>> +      * }
> >>> +      *
> >>> +      * Then it is possible to support "rpmsg-client-sample*", i.e:
> >>> +      *      rpmsg-client-sample
> >>> +      *      rpmsg-client-sample_instance0
> >>> +      *      rpmsg-client-sample_instance1
> >>> +      *      ...
> >>> +      *      rpmsg-client-sample_instanceX
> >>> +      */
> >>> +     return strncmp(id->name, rpdev->id.name, len) == 0;
> >>>  }
> >>>
> >>>  /* match rpmsg channel and rpmsg driver */
> >>>
> >>
>
