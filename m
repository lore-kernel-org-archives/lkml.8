Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA41C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:57:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE94214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsD+38Lc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGG55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:57:57 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:42813 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGG55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:57:57 -0500
Received: by mail-il1-f196.google.com with SMTP id x2so810156ila.9;
        Thu, 06 Feb 2020 22:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MvC4wfPqw9IroxJFE0+MeDBQWPGintIKajsHZYirMKQ=;
        b=JsD+38Lcu1jACdrWPnZvuVsKkMf9dmfdXJ9Ee1ctjb53C7MjQBeBKCKzUbCapxPkV3
         yN5Y+ylzMm0ioC2S4fmQYdctCkheyaqfreX/0qsFU5De5c2lxLN0OUU4ZM7V6Q5hIpAu
         xBNhx1UziYfV5qu8ffG5DleioJN5muRDe3FYloeKLvjcavOSBYp34gR2DMsa3AWZfxSb
         6x9GKsN4QeVGvwjKv8PfM9u5Uk/9EYvAf3Bb52pQ0wAKxux8d8f6Y7AZIHetvLvcKAxt
         T4YiGiKGm+RVxsAmWIYmcq2ywe/epX74Z69olrUPatdLthLCpKOS23rDaGbjyjIvbTPH
         rTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MvC4wfPqw9IroxJFE0+MeDBQWPGintIKajsHZYirMKQ=;
        b=HgIezn4Aljuq4R+ZpoM0H3OpkzaPewAea0G4JRR1FbbbwuORe32eh7YY0/uTaLsBm4
         i5/M30atrXDQ7eO8tGcSvrz9TaZXCqTSvUa/yA/olXP66XGFg6Cq5z9rMbVZq8CxKzYF
         VsxilslayXJ5N799XvU97act8ByYWzDvrEeyKT9P+hkuV2mLtIIqOJNVLiyC6JLy7jjb
         dWGzwEq1lCROfPDBjCRTU9nphBZl0AMWmFCUUxCxCedwIdqRo9YJCu0U7OiPrZm99TQ7
         okgP3cqj1tMvBHGvVHolXht9fuAJU0cevGMYk0o0K35OcWnMm6hGE0Rn+6NHeMbqv+d7
         DQYQ==
X-Gm-Message-State: APjAAAVtNqV8jZ6emEMXb6xO/2obxgJp6d+px7ez0DMnwgs5UdQ3MrPt
        qrkAbaJXKoe+dkP3ZG5mXhr0jK1TeiouSA4S6wDchL/E3jo=
X-Google-Smtp-Source: APXvYqzVlmSDZ11jLfB0Dk+b5wrJmCDCPMqzimvGfc3DZnWRvtmfFKx0rOtYrAe83Rd9Tv4z08oBry1yXBL1No/vG/c=
X-Received: by 2002:a92:860a:: with SMTP id g10mr7690199ild.280.1581058676368;
 Thu, 06 Feb 2020 22:57:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad5:5442:0:0:0:0:0 with HTTP; Thu, 6 Feb 2020 22:57:56 -0800 (PST)
In-Reply-To: <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
References: <20191104143713.11137-1-alexandre.torgue@st.com>
 <20200206133918.15012-1-youling257@gmail.com> <0c4a37a9-0a2e-e698-f423-53060854ea05@ti.com>
From:   youling 257 <youling257@gmail.com>
Date:   Fri, 7 Feb 2020 14:57:56 +0800
Message-ID: <CAOzgRdb5QfJDQzbtoHQry4wxUg52LwX5XFCPzzaYa=z+RqNWOQ@mail.gmail.com>
Subject: Re: [PATCH] phy: core: Add consumer device link support
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     alexandre.torgue@st.com, yoshihiro.shimoda.uh@renesas.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test this diff, dwc3 work for my device, thanks.

2020-02-07 13:16 GMT+08:00, Kishon Vijay Abraham I <kishon@ti.com>:
> Hi,
>
> On 06/02/20 7:09 PM, youling257 wrote:
>> This patch cause "dwc3 dwc3.3.auto: failed to create device link to
>> dwc3.3.auto.ulpi" problem.
>> https://bugzilla.kernel.org/show_bug.cgi?id=206435
>
> I'm suspecting there is some sort of reverse dependency with dwc3 ULPI.
> Can you try the following diff?
>
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 2eb28cc2d2dc..397311dcb116 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -687,7 +687,7 @@ struct phy *phy_get(struct device *dev, const char
> *string)
>
>         get_device(&phy->dev);
>
> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>         if (!link) {
>                 dev_err(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
> @@ -802,7 +802,7 @@ struct phy *devm_of_phy_get(struct device *dev,
> struct device_node *np,
>                 return phy;
>         }
>
> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>         if (!link) {
>                 dev_err(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
> @@ -851,7 +851,7 @@ struct phy *devm_of_phy_get_by_index(struct device
> *dev, struct device_node *np,
>         *ptr = phy;
>         devres_add(dev, ptr);
>
> -       link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> +       link = device_link_add(dev, &phy->dev, DL_FLAG_SYNC_STATE_ONLY);
>         if (!link) {
>                 dev_err(dev, "failed to create device link to %s\n",
>                         dev_name(phy->dev.parent));
>
> Thanks
> Kishon
>
