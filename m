Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9075CC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A3CA20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+LjHqds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMHVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMHVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:21:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1185C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:21:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x6so2365259pgx.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 00:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=Sb/qdUmtKdQcZzhXqvBHC/XQvL7lTUC7aHl/KOqJRQE=;
        b=U+LjHqdsm2Fo1v2iltmwYb6XwNstuN6jBf9ShIKaaSZSsYSdoPLw48TdXRfbxT3G3Y
         wQD4WcP1YNQXI5gbrKqNY4EL2Y+TNhEciZ/GLFlUFr0rgsFt4wQd35C+D2m0uUupNrHC
         52z7YOrrDdtvC37nsKqD2bf3CbWxN8FBzyoFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=Sb/qdUmtKdQcZzhXqvBHC/XQvL7lTUC7aHl/KOqJRQE=;
        b=Xt3krtTz00wzVBVOlB2KYB+gTGjTBSVVoo1EwdwR7kicKQzof7jdYaPT4qfdo26lh1
         7aKzn+jaohw4DxUAODOd7qxamMD6njPHiffsxhq0zSVCYx9QNAA12Kb2erYkkS4TLthW
         nCZN4pIzyvTIKl76/PJp2pACsU7rhC3gVZZfeH+KwfQeNHVTZ6pJyIqnLAkoGK0b3WGP
         4vuJfKj+aks4IWNzWqNhiiaWd6avdnWLVcwtm1IgfvqtgnV7zsZvZPt5dBKhnzN1NRew
         UANiKbhuPLEvZeo9xU6S1MLKlTu18vNuGx/+R9+qTBcINUQIDpF41HT2SqvY8miL61Yo
         jisw==
X-Gm-Message-State: AOAM530KMoKR2KJgD75BgVoqReXWBDBOBuh5IrGo4ZFLovP6iiqvWFyA
        Em3i1ws2KiP4xeoQg2NqioD1n3pccvQ=
X-Google-Smtp-Source: ABdhPJy2w+s3WMM+RACGQk4X2svexIeUrVnHXOKY7zentF5GT3o4XhKrgauiSUlyuaaL3GLR2KfA6Q==
X-Received: by 2002:a63:5613:: with SMTP id k19mr2638912pgb.424.1597303268734;
        Thu, 13 Aug 2020 00:21:08 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id r28sm4575088pfg.158.2020.08.13.00.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 00:21:08 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aa506a3d-3e89-08ed-2d66-7098f6e5af91@codeaurora.org>
References: <1597058460-16211-1-git-send-email-mkshah@codeaurora.org> <1597058460-16211-3-git-send-email-mkshah@codeaurora.org> <159717444178.1360974.6520145243224264090@swboyd.mtv.corp.google.com> <aa506a3d-3e89-08ed-2d66-7098f6e5af91@codeaurora.org>
Subject: Re: [PATCH v4 2/7] pinctrl: qcom: Use return value from irq_set_wake call
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Thu, 13 Aug 2020 00:21:06 -0700
Message-ID: <159730326694.33733.15791110829493100948@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-13 00:17:18)
> Hi,
>=20
> On 8/12/2020 1:04 AM, Stephen Boyd wrote:
> > Quoting Maulik Shah (2020-08-10 04:20:55)
> >> msmgpio irqchip is not using return value of irq_set_wake call.
> >> Start using it.
> > Does this work when the irq parent isn't setup in a hierarchy?
> yes it works fine even when parent isn't setup in hierarchy.
> > I seem to
> > recall that this was written this way because sometimes
> > irq_set_irq_wake() would fail for the summary irq so it was a best
> > effort setting of wake on the summary line.
> Thanks for pointing this.
>=20
> It was written this way since previously GIC driver neither had=20
> IRQCHIP_SKIP_SET_WAKE flag nor it implemented .irq_set_wake callback,
>=20
> so the call to irq_set_irq_wake() to set_irq_wake_real() used to return=20
> error -ENXIO in past.
>=20
> I see this is already taken care now in GIC drivers by adding=20
> IRQCHIP_SKIP_SET_WAKE flag.

Ok, great. Thanks for double checking.

Can you add those details to the commit message so we don't forget? And
then I'm happy to see:=20

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
