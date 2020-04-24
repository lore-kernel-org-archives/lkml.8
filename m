Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61F3C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1C720704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bJkJTJHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728774AbgDXR1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgDXR1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:27:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4413DC09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:27:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p8so4927757pgi.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=757eATNy6DcXBD0dJfNd9a4RLKac7QDmicHrKgoTBRA=;
        b=bJkJTJHj/GzTZ3ywmcf915mvKDOklF2XfK+t7rWKq7rhQhj0drdqd9RnHoHT4DyW7L
         5BAqgXJ87NBW/oEc8K4aIaEl/i4N36Kp4CF09P9sfMbK2tAp1Nz7MuzwUvcvovxF0h2R
         B8oxkci5KmV88Y079GFKPyGw//Hhbg2UqBrIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=757eATNy6DcXBD0dJfNd9a4RLKac7QDmicHrKgoTBRA=;
        b=jU2UmcJsRBRkVi6nhX7caat232hKMAXoreAEwgCmxSUELiVUNAxNGZB4WLOxQC+Pct
         fmF3pO+I+jW69pl/r7kY6wm/ESQHtgR5HGG9HLsaCXbfsbJqMcL4/rNS5j/Do66kg+rX
         Su7mihGZSTfnqPoWglVNWj5K009n7PX6Ubebzz4mU51KeK410wWmhIVkjK0knodn84ZL
         Riuizo1UTv/1hZnXAVfw3M3NWPWFNgOijdsMYTalEHiXRfyfNiWQW6ip4hHsz6PwTA8z
         rdEjLiduhbZ6+Hp2sAhKeGftkCh5MWsTRNAIe7GeCZQJZ7U6ceSNQg+FH/hp0fFXHBvF
         ot7Q==
X-Gm-Message-State: AGi0PuaxUaglyoTxuwW4kESbW5HvZeHadmE2Eo/tJBB80iGRJh7WtUPE
        PpR/sFx1dNo3gIIneahdJiH8lg==
X-Google-Smtp-Source: APiQypKw5WR5DnbdToP85PGHkarWb37+RaJrV6IbrFuNZsd1ng8JTeIUGSD+QIQsNJ+078GoGRpPTA==
X-Received: by 2002:a63:3242:: with SMTP id y63mr1578172pgy.28.1587749228820;
        Fri, 24 Apr 2020 10:27:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id d18sm6327663pfq.177.2020.04.24.10.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:27:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=V7KfjEpdQdkXdnGK86cEkpO_SxcDgFiXqAr8oj25P_zw@mail.gmail.com>
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-3-swboyd@chromium.org> <CAD=FV=U6YiD=ORDuuRsYVRJriv+jJie3=HoF7MokWbj5Wx0rew@mail.gmail.com> <CAD=FV=V7KfjEpdQdkXdnGK86cEkpO_SxcDgFiXqAr8oj25P_zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh-rsc: Loop over less bits in irq handler
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:27:07 -0700
Message-ID: <158774922735.135303.1360850783025067093@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-04-24 10:13:43)
> Hi,
>=20
> On Fri, Apr 24, 2020 at 10:11 AM Doug Anderson <dianders@chromium.org> wr=
ote:
> >
> > Hi,
> >
> > On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrot=
e:
> > >
> > > readl returns a u32, and BITS_PER_LONG is different on 32-bit vs. 64-=
bit
> > > architectures. Let's make the type we stash the readl into a u32 and
> > > then loop over the bits set in that type instead of potentially loopi=
ng
> > > over more bits than we will ever need to.
> > >
> > > Cc: Maulik Shah <mkshah@codeaurora.org>
> > > Cc: Douglas Anderson <dianders@chromium.org>
> > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > ---
> > >  drivers/soc/qcom/rpmh-rsc.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
>=20
> Oh, I suppose one nit is s/less/fewer/ in the subject.  "bits" are
> discrete / countable, not continuous / uncountable.
>=20

Ok that's good.
