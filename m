Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B04C2BBC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC9A20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+HQzlSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgDIOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:14:12 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43970 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDIOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:14:10 -0400
Received: by mail-lf1-f67.google.com with SMTP id k28so7990867lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5l6PQ+GVRa7BU6U1ZntSLjLMMgypiepyMSXTfzbcfec=;
        b=K+HQzlSADdA/gU9UN5hsyB/wBOLVrotfN1xcU/hiZ4MkzvC/09TmlJ0cMyNtSK85i+
         /HAQ2E/Oq/VmfOyviHdluDWMX4GMsQYVcRHcSkRiTUWsAUBQULwzl9MbP9eMUlzS7ow6
         IjtTG82w6zZ1vVJgylNTT7jPU516wUFxUqGJP8DreizdEF+C/Ij4pyuklFd2Xu722SgG
         iEiKbRVjaT8d8R/A0tfm1CRwsp/jU5dN/vDeYHwLFOL0KeeYzQc3VHbkXSn6qUwF+is9
         9bEywhJO0uB7J2Ht3v6eV244MIBu46Qx/PUfed00wwxDaC/D9E5xhv05vCqU6i6aOc99
         zyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5l6PQ+GVRa7BU6U1ZntSLjLMMgypiepyMSXTfzbcfec=;
        b=a/GZVPxDDR7bClFZXb+45eZMDjcFRWENC9YLdwLHzBZWStjJQvpWmGzRiBxbrT7gs6
         d8G3NjYdodWMT98UYpWP9U5BOAO6x+qfcY4qVJRb+MxGiCrab8cVWUr7+gx3AZ5edlB4
         RUZ802VEOyFzOcDf2iPYzx2R1WYcgkFvttqm/84fsCcUuEG11NnYMvhwOY2XeINN5Vwz
         ms5SyCmWeCDMUz0XtB1druJ9mJwdhFYDw0G1bz9S1PeMp1MyHl25Jn8Vrd954sexg5uK
         NDpIn8Njhlqtqk9p2ljh6h23vrsll/9edupKQqRqbkA871FECgJzA2tiRuMJ00CfmF0S
         NpBw==
X-Gm-Message-State: AGi0PuYFsV5Km0ovDthpY4QERSBU9JxSxI0kYf6eI73pQ2Tpfk7CYmGR
        ogdQyljpmhxxrObE/aYYQhgONDEgNvjAd+LbC1c=
X-Google-Smtp-Source: APiQypLlMrBVdUqdc71hA6o3EJAn4zXAycY/2wmHzaXHCp+RIRfuYi7Nw8iUkdf3tCEZE1im8tZoNiItZj0w8w2Jx8A=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr7913943lfh.90.1586441648993;
 Thu, 09 Apr 2020 07:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1586422035.git.baolin.wang7@gmail.com> <759f7471d03946ae273a06f7bcca8a54528ec08c.1586422035.git.baolin.wang7@gmail.com>
 <20200409104802.GB5399@sirena.org.uk>
In-Reply-To: <20200409104802.GB5399@sirena.org.uk>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 9 Apr 2020 22:13:58 +0800
Message-ID: <CADBw62oh6juAqUR1-U1D73H0oeW1x0gk0XJ01h47ko_Dxy7eEQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mfd: syscon: Add reg_update_bits() callback support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 6:48 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Apr 09, 2020 at 04:57:57PM +0800, Baolin Wang wrote:
>
> > --- a/include/linux/regmap.h
> > +++ b/include/linux/regmap.h
> > @@ -340,6 +340,8 @@ struct regmap_access_table {
> >   *             read operation on a bus such as SPI, I2C, etc. Most of the
> >   *             devices do not need this.
> >   * @reg_write:         Same as above for writing.
> > + * @reg_update_bits: Optional, should only be provided for devices whose update
> > + *                operation cannot be represented as read and write.
> >   * @fast_io:   Register IO is fast. Use a spinlock instead of a mutex
> >   *             to perform locking. This field is ignored if custom lock/unlock
> >   *             functions are used (see fields lock/unlock of struct regmap_config).
> > @@ -416,6 +418,8 @@ struct regmap_config {
> >
> >       int (*reg_read)(void *context, unsigned int reg, unsigned int *val);
> >       int (*reg_write)(void *context, unsigned int reg, unsigned int val);
> > +     int (*reg_update_bits)(void *context, unsigned int reg,
> > +                            unsigned int mask, unsigned int val);
>
> This is fine, we already have this operation for buses, but why is this
> munged in with the MFD patch?

Originally I want to show a example usage of the new callback, but I
can spilt them into 2 patches as you suggested. Thanks.

-- 
Baolin Wang
