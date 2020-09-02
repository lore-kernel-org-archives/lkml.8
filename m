Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5139C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 987872078E
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 11:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jvktss2w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIBLEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 07:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIBLEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 07:04:41 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F69C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 04:04:40 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id y15so1429236uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 04:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hf0PIlZBH2f6tZjqIqPKdTSDxg4ey5IHqqV7o7zs3fA=;
        b=jvktss2wubUFAj/XGva63/p+i21EmUocT+VKMGriS4nO/cV/LZCl8IS0SS4RAI5I1B
         PGSRGdX07J/2Y9ObU8kQKYXMoS2CyQ51/SiA8HmfDEN9bG6zj5ZUQSltN4eQYx5vC305
         jUIYB6t85WIce/eXD6+90KH03m60MDMZHE6SI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hf0PIlZBH2f6tZjqIqPKdTSDxg4ey5IHqqV7o7zs3fA=;
        b=G1h2IOcWOqBIIz5+kgTAaHNtKZem2a3VsA4df5ejQAOBFEvQDUWpic/Lo5W7nQif67
         3dC9qj19zlLKCP02HO0y+r/9UNLXXfBNZkuFLIaGjxStT0XB6r919sgGUYYL6gwk3s+k
         IFnmv7W2c+WuFY3STPqqsxfHBhyi6hLusuySLFcTbvLGsnWKgZxerl0MJLOYq9TQP6KE
         vnCfJaY/DMHKK2CegRimTYZlP/8NL0tHOSYmSJHXXCH5aJs69SVNgbNo+UDi2QmnDBoi
         vgP7zUAfdKojUeqsF9jLEdlIpoeIt88KbvXe/WL3F4soR2n8lB8W+v5sI4b4RAo+o0uY
         4YAw==
X-Gm-Message-State: AOAM531LH1ZqBjmEXZy5A8LmwW0s40FeE2ro428bzIx9QGw8MHDdANAi
        bSAUUFoGeKP83hV3TTjvZo6ITuRtXj0dwUA6h7Ndpg==
X-Google-Smtp-Source: ABdhPJwTAJmdVSE4G5yw+xOM510eJCrk4CeFZ0EVNnIfqJUjO0bPMVj4+uBwlLwieWiC9A5BtacoHnsFLK6H+cR9mhI=
X-Received: by 2002:ab0:1e84:: with SMTP id o4mr4725479uak.74.1599044678604;
 Wed, 02 Sep 2020 04:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <9f4fb922-4aa3-0b63-6d81-c83daefd13b9@web.de>
In-Reply-To: <9f4fb922-4aa3-0b63-6d81-c83daefd13b9@web.de>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 2 Sep 2020 19:04:27 +0800
Message-ID: <CANMq1KBJTpnYG59B1V=y_emqD3dtMZQAPY9bWJOC8FW2fNRgsA@mail.gmail.com>
Subject: Re: [PATCH] rpmsg: Avoid double-free in mtk_rpmsg_register_device()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Pi-Hsun Shih <pihsun@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 5:33 PM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> > If rpmsg_register_device fails, it will call
> > mtk_rpmsg_release_device which already frees mdev.
>
> Can another imperative wording become helpful for the change description?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3D9c7d619be5a002ea29c172df5e=
3c1227c22cbb41#n151

Looking at your posting history, I'll leave it up to the maintainer.

> =E2=80=A6
> > +++ b/drivers/rpmsg/mtk_rpmsg.c
> > @@ -220,10 +220,8 @@  static int mtk_rpmsg_register_device(struct mtk_r=
pmsg_rproc_subdev *mtk_subdev,
> >       rpdev->dev.release =3D mtk_rpmsg_release_device;
> >
> >       ret =3D rpmsg_register_device(rpdev);
> > -     if (ret) {
> > -             kfree(mdev);
> > +     if (ret)
> >               return ret;
> > -     }
> >
> >       return 0;
> >  }
>
>
> * How do you think about to use the following code variant instead?
>
>         return rpmsg_register_device(rpdev);
>
> * Would you like to omit the variable =E2=80=9Cret=E2=80=9D for this func=
tion implementation?

That's a good suggestion, I'll update and send a v2.

>
> Regards,
> Markus
