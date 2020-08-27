Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD5DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA35D20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sQ4xIyg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgH0Hu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgH0Hu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:50:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F3C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:50:57 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id q8so23069lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RkQRJUboBmIWKRro4UbK9rk7QeC/T9PUGaJz7oztuM=;
        b=sQ4xIyg58IQiXn+nPUK19yM0+B7Gm17W7ypBWJXOr94r4oRxJD4b1zXPizoTsmUAcD
         9q2tC1kDLy7fFvhagl9rJCv6MUnATZDCxNbclScXpPkTDzZv0Dln/6t2qrxCzO1ETduU
         gIapIkD7A1foHeFj4PN8/RtUZO9Jmqu1SoxD2iBC8stgHuk1VxWM6b2QMAlwTMyGCVWC
         EAuNb8A8vsBIzgo1DoIBeOmhhV18N03X2o0KszrL6d93TEZglrh6F2MVmEwCJ+UyyK4c
         obMnpmZohApi94oRseItRmcd4s0wyTFDp+ZCJu82+X6OB88tVaBNAXkJzjOxUOA/12Wz
         ZE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RkQRJUboBmIWKRro4UbK9rk7QeC/T9PUGaJz7oztuM=;
        b=DxaLASL7JJ++ntEqdK0zKnMOFQqtUgnxogk7uH44GvDezLDr1PnNDnK2+TC1QgtVh7
         EcugWz3jFfStI2uOQNw9dYpWG2dhzMENR4XZ/G/fsbq/VCv1zjZ8vFiPZGzUcPdXyqT7
         R9C7cdBQ6JvfKk8V/4FJRt0T+pIG167A3GEJmeMAK9eKMWFrNK9ZL2tsdcXc/xiteZO/
         LS5hxNZz2eOcPe/zg2/gnB+jFFHJe2nvOoQNdp0LXBx75lQmg0ZsUm61OBX2q5P4FW9x
         VJq4Yc4A1KnrFlIxAe0fzpSg3XMmlYuwhkYRSOlFQVzWiCarAzB2IaKxeRD66O+Xi3Sk
         szTw==
X-Gm-Message-State: AOAM533kxw3xqpr18N85sj+Lbk4S3Ut4X0fjZ/dxOQ3xdN9mMKn6UF/x
        615RKhRPyaISR1kcVkw5RkiNelh3x5tcdFg9cbQ=
X-Google-Smtp-Source: ABdhPJzSbTyB/nP5J0B+gu+OzkjMHitcnbwwKJFXXPrHyB+meYVZN3SURorEcenHbXH6dW5cv03jdc35k3NLeThqxZ0=
X-Received: by 2002:ac2:519b:: with SMTP id u27mr7128995lfi.10.1598514656088;
 Thu, 27 Aug 2020 00:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200824232526.16534-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200824232526.16534-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 27 Aug 2020 09:50:45 +0200
Message-ID: <CANiq72nSSrxTJBt4Mpm6uUEJMVEwe6rYedZQe6EtF1jnYqJDbw@mail.gmail.com>
Subject: Re: [PATCH] fix comment concerning GCC 4.6
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Tue, Aug 25, 2020 at 1:25 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> GCC 4.6 is not supported anymore, so remove a reference to it,
> leaving just the part about version prior GCC 5.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Queueing this one too, thanks.

Cheers,
Miguel
