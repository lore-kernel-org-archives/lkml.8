Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAF7C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7F6F2072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OL8/7Nzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCESgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:36:31 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:46013 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCESgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:36:31 -0500
Received: by mail-io1-f66.google.com with SMTP id w9so7562092iob.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mrKnuKdMvP4X7ZBG8bgBLmZOKarwJfZtHOJKCgxv4cY=;
        b=OL8/7Nzmih2KKFE4RC52LQULBl5+wCOilEaFZmRZG4knfnM2uqJmM/TALAQyfEQetB
         1VizdjRVZft8JaQ3zu450iaFyYKD30QiObuvgzHcL/s2O3eG0/1G671jWTpnqN6UoqXx
         wDgPmlpVyGW5uj/zaZxVzRXKTgdl+R8Jml9rhwgX9tNI4bQAoKbpxKa/u6yeg7Z5NLr8
         brVXvdVdBkLzAMzYVoLoJ9jrCSkcutvcsXl52bFHdp9k5mGlMmU6mZAFW8GWUt6VkM9+
         aSgaUmn1NdTwljsj0s1yltk9VTxezp9AtVYS92rmnZREaO/rD8c3duJPqMJNS8TTKrWD
         OsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mrKnuKdMvP4X7ZBG8bgBLmZOKarwJfZtHOJKCgxv4cY=;
        b=rsk6qRoF1fNBxnr15X9htiaINzr4fJZQvNPo2xI+RkamFwU0vlumi8BA+THCc5GIFs
         KZC7Lelxh6ewIL98EHCWnCH/HinOX9zn8k3gFyX2tXwQ7kS0+xxxSumhOQjYIXX0J4Lu
         b7OOee4lsmU3Ntbgma4kkhjxbLgq9vgGiqfM4d7NJ3LbxivwOHeEbh9KRYE4rvXcHs+f
         G8KlXzDyj22z2C3Sxn8akae3uHEet1g5Rum+pCZueA5/+Y8HdJ7fLWoSgEMSElKFvg6T
         uDWUmQdVzJex4JoNxoz1lOpq85z9B5v6lKMIa1lmAAnYuCyB1JnpLX/sJwG+FVQ53PBq
         PNNA==
X-Gm-Message-State: ANhLgQ1sgh9FxUi9gX/+3JC5rDLe0D/iKT3ukS27epJqPJJi/k/S9VP0
        q4tYxbQhlt8ZSqHnEjwmcE1ZXyt4WHl9/z2M+o3B3Q==
X-Google-Smtp-Source: ADFU+vuDOioOoFAW5W7R6s++eKhLCLBQi6Mc0cGqhEYuT14UAxXAJS/UWMFmyHl2gev0naSQUePQQBho/wd5WIAIcxg=
X-Received: by 2002:a05:6638:44a:: with SMTP id r10mr8592498jap.36.1583433390580;
 Thu, 05 Mar 2020 10:36:30 -0800 (PST)
MIME-Version: 1.0
References: <20200304142628.8471-1-NShubin@topcon.com> <CANLsYkzPROdphvmtpZ6YiajZ2dYLrojC-rGYkq4jK2yzTnAJ5A@mail.gmail.com>
 <264561583429111@sas1-438a02fc058e.qloud-c.yandex.net> <CANLsYkxj=1o8Y0V0WedbVirj9seZSArWeCvQvwk+N7wZa2_hPQ@mail.gmail.com>
 <266371583430956@iva3-67f911cb3a01.qloud-c.yandex.net>
In-Reply-To: <266371583430956@iva3-67f911cb3a01.qloud-c.yandex.net>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 5 Mar 2020 11:36:19 -0700
Message-ID: <CANLsYkyHaZFrCYFxWZVGqy=QwU86i2E2o9ENZ7k2mv70jU9pqg@mail.gmail.com>
Subject: Re: [PATCH 1/2] remoteproc: imx_rproc: dummy kick method
To:     nikita.shubin@maquefel.me
Cc:     Nikita Shubin <nshubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020 at 11:07, <nikita.shubin@maquefel.me> wrote:
>
>
>
> 05.03.2020, 20:54, "Mathieu Poirier" <mathieu.poirier@linaro.org>:
> > On Thu, 5 Mar 2020 at 10:29, <nikita.shubin@maquefel.me> wrote:
> >>  05.03.2020, 19:17, "Mathieu Poirier" <mathieu.poirier@linaro.org>:
> >>  > On Wed, 4 Mar 2020 at 07:25, Nikita Shubin <NShubin@topcon.com> wrote:
> >>  >> add kick method that does nothing, to avoid errors in rproc_virtio_notify.
> >>  >>
> >>  >> Signed-off-by: Nikita Shubin <NShubin@topcon.com>
> >>  >> ---
> >>  >> drivers/remoteproc/imx_rproc.c | 6 ++++++
> >>  >> 1 file changed, 6 insertions(+)
> >>  >>
> >>  >> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> >>  >> index 3e72b6f38d4b..796b6b86550a 100644
> >>  >> --- a/drivers/remoteproc/imx_rproc.c
> >>  >> +++ b/drivers/remoteproc/imx_rproc.c
> >>  >> @@ -240,9 +240,15 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
> >>  >> return va;
> >>  >> }
> >>  >>
> >>  >> +static void imx_rproc_kick(struct rproc *rproc, int vqid)
> >>  >> +{
> >>  >> +
> >>  >> +}
> >>  >> +
> >>  >
> >>  > If rproc::kick() is empty, how does the MCU know there is packets to
> >>  > fetch in the virtio queues?
> >>
> >>  Well, of course it doesn't i understand this perfectly - just following documentation citing:
> >>
> >>  | Every remoteproc implementation should at least provide the ->start and ->stop
> >>  | handlers. If rpmsg/virtio functionality is also desired, then the ->kick handler
> >>  | should be provided as well.
> >>
> >>  But i as i mentioned in "remoteproc: Fix NULL pointer dereference in rproc_virtio_notify" kick method will be called if
> >>  "resource_table exists in firmware and has "Virtio device entry" defined" anyway, the imx_rproc is not in control of what
> >>  exactly it is booting, so such situation can occur.
> >
> > If I understand correctly, the MCU can boot images that have a virtio
> > device in its resource table and still do useful work even if the
> > virtio device/rpmsg bus can't be setup - is this correct?
>
> Yes, this assumption is correct.
>
> Despite this situation is not i desire at all - such thing can happen.
> I am currently using co-proc as a realtime part of UGV control,
> so it must immediately stop the engines, if not provided with navigational information.
>
> The imx7d MCU have access to the most periphery that have the main processor.
>
> Of course the kick method should do real work, but i decided to submit step by step if i am allowed to do so.

Ok, the situation is clearer now and I have put your patches back in
my queue.  I am seriously back-logged at this time so it will take a
little while before I get to them.

>
> >
> > Thanks,
> > Mathieu
> >
> >>  >
> >>  >> static const struct rproc_ops imx_rproc_ops = {
> >>  >> .start = imx_rproc_start,
> >>  >> .stop = imx_rproc_stop,
> >>  >> + .kick = imx_rproc_kick,
> >>  >> .da_to_va = imx_rproc_da_to_va,
> >>  >> };
> >>  >>
> >>  >> --
> >>  >> 2.24.1
