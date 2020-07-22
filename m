Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F3DA20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R9y8+MKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgGVJza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGVJz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:55:29 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6FFC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:55:29 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so1256418wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kxSvJk8PPx85/FfqsccMmNMJL7JRomVt0OX9zD7tg3k=;
        b=R9y8+MKxhAGY+kSUmAdhrWM4yqyhfwT6dhGHfhkKsZeX7vXNAGA8IFPEl1hXUrfYD4
         WsDhPNz8WK1FByKUdXLD3XxoSgmLfu4rOop0ST/BnN4Ytd3dauao8CEHgdX5UzYjwK/X
         0ou3iRXjpIlPMdkAf3vMYpORaMFboFwB/giYGmeEa1bU/1UbksdzVuU1ewk8d4e+Df6j
         bv47KEvHL0jglmiyj2WDIOdv28hLuXxtp5Pri7uI4pBbLuluEyCqagl7ut7mKOfKWeBV
         DHCEOLPNHTrDg7Eh8iXnNgwb1D3nSG3VjJhftF5m6n/pxykenWUmFTBPkROev4PIyCs/
         tDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kxSvJk8PPx85/FfqsccMmNMJL7JRomVt0OX9zD7tg3k=;
        b=N0I3M1GFfux+m8wHjSGXHEqvmFts6VvBwu+roqYhGuphHe1uSinnPtuvLarJGXi0vG
         xwWhfEl+tpcwfHAlyKFsrDR3y2B1b6I+r6KThsW+iT/hKKWPC1L+/tfPQWt9a8cOIP8c
         WBE9SwSd/FC7GeX4LE9dNOFsZyuzshQ1l4ZRjQ6Zebv8eoecJV6onp0vUnZogI9qMAZG
         uMOpX/LbcKvXTV9BPf6kBtfXks5EaJ619GxPpkiTHtWoI2orNkQYUVW8Ayl38eN/5x7E
         iV7dJh2XCc80BZ2fPy9pbTGFPN9TOqojb7ugmVsGSLR9PTJ7RU1fXgga0aIC03jbi4pI
         V5Jw==
X-Gm-Message-State: AOAM533BVsiG7a+hIOD6N6eBXblvkowaR/naNC2MCnKrrr4Y4UIe+n3H
        c1680sAZiA26UYhKDj12FrFNMA==
X-Google-Smtp-Source: ABdhPJweVofYVl95BVJfDYpC0Nne2OWxwglmHkb5eMKOIUPDke+KD6Nb8Iif50Xf2/ZdtjhLxj3gIw==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr10430631wrn.225.1595411728204;
        Wed, 22 Jul 2020 02:55:28 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id w7sm6733476wmc.32.2020.07.22.02.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:55:27 -0700 (PDT)
Date:   Wed, 22 Jul 2020 10:55:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH] MFD: max77693-private.h: drop a duplicated word
Message-ID: <20200722095525.GL621928@dell>
References: <20200719002931.20571-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200719002931.20571-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020, Randy Dunlap wrote:

> Drop the repeated word "in" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/max77693-private.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Fixed up the subject line for you.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
