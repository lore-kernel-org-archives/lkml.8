Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B67C83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDC41206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc8uD1mS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgD1JmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726486AbgD1JmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:42:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1BAC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:42:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f11so16155387ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 02:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WT6mF0IwJRAWJibfVj6jkV3JG6t831H/TM7wsxX5kmk=;
        b=Oc8uD1mS503FcEMlkUqEA6u5te4rKpMM/UsnhiU+pzKrxq6vCg8ReWomPx9ySZjDJr
         +Upu1NQfJO+9N/qO+diiboHKlAuEJqt9aZ34HX/ZsPFxm7O5vOSC3B8Rwi2sfl2TcR45
         oq9TMx8Y30Anq/gkwzDocYWGUdVgj9/lmWha+za55Aoq9wVaZP22v4DdjzkOAP0plN1V
         KumbSL9f451cSixc4MIxZOBdo+1+k+YAMuF1d2Svjh8djlHUICTmr/SGlky8XOl49+Cb
         Pf1WGvOF+fGJjYSzYy2u403Vg+4dsi6C5uSxe2QqlhAJlD48Vqs+BiUvJuRW0EFZ7g3H
         VMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WT6mF0IwJRAWJibfVj6jkV3JG6t831H/TM7wsxX5kmk=;
        b=NBZM/bFcdcnnvuukg/NvgpGF1wJIcAz72KscIXie20g1bGm6AJgNJbOu72pvlPxbCy
         wT+YTB7T3ri/7EfF0vmI+kzAQg1kLkxh0T6REd+5br1PcKBEE8IScZ0k5aLdaZFIjCLN
         7mjg0Ex5gW6PnAd8hVSTypQpxyxhJgxXqELLVvQ9fnegCK13hcBHfRQAe2fiEJjVPKP0
         oTDHby9vSfAd8/mzO3sF4cNLXK9QPhJF6nK/SjxF739LmgcK1VkSgZDVlehk4ACF/chN
         ev5FA/CcFCUE+x+6wl4P8A/AkBhksR+Ne2uQ5wDDj+5AIdKkyFqLuT9uAVHNvNAD7T18
         4PvQ==
X-Gm-Message-State: AGi0PuZANLwvmMrMJWrpGElCQsFbgYsR73i3dsi2Uc8X8ifQ8Vr++0Cl
        fEsqSn/GJiRH9bNX0j8IJKh2+uuSyxJnPhLpzJJHRQ==
X-Google-Smtp-Source: APiQypJWdiCBwLqc2g8Irmc7/w41rf19eHaus5+KTPDZiZJ8NEqF3rSuv3WOFk23DG+Abnjohh4H216Y6yGgj84RaY4=
X-Received: by 2002:a2e:2ac2:: with SMTP id q185mr8261669ljq.125.1588066924774;
 Tue, 28 Apr 2020 02:42:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200417073455.42146-1-yanaijie@huawei.com>
In-Reply-To: <20200417073455.42146-1-yanaijie@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Apr 2020 11:41:53 +0200
Message-ID: <CACRpkdZv4W3LVxRqDx2EaqATW7a-dhZeDjzoa2iQu+dDtpkfww@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: ab8505: remove unused 'gpio50_a_1_pins'
To:     Jason Yan <yanaijie@huawei.com>,
        Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:08 AM Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following gcc warning:
>
> drivers/pinctrl/nomadik/pinctrl-ab8505.c:137:23: warning:
> =E2=80=98gpio50_a_1_pins=E2=80=99 defined but not used [-Wunused-const-va=
riable=3D]
>  static const unsigned gpio50_a_1_pins[] =3D { AB8505_PIN_L4 };
>                        ^~~~~~~~~~~~~~~
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

This should not be deleted, it should be used. I will send an alternative
patch with you as Reported-by.

Yours,
Linus Walleij
