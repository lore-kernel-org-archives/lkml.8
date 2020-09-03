Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A456C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0611320716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="DrefXjNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgICQrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgICQrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:47:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999CCC061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:47:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i1so3219203edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 09:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BoOsmQ2rBW+EbnUHAzVo+1cABtO0sjJmNcwrCxNVF/A=;
        b=DrefXjNN8klAxwkDEtDXlFK8vggfcZ/C/CRF+LX12Ix1TZ08f0o81Izumvko0Z2jVF
         LycY29rD0Pxs+7jbEPJZloKwDB2Uc4g/PH8c5khbTdNmIPWrx8dHYNHOeJMvQMQQB1qJ
         HwAKRNQ2jz9daw1E8VUsyq24UC6Mcxb74XxIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BoOsmQ2rBW+EbnUHAzVo+1cABtO0sjJmNcwrCxNVF/A=;
        b=hDVX/w8B3v1x2gDMmRjgC6QEFpku7Mq9B/NNU9U6vUZ7VGx9oMPspQ7zRkF+5uthQ1
         n1iueRJdqJC0CIqaTfySZm6Trz9qhD4Vw53lan/izQOT/aFpwPHC8r9BPkhGo1J2SNyI
         u0NY1FKQ4DIrG7ZcjPRkte4Lq9jLUMi1s/GgK9LQcxZtU/Ptqz7LQec2kotVLJgNfG3N
         +pH668CRYQtKb9Xqp3PiREF/8mOVyjXNHKjT+f3vjc6jp7OawV5BYP6PdDBM0j+5/+cJ
         R1RUnPJa9ZPxAC7pjBTMw3GFkoXFiR8DqjNEyphiOTbVoNPQ7SP9IuACHEbZD0aX190R
         rQ7g==
X-Gm-Message-State: AOAM531GAGC/Y7ZUxWMOwt5RGbR0zVodNrphfaKidOyyIY7F+1blh51u
        b9tm4gQU+lK16h6j+5Q2I+Tci4TuCQIW58Fn1KidnA==
X-Google-Smtp-Source: ABdhPJxMeFogkFas77zemMlntf263DD9ilLv7Qd6K+YljkScZccbQgYQDbdCP80JMCHM2uxPrdDdTxdUYKasre4/cYA=
X-Received: by 2002:aa7:d750:: with SMTP id a16mr4221514eds.362.1599151637185;
 Thu, 03 Sep 2020 09:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200831082917.17117-1-jagan@amarulasolutions.com>
 <20200831082917.17117-6-jagan@amarulasolutions.com> <20200903162550.GA2896127@bogus>
In-Reply-To: <20200903162550.GA2896127@bogus>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Sep 2020 22:17:05 +0530
Message-ID: <CAMty3ZCXV9=VzVKiKJ740RcR+uYA7CHUzjrDL0vwQ1NOw9n4FQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] dt-bindings: arm: rockchip: Add Engicam PX30.Core
 C.TOUCH 2.0
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 9:55 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 31 Aug 2020 13:59:15 +0530, Jagan Teki wrote:
> > PX30.Core is an EDIMM SOM based on Rockchip PX30 from Engicam.
> >
> > C.TOUCH 2.0 is a general purpose carrier board with capacitive
> > touch interface support.
> >
> > PX30.Core needs to mount on top of this Carrier board for creating
> > complete PX30.Core C.TOUCH 2.0 board.
> >
> > Add bindings for it.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > ---
> > Changes for v3:
> > - none
> > Changes for v2:
> > - new patch
> >
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Yes, it's on purpose. The previous binding was about C.TOUCH with LVDS
board and this one is C.TOUCH carrier only. ie the main reason I have
not included. I did mention in the cover-letter saying previous one
dropped and the C.TOUCH carrier added.

Hope this answers your query.

Jagan.
