Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C09B8206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 07:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qIrP0H3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgFDHlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbgFDHlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 03:41:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46833C03E96D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 00:41:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t18so4945906wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 00:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7ANSCRHoGP+yLgZ4w++LPSO7krhwJHNme8PNHzorV40=;
        b=qIrP0H3N/9Py644cE7DBX0T7bY9J9xZFEY1XClWzqAEbeSOdEPlpTCGO93VjQgNnoS
         h/byYR4vrPUhXvZBEihjeyX3zapMx5ISLMlf0MrfIAtKCJHpjmqcHFdCxb8SD1878bZW
         TTQUoc/l8QcyiLb8z82+0E7oHfAxP0Y7UKQ9dezoJ7bgC0ZKmZiiebDu1Huet1PC0BGe
         +O5Csy4A6ofqiMQ3B9tVp1tk2tVizCkNgMvzIkid9OHLqjxV2mfHB3yhcGAdmeq06p79
         MdFy+kXE2l9iBjpaVGO0OBQHYDa91E0Rrru7FZt30jRXUlD5NwGX4+Ly9sV9JlzWCcWu
         gH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7ANSCRHoGP+yLgZ4w++LPSO7krhwJHNme8PNHzorV40=;
        b=gYodyJx/Z1DUB+kyVy2PzFb37ZFoBpQ1Q/XF4xWCyHjqwoixYrkcvsbRzm1FP0Lney
         z8sOE8OehZFxay6GTsQeuH3uFrs0R191K5tjBpcP54EABkfVNoIB6shu83DT+1Y452JP
         5ywzzqy+9aecZ0oCbKKZKESB/lnlWC/SSe2SP5cDnJ4OH/NvGLepY+3VeGlYf65OhPXi
         Zi1dVCCx7iWWP1NK1GtJ+Jv/PwyCycDEXCHvJatrxDMumcOu6IQI0E5B2ZBRcfNc+AS4
         hjXk8kKLPhKWgKXnYiUiIfp6yIWIb555E3jjrcCsSwiQtDSZ0I0ZBSACX6OyNKgYk5/j
         WtXA==
X-Gm-Message-State: AOAM531PAkMHPv9l1QhSZu2R/5iTDW5BXXK8bu06HRK0xGgbJwy+/was
        cCCkEiuePB24XS1xW+LX7qi10g==
X-Google-Smtp-Source: ABdhPJyhFqgZpjvkbRqAIjH5z/p0+HwMwTMFfsljLtGeh5V8gmW45GgN5zOXyFqaLpClsh++3uVHRQ==
X-Received: by 2002:adf:82ab:: with SMTP id 40mr2927340wrc.85.1591256463800;
        Thu, 04 Jun 2020 00:41:03 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id z12sm7257136wrg.9.2020.06.04.00.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 00:41:03 -0700 (PDT)
Date:   Thu, 4 Jun 2020 08:41:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mailbox: mailbox-test: Fix a potential Oops on
 allocation failure
Message-ID: <20200604074101.GV3714@dell>
References: <20200603103329.GB1845750@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603103329.GB1845750@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020, Dan Carpenter wrote:

> The callers are expecting NULL on error so if we return an error pointer
> it eventually results in an Oops.
> 
> Fixes: 8ea4484d0c2b ("mailbox: Add generic mechanism for testing Mailbox Controllers")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/mailbox/mailbox-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
