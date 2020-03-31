Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA4FC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4103F206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dgw72UMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbgCaNyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:54:02 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46307 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730216AbgCaNyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:54:02 -0400
Received: by mail-pl1-f193.google.com with SMTP id s23so8132796plq.13;
        Tue, 31 Mar 2020 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eh6HoD2WSOyoYld2ZBtCaKD/ZdY+NnuzhftXLHQtZcw=;
        b=Dgw72UMDYMek1J2mctOS59XCDcB+nQhKYfiTsgobYLQQ/vLuKHZCFx0RPHCeMNyGbS
         Fi9isGEufr3h4mqnpBvzdn85v8BiVplFmzR5ZZcaj/wCP7Mfz2rzyWM6EF8hRUAii4Up
         y10n0nsI2JxhTh1CHtzZJ1lSTO4m9dX4FmyMqRfcZhqEJ+g2D2ELqMcwuuM+TAkrHO3A
         rwTi8VI6ODuCooHh5/C/tD9lNjEhUi2CaJKckqPOHtppSHh5u0iBrJ95thbEnn752HvZ
         EMq/d95XbBuGOuvENOO8q/iGoAhUQrvVcJaFnWgMqAbJ0lHgjZyYhnMABjdbMhdd/bd6
         /pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh6HoD2WSOyoYld2ZBtCaKD/ZdY+NnuzhftXLHQtZcw=;
        b=cOp2W9tB+q1XZoUG8VlqgIu7StDXokxx8kW7WrLBwMBKjKXv+4PuJdwL4ETlz7mn11
         oMBNqq24cZHRQSv0Q+qccirGtI/A8na10qHZXAskdBeAa0ou8aaeLjNEVUA7IzobXTjh
         jpwjzsTIprAuaIHUfTJwi3+p5bpflmfOA17eQjC2ITURTpP9j1SuRtFy/WypWZ/ystfw
         1yPeV/msqspKRUF15NqzjID3mNfJCku+PsssHK+jrvlvTUTy6ntS5hmX/XCjYz9ROmL5
         UKXk9CefS4EyMnN70lCsfxSQ1GwO/MHIDQaSeNfvcNitwLQL5m6T7mSDfqf3flaEtg4o
         W6aA==
X-Gm-Message-State: AGi0PuaU4DCtiyMiBAP8Ogaj10ghiVxaT6pHEvzgwc4naY/wlMFsXHhD
        +qm7Cd/8yF+HHj4N5aQOi/zSygzTbqmVaSamWRk=
X-Google-Smtp-Source: APiQypLYRrzWxZrlbpaHLCWWd1ElKKp5WQ8rvraTOsv33YWtdO90qCriipsZO40uAtIGauLg9nTUCvQqCtacCa2Id2s=
X-Received: by 2002:a17:902:5acb:: with SMTP id g11mr4436095plm.18.1585662841043;
 Tue, 31 Mar 2020 06:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200313110350.10864-1-robert.foss@linaro.org>
 <20200313110350.10864-3-robert.foss@linaro.org> <CAOMZO5D9bmXt9_qGTXw+qUG6JDHfuNtx++fJPJtn+mj1Dzsbag@mail.gmail.com>
 <CAG3jFystdBKnosNQ0LeWQfHEtMgU4iGSr_XuS2XU3-902c31nQ@mail.gmail.com> <CAOMZO5DHBCJbfS2Lt7R-3J_TUJi1is2Xn6n5iZkRwvmn5i6Dmg@mail.gmail.com>
In-Reply-To: <CAOMZO5DHBCJbfS2Lt7R-3J_TUJi1is2Xn6n5iZkRwvmn5i6Dmg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 31 Mar 2020 16:53:53 +0300
Message-ID: <CAHp75VfGx0psWk-4Dc-E=HL9Gz_Cz3T46L_nsqrehVLQgkqViA@mail.gmail.com>
Subject: Re: [v2 2/3] media: ov8856: Add devicetree support
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Robert Foss <robert.foss@linaro.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 4:43 PM Fabio Estevam <festevam@gmail.com> wrote:
> On Tue, Mar 31, 2020 at 10:37 AM Robert Foss <robert.foss@linaro.org> wrote:
>
> > After testing this change, it breaks the driver during probing.
>
> Why exactly does it break probing? Maybe the GPIO polarity defined in
> the device tree is wrong?
>
> > I had a quick look into GPIOD_OUT_HIGH & LOW definitions, and they
> > seem to never be 0 or 1.
>
> If you do a grep in all gpiod_set_value_cansleep() usages in the
> kernel tree, there is not a single case where  GPIOD_OUT_HIGH or
> GPIOD_OUT_LOW is passed as argument of gpiod_set_value_cansleep().

+1. It simple reveals the problem that is somewhere else.

-- 
With Best Regards,
Andy Shevchenko
