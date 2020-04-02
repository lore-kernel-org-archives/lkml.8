Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D1FC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B46920678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FJV4vDtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389144AbgDBUT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:19:27 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33801 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgDBUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:19:27 -0400
Received: by mail-ua1-f67.google.com with SMTP id d23so1845431uak.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/ztm4+HWR/JB+WHs+0Jt1MI0w7+TguyN/LcxGnJK9g=;
        b=FJV4vDtGhvbjegBl5UJH+glQ384Lw3LJ8hD6s2us9nP1vbzkGnFWUPCSKjqnvPD+26
         9aJnpv17ng67MB7svZsi0Yvr95LfvaU4CbWoDRSQhmC59aVaP2w8lqdxVMBUjV/vqVM3
         IqhMFbmIENGxYapPnEW0fj7MP96NqjurZAqRI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/ztm4+HWR/JB+WHs+0Jt1MI0w7+TguyN/LcxGnJK9g=;
        b=NsXeQSna/FJLTmSOrwqul0tlTbDoBmfJX6HyB0hriOm1DUDdGB7pGFgHEKpeCSB2Ur
         +KNrnuKNStCj88pT2ZU+zt7pUxHjANU3k/OpQx+oNk3GNiuz6KkzRhuCnNOVWViOC6cc
         p7OEOPsXA629LOnTN1/plFWbR38TPdCtd+3ItQurhbQLYjXi/AlJ1CO3yfJymL28z8tE
         v6Wm6jT1C/0bw7lLRsAjihBsLiEXdk16TTRAr9FrA0qvFf8ROWX2VD/laYmP37ZXMezP
         12kU1BHL4MppxzmqGPkxj/Dzb2K8/d96HgH0x1JjgyWvsKb6ShspYYojwoU8MdQDBam2
         k3rA==
X-Gm-Message-State: AGi0PubQWQ8HmrcyOuDrLZLiIPiiclWVDFcBgUsaSJhRP/Sj6eoCzYQI
        59oI/iVpKZcrpxX5i9pggsIikG5NSmY=
X-Google-Smtp-Source: APiQypL1v/nq4BfoJHa4JWXLmuPzV9EV/SIpgXQP2LxmnNhiStxaJVGdilCSldM2ryqfrs6/IY39Yg==
X-Received: by 2002:ab0:1550:: with SMTP id p16mr4036333uae.102.1585858765146;
        Thu, 02 Apr 2020 13:19:25 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id s17sm1578991vss.32.2020.04.02.13.19.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 13:19:24 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id o3so3434843vsd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:19:23 -0700 (PDT)
X-Received: by 2002:a67:2b07:: with SMTP id r7mr4187937vsr.169.1585858763476;
 Thu, 02 Apr 2020 13:19:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200311231348.129254-1-dianders@chromium.org>
 <20200311161104.RFT.v2.6.Icf2213131ea652087f100129359052c83601f8b0@changeid> <7a6edff1-3916-e802-0441-25b31989619f@codeaurora.org>
In-Reply-To: <7a6edff1-3916-e802-0441-25b31989619f@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 13:19:11 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VVArTaPqaWJJ9ONF5p+fg6c-ZiWUtdpqy4U96Ee-Pn9A@mail.gmail.com>
Message-ID: <CAD=FV=VVArTaPqaWJJ9ONF5p+fg6c-ZiWUtdpqy4U96Ee-Pn9A@mail.gmail.com>
Subject: Re: [RFT PATCH v2 06/10] drivers: qcom: rpmh-rsc: Comment
 tcs_is_free() + warn if state mismatch
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

On Wed, Apr 1, 2020 at 4:39 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Hi,
>
> On 3/12/2020 4:43 AM, Douglas Anderson wrote:
> > tcs_is_free() had two checks in it: does the software think that the
> > TCS is free and does the hardware think that the TCS is free.  Let's
> > comment this and also add a warning in the case that software and
> > hardware disagree, at least for ACTIVE_ONLY TCS.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Comment tcs_is_free() new for v2; replaces old patch 6.
> >
> >   drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> > index 9d2669cbd994..93f5d1fb71ca 100644
> > --- a/drivers/soc/qcom/rpmh-rsc.c
> > +++ b/drivers/soc/qcom/rpmh-rsc.c
> > @@ -181,8 +181,27 @@ static void write_tcs_reg_sync(struct rsc_drv *drv, int reg, int tcs_id,
> >    */
> >   static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
> >   {
> > -     return !test_bit(tcs_id, drv->tcs_in_use) &&
> > -            read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id);
> > +     /* If software thinks it's in use then it's definitely in use */
> > +     if (test_bit(tcs_id, drv->tcs_in_use))
> > +             return false;
> > +
> > +     /* If hardware agrees it's free then it's definitely free */
> > +     if (read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id) != 0)
> > +             return true;
> > +
> > +     /*
> > +      * If we're here then software and hardware disagree about whether
> > +      * the TCS is free.  Software thinks it is free and hardware thinks
> > +      * it is not.
> > +      *
> > +      * Maybe this should be a warning in all cases, but it's almost
> > +      * certainly a warning for the ACTIVE_TCS where nobody else should
> > +      * be doing anything else behind our backs.  For now we'll just
> > +      * warn there and then still return that we're in use.
> > +      */
> > +     WARN(drv->tcs[tcs_id].type == ACTIVE_TCS,
> > +          "Driver thought TCS was free but HW reported busy\n");
> This warning can come for borrowed WAKE_TCS as well.
> > +     return false;
> >   }
>
> We have a patch on downstream variant to optimize this by only checking
> tcs_in_use flag (SW check) and HW check is removed.
>
>   static bool tcs_is_free(struct rsc_drv *drv, int tcs_id)
>   {
> -       return !test_bit(tcs_id, drv->tcs_in_use) &&
> -              read_tcs_reg(drv, RSC_DRV_STATUS, tcs_id, 0);
> +       return !test_bit(tcs_id, drv->tcs_in_use);
>   }
>
> With this we are good and don't require to put above warning as well.
>
> if you want me to upload, i can post it and then you can drop this
> change from your series.
>
> Or if you want to modify it as above and keep in this series i am ok.

Probably easiest for me to replace this patch in the series with one
that removes the read from RSC_DRV_STATUS.  Then it will all be
clearer.
