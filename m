Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB77EC2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 809A020673
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpAw+cFG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730561AbgELSAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELSAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:00:34 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D989DC05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:00:32 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id i16so13249538ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cLEAYLVD6JreucQil+ujhm8FErflJCkoe7KXXK012mc=;
        b=JpAw+cFGmfHBajujn/xovuM0dYlazaSRxJ4KOtDR8DxkxTDdhtE1+ux/9NOdXlkDvb
         Yj5I98DG6givG6zWx5FND6O4IbR9RmMma41huxQDdrAFggw14jKpQ6A8aCQjY5lNRLaJ
         TtOlnoUqEuX2PFLxUBkT45aJ2ipRGUiirEJKSQ8+dIFJ57Bmx6oE6c8Vhs02VfxbT7mR
         JfL9SB7n3gHK8JbOhQmkzLxnr/v0qljAoDLqHHpHq57tY72JlfgJJ3aykj1tLeQtIDDf
         OOfoPyKWJWz1awCXqduOmpzQDGDJriVLYqiGyOEOK2s0Ek0MioR+r97kcvvl5CTgCUBu
         BnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cLEAYLVD6JreucQil+ujhm8FErflJCkoe7KXXK012mc=;
        b=TiLpguve1+LsD2AbwoY8anjTZsHwiUom/306aEOABtCuVeJJmO9wMLuBVjyv66uzMS
         A7vGG53x/4w5hdCPKBsgGcpwQ3CF4uOKXZGLEzx0C4g2wDDfPrX80MmyLNSq7ia5SObR
         6uwYGof5n1niT64uVfjARy9MwXOWOgR1Kv1Tq3fP7qMTVbGI0cz/AuBqfgdNl2qGarCe
         HZLEEvf0N9jyWKpchplk/TZe2HEu1OBiUxk3hB4i4mC/XlkyH5qxW6nVrDam0tdr3yH8
         kfaNcBB4T1noK4ze3/oRqWcVx8rzV2+t/FOxg90RpGzVp4wU+TuErqsHrc5iQOf+UUbg
         jm0Q==
X-Gm-Message-State: AGi0Puag03/b0ARMWW7IASTvWijXUfCdGRePl4C8g+5azAhwv54y3G8j
        ZJVKXKN7U+nEYLFFY4x5dCfGyiMAQ53Yf4wDXS4SwQ==
X-Google-Smtp-Source: APiQypImINfWk/azU+gh8VqSVBC+bjXOzMV58x6QAkL+twgu0FTJCnw6HhztAFigezzRtYkv2vWuAeZSEaiXI9PcO8g=
X-Received: by 2002:a92:390f:: with SMTP id g15mr1559060ila.72.1589306432104;
 Tue, 12 May 2020 11:00:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200507053547.13707-1-calvin.johnson@oss.nxp.com>
In-Reply-To: <20200507053547.13707-1-calvin.johnson@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 12 May 2020 12:00:21 -0600
Message-ID: <CANLsYkzeHpZygbQtz8Ed7dEaVMz362ftHQJ50DrBYR=+72NpJQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: remove incorrect NULL return check
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mike Leach <mike.leach@linaro.org>, linux.cj@gmail.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Wed, 6 May 2020 at 23:36, Calvin Johnson <calvin.johnson@oss.nxp.com> wrote:
>
> fwnode_find_reference() doesn't return NULL and hence that check
> should be avoided.
>
> Signed-off-by: Calvin Johnson <calvin.johnson@oss.nxp.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

I just noticed you were not CC'ed on the original conversation Calvin
and I had and as such you probably don't know what to do with this
patch.  Please see if you can pick it up as a fix for 5.7.  If that is
not possible I will queue it up for inclusion in the 5.8 cycle.

Thanks,
Mathieu

> ---
>
>  drivers/hwtracing/coresight/coresight-cti-platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti-platform.c b/drivers/hwtracing/coresight/coresight-cti-platform.c
> index b44d83142b62..2fdaeec80ee5 100644
> --- a/drivers/hwtracing/coresight/coresight-cti-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-cti-platform.c
> @@ -120,7 +120,7 @@ static int cti_plat_create_v8_etm_connection(struct device *dev,
>
>         /* Can optionally have an etm node - return if not  */
>         cs_fwnode = fwnode_find_reference(root_fwnode, CTI_DT_CSDEV_ASSOC, 0);
> -       if (IS_ERR_OR_NULL(cs_fwnode))
> +       if (IS_ERR(cs_fwnode))
>                 return 0;
>
>         /* allocate memory */
> @@ -393,7 +393,7 @@ static int cti_plat_create_connection(struct device *dev,
>                 /* associated device ? */
>                 cs_fwnode = fwnode_find_reference(fwnode,
>                                                   CTI_DT_CSDEV_ASSOC, 0);
> -               if (!IS_ERR_OR_NULL(cs_fwnode)) {
> +               if (!IS_ERR(cs_fwnode)) {
>                         assoc_name = cti_plat_get_csdev_or_node_name(cs_fwnode,
>                                                                      &csdev);
>                         fwnode_handle_put(cs_fwnode);
> --
> 2.17.1
>
