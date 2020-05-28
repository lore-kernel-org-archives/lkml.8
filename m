Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE450C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFA9C208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJpSZTSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387676AbgE1KCz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387643AbgE1KCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:02:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7793C08C5C5;
        Thu, 28 May 2020 03:02:52 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c11so30481538ljn.2;
        Thu, 28 May 2020 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I/h3gNMyb53kQmKAThGHtCMjDN3Ct7BvAp2TJgMXdZA=;
        b=WJpSZTSoXxOoQNFiNdn06UQLrPFVP7QspnEg1drKRgsC5f8Nx1hiN8zz9Z2vyNHKdn
         ITNwk3XNuaSbSVUe0EXZEmi7i50HofTw9v+2R5yRgBMmXkDGFGCMvvHubV4yBLyR16GL
         FP4oUpJVYVMfaKfVW8+s4LSpLZlmjsY8fgCxYYsOVDlHHl9nLEQxbl4830z8gHZMMJv/
         AWxk6I60V+gGP8EmM9PChMkBxBbWXuPoaOksra8i9XEzslhMxoX0mhOsZ0a/xgKQEGXx
         P0yYH6cE97WBgGOyrLTF+pXyBYBnlbUWi/+LV910wzbJzzhssmqPUjOrMmj2oIlNc0z9
         nTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I/h3gNMyb53kQmKAThGHtCMjDN3Ct7BvAp2TJgMXdZA=;
        b=j4Ps/OJqUxmG8pzA5WNcmTeeOarQPtRvAUp1RRm65n5zvISJyXhNYlUjRQkiUrTScD
         rQ8RmhKUoZfXSZU0p1hwpXZbSgu9BmFNgQA39tIcxp+tB6T/6/XJ5PGUqUN60W7oHL68
         1ffMYEg6QspVhRVN4pmitpWTrV4kwBrnTK5N+kiqXc0JMCiE2wQFPdbFG0FMNCs6sP6m
         qFm6gcfQbxCCQV3I/ALp6zvaDfMngWIZagS8uXXBbm0q1g7j32wIFw+3kDMiZ85qB4+E
         fVzc1bEdScCPip9NqaQt2vafmrfJQjzryUydToE/SveKHcGvEzN711MEDyOuvXMjtUlg
         CeUQ==
X-Gm-Message-State: AOAM532EaM+zCX9Jk3Ff38vxFx2WfWQT17E6aOL3PHYiITEHdgYd1J2g
        I4KqUBqaOAmRk7Eb+7fR9Q9UbMMAUASvYOcSYbE=
X-Google-Smtp-Source: ABdhPJyZid/lyuqY1E3XF3MpNA5pp/s7NOjWjcLahYBAhDGX3VlzICBAygFi9yx1WwgtsGZ7kz96rCT/FdXyTiDgFzo=
X-Received: by 2002:a2e:711c:: with SMTP id m28mr1088182ljc.104.1590660171385;
 Thu, 28 May 2020 03:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200518004930.20973-1-steves.lee@maximintegrated.com> <20200526223642.GA506893@bogus>
In-Reply-To: <20200526223642.GA506893@bogus>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Thu, 28 May 2020 19:02:38 +0900
Message-ID: <CABff4NR7MJM8VmM_gXnspEh2h+MEwv9WDW_Ra6t_Tv2SjrHSFQ@mail.gmail.com>
Subject: Re: [RESEND][V5 PATCH 1/2] dt-bindings: Added device tree binding for max98390
To:     Rob Herring <robh@kernel.org>
Cc:     Steve Lee <steves.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 7:36 AM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, May 18, 2020 at 09:49:30AM +0900, Steve Lee wrote:
> > Add documentation for DT binding of max98390 amplifier driver.
> >
> > Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> > ---
> >
> >
> > Changed since V4:
> >       * No changes.
> > Changed since V3:
> >       * No changes.
> > Changed since V2:
> >       * No changes.
> > Changed since V1:
> >       * Modified sample text in example
>
> You are obviously sending patches too quickly. Give folks a chance to
> review.

 Thanks for your feedback !.

>
> >
> >  .../devicetree/bindings/sound/max98390.txt    | 26 +++++++++++++++++++
>
> Bindings are now in DT schema format. Please convert this. See
> Documentation/devicetree/writing-schema.rst

 Thanks for review. I will change txt to yaml version.

>
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/max98390.txt
> >
> > diff --git a/Documentation/devicetree/bindings/sound/max98390.txt b/Documentation/devicetree/bindings/sound/max98390.txt
> > new file mode 100644
> > index 000000000000..0ddd4c6ae55e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/max98390.txt
> > @@ -0,0 +1,26 @@
> > +Maxim Integrated MAX98390 Speaker Amplifier
> > +
> > +This device supports I2C.
> > +
> > +Required properties:
> > +
> > + - compatible : "maxim,max98390"
> > +
> > + - reg : the I2C address of the device.
> > +
> > +Optional properties:
> > +
> > +- maxim,temperature_calib
> > +  u32. The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
> > +
> > +- maxim,r0_calib
> > +  u32. This is r0 calibration data which was measured in factory mode.
>
> Unless these are shared already with other Maxim chips, s/_/-/.
>
> > +
> > +Example:
> > +
> > +codec: max98390@38 {
>
> amplifier@38

 I will change example as you advise.

>
> > +     compatible = "maxim,max98390";
> > +     reg = <0x38>;
> > +     maxim,temperature_calib = <1024>;
> > +     maxim,r0_calib = <100232>;
> > +};
> > --
> > 2.17.1
> >
