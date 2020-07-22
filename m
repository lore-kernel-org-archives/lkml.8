Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7422C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B02AA2071A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S28SZVzv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbgGVVtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVVtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:49:21 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E950EC0619DC;
        Wed, 22 Jul 2020 14:49:20 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id b205so919704vkb.8;
        Wed, 22 Jul 2020 14:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ithjliQLqJY6tGxYNN/Cp/9uoUkvQUM6Qu6DjieyS3M=;
        b=S28SZVzvTqBP++BXwAVzA8kidLotcnQaXAEfAlpiKNPt9dVr/RVP+Y6zLJSlQYC8hK
         AyT/8BCNlBMUqVrjql1fSSSDlWysrQg2yRTd/F32IB7YuAM3euDwMJ2FHC1/kLnZ0uk9
         1EKjUKLsRrsNO/Wsz1X8h86cvyEbFT/nB/HdUQftPpcT6IqFRLKchmaYN4YwywSNAxwX
         0RLfKMKrMlWigH16BQrYX0yEEfpdkAXLn7kd85gKBVxxruTeD/ZhZBc/iHXFX+q2Flhr
         Pkl9g/IIfHpiRUkx6UDxngGdtMMZpTBLOKiPoGXnxstkoCj9fsTpEz/gmbf8/1xMgYV8
         PTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ithjliQLqJY6tGxYNN/Cp/9uoUkvQUM6Qu6DjieyS3M=;
        b=Z3isM2E49RbyfseGtQJEmNIc2wlJS3MBArkv4l64xd+amWcw3OitrijYbVM0etDb0j
         UHtamIqs/z3jLBS4+PcyfhTRXa9eq31A3iXn6ht+FehvGOEH4Se27XaPYA/hL9PNfqMY
         F/RHO1mvayFeqpjNlUSL5JyVtqqqFQM+ccllIpP6I+Cxftm6WZS1mWsMNJ75cKymnPAB
         KmO4IZCHnD9gS4mPEjAcWAd/WYCY0Pcrhdd8cEHQnw9gKAhblzAa5tVRZkcVKfg00JFr
         N2z0Ze6jTtgIu1jGpU9NmCfI7Rc6XdFdeJB88BHTcAKroInHLXc1kLVETLQvYDVKxI3T
         JaeQ==
X-Gm-Message-State: AOAM531Paql10/60SOBY+f5zNIiKaxnZyKa6XIzGTtiEOa6LxC+0rAie
        4UxIB6lIek2SuveKiS6Uco88/4aO4zjmBJ3CDaw=
X-Google-Smtp-Source: ABdhPJyyvmZr7Bt/PIKq8EkvKIF9yqm4tipgYWw+E8JY4c7+nItck3eN+1grf9hY5s++vEf73w5bBOrA+DdFGicoFCc=
X-Received: by 2002:a1f:f848:: with SMTP id w69mr1525600vkh.86.1595454560034;
 Wed, 22 Jul 2020 14:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200722203341.578651-1-cphealy@gmail.com>
In-Reply-To: <20200722203341.578651-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 22 Jul 2020 18:49:08 -0300
Message-ID: <CAOMZO5DfuU5dGALFOmryn=xpRq+wWfpQjZEhBje9JAQ8jkXPjw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: ZII: Disable HW Ethernet switch reset GPIOs
To:     Chris Healy <cphealy@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Wed, Jul 22, 2020 at 5:33 PM Chris Healy <cphealy@gmail.com> wrote:
>
> From: Chris Healy <cphealy@gmail.com>
>
> Disable Ethernet switch reset GPIO with ZII platforms that have it
> enabled.  HW switch reset results in a reset of the copper PHYs
> inside of the switch.  We want to avoid this reset of the copper PHYs
> in the switch as this results in unnecessary broader network disruption on
> a soft reboot of the application processor.
>
> With the HW GPIO removed, the switch driver still performs a soft reset of
> the switch core which has been shown to sufficiently meet our needs with
> other ZII platforms that do not have the HW switch reset GPIO defined.
>
> Signed-off-by: Chris Healy <cphealy@gmail.com>
> ---
> v2:
> - Update the description to more accurately reflect why we are making the change

Updated description is clear now:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
