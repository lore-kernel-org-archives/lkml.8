Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6594DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A53920768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL59yrrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgHKQqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgHKQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:46:20 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BF0C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:46:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id c10so1740226pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SoICVdOMd4Tqpxtq18KsD1itKSO8FUEzkBoLmDLhcow=;
        b=eL59yrrKsyb0bsSfO3YV1+l0ncnOX5D2/Xs4WFvonsn6PtwdynBeH0itxm3ElutGeX
         6q6tMvyaS0XtiDqlf1UQZbzfYUPzs+EMK0WoC+iVkOEBe/pSQbogzNeP7ZmPfdPNEu22
         LU2fNVL/yrUDiiZdpwdvIp0dM76FFcohMMTga2kvbUbFlwcYjCp6jrMEEcw3BREARxUQ
         DDPPmnYQ5+gNk5ZXw33oKflrz2xRCFnqaUx9P2Lw5zHc/UkAfeCAESRIoKZDUZhb65WX
         EifOA4elfaADtXvvtigldX2Ps4CGF4lLUh+m8PV+5KK79F5/IZOVOnnWnZaZRudo4RQc
         6RQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SoICVdOMd4Tqpxtq18KsD1itKSO8FUEzkBoLmDLhcow=;
        b=Ow7qJVV+S5AB2/NCCbj1uHBsNCh+NfE/1uMYRtbWxyoDPGJdtE8+CwW53DuxyLR/yM
         4dspUpPZ9XPxfskAnoDJLPFqIl9TXU9rjbxEb8HsMQrFbd9SvyuvatU/Xps208NCJkrK
         SzsWMEMdMlX6km6kxfbhTs30d8Mycdg71latVPWBQRyAsdT31+uepHNfYGIpdbSVyzCu
         oK+hkKiGYk07BfUfkW9VA3EAmEOgEKGduTRXWeZyB7Rj+cDvisLVjdhL3yNCin3MVXVQ
         /Q1T6xbP0sNqSsaZsw80VDagY9XD0tXfjH5lOGcURnH+uTJoDITd9mCnxJ+isLre2Fbd
         Nyyg==
X-Gm-Message-State: AOAM533khM7YPMdcbLxIGSnTZnamAgq+bHcxU/doTb/GxWjU998LnLqG
        33GZKWm/yO0xNJ+Y9xpOaxAjy46ZTlF17WUMdShqSw8fwhU=
X-Google-Smtp-Source: ABdhPJyEIOzjg18QmQ+dOADWbUqwbtJr18f5lR5OziHFc0pyu8YJaX9K7YoLYsGzJYyelYQz3gnZJ7hJy2SKUsGpMbg=
X-Received: by 2002:a17:90a:4f45:: with SMTP id w5mr1974736pjl.11.1597164379902;
 Tue, 11 Aug 2020 09:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <a5d4bb540e606d7980d4127a82e6af9b436e0642.1596730667.git.vaibhav.sr@gmail.com>
 <20200810150356.GL1793@kadam>
In-Reply-To: <20200810150356.GL1793@kadam>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Tue, 11 Aug 2020 22:15:42 +0530
Message-ID: <CAAs3649URK20TyU=EpfoY9ow-fK6jSjP1214KTPnUUU_t2d-7g@mail.gmail.com>
Subject: Re: [PATCH v1] staging: greybus: audio: fix uninitialized value issue
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        Colin Ian King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 8:34 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Aug 06, 2020 at 09:51:57PM +0530, Vaibhav Agarwal wrote:
> > diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> > index 2f9fdbdcd547..4b914d0edef2 100644
> > --- a/drivers/staging/greybus/audio_topology.c
> > +++ b/drivers/staging/greybus/audio_topology.c
> > @@ -456,6 +456,13 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
> >       val = ucontrol->value.integer.value[0] & mask;
> >       connect = !!val;
> >
> > +     ret = gb_pm_runtime_get_sync(bundle);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = gb_audio_gb_get_control(module->mgmt_connection, data->ctl_id,
> > +                                   GB_AUDIO_INVALID_INDEX, &gbvalue);
>
>
> We need to check "ret" after this.

Oops, my bad. Thanks Dan for reporting this. I'll share an updated patch soon.

--
regards,
vaibhav
>
> > +
> >       /* update ucontrol */
> >       if (gbvalue.value.integer_value[0] != val) {
> >               for (wi = 0; wi < wlist->num_widgets; wi++) {
> > @@ -466,16 +473,10 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
>
> regards,
> dan carpenter
>
