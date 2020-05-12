Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41099C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2071520747
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rwCA7Rt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbgELLtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:49:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37823C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:49:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h4so13256980ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LaN40dqXaRdgr+itxZUWzR4xWLlgoAEeZw85S/t/at0=;
        b=rwCA7Rt2qANtiQ1cyJisGlj52sRYBq7zbk5/4TT1kGGAX5i7eijZbUHqjB7XeMtVK6
         0NCBd2NrzB8IHtgcaRVzKuFDU7c7SqP6t3hEj11m3Mn9ITaO6oTnc69X706rR8l7Q+ro
         n3TFb8q0OwfkqdJHauWFFZBXJczkJa/njkERdmIR+kVjmA4mvIwhXZRF1b88vCQ96wlr
         bn1JysDUZ9XSRKakRudo0R018IEw5XpdGscj9Fco0gWcygt/iuDEUNnspGFEsgNlxw5+
         MUwRO+9YK5h5tDbK/ekLGMO5rAO06IQlTANQWCdUYsDxktfNfn8/hLboScSCkyo0DLTb
         tBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LaN40dqXaRdgr+itxZUWzR4xWLlgoAEeZw85S/t/at0=;
        b=Ugg+Twfd8sOGlNFF6GSK0jmfcNKLxStf3C5q48JLVxNVqoKnzOHoFGEZdMT6dzokjP
         hGHc6W55x0x+fEz9hdGYfAWXXDg9DO6/2v25EcGrxds1r34uKPklYpzPODOeTUBUnNUE
         gEpFN+8oRjo8EHVbL0BS0bRxxfW+RsvEOd5iM1JJWf3EMi1pz4Bp512LAOIjjwSvESs7
         G7K1kqLGnAGSB9P675+mKwx9S+n9EValbEXqLn+lQpZ262Oo6P8GpC57Rym6/I5IQDxm
         sNZYObtH+8gm0d5I3LQPIRGxN441StScRLu8eKMG4MB38ro5z7an7TCLk3HoZmiE9M2b
         Cq2Q==
X-Gm-Message-State: AOAM532ZsqBprf2C7Jny3WVw6E14KlnyzFf0QCFpuQgo2a2+M7g5z7Cc
        zrF8Cou4BXap4Jc69gyum8BICekqJKIa3+jaJ3PiZg==
X-Google-Smtp-Source: ABdhPJzH0WBo+S41IQb7cfAxprmCk+6/byQtNll0cLlMLCB+prcvinTQdNVQlk9tigEy64l94Ilx3732NrcK0VCb74Q=
X-Received: by 2002:a2e:8805:: with SMTP id x5mr13984293ljh.223.1589284156747;
 Tue, 12 May 2020 04:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200428141459.87624-1-weiyongjun1@huawei.com>
In-Reply-To: <20200428141459.87624-1-weiyongjun1@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 May 2020 13:49:05 +0200
Message-ID: <CACRpkdZ++vYw8LAiNUv6AXQ0QTh+W9vSL0_w2AR-GNNd=GH7FA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mcde: dsi: Fix return value check in dev_err()
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 4:13 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:

> In case of error, the function of_drm_find_bridge() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Patch applied! Thanks Wei, sorry for the long delay.

Yours,
Linus Walleij
