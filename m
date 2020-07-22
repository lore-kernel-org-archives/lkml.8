Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5F2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 752F020714
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="csJWD79/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgGVJyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727819AbgGVJyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:54:16 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EFAC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:54:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 184so1394291wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RHQiUVBKwsdsF7AZC7QnCNkB3D/ZZ2Z+fOAYpbXSgRM=;
        b=csJWD79/EGCTPRXzS0S34wU3Yi1tRkRw4QpCGVrfBP8ywlMjEaUMLeENuFFbbO047f
         m70s6wv6vbg9mS5Tf3j7WSMZED8EHok3Hxlb60XBJ42gej5WDAy2CPEDO7Egrr9UyHtq
         ZTdNBLenWCwJwG0E9e5TZ1XRIWY3oLUkrd8mYwm8Fw/wTzybnmafbGuoLGXKfmN9nWvd
         ObKl69G71JKqj44k+VZF78i8RekJq3Ez5nvkmfGmew1JXo8SpNEWYJC8uZvy7w2yMPNJ
         Z3GqW349u9425z3UMgyHxd5VOWkSTwluklqAq+MwwT+Tuo/UAEeQA7hJ2UBZ2sK7tswY
         zbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RHQiUVBKwsdsF7AZC7QnCNkB3D/ZZ2Z+fOAYpbXSgRM=;
        b=HE3/Sbf1JJxbURlgyfn1HRceEvU4DuP6fDU/z1vM1zi/xmXBSGOcTbRU1UWhfMTaPb
         NaJR+Xb1C5mW9iZ9d8y8w7PnDQxpT0xpGgciHabCdybvLkHN54J9RcOm6HlVwF+Z+69i
         r1uEVRM02irJdafug3tcLgkdcDJdw8dxiZgxuKsNfQ/70Ilxi9vYFvHQshhjDRLhpUn5
         F8iCI9bz6Ymspz/ne32zbr3fcIKX5Pfm5CFN3Q1LHy9OKD+dv6ZsadLwr78OoJxcWx70
         e2NW5zF5hn5ZBOLja9wJJ/E5Cki7Jf44kgBs1pKpHWdB4t9FqgFiJ0kCzbcTOonxSbzJ
         ilIw==
X-Gm-Message-State: AOAM531UUmSSx56W3EFlm6j1Z7phpfJ83rGd0HtkLX6JdcNuECI0m+gl
        68r+XHOqCPUrsKxYgSYhW4YAbGcRW8E=
X-Google-Smtp-Source: ABdhPJzoLl2Q0cO0zSy5tAEFDRk0NNlf04sEtzJB1WZu9dpXk5eVatiL5wYEtd4KzivQZv7wcWtqXQ==
X-Received: by 2002:a7b:c4d7:: with SMTP id g23mr8389054wmk.17.1595411655327;
        Wed, 22 Jul 2020 02:54:15 -0700 (PDT)
Received: from dell ([2.27.167.94])
        by smtp.gmail.com with ESMTPSA id y189sm7439025wmd.27.2020.07.22.02.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:54:14 -0700 (PDT)
Date:   Wed, 22 Jul 2020 10:54:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH] MFD: da9055/pdata.h: drop a duplicated word
Message-ID: <20200722095413.GK621928@dell>
References: <20200719002917.20521-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200719002917.20521-1-rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020, Randy Dunlap wrote:

> Drop the repeated word "that" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/mfd/da9055/pdata.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I fixed up the subject line to match what is expected of the SS.

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
