Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C71DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B322065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tcg0l6Yi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGXUBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGXUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:01:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0FAC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:01:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t15so5993494pjq.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=CF38ejeupSdGLQ8SJg5UVKB/UvbU/lVoIN0k+iE3qP0=;
        b=Tcg0l6YibTvYMjZh4BV+v8/m9CpmT00Z5P0C8vjG89p7GV0rRLK3NFXh/rDz2pt4ki
         0qUjFnOw9u6BGRfN7nhWgp6KpVrdRPDX4GayUdMXNYAUyPqOSmyEihmKjQUENfrgWwEl
         jYo7/U8rtG7haX9+GPmj8KMso+v8hNrbBAcUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=CF38ejeupSdGLQ8SJg5UVKB/UvbU/lVoIN0k+iE3qP0=;
        b=DMb51DLXx2N8H0zXjfLsHzdsY8ZI0qGX9Dv4DDf2WR39Rx5UEzOxXM0WYIPLDf7pYH
         plpZVxAli/1rNkS+Z4nfg4w5em1XvSlcs5+3CgZoTsi9c/Gu8emJZdgaLMMg3jnHqfN9
         amzCEWL8yInvqOeij/nndrVtq1EgGIwZiOKk7Yk8GlElcweaMAoIXlzxWtT66JnmNdQr
         g96QSwBssDwxrevFr+Z9bzgOINcFy1N6xYYek6LSjug/h78VTsEuqqCiK5+6/NWmqnvX
         QGCXAy3TWOCkfetVJ8cPX1iy+gP4XMAplC1ehILT8t8bq7IrFCiZHdV7NosZ802nfJpX
         rFwA==
X-Gm-Message-State: AOAM5313HqV+2uwI4OiEgeYrXrDwOvFlumTdiAnpIXcKjLhVRR2G8AOe
        EQx31HUW2yT8pmpB0G0aeYgfiA==
X-Google-Smtp-Source: ABdhPJyzr5neoT60gNXUQQSg7ocpplLzu7m3kBYCJZ+3TaGidqYMJ/jEdnJ9B0vMdagFMjBKvSBtVQ==
X-Received: by 2002:a17:90a:750:: with SMTP id s16mr6847752pje.218.1595620873480;
        Fri, 24 Jul 2020 13:01:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u23sm6991699pgn.26.2020.07.24.13.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 13:01:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com> <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com> <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:01:12 -0700
Message-ID: <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-07-24 12:49:56)
> Hi,
>=20
> On Fri, Jul 24, 2020 at 12:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > > > -       if (ret)
> > > > -               goto unlock;
> > > >
> > > > -       ret =3D find_free_tcs(tcs);
> > > > -       if (ret < 0)
> > > > -               goto unlock;
> > > > -       tcs_id =3D ret;
> > > > +       wait_event_lock_irq(drv->tcs_wait,
> > > > +                           (tcs_id =3D claim_tcs_for_req(drv, tcs,=
 msg)) >=3D 0,
> > >
> > > Even though claim_tcs_for_req() only returns 0 or -EBUSY today (IOW it
> > > never returns error codes other than -EBUSY), should we handle it?  If
> > > we don't, claim_tcs_for_req() should be very clear that it shouldn't
> > > return any errors other than -EBUSY.
> >
> > Do you mean you want to change it to be
> >
> >         (tcs_id =3D claim_tcs_for_req(drv, tcs, msg)) !=3D -EBUSY
> >
> > instead of >=3D 0? It should return the tcs_id that was claimed, not ju=
st
> > 0 or -EBUSY.
>=20
> Ah, right.  Yes, you got it right.  Of course then we have to add a
> "if (tcd_id < 0) goto unlock", too.  If you think it's not worth
> adding this then we just need to make sure it's super obvious in
> claim_tcs_for_req() that it's not allowed to return other errors.
>=20

Hmm right now the code will wait forever for the condition to become
true, so it will only ever continue past this point if tcs_id >=3D 0. We
could add a timeout here in another patch, but I didn't want to change
the behavior of what is there in this patch. I don't really care if >=3D 0
or !=3D -EBUSY is used here so I can change it to -EBUSY to provide
clarity.

If we add a timeout here, it would be better to change this driver to
use a pull model instead of the push model it is using today so that the
timeout isn't necessary. That would entail making a proper kthread that
pulls requests off a queue of messages and then this asnyc call would
append messages to the end of the queue and return immediately. That
would be necessary if we want the async calls to work from non-sleeping
contexts for example. I think Lina was alluding to this earlier in this
thread.
