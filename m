Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89785C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65D51207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/KLeixE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFRSzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgFRSzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 14:55:11 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DC6C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:55:11 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id k11so7516144ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vV2NKAwwG9weRpJh7z4+sc1G6KD1VqKirshMPIkEXII=;
        b=V/KLeixEOssNd4u7OnhM5r55EvUDZwZ39FB2mlsyhLmAgpAsiHpvIVJbcHOBTHzZ/b
         08O0PjMCnUfAnNK8btjtU/2RwrSTV4o2JPpd4PZgwBIJSc1LsA+pzaHnzyosqCQ3gGqM
         rJnIYedtUE6XmXlihheH+Q1Atc5Qo0NT+bpEKVFwdwBESkCU+zN5Vhar0C5B5mqNGWIc
         JzgWkMwL6sIqwOJASIrIgLDRr4bjxmBTSOucaBOsVbqsCkIWyWorsMVsYzkLbBW1QLLn
         zSANQ1nWSIktZ15c0VrOeJJ8l3+xTHM1QbKv5jhVDhHyUlHFkrCEYTIuZQ6yGBn3VlpS
         ifTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vV2NKAwwG9weRpJh7z4+sc1G6KD1VqKirshMPIkEXII=;
        b=hZO8TSDBiREkEYKyGK2Fj1Y3pe1GG5JuVeaXreMvq2jNoWFlZBf4/BKL9Br5b2Z9sH
         aj7GGkBHMuDwGmojICnQtOV+EJO8Vk709djj0+B+nlirm8vAR98fA1q5YP3pN+Fe45Tm
         7BVXF4zsRgcB7KvchqEMRZ90XIGQeAsFXHHFdxdaKIiA7zCEbwi7o2TB15CHjDBhmZi/
         cj3gnail/D78Mkp/FrP7eWArbJoPZzuZnPeXruTLQQNl8pOkh5NhAkmuBNlFJerM3M+J
         d1SBzYnN+Tl3rRVEXVICTsboiWibpxuMZNb+WJV18TBKOJJZYk0KS7d7TtmFHxzVblAO
         pOEg==
X-Gm-Message-State: AOAM530IJecLzD9AGjNyUlhh9+lra+E5hTiEJ45Hro9Gsk+AhaGhmzAY
        f8PlERLxt9uaOJRbFrQbxhc=
X-Google-Smtp-Source: ABdhPJz6LGmuh4lw9b2tQt1mbH5rQZmr1jW8c0RL2FtTKsEeCS71PJENwT29Dh9vgNvPmgBqIR1kvw==
X-Received: by 2002:a17:906:7e5a:: with SMTP id z26mr72834ejr.263.1592506510317;
        Thu, 18 Jun 2020 11:55:10 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:4c3c:7f8a:3583:598e])
        by smtp.gmail.com with ESMTPSA id g25sm2684039edq.34.2020.06.18.11.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 11:55:09 -0700 (PDT)
Date:   Thu, 18 Jun 2020 20:55:07 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
Message-ID: <20200618185507.p5tmurllwygmfwrq@ltop.local>
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
 <202006181747.1x7hGaZR%lkp@intel.com>
 <CAHk-=wi=y6XoZKjxoGf9h4Zj3SPZnA+g5ZjsZ2hKT-AZW7H0ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=y6XoZKjxoGf9h4Zj3SPZnA+g5ZjsZ2hKT-AZW7H0ag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:59:05AM -0700, Linus Torvalds wrote:
> 
> The new warnings don't seem to be due to the kernel test robot having
> an old version of sparse, but just because the error strings changed,
> and presumably the kernel test robot has some "ignore old sparse
> warnings" logic.
> 
> So the warnings all look new, even if they aren't.

What is strange is that only some of these warnings are shown as
new, but not all.  For example it shows
  >> drivers/spi/spi-fsl-spi.c:93:44: sparse:     got void [noderef] __iomem *reg_base

as new, but not the following one:
  drivers/spi/spi-fsl-spi.c:294:44: sparse:     got void [noderef] __iomem *reg_base

while both have their string changed (__iomem).

Just to be sure, I checked this file and (of course) all these
warnings are old ones, caused by a missing __iomem in the assignments:
	struct fsl_spi_reg *reg_base = mspi->reg_base;

Why some are shown as new and some as old is a mystery to me.

-- Luc
