Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC457C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9B0D20787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXY+v/sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441399AbgDOSVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441440AbgDOSUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:20:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAFB8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:20:43 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k9so14304064oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojVHvjTSZ0OhtB2Ea6baXllCpS6m57iP2kTa4q+hlag=;
        b=XXY+v/sMPlfoxgCHIaWR34ZLwP2DivNeNq+kmxmOeMgAn/zIOAfnHrUDB54NCoCUv6
         +QXoE5yjOMXYNv1vX/KaSQDRbO/LT9wYp6KE7IlaFBizS+jhg8oieCfnkKHnQBhF4bcw
         guN3gv5kivmb+/iw8COFefgISvdTdvsMaCs2bsuJO5SIWwC3scS5dfiLxu3ljY4rc1Eg
         Udo2rMYDZEW4H1OLd+dw/60uP5K/DiC6HJaaML54ZNdjXY/WlZffhMHYSmYAMRIWy2hY
         OtrGtAXZPyekZVO3jp0GAcnk8KrgyIhW032XTdmQvtCFnZU3RbLrn9CrGm5atSPFJHKp
         LToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojVHvjTSZ0OhtB2Ea6baXllCpS6m57iP2kTa4q+hlag=;
        b=DQYMe7z3CHffPUvb7NaWsM+YmnaFClQarSTEMYE8VbNVHmhy6MfoFxhkElIE5fG6nT
         +/nklX6Hq+ablpbAIyi8NjKbgvmC0mRsJtC6VQeG8eP5uBfkn++VtzeVpmGsFpBZx31F
         WHzN2lTRpmJlAtaqpNK2ge4peLLrsEMVDlN2oXXESiDVdry9HNzMUKLlHB18TvIHhHDx
         vZti8RXsOm/W5WinnOUM/T4maXr+4yBKmCkvUSPz3DIZCtfPrK7/liWS8jErfjjbV1LZ
         sdQg0zMAiwujeftziWE89mX092UU9m1bz1ZebpSczz2j+FK6M5xPRJjx0HL1lfBxa06V
         3Lpw==
X-Gm-Message-State: AGi0PubtYca3B2/KRkhZh39cxgkKz4uYoE+EdwvGP8sAKYVNZMPtl7B5
        7quXNvxf3aG3VaJX5zZwVWTmgntmRhWWEkzfenTK9Q==
X-Google-Smtp-Source: APiQypInj0TMrPwyDUQ/C5zzUj3niWiwzqacXSJKc996Yy8ybqLupH5nGy5yp5Ew42jSvs3skEaLFaO5H5KBIr+e4tE=
X-Received: by 2002:a54:481a:: with SMTP id j26mr400251oij.172.1586974842961;
 Wed, 15 Apr 2020 11:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200415150550.28156-1-nsaenzjulienne@suse.de> <20200415150550.28156-2-nsaenzjulienne@suse.de>
In-Reply-To: <20200415150550.28156-2-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Apr 2020 11:20:07 -0700
Message-ID: <CAGETcx9CMQWsTbez1sSY3qfAepafFZLDj_2+hdCbOMAGX22Few@mail.gmail.com>
Subject: Re: [PATCH 1/4] of: property: Fix create device links for all
 child-supplier dependencies
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Upon adding a new platform device we scan its properties and its
> children's properties in order to create a consumer/supplier
> relationship between the device and the property supplier.
>
> That said, it's possible for some of the node's children to be disabled,
> which will create links that'll never be fulfilled.
>
> To get around this, use the for_each_available_child_of_node() function
> instead of for_each_available_node() when iterating over the node's
> children.
>
> Fixes: d4387cd11741 ("of: property: Create device links for all child-supplier depencencies")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index b4916dcc9e725..a8c2b13521b27 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1296,7 +1296,7 @@ static int of_link_to_suppliers(struct device *dev,
>                 if (of_link_property(dev, con_np, p->name))
>                         ret = -ENODEV;
>
> -       for_each_child_of_node(con_np, child)
> +       for_each_available_child_of_node(con_np, child)
>                 if (of_link_to_suppliers(dev, child) && !ret)
>                         ret = -EAGAIN;

Thanks. Good catch. I have plenty of disabled devices in my test
platform. But I guess I never ran into this scenario.

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana
