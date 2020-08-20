Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F0DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE702072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4ll16vi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbgHTLF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgHTLFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:05:32 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59909C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:05:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id h4so1737160ioe.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ki1WQNTHcThUFIdfEkntkrGULJACUJ9yJz/bmSD9Zk4=;
        b=T4ll16vitP366qklDX50f3YJzjIWVqhIPBxyHOXoytwEHnmw5TXRhyruxNl25YYGv1
         drxoowiA08/SofODXLrxwlo+/T4BP9gCbFFq8vUQWigeMopmJM0JoaIrftZTItta8Lm0
         AHhxpM4P9BvWA9b5Vo7U79Oqj82MezCBEnA7yMW4U728fP5/YxpZrTZAEk0PnEVhROOY
         fAWSUnNgXFNn0mISMiB0CLB8ne+1yvt5Xf479kIDAZg+krVxehKGrtPndcD+hupW7h1W
         kMox2AJibyI0Y6rc0JxsNTaiObDyh1TMZ1X1aAw2e0w4KqHM0bas/mAOXfjcvuVEchVK
         OgQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ki1WQNTHcThUFIdfEkntkrGULJACUJ9yJz/bmSD9Zk4=;
        b=EVVVzS96ld/s5cNusGI313Y4nt0kV+4/Mb0L9t/CeNgzFKBRyWFYjhtdgFD9+L3hKh
         Lk1l0c+jTwJ4O5ydzQluYfaFclmwQ/gr2w7AJVrvZj4ScD2OSnSIfkkhB1wcRWCteqOD
         sbCOYo5sxdJZQ9pMlf0xVcBHvDhDsfm6KUw853RF04A6Igas4qJSnBisu2WmT5AIGH31
         3q/e//ysJoo1XJ/vMzFnAIT0ht+AwrxYIQ2QaKgf9TaInAeyg1E8p9dCsrX0UD6+Za5L
         aw/6m8KmBzcmvs2d/OuOn90scavB9e/5ombCAzpTVg1LolHJJEyY3INjWHYTbEliIVQC
         EE3w==
X-Gm-Message-State: AOAM533fioHYjjuvqgOLKsqX/coGqjaeY5wpMoz2eeS12QYIzsP58tVH
        mqFp0po6S8pkwUHI+/OkYY1h3AXmYo3IU5nzkVxAUlnVp01M+Q==
X-Google-Smtp-Source: ABdhPJy8/B73Rwis0rcIrLcmnezpMOZs5TSkb/gxeBASX1Y68sIG9u8fggt3cVgCb7QgHUrLjqugAPGdHve9mLdVjAk=
X-Received: by 2002:a05:6602:2409:: with SMTP id s9mr1985839ioa.98.1597921528654;
 Thu, 20 Aug 2020 04:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200820021641.3188-1-thunder.leizhen@huawei.com> <20200820021641.3188-7-thunder.leizhen@huawei.com>
In-Reply-To: <20200820021641.3188-7-thunder.leizhen@huawei.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 20 Aug 2020 13:05:17 +0200
Message-ID: <CAM9Jb+jrzR3Q7JcYJKpjHr6_xXCrMUybRc3+hzM1zRd9dETmPA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] libnvdimm: make sure EXPORT_SYMBOL_GPL(nvdimm_flush)
 close to its function
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Move EXPORT_SYMBOL_GPL(nvdimm_flush) close to nvdimm_flush(), currently
> it's near to generic_nvdimm_flush().
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/nvdimm/region_devs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index 49be115c9189eff..909bf03edb132cf 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -1183,6 +1183,8 @@ int nvdimm_flush(struct nd_region *nd_region, struct bio *bio)
>
>         return rc;
>  }
> +EXPORT_SYMBOL_GPL(nvdimm_flush);
> +
>  /**
>   * nvdimm_flush - flush any posted write queues between the cpu and pmem media
>   * @nd_region: blk or interleaved pmem region
> @@ -1214,7 +1216,6 @@ int generic_nvdimm_flush(struct nd_region *nd_region)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(nvdimm_flush);
>
>  /**
>   * nvdimm_has_flush - determine write flushing requirements
> --

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>

> 1.8.3
>
> _______________________________________________
> Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
> To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
