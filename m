Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192E8C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA49A221E9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 20:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R9pFeoH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgDQU5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgDQU5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 16:57:14 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCCFC061A0F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:57:14 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id o7so1506076oif.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 13:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39lTiL2QUNm6Li0BGrvaywbwuxh4rjX/zhgI0VviW50=;
        b=R9pFeoH+DNmb2tnvPG+u2/fSvDd5LqOsY/uTzKa5o5WW6nvaLBQV8lvtpmevzumpe3
         3r6XDsAKuAnAoHWvH5PqLO0BySgzd300CYL4gwMDhJ1G4gT0sQ0pBE0DL5DJEaPm7zau
         MJydGJoo5YerDjcgu0Up5ndFoKbXlirzP7JN2ExqXQiLBaxFKG/sGZ07rtZE0HKeIaWk
         cKArkKF5l5eu5tcheWccuMoA6VUBXlsEaPAdLXGpf2twHEXySjhBKCUmO8OrDrItTOJP
         ePRL0k0pE7FY/a31SorUiyNUQZNaATX7i5FARFjUGhJXTr/6LWDx4tuSDihhZ+oigIjX
         OH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39lTiL2QUNm6Li0BGrvaywbwuxh4rjX/zhgI0VviW50=;
        b=jMG8DYE6vtrUERxaKybR613Cw6cTz/TXX3zzQ0Vv/q7zrza0B13C9YBKjQE4SMQV59
         u2fbpiH9xA7rz3Nnvn3ZWMt2h0cAnlu45e6LaEvBn2mlowVMLhvAGkX+jqj9+3aqZGZh
         yiziAVb9pEoDcRNg61tGlcfSllbgVIZTMfcTznkPvkjlaM1oR01JL8dtBS+yJO3lh2xS
         nN/xQqNycDVTcxMXrjIWGkL8fGUY9xCaNCC3Sjo2Ux4H9ZzCWSinTjLOdBnBW2is/CX8
         Z5n+G/xSHyFoFLlMgtuJjzc2g3xJNZv1cGnfViImW0ug7ofJk9x2rgomcLV6i1PI+qsX
         6xQQ==
X-Gm-Message-State: AGi0PubvpdO7V+7ynWvCucFYLHrX1v2KXaeC+jT700InRw9pOjvn5/fE
        erFw58w/t7FGZHeyyzcjfL4Vz5qO6GYJZRwb6QFiqQ==
X-Google-Smtp-Source: APiQypKyObG1xCJPIVhAidk/Nuq+dSDAiBa3fvckIr9iSodvJnzuwaxnrnyRyz8kCrqgMjV7dryGPmQ+W3KrJ6PxP3A=
X-Received: by 2002:aca:682:: with SMTP id 124mr3585199oig.69.1587157033687;
 Fri, 17 Apr 2020 13:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200417165442.1856-1-nsaenzjulienne@suse.de> <20200417165442.1856-2-nsaenzjulienne@suse.de>
In-Reply-To: <20200417165442.1856-2-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Apr 2020 13:56:37 -0700
Message-ID: <CAGETcx88KCPRHEJWkBfkp1CUKzFvfssfJrvymgVbOg_BJfyhrw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: property: Fix create device links for all
 child-supplier dependencies
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:54 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Upon adding a new device from a DT node, we scan its properties and its
> children's properties in order to create a consumer/supplier
> relationship between the device and the property provider.
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
>
> ---
>
> Changes since v1:
>  - Slightly reword description
>
>  drivers/of/property.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 252e4f6001553..dc034eb45defd 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1298,7 +1298,7 @@ static int of_link_to_suppliers(struct device *dev,
>                 if (of_link_property(dev, con_np, p->name))
>                         ret = -ENODEV;
>
> -       for_each_child_of_node(con_np, child)
> +       for_each_available_child_of_node(con_np, child)
>                 if (of_link_to_suppliers(dev, child) && !ret)
>                         ret = -EAGAIN;
>

Reviewed-by: Saravana Kannan <saravanak@google.com>
