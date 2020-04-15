Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B2C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB4420737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qHK0VzOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416762AbgDOSZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1416693AbgDOSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:23:33 -0400
Received: from mail-oo1-xc41.google.com (mail-yw1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:23:33 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id b17so82573ooa.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 11:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N/364UOQV/F9OhYoUwCrLEZcG1FusHWS5bcvrl8jz2w=;
        b=qHK0VzOeMeIvWuDEg9DQg3oOZt+awXi4JnTR3FkSp4lyaHjbHcD88TAqCzyg6xrVRB
         8sf7+NG2SbK9iPYxmqKBn5PSTFASpoKEOmWWw0JFr8vidNprFyZkL/r6DOaxnx0iE1Fp
         fg3az2zIXslQ3beoYX1vk5E6lUsOId7CkSFy0UHWr/IxFNsdLzbZjzzt+D7AlUKlaCei
         NOQdA5ycXHdB1AuZYdL2SiFwPN5Zdi1MnDgyV3wumYGPqwSETLbezsMZqpnsxOfcpNmJ
         o8BhT15ghclPxAbsrG34l8vgJ2HzV9y56WBnFbYBSnCA+wwEte8wEwTjCTl3OFHE4CKG
         n0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N/364UOQV/F9OhYoUwCrLEZcG1FusHWS5bcvrl8jz2w=;
        b=WipQ9wFOF2mwXm6e5i8aQZgrOXKOe2skMKUPBwKhYv+y7NedJwOwx1vFDoCj00Rmax
         x0uFAEooVFnurpKVdUzDtUzLvUq3VfrXbT1fafmMErajAZMbMXkBdW30WWz6WN0MC3sN
         PBigNsrwA+pZ1NORccjrFQXyYdVdjI7h28WMHyOKYQMgfop/to3/FnujnacubcWgxwh/
         CIp+SxQwc+GstMDca7bJ1yRTk36gfTqCsN66daUcGrlqApmxwcn8EzRmKk0yHbttFaLk
         h3gz9PyIZGjLjdAUcI93LRgPWl3WPSXWAfLljuuJbPMoFs0zcx31JL/HZQBX4j07+4N1
         W6pQ==
X-Gm-Message-State: AGi0PuY2b0EwMrlpXkxsMCtTNzIJaRWYP0YtvPjwnifNKdK/pTC30f28
        694wrUo/+KlK5CTh8wtZb/kS718WeZESHWP7Wj4oIg==
X-Google-Smtp-Source: APiQypL40RhF6vlHXSbiQX7ID3/5K6fuLLYdzVlTCNywKin+vKrOPqEX+sTqWif0e5PqnxV6i8UV+TU6VE70Paun67U=
X-Received: by 2002:a4a:615d:: with SMTP id u29mr2702657ooe.15.1586975012444;
 Wed, 15 Apr 2020 11:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200415150550.28156-1-nsaenzjulienne@suse.de> <20200415150550.28156-2-nsaenzjulienne@suse.de>
In-Reply-To: <20200415150550.28156-2-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 15 Apr 2020 11:22:56 -0700
Message-ID: <CAGETcx_+i9=+a4OEY-rySY4vNDg1jt4160zAMPR7U-UG38Ysww@mail.gmail.com>
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

Actually a few more nits about the commit text.

On Wed, Apr 15, 2020 at 8:06 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Upon adding a new platform device we scan its properties and its

This code runs for all devices created from a DT node. Not just
platform devices. So fix this paragraph appropriately?

Upon adding a new device from a DT node, we scan... ?

-Saravana

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
>
> --
> 2.26.0
>
