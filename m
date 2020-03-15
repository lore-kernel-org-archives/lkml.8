Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4885CC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 12:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B01820663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 12:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJURvzgK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbgCOMjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 08:39:01 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52964 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgCOMjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 08:39:00 -0400
Received: by mail-pj1-f67.google.com with SMTP id f15so6585111pjq.2;
        Sun, 15 Mar 2020 05:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/JmdDH59rdv7DEibIPWZ7GdWNI7WIfFiOZu+jrSl3Oo=;
        b=hJURvzgKdvmu7/uyg0oRe/r8CLRcXnIgKllpmpoFa99OWuAKm8jhXBZxwDLnkp4DTE
         ohZcs0tlnPz68VlOjPFjmje+IZ2rf79qKIBxN/NMwTxN0l3xM0ReA57Mv8rmQRJrVhXj
         /vkSqg6o3ZB6XazQsltgb7aT1XEStd1/lnF3mDyKyT9r9gcv+qATu2YjzJXUSJmWPczQ
         aAqis9mSpbpqaKwMin/LA/zdun1yQj0OGZz6v5cbLLSyn7ppXiVbA3xmy7w/q52I00Dn
         AjpiU4Snl40bxt1LumJwzrXYOaKDIwfQz5V4uohUVoiYPd8pYbgMqu5WjQeobe2uhYfg
         4RvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/JmdDH59rdv7DEibIPWZ7GdWNI7WIfFiOZu+jrSl3Oo=;
        b=D4ClCgacC7rUXmTp2NRhdu8vkxIFqHDWQrGDXL0atOMWyyE/SxggDkd12Bu2veZp5d
         NTHuhjh/kHZA+WEgOjtJr1yosOJF5Fba6LJNIH7VFtC2Vo54rFvaUQdNSkgGZxv+nTXQ
         aYLt3lFJue0tP0oItWJvmLwB/7edT6msSjc87D+WLTAjickKgFUme1K56EQ2CFPJMFbG
         7Mmi4JCFv8LE3/UcMuo4U4Glh3SnzbG1hrlepIcu9PTeKoFWRqHQiGGqE03n29YGNL9W
         3MQ0QmcltrjnmOhWPU2EOGVpznBI941RgkqRhSH1494U1fSlHvTcSoi1VW6qP1MSLmKs
         dALA==
X-Gm-Message-State: ANhLgQ3nz3zUFndpA2/GCtva7hDFmpeq7VPURIy671aS4p9woOg+woXv
        SLwcMsr3ZAsaxgQDUhpZOJM0Q8ck
X-Google-Smtp-Source: ADFU+vsB37XDNXWbOdHD+OhqBvUd1lvACOl/Q+1+zDsqZgrBCVnbY2Rza6J50PYzNWWemVYVQR8aBQ==
X-Received: by 2002:a17:90a:a483:: with SMTP id z3mr20596769pjp.43.1584275938122;
        Sun, 15 Mar 2020 05:38:58 -0700 (PDT)
Received: from localhost (216.24.188.11.16clouds.com. [216.24.188.11])
        by smtp.gmail.com with ESMTPSA id w205sm7718352pfc.75.2020.03.15.05.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 05:38:57 -0700 (PDT)
Date:   Sun, 15 Mar 2020 20:38:55 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, hminas@synopsys.com,
        mathias.nyman@intel.com, bgolaszewski@baylibre.com, arnd@arndb.de,
        geert@linux-m68k.org, mchehab+samsung@kernel.org,
        treding@nvidia.com, tglx@linutronix.de, suzuki.poulose@arm.com,
        hdegoede@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] drivers: provide
 devm_platform_ioremap_and_get_resource()
Message-ID: <20200315123855.GB13262@nuc8i5>
References: <20200314052638.6008-1-zhengdejin5@gmail.com>
 <20200314052638.6008-2-zhengdejin5@gmail.com>
 <a7cbeabf-a7c3-b960-7aca-e124e98f9c7f@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7cbeabf-a7c3-b960-7aca-e124e98f9c7f@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 15, 2020 at 01:01:14PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 14.03.2020 8:26, Dejin Zheng wrote:
> 
> > Since commit "drivers: provide devm_platform_ioremap_resource()",
> > It was wrap platform_get_resource() and devm_ioremap_resource() as
>   ^^ it
Ok and Thanks!

> 
> > single helper devm_platform_ioremap_resource(). but now, many drivers
> > still used platform_get_resource() and devm_ioremap_resource()
> > together in the kernel tree. The reason can not be replaced is they
> > still need use the resource variables obtained by platform_get_resource().
> > so provide this helper.
> 
>    Not really sure that's worth the effort...
>
Many drivers using platform_get_resource() and devm_ioremap_resource() together
in the kernel tree. if use this helper, have one function call less.

> > Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
> > ---
> >   drivers/base/platform.c         | 18 ++++++++++++++++++
> >   include/linux/platform_device.h |  3 +++
> >   2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> > index 7fa654f1288b..b3e2409effae 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -62,6 +62,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
> >   EXPORT_SYMBOL_GPL(platform_get_resource);
> >   #ifdef CONFIG_HAS_IOMEM
> > +/**
> > + * devm_platform_ioremap_and_get_resource - call devm_ioremap_resource() for a
> > + *					    platform device and get resource
> > + *
> > + * @pdev: platform device to use both for memory resource lookup as well as
> > + *        resource management
> > + * @index: resource index
> > + * @res: get the resource
> > + */
> > +void __iomem *
> > +devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
> > +				unsigned int index, struct resource **res)
> > +{
> > +	*res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> > +	return devm_ioremap_resource(&pdev->dev, *res);
> > +}
> > +EXPORT_SYMBOL_GPL(devm_platform_ioremap_and_get_resource);
> 
>    That looks more like devm_platform_get_and_ioremap_resource().
> 
Thanks for your suggestions. I will do it.

> [...]
> 
> MBR, Sergei

BR,
Dejin
