Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B460BC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FD820678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MVes92Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389396AbgDBUTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:19:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41644 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388791AbgDBUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:19:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id a63so3412450vsa.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YWnBxNBu0tvIKCGTwWpIq7wFm6hg3vnqf4EkEdpDgPA=;
        b=MVes92VnDQd6LBjIaPZLnyNoP61o6SSwgxqnbyqCf5k/hP8S+V5GmO4tsLi4u9rJ3T
         YLQhEOa86bUYjdRNZN96cKOcM2yfS1caMIBh4aZ1bWk2jZ1N8/vkoQnXx/26WqQKlARu
         7TbxcRPh2Ez/VfAugMD5GpPWWsuC15CczRefE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YWnBxNBu0tvIKCGTwWpIq7wFm6hg3vnqf4EkEdpDgPA=;
        b=BwAsy2wWfQuzuRT4BYEZECAXbCEySGSDyvD7fJrls7u572aanY75SuGYYtmNak06h9
         grSYBiDYcNqd152dBWAuiFozDbRzz1LI4tcOG7uySq9V6ZCzA4q4uXJa3DNsuloUmbKK
         DjEl4b3kD5WR1KPqjwnTZRUXAQXilJur9pQTyBeI9pSu8SE92SJ5nxQGwUkivaT0ruyI
         bKnCe+Qwpxjj5vU4YIB1bezvABCn+m2VSzLvLFnnZkiYWzG3nUFHGMaw0PaYVNbYp6ut
         Zl0xcsmjzx9ZsXOZvL/WDGkamwGqoRQPUFNFRNSZg2ITHd2FrRDh+X1sWdYSevkkiXw4
         a60w==
X-Gm-Message-State: AGi0PuYLDBnOpHHckxQCxqE6dGG/tAfiNhzVT7ZTc+QZ/kLX5o40dAiF
        mZPDtA6pdDh2wvgnTm2AJaA8VEpnn28=
X-Google-Smtp-Source: APiQypLk1JREHjmfa/GSWjo9dfLd63hReho5YPB8bmUs9wWWNzR06TZsskjcVVEdMtcQlZ02jRueRQ==
X-Received: by 2002:a67:c509:: with SMTP id e9mr3898106vsk.68.1585858791066;
        Thu, 02 Apr 2020 13:19:51 -0700 (PDT)
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com. [209.85.222.49])
        by smtp.gmail.com with ESMTPSA id d83sm1678614vka.34.2020.04.02.13.19.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:19:50 -0700 (PDT)
Received: by mail-ua1-f49.google.com with SMTP id v24so1859255uak.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:19:49 -0700 (PDT)
X-Received: by 2002:ab0:2389:: with SMTP id b9mr2719796uan.120.1585858789341;
 Thu, 02 Apr 2020 13:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200311231348.129254-1-dianders@chromium.org>
 <20200311161104.RFT.v2.7.I8e187cdfb7a31f5bb7724f1f937f2862ee464a35@changeid> <339a7a7b-af4e-d6a9-4b48-2a603ea10172@codeaurora.org>
In-Reply-To: <339a7a7b-af4e-d6a9-4b48-2a603ea10172@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 13:19:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VMt+jQPX8hXBJkNGafEr_+r2p1hbFkG3LHeX9JjPCvrg@mail.gmail.com>
Message-ID: <CAD=FV=VMt+jQPX8hXBJkNGafEr_+r2p1hbFkG3LHeX9JjPCvrg@mail.gmail.com>
Subject: Re: [RFT PATCH v2 07/10] drivers: qcom: rpmh-rsc: Warning if
 tcs_write() used for non-active
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 1, 2020 at 5:40 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 3/12/2020 4:43 AM, Douglas Anderson wrote:
> > tcs_write() is documented to only be useful for writing
> > RPMH_ACTIVE_ONLY_STATE.  Let's be loud if someone messes up.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2: None
> >
> >   drivers/soc/qcom/rpmh-rsc.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index 93f5d1fb71ca..ba489d18c20e 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -573,6 +573,12 @@ static int tcs_write(struct rsc_drv *drv, const struct tcs_request *msg)
> >       unsigned long flags;
> >       int ret;
> >
> > +     /*
> > +      * It only makes sense to grab a whole TCS for ourselves if we're
> > +      * triggering right away, which we only do for ACTIVE_ONLY.
> > +      */
> > +     WARN_ON(msg->state != RPMH_ACTIVE_ONLY_STATE);
> > +
>
> Unnecessary check, we will never hit this warning. Lets not add such check.

That's fine.  I can drop it, especially now that comments explain that
this is only for ACTIVE_ONLY.  Personally I like having extra
assertion failures like this that indicate a serious internal logic
error in the code, but I won't push strongly for it.


> Saying that you can modify this change to drop below check  from
> rpmh_rsc_write_ctrl_data() as that never hit.
>
>          /* Data sent to this API will not be sent immediately */
>          if (msg->state == RPMH_ACTIVE_ONLY_STATE)
>                  return -EINVAL;
>
> we always call rpmh_rsc_write_ctrl_data() for RPMH_SLEEP_STATE and
> RPMH_WAKE_ONLY_STATE.

Sure.  My preference would have been to change it to a WARN_ON() too
(because it signifies an internal error within the RPMH driver, not an
external error that a client of RPMH could trigger), but I can just
drop it entirely.


-Doug
