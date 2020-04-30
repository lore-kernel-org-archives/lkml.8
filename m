Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43353C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BE92074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XMafNpnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD3Oxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgD3Oxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:53:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7119FC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:53:48 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so7270875wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+QmnvA5dChJIrax5V/yu0dUwTA3YT4Rbv3dYKbrlm30=;
        b=XMafNpnqZG9Xdd7UCHcbsV9f2c8cG/AAV3triecqXWg4KtluV8iWCXdtsAyYLBrbtS
         /ymgp1h6s/Ot7N+Pv/6/0QhvJ7iiu4tlLd36OgC0vSAuFTBU6qckF82f6ftOGqJXPKGv
         4b8qCnS8WlMEfblgozRdx1BwqUACDuVSzQa/9KdqBjjkJesUjNtkZKXHEpCeutZ5Dux0
         bjz+gvYSj3qNbOYLsHZ99BVOxxrhkN5XGf3w1ewGboFLGsqOGzbuprjG8Jks8PK1X/Ki
         tePOZILA4bveKNlBTjMy6qWWOdhMAn+FQoGY2VUOLcVhMq8G3yuZ6KrHeaoO2r/bQSMF
         LOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+QmnvA5dChJIrax5V/yu0dUwTA3YT4Rbv3dYKbrlm30=;
        b=KbOvjWXShVR8GROBnPpog5qZJ48DZ11xLihI7j+CI6VoDr5UVMkXKNcgBVlky/PzJ6
         rX/RIIE5jmXkhe5U1PrsMgtYp3LU0gLFx+o217izeybr8usedlJVSDcKd8lDxpoWIe0N
         zznDVqelRGmFLqh+q/t846ntBO9U9/5EnFyHbHIA1oARy+IyLx8Jllv8+bW+UyJiDljS
         MaiU6Lf+rxvjECraoZ34ffsMQ8x72RJiwV3wctiV8xgZRJptYmiTerK0m4Vr8+TGAC/T
         7UBkU4SyBw6DFD3Z/UqaZivlFh57YulKS4us3Wan4OE4PJYfjf6ZE/rs3g/DlzO4EYX2
         QGaQ==
X-Gm-Message-State: AGi0PuamPyQF2tlPNjzFXNbW68LbiVydmIuw0u/D0jsg21oBi8PUhHRI
        ymr2xD38b+Y49lCzjp/gEZrusOXN6XUBYBu/+Kw=
X-Google-Smtp-Source: APiQypKPNxr+JrUQbiF77qrXpEEmom/FKCXB3JuYSzSBbLwlnR1j6K3W+ykUs0PMmTzo2G0I3AwwMK53JhmZEivp4kM=
X-Received: by 2002:adf:f844:: with SMTP id d4mr4292599wrq.362.1588258427244;
 Thu, 30 Apr 2020 07:53:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200426131244.22293-1-bernard@vivo.com> <2c67e29b-df17-6ae3-cb55-af950acc022c@amd.com>
In-Reply-To: <2c67e29b-df17-6ae3-cb55-af950acc022c@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 30 Apr 2020 10:53:35 -0400
Message-ID: <CADnq5_M-pZoFXeeULweXGkzDEvbBjoKm1ZBqAwn0S3J7iM18TA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: cleanup coding style a bit
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Sun, Apr 26, 2020 at 9:18 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 26.04.20 um 15:12 schrieb Bernard Zhao:
> > Maybe no need to check ws before kmalloc, kmalloc will check
> > itself, kmalloc`s logic is if ptr is NULL, kmalloc will just
> > return
> >
> > Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> I'm wondering why the automated scripts haven't found that one before.
>
> > ---
> >   drivers/gpu/drm/radeon/atom.c | 3 +--
> >   1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/ato=
m.c
> > index 2c27627b6659..f15b20da5315 100644
> > --- a/drivers/gpu/drm/radeon/atom.c
> > +++ b/drivers/gpu/drm/radeon/atom.c
> > @@ -1211,8 +1211,7 @@ static int atom_execute_table_locked(struct atom_=
context *ctx, int index, uint32
> >       SDEBUG("<<\n");
> >
> >   free:
> > -     if (ws)
> > -             kfree(ectx.ws);
> > +     kfree(ectx.ws);
> >       return ret;
> >   }
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
