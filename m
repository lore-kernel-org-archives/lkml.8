Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 388B5C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B3DD206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 17:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWpewJSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgDURYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 13:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725930AbgDURYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:24:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C960C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:24:32 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so5496064plt.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L2/tuyyrk+FrC+TVWKAO9Jkv7cmo4/vzdDOJ54GNqZ0=;
        b=IWpewJSykrsnWxN4K46c7BXyiKGU5U5+mh07wYceXa0O/DjBweXi+37HQV6tvxior8
         HDFIvxDRQZvnytbETu4ORlFbuLNAvRUZK06E6ocYW7wZu3MO0ot/BhZfVywbZG5Q50QL
         uhYIs5AGh2Ws5lc7HIcAFax5orO6IPLEuQ4MUp3tO8d9xZqSM/jnmzB2XmrdyBBMlzBA
         Nc+q2c2kebrbl7Q0mknsP2gTP5mwFdo5px3V0KHY+UtIh9rPfDAMM4hb/JVZj9ZdEujZ
         35nYpMtceYIjgLbKPL5kiaQ0fbIdc4SA15dZZhg0NguR4NdcLqUIeGKiT7WOdc3yeyJx
         14NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L2/tuyyrk+FrC+TVWKAO9Jkv7cmo4/vzdDOJ54GNqZ0=;
        b=XAk1T32fkxmBx7GUqJHfndEnoqlS4BT4ru+rhYvTXl7hrs7HjMCAbOL50Aa7Fil5Q9
         Gaoft2EluUbWu2miJbyYzn+fp9ePbdQwx21714YwmJ7IK/JiT4LG0OGdc8EbVC7hkdw6
         b59EJHBzbpuBzkx9iUFvXaIPAUGcghl8ykteUWrlOplaGMz6TDVedR53fasgrAxShtRr
         QicTawOsLBobfW3L/KC/HibB9/difcBsAYoVjgA+xZEpIaahpe4oRCGpfRN8/a7fOgol
         w8nLYWAYH/+FtBp9CAmrqXb2MZEUyz3DmBTmLlpoIi8KKD3PGAaoMfSks+1Nn0bo1H9M
         xtVw==
X-Gm-Message-State: AGi0PuaKHNK95k6C8VvsPeKtF3imdhnkbf2nXDpgawiAGmizFn/F239i
        WPI78TRcbSgpQL7MVEYj7l6kxwzj5VPgvjPxNGw=
X-Google-Smtp-Source: APiQypLrw+ulWURfZADaQwTNudM24Gky3/1zWkBus2GpUzJiXP5056wZocjopPa5wu8+IgkOOwrer2mXCfEh+NM3RgA=
X-Received: by 2002:a17:90a:2401:: with SMTP id h1mr7010141pje.1.1587489871604;
 Tue, 21 Apr 2020 10:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200421164543.16605-1-zhengdejin5@gmail.com>
In-Reply-To: <20200421164543.16605-1-zhengdejin5@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Apr 2020 20:24:24 +0300
Message-ID: <CAHp75Ve4JwkM+=WHHF73jwNwRS39E-xPDrcn77zCUTpVkj8buA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/bochs: fix an issue of ioremap() leak
To:     Dejin Zheng <zhengdejin5@gmail.com>
Cc:     kraxel@redhat.com, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 7:45 PM Dejin Zheng <zhengdejin5@gmail.com> wrote:
>
> It forgot to call bochs_hw_fini() to release related resources when
> bochs_pci_probe() fail. eg: io virtual address get by ioremap().

Good start, although I think the best is to switch this driver to use
pcim_*() functions and drop tons of legacy code.

> Fixes: 81da8c3b8d3df6 ("drm/bochs: add drm_driver.release callback.")
> CC: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> ---
>  drivers/gpu/drm/bochs/bochs_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/bochs/bochs_drv.c b/drivers/gpu/drm/bochs/bochs_drv.c
> index addb0568c1af..210a60135c8a 100644
> --- a/drivers/gpu/drm/bochs/bochs_drv.c
> +++ b/drivers/gpu/drm/bochs/bochs_drv.c
> @@ -138,6 +138,7 @@ static int bochs_pci_probe(struct pci_dev *pdev,
>         return ret;
>
>  err_unload:
> +       bochs_hw_fini(dev);
>         bochs_unload(dev);
>  err_free_dev:
>         drm_dev_put(dev);
> --
> 2.25.0
>


-- 
With Best Regards,
Andy Shevchenko
