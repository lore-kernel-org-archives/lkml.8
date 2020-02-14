Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DBC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDCF12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdkH5PaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388971AbgBNRWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:22:20 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42658 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390454AbgBNRWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:22:16 -0500
Received: by mail-io1-f66.google.com with SMTP id z1so10773508iom.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 09:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xv17a45pi5NucetgPC6cMwzW5Vj6j3Q1UdEccsF87iI=;
        b=jdkH5PaG1H+2nkU3l9wXveH84Du4g4JPLe3p08esY/8YFJ54sSW20xmuXMNZuEdGXv
         oplq+b/lfm9egkj7LuYMxQ8bJ6oBD/rGnBL+Ep43i0dgfs34aOJeeo/BekoVdQGl1xyH
         61cgMmjI5k08v96putoK2ty0W7x0iSRkgmVyGo+/IrOTRHF0v66Cy8vJbXt73GL4ijDn
         6RAW+PifPqEORYEqm43APpyAPqzRvTEInCFBs8NCy3ErMv1DQT8qUSuRig62bqsUv7mN
         /aPMdW990kBDVRD9r1Mbe9LaF/zd4ojApPMkioKtmZdRLxYfFS0q/r5wKYnNY6vILx67
         YfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xv17a45pi5NucetgPC6cMwzW5Vj6j3Q1UdEccsF87iI=;
        b=iXgVZKvOSKQOFFLBHMloEVwE4AsBdf06A7r547/IjKYxkpVBIHkX7CPGFWkK2V5fnZ
         xoUEf/3Y44ZIAUuERQpPmCaVn3DtbruRCGgM2HpT7qK5U16fltD+jlyAq3eri+9y8a5u
         0dG7wE6i9tZVIyKHhyDMirTCTyTqxsYF3xV6K16jL4K0SoBlxkhwd0JRMIHyAxC0fDJD
         hRFiAn85gztpw/nqq3SnjkW91jFnLCwMDYHo3wUDLYMOmfnJ2FtnfoWlwFFYnHyMTM24
         Vjlz3g8Gl16dU/DaFdA+VsvaaLGDmgsnaNMZjSAcWRicBBtxab506/4qIjTiv5LlE8FT
         bTAg==
X-Gm-Message-State: APjAAAXMD9nVz6BCPwlpBIVzhKmhsyhXHuQEq04MOLEKFFu7EtL/yOxw
        VGl9DiBIk8R62M8E1KCILGkTvalCq1nPGJJWcxT2ew==
X-Google-Smtp-Source: APXvYqypSbqZ4jw/jzA7yD97cGOuUK73KMvRHZK3KHww9cRWf4lUdMOs3QJI2H26Auomb9rUQ87gBjcB9xIRLzsGHZY=
X-Received: by 2002:a05:6638:44a:: with SMTP id r10mr3354681jap.36.1581700935651;
 Fri, 14 Feb 2020 09:22:15 -0800 (PST)
MIME-Version: 1.0
References: <20200212211251.32091-1-mathieu.poirier@linaro.org>
 <20200212211251.32091-2-mathieu.poirier@linaro.org> <034dcb0b-e305-aab9-f52b-5f725856480f@st.com>
In-Reply-To: <034dcb0b-e305-aab9-f52b-5f725856480f@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Fri, 14 Feb 2020 10:22:04 -0700
Message-ID: <CANLsYkxfavBjbtkOco59xatvW82+uoDAsos5Js_M9_55F_a_Pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] rpmsg: core: Add wildcard match for name service
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>,
        Xiang Xiao <xiaoxiang@xiaomi.com>,
        Tero Kristo <t-kristo@ti.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 at 06:56, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu,
>
> Simple and elegant :)
> I tested it with my rpmsg_tty client which defines several IDs: work fine.

Perfect - many thanks for giving this a spin.

>
> Just a question regarding the comment else
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>
>
> On 2/12/20 10:12 PM, Mathieu Poirier wrote:
> > Adding the capability to supplement the base definition published
> > by an rpmsg_driver with a postfix description so that it is possible
> > for several entity to use the same service.
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/rpmsg/rpmsg_core.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> > index e330ec4dfc33..bfd25978fa35 100644
> > --- a/drivers/rpmsg/rpmsg_core.c
> > +++ b/drivers/rpmsg/rpmsg_core.c
> > @@ -399,7 +399,25 @@ ATTRIBUTE_GROUPS(rpmsg_dev);
> >  static inline int rpmsg_id_match(const struct rpmsg_device *rpdev,
> >                                 const struct rpmsg_device_id *id)
> >  {
> > -     return strncmp(id->name, rpdev->id.name, RPMSG_NAME_SIZE) == 0;
> > +     size_t len = min_t(size_t, strlen(id->name), RPMSG_NAME_SIZE);
> > +
> > +     /*
> > +      * Allow for wildcard matches.  For example if rpmsg_driver::id_table
> > +      * is:
> > +      *
> > +      * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> > +      *      { .name = "rpmsg-client-sample" },
> > +      *      { },
> > +      * }
> > +      *
> > +      * Then it is possible to support "rpmsg-client-sample*", i.e:
> > +      *      rpmsg-client-sample
> > +      *      rpmsg-client-sample_instance0
> > +      *      rpmsg-client-sample_instance1
> > +      *      ...
> > +      *      rpmsg-client-sample_instanceX
> > +      */
> What about adding this as function documentation? i don't know if it makes sense
> for a static volatile function...

It didn't cross my mind because (and as you pointed out) it is a
static function.  Let me know if you're keen on seeing this corrected
and I'll go for a respin.

Mathieu

>
> Regards
> Arnaud
>
> > +     return strncmp(id->name, rpdev->id.name, len) == 0;
> >  }
> >
> >  /* match rpmsg channel and rpmsg driver */
> >
