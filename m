Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22E4C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8072021744
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 14:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="s7e5W0fX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgGaOwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgGaOwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:52:49 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5123C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:52:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id di22so15375170edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7xbkWYnKB5bD8Dx+A3hqQvuyFQl9+LQz6yTL7Vvq6w0=;
        b=s7e5W0fXDILLB6ZWbNuQf571n49wktNjevDIf5ymOQ4TmVGXG/ZXEhdZ5d2V2CSlGz
         SQFONr4GotVUcj7ixDNsa/uashyzLwpPDHZD254BElUXOnbseZXkDpKdmlzJHzGcW5lN
         HvkEPK1kV8BwVkzcYf2T62N3V+yUFc1TSsAWKyqD7cET6pOYxMk/unAf2w3OhIWXlwJC
         iQPf5U3ideRZ3LCcsaE5QbRva7XwFMZadtyqvvng1ODDFENc/f5u3wI+RXzsiF+dYn32
         5YUMF86zfXDGdwXniwrzfwZf3DBgyBPfFya+TKVIhW0JLlMZ2fz/t76egk/7KVNrEX59
         7bUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xbkWYnKB5bD8Dx+A3hqQvuyFQl9+LQz6yTL7Vvq6w0=;
        b=n9dTe1YiEaRYaJThKRPnzVVFyc2FFGt93eHunseyKq1A1dkA4NIVRYU0srGO45GSpJ
         suDiSRSl9VyExnxLyqXIRFoSPigH156oWWaqBsBuymAsMOHf1OjpxpOxoETCfY9eY3lv
         Ec86Hzb4zmkUwVdWs/mZw+ji3gHVt09rZVgnYLZLLdDjLzEyt716dmTcXacK/3zX1UML
         6dtRMs6yHNuCO7D0XoNleNRJk83eRGP6WEX0C7noOKG5idcF+oQYfIT4iKzqFJIlrodo
         O7V5gehSWwt9zBbKAU2saY/WDQrGPjG4ty1K6obbyOdgTv5lAxXA+zarCJj2cM6XKa8k
         akEg==
X-Gm-Message-State: AOAM532osxzCK/ehiVw6WaVTjQ9qKC67zHmtLQFsdcFdYBxfW0FKDW7e
        4CUWc+WQHM5aljMygbXOkIjw6YlLqbKPFzaV7VrLzQ==
X-Google-Smtp-Source: ABdhPJzWcMODSLzAdKZ6q1frH2GXeDvyC+w2kZfqO8Lo3sAsT7hyYeTYxvBgCwoinitzwZZZSd9uSFR6RseVBdrmti8=
X-Received: by 2002:a50:fb06:: with SMTP id d6mr4114200edq.165.1596207167258;
 Fri, 31 Jul 2020 07:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200716172913.19658-1-joao.m.martins@oracle.com> <20200716172913.19658-3-joao.m.martins@oracle.com>
In-Reply-To: <20200716172913.19658-3-joao.m.martins@oracle.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 31 Jul 2020 07:52:36 -0700
Message-ID: <CAPcyv4iueciTchM+tkhHZd6PhmbgKhQuBWaxm2Ff2bvvZWBBOw@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] device-dax: Add an 'align' attribute
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:31 AM Joao Martins <joao.m.martins@oracle.com> wrote:
>
> Introduce a device align attribute. While doing so,
> rename the region align attribute to be more explicitly
> named as so, but keep it named as @align to retain the API
> for tools like daxctl.
>
> Changes on align may not always be valid, when say certain
> mappings were created with 2M and then we switch to 1G. So, we
> validate all ranges against the new value being attempted,
> post resizing.
>
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  drivers/dax/bus.c | 101 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 92 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 2578651c596e..eb384dd6a376 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -230,14 +230,15 @@ static ssize_t region_size_show(struct device *dev,
>  static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
>                 region_size_show, NULL);
>
> -static ssize_t align_show(struct device *dev,
> +static ssize_t region_align_show(struct device *dev,
>                 struct device_attribute *attr, char *buf)
>  {
>         struct dax_region *dax_region = dev_get_drvdata(dev);
>
>         return sprintf(buf, "%u\n", dax_region->align);
>  }
> -static DEVICE_ATTR_RO(align);
> +static struct device_attribute dev_attr_region_align =
> +               __ATTR(align, 0400, region_align_show, NULL);
>
>  #define for_each_dax_region_resource(dax_region, res) \
>         for (res = (dax_region)->res.child; res; res = res->sibling)
> @@ -488,7 +489,7 @@ static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
>  static struct attribute *dax_region_attributes[] = {
>         &dev_attr_available_size.attr,
>         &dev_attr_region_size.attr,
> -       &dev_attr_align.attr,
> +       &dev_attr_region_align.attr,
>         &dev_attr_create.attr,
>         &dev_attr_seed.attr,
>         &dev_attr_delete.attr,
> @@ -855,14 +856,13 @@ static ssize_t size_show(struct device *dev,
>         return sprintf(buf, "%llu\n", size);
>  }
>
> -static bool alloc_is_aligned(struct dax_region *dax_region,
> -               resource_size_t size)
> +static bool alloc_is_aligned(resource_size_t size, unsigned long align)

For type safety, let's make this take @dev_dax as a parameter. For the
dev_dax_set_align() case I think it is ok to provisionally adjust
dev_dax->align under the lock before entry and revert to the old
alignment on failure.

I can fix that up locally on applying.
