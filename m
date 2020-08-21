Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25369C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBA22078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rC73kmB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgHUHfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgHUHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:35:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDA9C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:35:08 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id p20so1070945wrf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6TsSI3ppmDACGnTZYw4xLaVEW0FRiRe0kRZdKFZhNfs=;
        b=rC73kmB0BhicAqRgItfbrXIaZAxXezkk4wQCgK+hqYp//haaWwZ1SeAEIZ2pcgOj/i
         TfeRNRwUAisHpNDbNZK6xUMM4wHFmp2oLmW/P9Rhh2ZyxHcQoR8bLM2AmX+oqmn5mOe5
         0Vh3wc68SnDb1vR++xtAzTfapBNeB8LGu/Xa2eytzmWbeiG2xP7BaIYfeqgUtG8gW0O9
         gBpUNA+WL1MxqEnKL8ZIk4Gx2Ngwko/VSGIxKXaU+w75b5kZw9IrSHqFb7PuZQlZ7rO0
         G0nzisXOPjdrM+nxyDRQa4TsAGrCDNucYatAcld8oj79Y6ShKLieAAF7AGFUDbPZpup/
         zwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6TsSI3ppmDACGnTZYw4xLaVEW0FRiRe0kRZdKFZhNfs=;
        b=csEZQECo2Rv89h0s7WQXLHXN7d4YTqRE+Cv8zHoOrVJbbaY6D+5Bw/2d//ZLrf9RQA
         n39Pqg4pWNq2RVTpSz9WljUZ/cmOfuqMMCzXP4/peQfNkIfmn3xJa3Z6vm1WOrIe2JBZ
         fx7geG4YFLFzIa4L0ZGEbDqFiHl7oDxaxBCF4BlbqZNcjXrug4ygFLyO9kFyTNpww5Ny
         N1YI4BcDjSMngu1gad8Lw20ivl4HGU1rBw4I/F5pz2nZiJCMyCa55DLBBHPW7YMEABFA
         yn6b+TDPlJ9vc1U//KcGCtnh8nhYUfX7gi12wtzu8SegCBjDIvi1n4hkDXZsr4kxn1iX
         dfbQ==
X-Gm-Message-State: AOAM531AQJBj5ukIcKUBQmO68PGBZDVO4FKJQIdIBr41SMpA3kBAkkM8
        N+aoQLtJ0c1vNujNklHuUWNfHA==
X-Google-Smtp-Source: ABdhPJy7CpTYOdq7LVvg+J9TlPTC032ahciZbkBcbDk7ThcCWVLcy95ZTBeW2zxv1NABYi5DPqhB1w==
X-Received: by 2002:adf:efcc:: with SMTP id i12mr1520057wrp.308.1597995307310;
        Fri, 21 Aug 2020 00:35:07 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n124sm3137824wmn.29.2020.08.21.00.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:35:06 -0700 (PDT)
Date:   Fri, 21 Aug 2020 09:35:04 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     davem@davemloft.net, mripard@kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] crypto: sun8i-ce: move iv data to request
 context
Message-ID: <20200821073504.GA21887@Red>
References: <1595358391-34525-1-git-send-email-clabbe@baylibre.com>
 <1595358391-34525-9-git-send-email-clabbe@baylibre.com>
 <20200731082427.GA28326@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731082427.GA28326@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 06:24:27PM +1000, Herbert Xu wrote:
> On Tue, Jul 21, 2020 at 07:06:22PM +0000, Corentin Labbe wrote:
> > Instead of storing IV data in the channel context, store them in the
> > request context.
> > Storing them in the channel structure was conceptualy wrong since they
> > are per request related.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../allwinner/sun8i-ce/sun8i-ce-cipher.c      | 27 +++++++++----------
> >  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h  | 10 ++++---
> >  2 files changed, 19 insertions(+), 18 deletions(-)
> 
> This patch doesn't apply against cryptodev.
> 

Hello

Since cryptodev now have 453431a54934 ("mm, treewide: rename kzfree() to kfree_sensitive()"), my serie should apply cleanly.

Thanks
Regards
