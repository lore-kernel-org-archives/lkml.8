Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868B9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B6262083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 21:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jg0aAF/V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgDQVRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 17:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgDQVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 17:17:08 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D818DC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:17:07 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id u12so1178134uau.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJ2fYj8faRnQWYU+YUvw2BuJTdJ8p/wj9zFiQhRecXY=;
        b=jg0aAF/VBOEowYu593EttCPIZkn+y5RfCCJA7A9me76IkPZAsRrbd0/T/gxbhJ/Nea
         tWQR2GXYK9vwBRwjMNG23L4vJh1oGHmRc2CjVNncy5RDzfuzEGb8ed+0x7qWLo5t/5OA
         YnhUhWAj1kNKyBGVtXGLHtwZuHxHlvy5ESOgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ2fYj8faRnQWYU+YUvw2BuJTdJ8p/wj9zFiQhRecXY=;
        b=tNGhWZ6d1FUk0C49XooLausLbDIKJmTSoAeimJ3uDac09dIMEOElWAiYeHfsI4fJLw
         z6t9T4jTEWY+5KiSyRXi475sDoG/eCdnvskt7tr8gyxj8Qs+jqnNCwUOS95eYVQK4VND
         D4Lk9P49MbWwhqQHuSCadmhUPC691cJ2vACghIK2sFxDvsfYn3pXynoGihzzRW1Hwrxo
         hUciXC1lsRwJrXrEf++/5MibA00DSBjQnmSHQm5DuLkVhRrfXzeNUPlvMqDpjcGRn8un
         XXKlOASgWw5Yg/lbY+4x9EycibAvpzw4QIHk0WcFSWRNEiyee0+2LL8CVrECMUr+Y2lw
         LKuQ==
X-Gm-Message-State: AGi0PuZBbkMTyHt1GL6iex30ZHC/d3nlZ+Y2Uu0q+g33XTDmnsmQjtL/
        tlzkeqgVKVkYEw/yQnQhCL7V/sSfrX8=
X-Google-Smtp-Source: APiQypK1AS44f9YAYcP9aasPaJYvE16dh4m5pw4RWmCIfS7Tfdnf8MrLsFm+e0v45wpAWLa9g4MP1w==
X-Received: by 2002:a9f:2204:: with SMTP id 4mr690185uad.87.1587158226582;
        Fri, 17 Apr 2020 14:17:06 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id x73sm2970281vsc.27.2020.04.17.14.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 14:17:05 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id q200so730640vka.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 14:17:05 -0700 (PDT)
X-Received: by 2002:a1f:5fc3:: with SMTP id t186mr4344481vkb.92.1587158224782;
 Fri, 17 Apr 2020 14:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <1586703004-13674-1-git-send-email-mkshah@codeaurora.org>
 <1586703004-13674-3-git-send-email-mkshah@codeaurora.org> <158708153779.132238.7823999141480422982@swboyd.mtv.corp.google.com>
In-Reply-To: <158708153779.132238.7823999141480422982@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 17 Apr 2020 14:16:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WOwMrTNS7FK0jybJyEOvT-rHarA0m5U6B+pKoeA7RCHQ@mail.gmail.com>
Message-ID: <CAD=FV=WOwMrTNS7FK0jybJyEOvT-rHarA0m5U6B+pKoeA7RCHQ@mail.gmail.com>
Subject: Re: [PATCH v17 2/6] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Maulik Shah <mkshah@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 4:59 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Maulik Shah (2020-04-12 07:50:00)
> > diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> > index eb0ded0..03630ae 100644
> > --- a/drivers/soc/qcom/rpmh.c
> > +++ b/drivers/soc/qcom/rpmh.c
> > @@ -133,26 +134,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
> >
> >         req->addr = cmd->addr;
> >         req->sleep_val = req->wake_val = UINT_MAX;
> > -       INIT_LIST_HEAD(&req->list);
> >         list_add_tail(&req->list, &ctrlr->cache);
> >
> >  existing:
> > +       old_sleep_val = req->sleep_val;
> > +       old_wake_val = req->wake_val;
> > +
> >         switch (state) {
> >         case RPMH_ACTIVE_ONLY_STATE:
> > -               if (req->sleep_val != UINT_MAX)
> > -                       req->wake_val = cmd->data;
> > -               break;
> >         case RPMH_WAKE_ONLY_STATE:
> >                 req->wake_val = cmd->data;
> >                 break;
> >         case RPMH_SLEEP_STATE:
> >                 req->sleep_val = cmd->data;
> >                 break;
> > -       default:
> > -               break;
> >         }
> >
> > -       ctrlr->dirty = true;
> > +       ctrlr->dirty = (req->sleep_val != old_sleep_val ||
> > +                       req->wake_val != old_wake_val) &&
> > +                       req->sleep_val != UINT_MAX &&
> > +                       req->wake_val != UINT_MAX;
>
> Can this change ctrl->dirty from true to false? I'm worried that we need
> to make this a saturating assignment instead of an assignment.
>
>         ctrl->dirty = ctrl->dirty || (req->sleep_val != .. );

This seems like a serious problem with the current code and feels like
we need a fix sooner rather than later.  I'm sorry I missed it in
review (and in fact, I probably suggested the exact code that's here
so it's even more my fault).  :(

I posted:

https://lore.kernel.org/r/20200417141531.1.Ia4b74158497213eabad7c3d474c50bfccb3f342e@changeid

-Doug
