Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E377C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5662620714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 08:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BYn6G5G3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgELI3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 04:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729174AbgELI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 04:29:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B1CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:29:02 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j5so14243823wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 01:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CLwgn00j3cccENKknkxTYm+dTCnpuQMyc2nOwSHSj2c=;
        b=BYn6G5G3mtGsIR1q4yA4kFS7gfXpBHHdZKx0VJK7nrUiNtfFh+DdPFXdeAXqIZvVDv
         v0PgNgzR4GT8M52jE89yjyq94Q62WiavRzf0MTRQgnu0uJbfVVCLlPY/JVLeo33RV7j9
         HBq3nfoDVTq7kErmLaSWtEpPMXkVZkcLD2+OHGVEeVKJppnkAW6Z4U6xU/Nh1x/yWenb
         MQylVsHkc79+ixLtUnYaOMMSzQZhVr3XrGvWnCefe37GJAxHKcYxhkjCCBSMiXXlzZ2y
         CKWAeixz+8wDaMHk3ppW6gRgFeVBXo/XCvEWzOBxMPeQDHO64hnF7wpRSx/0m9UW6cIa
         RxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CLwgn00j3cccENKknkxTYm+dTCnpuQMyc2nOwSHSj2c=;
        b=oy5/KFsAdfqaRz6Nn6+J/mv/kcMQSF20xLG07hXqWlaNqDjVOEbHKkq5oPzBYOSDFQ
         0CaRTD/T/MXuQmTAjh48dYYcbQy2tujBZ7jnp26zq8o8WHsYH18DCpj1/29hIivwTK3/
         xkHE30BWnjL3h5i32Y1PZ7JQZ7IEcl4lM7JGky7yVJ+xfSj65yJAmwdIWldYDUITBAl9
         cYzt2YBG3+GyaartnFdcItt67nTyYsBZBzZY1lQb+ulspMNC648rEBsVrDiJU0QQTtlt
         v7Q4f9n3pQq+3d3yWffCBguXGieFPij8/2cbTcgis/vjyyEc2F9e2sYa7W4dHpeRWwzq
         ResA==
X-Gm-Message-State: AGi0PuYmcBBi9DN8ZP+IS49h+89OVfpJTudJL29BKuWyVB7VYPUwnUap
        EUzIG96BwwQT5+/ebf+0BWRra7dXkv4JYDguaCA=
X-Google-Smtp-Source: APiQypKiw4ztGscW4TPsTbkxd70wqekjLwotcF9sLjfkoh2+IyKcOT4dTgbQuhjEHTTRs0ceruxRG49EoxIeiRErzTc=
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr23375923wrg.196.1589272141413;
 Tue, 12 May 2020 01:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200508091340.11711-1-zhang.lyra@gmail.com> <20200511164647.GA13202@xps15>
In-Reply-To: <20200511164647.GA13202@xps15>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 12 May 2020 16:28:25 +0800
Message-ID: <CAAfSe-v4h4p5bGPrTo3U+GxNGMxK78ZKK-L=Eiyb=Fnq+Do9Ng@mail.gmail.com>
Subject: Re: [PATCH] coresight: tmc: mark coresight_tmc_groups with static
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 May 2020 at 00:46, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Hi Chunyan,
>
> On Fri, May 08, 2020 at 05:13:40PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Sparse reports a warning like:
> > drivers/hwtracing/coresight/coresight-tmc.c:364:30: warning: symbol
> > 'coresight_tmc_groups' was not declared. Should it be static? [sparse]
> >
> > coresight_tmc_groups is used in the local file only, so it should be
> > marked with static.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-tmc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtr=
acing/coresight/coresight-tmc.c
> > index 1cf82fa..39fba1d 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> > @@ -361,7 +361,7 @@ static ssize_t buffer_size_store(struct device *dev=
,
> >       .name =3D "mgmt",
> >  };
> >
> > -const struct attribute_group *coresight_tmc_groups[] =3D {
> > +static const struct attribute_group *coresight_tmc_groups[] =3D {
>
> This has already been addressed by Stephen [1] earlier in this cycle.  It=
 is
> currently in linux-next and will be submitted for inclusion in the next c=
ycle.
>
> Thanks,
> Mathieu
>
> [1]. https://www.spinics.net/lists/arm-kernel/msg801714.html

It is better, I will backport this patch=E3=80=82

Thanks Mathieu=EF=BC=81

>
> >       &coresight_tmc_group,
> >       &coresight_tmc_mgmt_group,
> >       NULL,
> > --
> > 1.9.1
> >
