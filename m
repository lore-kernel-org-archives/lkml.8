Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C13C20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:54:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hBbGeGzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbgFVQyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729648AbgFVQyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:54:17 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABAC061796
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:54:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so13165287qtg.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U2Loxh0UBGoStu/YgkMRO85TtEfjsm65VCNYI1DGVpM=;
        b=hBbGeGzLTLBinyYmygP0QeLy0oQ2I6xRNrZUWldovLttIo6FHiqlFsCCneBCMwtu3b
         l+eesx3TqWWgSxl13iviJuwhWHwKLTn7AY8Is2/HdRql4/bKOtAaDyhKU0pudfhGb6hf
         vOBncZGzqJGUBX98xFFLXxeGqf8B1bZUTWawV79agKnkyFxjCy7Rx/4ZFOGzWsLkvJBY
         MlXWlf6wngLFVkq5RHRa/cCd2QQpyoaItKpMgrtNyi7xkZUfsovspyvQo28R97Guf7cf
         bz3cKl0CGfDrGP+HCW1T48Xk7Iz2QCCeVukYl1g3hzCWecOtEngG3CyZhXIMQPya+XkI
         S9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U2Loxh0UBGoStu/YgkMRO85TtEfjsm65VCNYI1DGVpM=;
        b=dK/QRn4cEyxXOxljg/IUhD6WswOd/TQdlBGzfNr0DMbJlRySwrr2oXiTZvEB/dQBdf
         51oIchZtpzScFsVVgi9p8FOz19XN4E+s4kh/1aMeISlHl4aREgasLofpx6PNgpWuSvaa
         hRZSE9GAXAS6J1ByRdwgv0jjKup0RzJMixuxG3kQOr/jGAkmDPWWic/jJa90BsVgbR4b
         d37jxAPY5z881iSCQD5QqiTUqP2mHUxPZ74/nLuY2UrDA4KgYPi1+QNkrUcqVLy0EXv2
         Y6vGmoz/5M0tTlpzuVCiUXUyv1wpGX6Ded4iDH9GXm8sz8ZRGchOkP25sUcHGXRR4SFY
         d/TA==
X-Gm-Message-State: AOAM531//SBa3z6EAlElKd32L+sxweqWz+LZM2CiqS5fEjZZsNy6txHk
        rogkxnJxCC/FU6p805MfJI4j705xbixtUpsV3zuigA==
X-Google-Smtp-Source: ABdhPJxJRkNoCJbxm2I4k4r24isKwYxnzf+6aabgXu/eybkXHa83zMm5fzbIxRLx/cTRNHny+hAKtkEMW1qPcyf1Vm0=
X-Received: by 2002:ac8:23fb:: with SMTP id r56mr17439684qtr.197.1592844856891;
 Mon, 22 Jun 2020 09:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXHT9y09L19j2K=oQ1W+7x=SE7MEyjj6r1i=DPcokvWzg@mail.gmail.com>
 <20200617074023.30356-1-navid.emamdoost@gmail.com> <CAMuHMdULgdhgoydX-nnVSyCEBd4zkCgSyVZ+ojFzGM0gky6OJQ@mail.gmail.com>
In-Reply-To: <CAMuHMdULgdhgoydX-nnVSyCEBd4zkCgSyVZ+ojFzGM0gky6OJQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 22 Jun 2020 18:54:06 +0200
Message-ID: <CAMpxmJXV-Ujx2zgXxiYWOED2CYz_89aAiUUiqak1JbtNJKgSFg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: rcar: handle pm_runtime_get_sync failure case
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>,
        Qiushi Wu <wu000273@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        mccamant@cs.umn.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 17 cze 2020 o 09:43 Geert Uytterhoeven <geert@linux-m68k.org> nap=
isa=C5=82(a):
>
> On Wed, Jun 17, 2020 at 9:40 AM Navid Emamdoost
> <navid.emamdoost@gmail.com> wrote:
> > Calling pm_runtime_get_sync increments the counter even in case of
> > failure, causing incorrect ref count. Call pm_runtime_put if
> > pm_runtime_get_sync fails.
> >
> > Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>

Is this stable material?

Bart
