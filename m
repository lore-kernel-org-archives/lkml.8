Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1065AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE5852065E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7opUyK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGWUl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:41:29 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059F8C0619D3;
        Thu, 23 Jul 2020 13:41:28 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so5846252wro.2;
        Thu, 23 Jul 2020 13:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DEHuwTmHfM6jPX2Oo9IcWySJbO6MovJApsAE0g9jcS4=;
        b=l7opUyK3fCQXpJQKsFzCdaoNL0cpR9THAbku/w3qFpjV6KsgCq2dVnfO/5qDyydF3o
         RcW/CUT4UJIoZLxqro8XjYrE8YDayx0FVHCuVUzLhUr/dU0ewNklXcCBo9/xeY8FQv7A
         wCFCbG4WGkrgNQQqJqVM0jll1OrQiLx7NPo9dAbNnEzS2mh3kaQyIU99lrY+eTCGd/LD
         OXD+Hl1+Wr9u5gsO0d7jqG/oozWm4ro9rSvQ/TMfhEAIMJy6adLTzssgjAStjStD8K+4
         0o8al43yK1CPPk0JMDGrUowYcNnIOoVEGPAy6da/LWfhf1DISsWr66uQNhAPFdTXeWNA
         a4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DEHuwTmHfM6jPX2Oo9IcWySJbO6MovJApsAE0g9jcS4=;
        b=TCEi2nZ0XTRdmLBTmIa+0RTO73T8fr3Ohc+n0ywji0xAD/exKpbdNNxwR4/J7PzTqf
         scrkDCS2pY3pXoH2iYO4l02eBK6Cb5qFxd3HWzuDrYpNIqtpFTj2qoofkTaCXTVKXtX9
         ahSe3qJkJ/o7GlLIF53yRxhBua30oVCybNtm0tIT3ZeGFKogjXMmePz9tthvQvAxvpBM
         4XwGxK1L5+1gMMgj0FaTFkqci/dQgsBI4TK0kcSjVxSvOuyUtE/Fc51LUySnQgdKfHrE
         iCZydhgmPZmoGIGHzaH1is4Z2ZvUJqZqplFU4sKFKz/jE62FRU6U4aaK3mot3J+FjVRS
         X2VQ==
X-Gm-Message-State: AOAM53389Fr0t25t/g3NDbh1/NyOj2LkUWh5S0ujzBb+SYaxpsV6W7+9
        PVRxFtXvxQGIpOLJqnXhKFrbI/whaXLmOPLMT5I=
X-Google-Smtp-Source: ABdhPJwe2QpV4/JnbT/qj55tsLIxV0aWuNlNbtPgiz9hklOpzxMRpvjqQpO8ycTfm3THOAE1PJq4Bv+wkd8+sOYcLhU=
X-Received: by 2002:a5d:464e:: with SMTP id j14mr5571416wrs.361.1595536887627;
 Thu, 23 Jul 2020 13:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com> <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus> <20200723195755.GV3428@piout.net>
In-Reply-To: <20200723195755.GV3428@piout.net>
From:   Miguel Borges de Freitas <miguelborgesdefreitas@gmail.com>
Date:   Thu, 23 Jul 2020 21:41:16 +0100
Message-ID: <CAC4G8N7Agb6pVVv6x9_pMMxkB9HnCFiaaC6EJb4-MNzEPd0Uhw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rob Herring <robh@kernel.org>, a.zummo@towertech.it,
        baruch@tkos.co.il, linux@armlinux.org.uk, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

Having a way to dynamically change the configuration would definitely
be helpful in most cases. I decided to go with a DT property because
in the case this patch tries to solve (the cubox-i) there isn't simply
any other option - the default mode won't work due to the missing hw
components. So, I thought that by defining it as a DT property it
could somehow be locked to the hardware definition.
Keep me posted

Regards

PS: Sorry for the second message, forgot to disable html and the
message couldn't be delivered to all recipients.

Alexandre Belloni <alexandre.belloni@bootlin.com> escreveu no dia
quinta, 23/07/2020 =C3=A0(s) 20:57:
>

> >
> > I'm all for common properties, but is this common across vendors?
> >
>
> This is but this shouldn't be a DT property as it has to be changed
> dynamically. I'm working on an ioctl interface to change this
> configuration.
>
>
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
