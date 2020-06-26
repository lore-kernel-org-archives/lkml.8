Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EC5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EADD92053B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W1jKttVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgFZQBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgFZQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:01:55 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E43FC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:01:55 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id cm23so5125869pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vBgkqduIoiDQZRNDloYMKFR5pMrC2D5+LBXw6ASMqtY=;
        b=W1jKttVPL03wpCJ++3iirIT+cOM26MtJz9eUZ+i67X8bip7EOCdRedzXBiRA9/OtmW
         FmnrPd6Nny84NKa8adb+stMBy3NIisy09LOb2Cj4+OD0kFzlvZzzJTwrE4VPNDjSqGtU
         HYOhsV03kmPz+99JvNj2a8EnGSIVb4eVQ9CYc2kUTLPLZcQp9nu26kK0xltSl/34pUA7
         TfgV7Y39VZNN0BCrGMNxVifXIbEA1kQjVVn8rL+jXfwC7MfC3yb4JgqWwmWmsliOhOR7
         h91mzrK5vefVAh8EMRnp/pdGn+rFtPwqzUvYa2X8ibuMmKTCHz7fOC45DnguhQ0ovomi
         WqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vBgkqduIoiDQZRNDloYMKFR5pMrC2D5+LBXw6ASMqtY=;
        b=GcojPm1Ry6UbYhNxlWzJC61tC+9bxQ+TYL2gzW5B2qs9yKrAyBejJyNK9jVgmRTeID
         yuQa6z4+Z2q9aSZjItwiP5X161TwpYyTEDhm/D+2fol+LNLJTjlWKG22+lpSvEyNpuFj
         r+iXdHXaB+YXVvzMWowTXlhK8+aW/4MJ8sWSausWmO5FaHIL/ncQ8bIPMSv4uI90ztNE
         AGD8cXZu4u1GuxorMju1spfwp3T/ALLy6G7dLqEdeMHLR7A5KOxxXvMyL/XxrvH0rLZp
         FmMV4nC9UvlAU+vQwXw3ClH1/IHTh07d1fnLx7WrYlVsnN6FZ71+w6OSewq7JTOz4EhT
         mnQQ==
X-Gm-Message-State: AOAM530IV1/y9uHVU7d8C3aBxY+KsHncxCzxbNXHVEtP7UnuAIi8Qens
        7PsAavSmPYrscq9r5AEaDlXrb1M8oWfwOFlZvVzllg==
X-Google-Smtp-Source: ABdhPJxkiPXrluqrBWIu4mY6uZkpSof8v3c++Qmb2CLS7MHUUudwY3FZPgMNdRU5M8k1eA9Q4ZLX1g+RQlGoP8VnLPw=
X-Received: by 2002:a17:90a:ff0c:: with SMTP id ce12mr3517668pjb.100.1593187314284;
 Fri, 26 Jun 2020 09:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200523031608.17918-1-wu000273@umn.edu> <8d81a91b-4c1d-d0e1-60d0-a68f6ef65bd0@collabora.com>
In-Reply-To: <8d81a91b-4c1d-d0e1-60d0-a68f6ef65bd0@collabora.com>
From:   Mat King <mathewk@google.com>
Date:   Fri, 26 Jun 2020 10:01:43 -0600
Message-ID: <CAL_quvRZ9jiDxsRsVjXnU3VdT7C3MUsnm+=M+j6JhoV9d_ntCQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix a double-unlock issue
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     wu000273@umn.edu, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kjlu@umn.edu, Jett Rink <jettrink@chromium.org>,
        Mathew King <mathewk@chromium.org>,
        Enrico Granata <egranata@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 2:26 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Qiushi,
>
> Thank you for your patch.
>
> On 23/5/20 5:16, wu000273@umn.edu wrote:
> > From: Qiushi Wu <wu000273@umn.edu>
> >
> > In function cros_ec_ishtp_probe(), "up_write" is already called
> > before function "cros_ec_dev_init". But "up_write" will be called
> > again after the calling of the function "cros_ec_dev_init" failed.
> > Thus add a call of the function =E2=80=9Cdown_write=E2=80=9D in this if=
 branch
> > for the completion of the exception handling.
> >
> > Fixes: 26a14267aff2 ("platform/chrome: Add ChromeOS EC ISHTP driver")
> > Signed-off-by: Qiushi Wu <wu000273@umn.edu>
Tested-by: Mathew King <mathewk@chromium.org>
Signed-off-by: Mathew King <mathewk@chromium.org>

>
> The change looks good to me, but I'd like someone having the hardware giv=
ing a
> Tested-by tag, so cc'ing some chromeos people. They must be also interest=
ed on
> backport this patch.

Tested on a device with ish based cros EC. Looks good to me.
>
> > ---
> >  drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform=
/chrome/cros_ec_ishtp.c
> > index 93a71e93a2f1..41d60af618c9 100644
> > --- a/drivers/platform/chrome/cros_ec_ishtp.c
> > +++ b/drivers/platform/chrome/cros_ec_ishtp.c
> > @@ -660,8 +660,10 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_dev=
ice *cl_device)
> >
> >       /* Register croc_ec_dev mfd */
> >       rv =3D cros_ec_dev_init(client_data);
> > -     if (rv)
> > +     if (rv) {
> > +             down_write(&init_lock);
> >               goto end_cros_ec_dev_init_error;
> > +     }
> >
> >       return 0;
> >
> >
