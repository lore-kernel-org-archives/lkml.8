Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F821C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8DB20659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 19:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNAIVCs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387687AbgEMTiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 15:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733092AbgEMTiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 15:38:14 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F5BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:38:14 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id m24so510855vsq.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ke4uWAP9sQZ5K5ZqcbNueL/vqjGx4KuSfWacNnG9IP8=;
        b=KNAIVCs5xSS7MZJNvGuxgkkkhNsEsO5VSgsdXDdeQrNZCf9D+Sn2/2tSsN24QHNc8p
         AvOTOqWe+sx6il52JIgv4kXuEZRZ0u51yvR7MKLbd9tIyP/Xzg0IqYK18kjhr/kYWe8G
         42W/luCMqYbPVnfkpDJFoAuovJCbFmCn0DUVGtv2AI+0lmnPI1YqLE94SS104mzu4Bjn
         J7x8nTO846CB35bhaKjcdPKDUbf8Oyd0b6uSZ9hhsip1o3y4p9Xj3RyjiOkcm4fR3SZb
         rWElA7JW0rGfwLmbIywb7vTWW//w2WZ3cy/2DbHbqz7sRN8cCVSvbfjnaB4p2AXGG6Ig
         xLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ke4uWAP9sQZ5K5ZqcbNueL/vqjGx4KuSfWacNnG9IP8=;
        b=JcHZhosBT4wFrinJWeEAze50FT+SJs+TZJLIBpW7qyP90gbsoVisKdCm3bl2GFeo6P
         I6dL0b4MJ1C/fUfQqriDaCede/AV8z6AanLZaTf6+t69BlxaSe3543LzGBTeuDFLtInx
         ugJJjipgWxvwjxJUuE9ceWzQ3691VXnAQG8GKCUAxFv7O5yJgknhAMB53QfB47RYqDus
         l/+N7Rytm1nNGLl0Ll58XzkfuaZiqMTSAg3f00C09bJ524Ap6zoOgB+6O8Ri24FULsd0
         DoDfEkTncP5QdJ+QTSxJ8wR39gr37AjdTLqTUaSK8XFdTK1eaBTJ6CfA+RZmTzpSSmmq
         6IEA==
X-Gm-Message-State: AOAM532jgZZcW2nubM89Wy58JdMLrgnwBr5b8xVu7xBoDRX/LBRQMLCQ
        LtVJJqFOUl7Ru5ZeY94aH4B/+MECn2yyjqm7y2I=
X-Google-Smtp-Source: ABdhPJxXY5J5q/rrCCt9ey3fgywEcsxm9dJjt4mAdeE5DwUTG5N/TW670z8VUoUjQ46NKw8Hm0DCwBQ7+Eq+mRYUQ04=
X-Received: by 2002:a67:7f0a:: with SMTP id a10mr669800vsd.147.1589398693723;
 Wed, 13 May 2020 12:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200507212912.599433-1-alexandre.belloni@bootlin.com> <20200513174530.GA32096@animalcreek.com>
In-Reply-To: <20200513174530.GA32096@animalcreek.com>
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date:   Thu, 14 May 2020 01:07:36 +0530
Message-ID: <CAAs3649-3dAmUqjLiEP8Ar3dKamp7ek1o0R5WN3g8kxTgz6fFg@mail.gmail.com>
Subject: Re: [PATCH] greybus: audio: remove unused code
To:     Mark Greer <mgreer@animalcreek.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:15 PM Mark Greer <mgreer@animalcreek.com> wrote:
>
> On Thu, May 07, 2020 at 11:29:11PM +0200, Alexandre Belloni wrote:
> > GREYBUS_AUDIO_MSM8994 is not an existing configuration option and as
> > reported in September 2016, it depends on an "out-of-tree qualcomm audio
> > driver". This driver never made it upstream.
> >
> > https://lore.kernel.org/lkml/20160921073905.GA31263@kroah.com/
> >
> > Moreover, there doesn't seem to be any interest in actually fixing the
> > driver as it uses ASoC APIs that have been removed from the kernel in 2018
> > as shown by its use of snd_soc_register_codec and
> > snd_soc_codec_get_drvdata, removed in commit 999f7f5af8eb ("ASoC: remove
> > Codec related code").
> >
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > ---
Hi Alexandre,

As mentioned in the mail archive referred, the GB Codec driver that is
currently available in kernel tree is dependent on qualcomm audio
driver. And some time later I made some minor modifications to remove
the unnecessary dependencies. However, I missed to share the same with
the community :(

Thanks to you for triggering the thread. Now, I could retrieve my local
changes and I have been in the process of updating it again to make it
compatible with latest kernel.

I'm planning to share the same here in the next few days.  I'll mark you
in CC to seek your review comments as well.

In case, I'm unable to make those changes to the staging tree, I would
also recommend to drop this code. Kindly let me know your opinion.

--
thanks,
./va

>
> Everything you say is true but it is still kinda sad to see this go.
> But that is life...  If and when someone has the motivation to get this
> working again they can take a look at the git history.
>
> Thanks for this, Alexandre.
>
> Acked-by: Mark Greer <mgreer@animalcreek.com>
