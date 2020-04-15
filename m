Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B425C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2082720784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q2sqLZJi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393181AbgDOE6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393136AbgDOE6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:58:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE999C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:58:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d1so149456pfh.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=R5xbiSaj5Oy8Nnf2GgKJ4RfScFxtsge56lV6SHB/Y3M=;
        b=Q2sqLZJiLyjBBVROU/jscisw1EzVvQg8WBDR4qLWL72E0zJ3iX9fS/ITToP8f9KkYB
         mmFa9RKmzjdEr/SKNlOzoQkifzdpF1LcY8IeSja1ZY9giLjwloc6vR+tnAogzlc3zOi/
         PkkeVN7PzU6KiqZwmWEOwSFXm1gnqPhPpB7SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=R5xbiSaj5Oy8Nnf2GgKJ4RfScFxtsge56lV6SHB/Y3M=;
        b=muOulWD3I4kbffhKZTvO+LueyD0021O2i+S8Qzv29X3hkKMHWU1qrEeNSc0otgqQ7t
         9eTT7Z0VF+apJ3aporA8WT1qlogLDyW4aGH7qCZZAKGyzh2IQyeakRgVSHUKuJtgX2LP
         p8mz/josW7scWFV3UWU6lsI5pHRNojJBzhCwjX2AhuhZXqhGnFICWOpe4T0u6H1aaAAN
         mfLQP8GCGyktlGwrzCS9WlCn3hTgu6XRTv/mDHhLkhbf6WXaODyEDbOeGSUvaBNxT9EF
         32L+FOD+HUBapymN5qWJGyDdO+Aoq8Sr9zehinMhkaR1I0xpxcgwYWkUY1f6+jU6a4OK
         Xp5Q==
X-Gm-Message-State: AGi0Pub/YM+mGeHQTdAAbDY0o6bZjr16/iaUYQrnBE5mjRaWF424g0uC
        49A7AkNlrLtu9EmQUFxfvKYSYg==
X-Google-Smtp-Source: APiQypKQOOZTdpdrxorZia/8YjPs8v7toOXT6LnIG2Xi/GGtNGiEILQJhuxpvhsDjjAu08AHdVi+ng==
X-Received: by 2002:aa7:8101:: with SMTP id b1mr26659253pfi.322.1586926691162;
        Tue, 14 Apr 2020 21:58:11 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w66sm9174048pfw.50.2020.04.14.21.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:58:10 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=W9swvzfCX5H=qhqdsnCAFTCWwzibcu72JJ9VKi9cR+1Q@mail.gmail.com>
References: <20200414131010.v2.1.Ic70288f256ff0be65cac6a600367212dfe39f6c9@changeid> <20200414131010.v2.2.I8550512081c89ec7a545018a7d2d9418a27c1a7a@changeid> <158689621032.105027.15399009553185990099@swboyd.mtv.corp.google.com> <CAD=FV=W9swvzfCX5H=qhqdsnCAFTCWwzibcu72JJ9VKi9cR+1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] soc: qcom: rpmh-rsc: Timeout after 1 second in write_tcs_reg_sync()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Joe Perches <joe@perches.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 21:58:09 -0700
Message-ID: <158692668955.105027.2532988655671853557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-04-14 13:39:15)
> Hi,
>=20
> On Tue, Apr 14, 2020 at 1:30 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Douglas Anderson (2020-04-14 13:10:16)
> > > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > > index f988e9cc2c30..02fc114ffb4f 100644
> > > --- a/drivers/soc/qcom/rpmh-rsc.c
> > > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > > @@ -174,12 +175,13 @@ static void write_tcs_reg(const struct rsc_drv =
*drv, int reg, int tcs_id,
> > >  static void write_tcs_reg_sync(const struct rsc_drv *drv, int reg, i=
nt tcs_id,
> > >                                u32 data)
> > >  {
> > > +       u32 new_data;
> > > +
> > >         writel(data, tcs_reg_addr(drv, reg, tcs_id));
> > > -       for (;;) {
> > > -               if (data =3D=3D readl(tcs_reg_addr(drv, reg, tcs_id)))
> > > -                       break;
> > > -               udelay(1);
> > > -       }
> > > +       if (readl_poll_timeout_atomic(tcs_reg_addr(drv, reg, tcs_id),=
 new_data,
> > > +                                     new_data =3D=3D data, 1, USEC_P=
ER_SEC))
> > > +               pr_err("%s: error writing %#x to %d:%d\n", drv->name,
> >
> > Shouldn't the register be hex? That seems to be how the registers are
> > represented. But I guess tcs_id is decimal and can't be translated to be
> > meaningful enough to indicate which TCS it is like the sleep or wake
> > one.
>=20
> Good point.  Should I quickly spin a v3 just so this is all ready to
> go, or wait to see if there is any additional feedback?
>=20

That's my only complaint, so if maintainers fix it then you can have my
RB tag.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
