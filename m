Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23F5C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8523520801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJORh3w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgBZKc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:32:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45710 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgBZKc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:32:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id v2so1239466wrp.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 02:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=lzDEWKPcguCo8G2LOoovjCXzcVBmrP7+p+BK1qciGjU=;
        b=pJORh3w6SN1SakeUIDUAv22ynfige3lJdRAOvIfynhVC5ojBf1Ah+t5Ctldrm1pAFU
         6w/RD07oPzV14/YfdNaLpQWG1fId4OZHQdLF2kPAzWaTwiE8aZbIBlM5GxguTfTZqg3F
         Jpwog9zhhv0qTKZIENBSJA7DXgGGbuWTFJOYoLkMaeG9hf9+BskCTdae5RMy4GCOXgW6
         5DP9Y9ArHNXmphklXCUrCj03L/2V86dWVruMJEHHxEcZFtrXrAIh0T2OyJxGzRoEHmEt
         TJlovug0o/lxaJTm+ON4TuxjbiVfUenWkBy2DZ9NXzNk5hBdKc826oGaX5lOGbKlA99P
         D/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=lzDEWKPcguCo8G2LOoovjCXzcVBmrP7+p+BK1qciGjU=;
        b=amFx+Hbdt68T3Yd+zaIvKg8cPvjSCUKOOvwifeqP0J8hr43HQsXzS/8t/IcRFvBsDr
         1Zh29GnbpY8z3wjkuYAT/tXYAAGn0ZQNkprX6I6F0eqjNHXTGDA4gqBclyc67TvcRdG2
         Y2VFey0QclchxL9esuXb2ELGrGp+0OJIbFMNlZ44316Oxlr4botzzuAtfkNPoVc8KlH3
         NsEE26qyxJ9VlIgx7HjV0rCej9VuDweb2MyPNYrKdNmGzzLhUs0oKWBavNwknEYVarTh
         9QliKwogEa8M/t3QxOYLkWlkhay9LgM012PQOiOdNwUQwodoTuaXQhVKazj276jv4cFx
         sbjQ==
X-Gm-Message-State: APjAAAU3QKoJtMVwnIF1ucJ8RoSlZXHriBps6KVNunnh8j2Ki94LiyzQ
        dMvSmJCZXzReIqvbufG7FPA0Jw==
X-Google-Smtp-Source: APXvYqwzbK/t7bokdb1eFC4fb7dg+m/zuk8ZwzA11pHQK3e6UUZGyhJL//Tzp8JyW9aV6P/sr8YKUA==
X-Received: by 2002:a5d:6544:: with SMTP id z4mr4632606wrv.31.1582713145129;
        Wed, 26 Feb 2020 02:32:25 -0800 (PST)
Received: from dell ([2.31.163.122])
        by smtp.gmail.com with ESMTPSA id o27sm2683343wro.27.2020.02.26.02.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 02:32:24 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:32:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: Re: [PATCH v2 4/5] mfd: rk808: Reduce shutdown duplication
Message-ID: <20200226103255.GH3494@dell>
References: <cover.1578789410.git.robin.murphy@arm.com>
 <c6d320601104ab6502123a8db947c02801de69ea.1578789410.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6d320601104ab6502123a8db947c02801de69ea.1578789410.git.robin.murphy@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jan 2020, Robin Murphy wrote:

> Rather than having 3 almost-identical functions plus the machinery to
> keep track of them, it's far simpler to just dynamically select the
> appropriate register field per variant.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/mfd/rk808.c       | 61 +++++++++++++--------------------------
>  include/linux/mfd/rk808.h |  1 -
>  2 files changed, 20 insertions(+), 42 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
