Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAEBC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F26E207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 17:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ev0M7hLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgFFRqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 13:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgFFRqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 13:46:13 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72EAC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 10:46:11 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 7so2664621oof.8
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 10:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FTx+jphm/lLacI7W/EoGrspqF//hnRGVpfw1BWx6hc=;
        b=Ev0M7hLQ9ENXb2BTvaz91PCbx1fqgPBPdFIwc+1xGai2U3y+hqIN4H6zdTxZkFhsOx
         YZDoYfDoJjFNElquYws3h/m1BbMLPMkFCp84lwo5AgmzGNowfxDRlHF6AwCwEGhB8t6P
         qA3mmUZKcG78fwWRIRzsiuBr6L6z4MmVybJ5jX7WhnGUhcL9kh1acfGpsBP9gdZ5P1Q6
         rBB2bfYAWrEt/HJsVtun2yYpyjhFxkTjA2BRqxxy5NAwVqz5luPdWqtg2N3q11BKsyOH
         GRFQWcIcZzbTiy0+nRfiz/4UGBjuYPtFTQEg6wD8p6+S3x11lqzADQTTesQv1wUp/dBl
         Wh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FTx+jphm/lLacI7W/EoGrspqF//hnRGVpfw1BWx6hc=;
        b=ZhOdr0H4o5DIVuVkcRe91uTeUzP0vuLM4B6a/xecrFJitA2WTDs1mo4W4TAv2VgYHr
         vmfckYKmg0E2+OU35O/z8NyJQRVqhWVAo+y20N6kjQPVNC9qWVezNZKR6ubrRD25PHGJ
         W42fIzwbK2bXOCh/YuHZOfqYsuEOS15jRWV/SwLTpyq43fpUB72S2yxPMX0Zp/Px58cp
         AVpgKxd2EbCDVKGk5MdFMZoxcyNn6hJsBqJzBzPqo/B2H4RRTUEedc8nzCpw3C/xA9tH
         Hl+gCZldps0+EaIs2WuJgRzNrj+avcyBoXnmjeB1FHpIsOv+lVYTjHGa7FXqDavzyRQ4
         H6zQ==
X-Gm-Message-State: AOAM530eigmwNq0OFJgXE7tj2MfN2Yuh4dnRyzlopHOv/IuXh1HwSGoE
        W9ecrdYfnjzsp8e/GTQmvzf5sB7ScC+pEmicOU1WGg==
X-Google-Smtp-Source: ABdhPJxy4ZsnRRjBwanalABT43t4/eoN4tc25jTOSNzsJ5z6HV+MW9CMyrLY1sAN87Wp24jHgw+InkK1qpcJXM338ho=
X-Received: by 2002:a4a:7ac2:: with SMTP id a185mr12223320ooc.84.1591465570614;
 Sat, 06 Jun 2020 10:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200606003552.247693-1-saravanak@google.com> <20200606003552.247693-3-saravanak@google.com>
In-Reply-To: <20200606003552.247693-3-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sat, 6 Jun 2020 10:45:34 -0700
Message-ID: <CAGETcx-yGztpfATAYRRwPD87uLmYPN53bt146=NTc-+qYzh8Ng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Improve cycle detection when one of
 the devices is never added
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, John Stultz <john.stultz@linaro.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 5:36 PM Saravana Kannan <saravanak@google.com> wrote:
>
> Consider this example where -> means LHS device is a consumer of RHS
> device and indentation represents "child of" of the previous device.
>
> Device A -> Device C
>
> Device B -> Device A
>         Device C
>
> Without this commit:
> 1. Device A is added.
> 2. Device A is added to waiting for supplier list (Device C)
> 3. Device B is added
> 4. Device B is linked as a consumer to Device A
> 5. Device A doesn't probe because it's waiting for Device C to be added.
> 6. Device B doesn't probe because Device A hasn't probed.
> 7. Device C will never be added because it's parent hasn't probed.
>
> So, Device A, B and C will be in a probe/add deadlock.
>
> This commit detects this scenario and stops trying to create a device
> link between Device A and Device C since doing so would create a cycle:
> Device A -> Devic C -(parent)-> Device B -> Device A.
>
> With this commit:
> 1. Device A is added.
> 3. Device B is added
> 4. Device B is linked as a consumer to Device A
> 5. Device A probes.
> 6. Device B probes because Device A has probed.
> 7. Device C is added and probed.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 44 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 1f2086f4e7ce..7eebe21274a4 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1014,6 +1014,20 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
>         return false;
>  }
>
> +static struct device *of_get_next_parent_dev(struct device_node *np)
> +{
> +       struct device *dev = NULL;
> +
> +       of_node_get(np);
> +       do {
> +               np = of_get_next_parent(np);
> +               if (np)
> +                       dev = get_dev_from_fwnode(&np->fwnode);
> +       } while (np && !dev);
> +       of_node_put(np);
> +       return dev;
> +}
> +
>  /**
>   * of_link_to_phandle - Add device link to supplier from supplier phandle
>   * @dev: consumer device
> @@ -1035,10 +1049,9 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
>  static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>                               u32 dl_flags)
>  {
> -       struct device *sup_dev;
> +       struct device *sup_dev, *sup_par_dev;
>         int ret = 0;
>         struct device_node *tmp_np = sup_np;
> -       int is_populated;
>
>         of_node_get(sup_np);
>         /*
> @@ -1075,16 +1088,35 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>                 return -EINVAL;
>         }
>         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> -       is_populated = of_node_check_flag(sup_np, OF_POPULATED);
> -       of_node_put(sup_np);
> -       if (!sup_dev && is_populated) {
> +       if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
>                 /* Early device without struct device. */
>                 dev_dbg(dev, "Not linking to %pOFP - No struct device\n",
>                         sup_np);
> +               of_node_put(sup_np);
>                 return -ENODEV;
>         } else if (!sup_dev) {
> -               return -EAGAIN;
> +               sup_par_dev = of_get_next_parent_dev(sup_np);
> +               of_node_put(sup_np);
> +
> +               /*
> +                * DL_FLAG_SYNC_STATE_ONLY doesn't block probing, so cycle
> +                * detection isn't necessary and shouldn't be done.
> +                */
> +               if (dl_flags & DL_FLAG_SYNC_STATE_ONLY)
> +                       return -EAGAIN;

I need to put_device(sup_par_dev) before I return here and at other places
below. I'll send a v2 later to fix this.


-Saravana

> +
> +               /*
> +                * If devices haven't been created for any of the ancestors, we
> +                * can't check for cycles. So let's try again later.
> +                */
> +               if (!sup_par_dev)
> +                       return -EAGAIN;
> +
> +               /* Cyclic dependency detected, don't try to link */
> +               if (device_is_dependent(dev, sup_par_dev))
> +                       return -EINVAL;
>         }
> +       of_node_put(sup_np);
>         if (!device_link_add(dev, sup_dev, dl_flags))
>                 ret = -EINVAL;
>         put_device(sup_dev);
> --
> 2.27.0.278.ge193c7cf3a9-goog
>
