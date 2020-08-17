Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC31C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B06032063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v15ar5ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHQJL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgHQJLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:11:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4447C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:11:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so14209581wrf.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 02:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=07PeHWdMcjvU0Z3mRCz4j6J4OnybjlFdXNQEtkp5iNM=;
        b=v15ar5ZUf9fg2i9QpHlhA6tdSPxe3HKgh6yeZR7gDrMQwuAwkn6z0ypi/Jst3Xy+/9
         znCE6w6lWD3t0eiVK1ZnPHfiRnsWsNz+N0PIp5zraYB3uKpz2TBYyrDWVPEhcZ9G9tBv
         mby8rluoaeyMAXtw9tU5Mb8qKohXcPYb0BJkvdX+bZRi5rl0V1Y2GdLEdEp+tX/IuqiZ
         pFNDiah4j6cRgiSjjUcXqrHTdSJw+qCfUzu+CM+b/Dft1Q8pQrScUi5PmBDf9fvZh925
         1Q7Sv9WDpx0GX/iB1FJBym/ML+ZNHveCrT5hC/Q1z1IHpgFqmxaMnqt9+Z2wW4DnPHqN
         wNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=07PeHWdMcjvU0Z3mRCz4j6J4OnybjlFdXNQEtkp5iNM=;
        b=XDoaCD5mW9MzLUQyTKSLatqOWpq1jHstPustS8lYb4/UvUCwOjg+4sNv26T0AX0dvz
         h7kgJRwfOBpEm4kuaYRLLSCJML9MBszW8St3fhdmRQOmZVabCLt32GmYdEsKTeOPPC/Q
         WyE7EBPVu36W3oMmXGdtmgLm5i+FJ4SHaB6EmxV8fKCNRMuBEt6HjceJ3yYko03FuIpF
         vbBxNKdunbnR03vnkJKDWo9doBLR/8G/DvivgQgAV8FmP6LOwVWhOeW9YHHNXdGX8q58
         LpEQ0xk+VrWqkmmbChPsGgObA30Kec1ZB0HbdEd3tWVshkwb3lPH3InKU4TrLNyxaz+Q
         fvPg==
X-Gm-Message-State: AOAM533O1FzaV41W+NAvEmEcKnz/gBFbO1qrgNwSL0kO+J+CsvATZEg3
        VY7V+D+vaKdpeLizdS4vG5nWzw==
X-Google-Smtp-Source: ABdhPJzb6oTwo2yK93dI70IfJGN9epiVad6B2+zA3GHeS9TaBGz+cBETqM9IVYZ/+Y6/tC5EHWTY/A==
X-Received: by 2002:a5d:6910:: with SMTP id t16mr15249162wru.178.1597655502546;
        Mon, 17 Aug 2020 02:11:42 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id 15sm27555396wmo.33.2020.08.17.02.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:11:41 -0700 (PDT)
Date:   Mon, 17 Aug 2020 10:11:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     David Miller <davem@davemloft.net>, kuba@kernel.org,
        Michael Buesch <m@bues.ch>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        Network Development <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        b43-dev <b43-dev@lists.infradead.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Martin Langer <martin-langer@gmx.de>,
        van Dyk <kugelfang@gentoo.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: Re: [PATCH 26/30] net: wireless: broadcom: b43: phy_common: Demote
 non-conformant kerneldoc header
Message-ID: <20200817091139.GU4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-27-lee.jones@linaro.org>
 <CACna6ryNNyyVftEFNFEwouKc3O21oPaeqie+bjJR4L_Cf8z2BQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACna6ryNNyyVftEFNFEwouKc3O21oPaeqie+bjJR4L_Cf8z2BQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020, Rafał Miłecki wrote:

> On Fri, 14 Aug 2020 at 13:41, Lee Jones <lee.jones@linaro.org> wrote:
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/net/wireless/broadcom/b43/phy_common.c:467: warning: Function parameter or member 'work' not described in 'b43_phy_txpower_adjust_work'
> 
> Why you can't document @work instead? Should be quite a better solution.

It some circumstances it would, but not this one.

 1. This 'kernel-doc' function is not referenced from any
    documentation location i.e. it is presently unused and there is no
    reason for it to be kernel-doc in the first place.
 2. This patch stops `scripts/find-unused-docs.sh` complaining about
    phy_common.c
 3. 'b43_phy_txpower_adjust_work' is the only function that has been
     documented as kernel-doc - why is that?  Seems like a mistake.
 
-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
