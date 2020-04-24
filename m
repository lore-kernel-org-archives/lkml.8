Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDCDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2FCE20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9O7zP5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgDXIc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXIc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:32:59 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29775C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:32:59 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so9700834wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HH7SBcIHpC3+oSovD7oT6/tXCz3H7a1cytYYIbkSHU4=;
        b=p9O7zP5Y2QyMsyNfDxdcW41y61KcamnRw5j58fC5Fze3ViVEvp2UvOGVJ9GIfiINL/
         IbOaR8d12Rnwg5fiNVfxBgORzMNCPLhthTvb3oEXsJ2frWW9aVw9xGpuA5Trv3aTL/DS
         Q9cLiyOfuyReoUeMsEBdkDP9iKzFAUq/6iA0owbnwgVm6yue6KpnrI020pVsQRgWNUU7
         RPBmhxN4HvdLwSGKXVbRpRlvumMMOQYKHyDonlsBON0nb3IWSwaOgihSBXkp8iBr9NjS
         yK2HoqrzsDE+/HAdSZn8405OlfOqysrQfPjY6qlJgkJZSiQwtN6rD4SJirkFUvpz+LD6
         I80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HH7SBcIHpC3+oSovD7oT6/tXCz3H7a1cytYYIbkSHU4=;
        b=HFQmNDaxWY0XaePFZCdII8/2QNkIkFOuLAYlYS+Fw7C6ulf9Z1TKjpK3EGJopetcMk
         5zXYfOzMHyR2WKjTIT82sxerJrzV2G7qgkDnPsFaaZ1zpEYTCTJGrV1aQLDCpO0KMCOq
         8oS+wd7ggVV06Ncbgz9cJ4mbNMuvKmR+0PGCX6Pq0hUZ9UNk9NOdKVnuZujseINDRiw7
         liJMVHYXNV0MKtaJuik2So86KRoDZ9wZxc2CDNfTzAsxrZi6ezuA2Eyrgmhwk/ikkQ+0
         OhaGcE17rqmQ4jm2TCic9ybyrEs75Q+ISaG3vcOThst7j55+s+hXNsUNiH3XmC4ROm17
         cIVA==
X-Gm-Message-State: AGi0PuadLQNKtKu5uOmI1DHxrykJpzWg1mx54T41Rftwl3sJ+sv6XvhK
        AGMCDFudW/nzcTtGNMaUZpWNKcZQ2WU=
X-Google-Smtp-Source: APiQypKno5VpdylTTiSqfpE25fV4uVJIjWZSYsgg6vaekGhwxp4WP+vg2Bhmx7rO7D7rpCt+fqDFSA==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr8738607wmg.70.1587717177710;
        Fri, 24 Apr 2020 01:32:57 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id k14sm7480852wrp.53.2020.04.24.01.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 01:32:57 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:32:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mfd: syscon: Support physical regmap bus
Message-ID: <20200424083255.GQ3612@dell>
References: <cover.1587088646.git.baolin.wang7@gmail.com>
 <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
 <20200424081138.GP3612@dell>
 <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020, Arnd Bergmann wrote:

> On Fri, Apr 24, 2020 at 10:11 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Fri, 17 Apr 2020, Baolin Wang wrote:
> > > @@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> > >       syscon_config.val_bits = reg_io_width * 8;
> > >       syscon_config.max_register = resource_size(&res) - reg_io_width;
> > >
> > > -     regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > > +      /*
> > > +       * The Spreadtrum syscon need register a real physical regmap bus
> > > +       * with new atomic bits updating operation instead of using
> > > +       * read-modify-write.
> > > +       */
> > > +     if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> > > +         of_device_is_compatible(np, "sprd,atomic-syscon") &&
> >
> > Please find a more generic way of supporting your use-case.  This is a
> > generic driver, and as such I am vehemently against adding any sort of
> > vendor specific code in here.
> 
> I suggested doing it this way, as all alternatives seemed worse than this.

If we're using a registration function (could probably be swapped out
for or accompanied by a Device Tree property) anyway, then why conduct
the vendor platform checks?

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
