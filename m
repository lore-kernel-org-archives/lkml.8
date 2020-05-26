Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9045C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0C5120787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 07:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t5FQ5+ta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731685AbgEZH50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 03:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731406AbgEZH5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:57:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379FCC03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:57:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so19428291wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 00:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=f4CVXpIwbYA1/rSO3By0QAy5Aok5IdKGfU45oFxadek=;
        b=t5FQ5+tazNQZsu+Wc06IXbeyHxcZj04wOnM1WAOZod74jk0nVN+HvZzxoUv6Dz7tsI
         EApI6/nxS/j2UONJ+N8D/YNKcNnNSA6Xm5bRC28FTWy46oex7A7mQ6BMELMNQs4wc3Fq
         9yI0xDi7xVi7P9vfcei2EAKKljYXwHgjtiHk9yeXjLTW0DjfQYLbUiUMYkueG8npr5YO
         ZN+HNILf+FzKYTZ2Wk/Wkg5PVV6F9ejS/1DWzrGFd4q3EWqxBxUMdXLUSuqsBA2+XJDN
         VOiJtBaucsQF58wwW0ai/ukJlm72bo7w0CD+ufxxLvroTcQEKIOCU2Sh+yO81YHi3v3G
         D1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=f4CVXpIwbYA1/rSO3By0QAy5Aok5IdKGfU45oFxadek=;
        b=Wnnd8LgQJgOspMmGhy6MKYUttBTsEaNZy3br5JWYv3C+ATM4K7vazWi+dkt9oC/Bnp
         bOZ/iyLHOwyoVZor0JBko+BaarbtXje0kW4abUi1XHLSD2DbQ0I2ZhV+dwFZH2fW1UWJ
         gECSxRrYhCP2HPAVbfnYbXq52J/Z+dHEWsWSFgr1K3ah5BpZC6na8mi7QD8qvsktCfbt
         Ce2jxCG5gFIUFO2VgkrM0QPgElS55diiQzz85t5Z05ObNZe8/wjcWFDKf/Dx26DlUX2l
         0Bl0IzQ3sOiOF1f+4dtu1+6kOVHnAm++r9/RRClDq7Ldbnx6sdD6IMfc1k7jcJaNU65E
         awDg==
X-Gm-Message-State: AOAM533T2o3ZhF2nzlDDIY04FfWxp2SNVUKQQXhUBNR5Y2UiPtSitL0q
        KouJirOCCzM5NzUDT4eAg8eFucjxfrI=
X-Google-Smtp-Source: ABdhPJzl4RWw8izusLBGpeBBKAIALyCyKMKS4tx46Usuii5EVZ40Iz2jybqnYKnh8NS7Yl2OGR4tvg==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr19360150wrs.67.1590479843845;
        Tue, 26 May 2020 00:57:23 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id j68sm217211wrj.28.2020.05.26.00.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 00:57:22 -0700 (PDT)
Date:   Tue, 26 May 2020 08:57:21 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: stmfx: reset chip on resume as supply was
 disabled
Message-ID: <20200526075721.GE3628@dell>
References: <20200422090833.9743-1-amelie.delaunay@st.com>
 <20200422090833.9743-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200422090833.9743-2-amelie.delaunay@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020, Amelie Delaunay wrote:

> STMFX supply is disabled during suspend. To avoid a too early access to
> the STMFX firmware on resume, reset the chip and wait for its firmware to
> be loaded.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  drivers/mfd/stmfx.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
