Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F05C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012C2206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 20:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SHfnBisN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgGXUbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgGXUbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:31:53 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3180CC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:31:53 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id s20so5579908vsq.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUE6iV1Nh/oJYrMV+RYxiuJMvZ3y8L6jKlZzmL+Z6UQ=;
        b=SHfnBisNh4+tugXYFj/mO4bsA5w3zj3n5+t/rJu6EjcqV7y6b12B5zmhYf5j3CL8/4
         YF0Yp7PtLzxF8IfKlWr+mdsQRWmjWzAqB0KXKvzJlTG/VhRp8exmCqXexUdykoJLaIeQ
         10SECNLVO19a/L+yaJ7meQTr+WGDBKH+6OID8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUE6iV1Nh/oJYrMV+RYxiuJMvZ3y8L6jKlZzmL+Z6UQ=;
        b=MBF3ME5W4FnW2BQb0Wl4YJhGkbs0X5RnQQRAbnRgCa9Qz9Z/h0fzCuLNWHaXuxcN2e
         bcnCzeGVvZiaAi2fnseG6tOMaq1CqenA2gep7hoGp5UaPU6BTnroDjEWeR/97arpu3Zl
         RuAge2Cn6Nxr00oX8lYiS4Cc63VZxVWAIMyhWEL7wcjzYCLuGeNj5HR9EREWh4/z9Fxf
         VYS/6Vt/+ZbBRpax+qpoze259+4DHRuFimRJn6BO4kiXPjc+qlEyirws5V6YXGVo093C
         TtQMKghSUoWLUq0zsnPdAaFXlQjlh6Yb/i5N6BM+9BmjFrqHxkQ622nojNQct8cwtSl+
         e5xw==
X-Gm-Message-State: AOAM5322gpv1q/7fJ9hQkWEdDEYM/+6mM94IESVj7X2w4pHd+aow0N2I
        EOQj+pp9is8Fk57aAsrnFCuI4ebYmsQ=
X-Google-Smtp-Source: ABdhPJxGFHTFf2UBhzg72XWxWMRLVTqHJBvqB1ArIYxomFZ5p5ll35NdSgWQQS57WxHrbOGODUvvag==
X-Received: by 2002:a67:f504:: with SMTP id u4mr8969852vsn.91.1595622712219;
        Fri, 24 Jul 2020 13:31:52 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id p5sm247344vkp.44.2020.07.24.13.31.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 13:31:51 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id o25so3371027uar.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 13:31:51 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr9953284uaj.104.1595622711118;
 Fri, 24 Jul 2020 13:31:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200723010137.3127584-1-swboyd@chromium.org> <CAD=FV=WtjyYY+bmocc17S9NbRs6inkAWjj7=c9qBsVf3LtG99Q@mail.gmail.com>
 <159561988523.3847286.14763422711224252201@swboyd.mtv.corp.google.com>
 <CAD=FV=WH1vKKe=MPVdtBJZWnSzxNLO0uyM02GFG6oCJfSEwehQ@mail.gmail.com>
 <159562087212.3847286.9484527206999948907@swboyd.mtv.corp.google.com>
 <CAD=FV=VUSwsP_xrHsufLjZqbWdn5V8rybtv2DWad2nBfU+VJ9w@mail.gmail.com> <159562244072.3847286.7905035931282026601@swboyd.mtv.corp.google.com>
In-Reply-To: <159562244072.3847286.7905035931282026601@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Jul 2020 13:31:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V2NduvgdrSNOs7Ufm+=Tk3+rtkSoJg8BH7cYtOdCHXcA@mail.gmail.com>
Message-ID: <CAD=FV=V2NduvgdrSNOs7Ufm+=Tk3+rtkSoJg8BH7cYtOdCHXcA@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Sleep waiting for tcs slots to be free
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jul 24, 2020 at 1:27 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-07-24 13:11:59)
> >
> > I wasn't suggesting adding a timeout.  I was just saying that if
> > claim_tcs_for_req() were to ever return an error code other than
> > -EBUSY that we'd need a check for it because otherwise we'd interpret
> > the result as a tcs_id.
> >
>
> Ok that sounds like you don't want a check for -EBUSY so I'll leave this
> as >= 0.

To clarify, I'd be OK with either of these (slight preference towards
#2, but not a strong one):

1. Your current code and a REALLY OBVIOUS comment in
claim_tcs_for_req() saying that we'd better not return any error codes
other than -EBUSY (because we'll just blindly retry on all of them).

- or -

2. Handling error codes other than -EBUSY, like this:

wait_event_lock_irq(drv->tcs_wait,
                    (tcs_id = claim_tcs_for_req(drv, tcs, msg)) != -EBUSY,
                    drv->lock);
if (tcs_id < 0)
  goto unlock;

-Doug
