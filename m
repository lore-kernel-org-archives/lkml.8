Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3269C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A770A20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fYK35UF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgBCSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:39:52 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34348 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729013AbgBCSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:39:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so7316814qvf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Il6XQshJNFTKlxloPo0tHXa6dTM59eOI4JIxahczn70=;
        b=fYK35UF7/KEcKhM5B4Hkw/zN/WXIYaZqGxwqBK/iS7bjlJiLmajAQUzLZXzqvNNkjy
         C13unCflsld/wlRseCalRIdk2lccNINvEIOSo/ZxoldppPxEen1UeNDVanFO/rPyCdCA
         sL/idk8kSK3NrPmk9pFWtvF9d4GAIXbXTTgSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Il6XQshJNFTKlxloPo0tHXa6dTM59eOI4JIxahczn70=;
        b=doioyZBJE1ysyiXDm23pB+EP2fTZmuWlzdtYvD5Pf7FvItbX0GLL2/cp7SIh9xV6Xo
         DJNc2Mros+Olwfvy2EpFUc3lAzgQUVWWqmWMO77pd4nlBCz9FLj63oRPBQ+nM7Az0FuX
         9dJma6n0UXCaLfz2ItJ/wMLAKjkHDYBIu4EdGL6dt7uOkegyW/Rp1j1LHMHvnuejle18
         YtaUPZmfNQYrfE1j5QkeidJE91Rxn7ttIvhuFKwxy4HbrF6ZMG2mYS96e74aiALOk+T3
         nPjSz7okYvks953TumA5D223FwmnjwZFf4v1zvLB2/rhVggGZQC4HgC+SScvm2Z+9qqE
         +X9w==
X-Gm-Message-State: APjAAAUtVnygdTNBaBbOL6iPJ3clbNk5B+DkQ/Q94f+hKs6sfTv+qdHx
        Gfh26V/I7z75SBuE6IOhtfZalQxyFgPLaF+RF/SFpw==
X-Google-Smtp-Source: APXvYqz6yocBMBK3Xc21RoO3O8L8ZLpDlqlI+TYq5Z+1/Ua4Qk8gmtMFurGcFBVzfbYKb5cjpa1QA6F4wMPrfDAIw9Q=
X-Received: by 2002:a0c:e790:: with SMTP id x16mr23571260qvn.18.1580755190178;
 Mon, 03 Feb 2020 10:39:50 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-14-pmalani@chromium.org>
 <5d7cbb93-dfa0-11d3-1374-2e4044ead524@collabora.com> <CACeCKac=WyYZqnP=OqG9CoMWUfJzE=RwE+CtXhAbu7G5gmBfCA@mail.gmail.com>
In-Reply-To: <CACeCKac=WyYZqnP=OqG9CoMWUfJzE=RwE+CtXhAbu7G5gmBfCA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:39:39 -0800
Message-ID: <CACeCKacLSYF_MWqTxidQW5m__vDXSnPVgKttLcLU4X_4xfrJAQ@mail.gmail.com>
Subject: Re: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "open list:PWM SUBSYSTEM" <linux-pwm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Mon, Feb 3, 2020 at 10:26 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> On Mon, Feb 3, 2020 at 7:33 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
> >
> >
> > On 30/1/20 21:31, Prashant Malani wrote:
> > > Convert one existing usage of cros_ec_cmd_xfer_status() to
> > > cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
> > > the EC message struct setup,and is defined in platform/chrome and is
> > > accessible by other modules.
> > >
> > > For the other usage, switch it to using cros_ec_cmd_xfer(), since the
> > > calling functions rely on the result field of the struct cros_ec_command
> > > struct that is used.
> > >
> > > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > > ---
> > >  drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
> > >  1 file changed, 9 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> > > index 89497448d21775..8bf610a6529e7e 100644
> > > --- a/drivers/pwm/pwm-cros-ec.c
> > > +++ b/drivers/pwm/pwm-cros-ec.c
> > > @@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
> > >
> > >  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
> > >  {
> > > -     struct {
> > > -             struct cros_ec_command msg;
> > > -             struct ec_params_pwm_set_duty params;
> > > -     } __packed buf;
> > > -     struct ec_params_pwm_set_duty *params = &buf.params;
> > > -     struct cros_ec_command *msg = &buf.msg;
> > > -
> > > -     memset(&buf, 0, sizeof(buf));
> > > +     struct ec_params_pwm_set_duty params = {0};
> > >
> > > -     msg->version = 0;
> > > -     msg->command = EC_CMD_PWM_SET_DUTY;
> > > -     msg->insize = 0;
> > > -     msg->outsize = sizeof(*params);
> > > -
> > > -     params->duty = duty;
> > > -     params->pwm_type = EC_PWM_TYPE_GENERIC;
> > > -     params->index = index;
> > > +     params.duty = duty;
> > > +     params.pwm_type = EC_PWM_TYPE_GENERIC;
> > > +     params.index = index;
> > >
> > > -     return cros_ec_cmd_xfer_status(ec, msg);
> > > +     return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
> > > +                                 sizeof(params), NULL, 0);
> > >  }
> > >
> > >  static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> > > @@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
> > >       params->pwm_type = EC_PWM_TYPE_GENERIC;
> > >       params->index = index;
> > >
> > > -     ret = cros_ec_cmd_xfer_status(ec, msg);
> > > +     ret = cros_ec_cmd_xfer(ec, msg);
> >
> > Why? There is a good reason we introduced the cros_ec_cmd_xfer_status.
> >
> > IMO the purpose of introduce the new wrapper only makes sense if we can cover
> > _all_ the cases, so we can remove cros_ec_cmd_xfer_status and make
> > cros_ec_cmd_xfer private to cros_ec_proto.
I'm hoping for that too, but as we saw below (and some in some other
drivers), some callers of cros_ec_cmd_xfer() actually use the
msg->result.
Should we change the new wrapper to return the message via a pointer
(if not NULL), so something like this ? :

int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int
version, uint32_t command, void *outdata, unsigned int outsize,
void *indata, unsigned int insize, uint32_t *result) ?

> >
> > Is not possible to use the new wrapper here?
> >
> > >       if (result)
> > >               *result = msg->result;
> >
> > Hmm, I see, that's the problem ...
> >
> > This driver will need a bit of rework but I think could be possible to use the
> > wrapper.
> Yeah, I looked around, and it seems to use msg->result.
> Perhaps we should work on reworking this driver before doing the large
> patch series? I would be happy to work on it, unless you feel there is
> someone else who'd be better suited. Kindly let me know.
> >
> > >       if (ret < 0)
> > >               return ret;
> > > +     else if (msg->result != EC_RES_SUCCESS)
> > > +             return -EPROTO;
> > >
> > >       return resp->duty;
> > >  }
> > >
