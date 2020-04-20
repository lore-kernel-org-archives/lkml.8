Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DB2C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BAC52078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lu/WVv9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgDTQvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTQvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:51:41 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11ECC061A10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:51:41 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id t199so9384994oif.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqQhWBNRVhW6KQWEFBcPM7sptcfxEVerh5+7KiBxKHY=;
        b=lu/WVv9ah7vi8Hsj9QKCh3seAPQ7I3aowGxEe1aGHyefJm9BuqyIyani6NL+hj+dcI
         lsB39FGjDPOrd0/XVZOcH/PtFISnz7zVadFSO/HVUsmSxZeckGOs/ysRC60wLneSC0e2
         l+BqE4Zys5B1IJu6r1RevtW3lgyVRk//eJB5v4B+totP9li4YQ+yCNfpT7PzoyKQ0gBN
         4JTOGVr37kKQjH01oIRDN4FoLMLK+au8X0cx/4MzxHuHjeZwFA78opZWb8C2xIgkZXca
         Hv833IfRxKrdTiZdRu3JqiyTe3+fJB9siKjPOnVRao/cTY6+T+HrVd101DcgRLycoCZg
         VmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqQhWBNRVhW6KQWEFBcPM7sptcfxEVerh5+7KiBxKHY=;
        b=seddC6v4zJnnMKBaAaWIrTXqWqFN7fezHqxi17CPHDwyxng+a+/CTr3I0LqYk8aL+n
         tIyZ61xLY+qaH2vKmtw/f8UyPAl7Gfy0wN3zJQvdymDsx/ENvzA1mV2SXfUuU72VOo59
         TEJHd8G6Ys2YMl4oG+3o357pxixrkUahhwbFoB3/+4F2qcTDjUFz0CnGXWPu8CVphj7e
         qMWIkzkisQmUpYQkG9v9pM+ihEiH208KHmCVEN2iaZH5H0BZYu7xmc9/Xx3+tROaiNz6
         JXHmF59q3swvnnRudl6WUzzhCpr0l04XN/5gGs+LhXzir8oI8SVCuMiU4NVDrf7XqWCj
         PlAA==
X-Gm-Message-State: AGi0PuYoEtOqBHnXqBvxD+n75nkMGE0xaL+Oipc2hqXX6mY9WyNdQsN5
        X04rdZjkESdnkpS05nuAgotwLfISKRLaV9vrWwGtbA==
X-Google-Smtp-Source: APiQypJYYaLHQcSVI2bZtlFq6cyMPPAVJWX+kv6+xKscU2Hlf+9c+6T/dxP1qjtyu2Yak43rF6k0r/eK/nJo/AG2egM=
X-Received: by 2002:aca:abc6:: with SMTP id u189mr259769oie.30.1587401500754;
 Mon, 20 Apr 2020 09:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200420120101.31405-1-nsaenzjulienne@suse.de> <20200420120101.31405-3-nsaenzjulienne@suse.de>
In-Reply-To: <20200420120101.31405-3-nsaenzjulienne@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 20 Apr 2020 09:51:03 -0700
Message-ID: <CAGETcx-g=4FQsYZ2=4wXV2EBeTAyt6182KVW2i1qroGajLgfrw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] of: property: Do not link to disabled devices
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

On Mon, Apr 20, 2020 at 5:02 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> When creating a consumer/supplier relationship between two devices,
> make sure the supplier node is actually active. Otherwise this will
> create a link relationship that will never be fulfilled. This, in the
> worst case scenario, will hang the system during boot.
>
> Note that, in practice, the fact that a device-tree represented
> consumer/supplier relationship isn't fulfilled will not prevent devices
> from successfully probing.
>
> Fixes: a3e1d1a7f5fc ("of: property: Add functional dependency link from DT bindings")
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>
> ---
>
> Changes since v2:
>  - Correct code comment
>  - Use already available return handling code
>
> Changes since v1:
>  - Move availability check into the compatible search code and stop if
>    node disabled
>
>  drivers/of/property.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index dc034eb45defd..7bcf31ba717d8 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1045,8 +1045,20 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>          * Find the device node that contains the supplier phandle.  It may be
>          * @sup_np or it may be an ancestor of @sup_np.
>          */
> -       while (sup_np && !of_find_property(sup_np, "compatible", NULL))
> +       while (sup_np) {
> +
> +               /* Don't allow linking to a disabled supplier */
> +               if (!of_device_is_available(sup_np)) {
> +                       of_node_put(sup_np);
> +                       sup_np = NULL;
> +               }
> +
> +               if (of_find_property(sup_np, "compatible", NULL))
> +                       break;
> +
>                 sup_np = of_get_next_parent(sup_np);
> +       }
> +
>         if (!sup_np) {
>                 dev_dbg(dev, "Not linking to %pOFP - No device\n", tmp_np);
>                 return -ENODEV;

Thanks for the fix!

Reviewed-by: Saravana Kannan <saravanak@google.com>
