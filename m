Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B869C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D956C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhGh/+P+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgIJRJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgIJQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:52:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83608C0617BA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:47:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so7497954wrt.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=r1RcJjuq+WDDkjUNNx0Km9/voIY1piTuPNUK42+ZJ10=;
        b=hhGh/+P+DIvxgxF4b56VE+cZu+xIiQTG23eijHpqAg1XY0vXdBbnkpxrCR/8YHYLKL
         FYaVLiMDnOMSkqRRGV1dkJe5NsmwrLO9JyvFn6jeDz2fwVIv5oRZyXOcJKxMiUSG3Pg3
         1pToGHQpt1QygecOnaQz2B5Ua6U8U+OFIwIaHJvrf5zRHXYg/o9o77WcCXMtdEIeMPET
         C4niO9cAe7m7JT9qaON0lLRNgI1EjfinvANaVFnhuisFOV7YMqYJ/uSuhhC98jy/aNv8
         gR9RWlizWTVx7ZDRiuTmpiuKdGYBsdX5ZHYJJC4UTcxYLRgzH/n9mwDuQ1wSgkDAgNNJ
         tuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=r1RcJjuq+WDDkjUNNx0Km9/voIY1piTuPNUK42+ZJ10=;
        b=YxzzYOn6IzCIbvOouMQRsm/sSepwCwn6TTbynbL6Dxatc1boFyCYOy/Zqn+alFbn4y
         89DWWeiRlfQrprcumIyQVxkr4slW2kudyh87noZN8gyEodybL9uXSPnCCEBoJs7NKUSs
         xY5j8jtA4PJb01M6IkLIUKpYavyEv1TKzv2x9P5rjNj9tMd5SdIPDKR/7qHPrYFva78b
         xBuT081ngShEkklymiGSHAhtbgiJsdD91MUKPd3vp2SoPXQ5+pubu0req7xn7cwp+0TU
         iuRp4u8IM5jq2RwYNGbpeBNUoTcFtF+Io/ogzfzL9286zcxwglS8ihOj1zHs3vuJ/so5
         8L3g==
X-Gm-Message-State: AOAM532nR0BgCmTEMcUuZQO7vHVbaVkb4Cca3XIMy9pTlxXxmmcISloH
        i80JywjIpBgF/dNDhK+531OJeg==
X-Google-Smtp-Source: ABdhPJz2cYBlng2UuRHg5FdXgp1BGkBu4JdjKlSL95jLVVUPGP6aY3oQJGp0YgYlPLTAa65o+jk8cA==
X-Received: by 2002:adf:eb86:: with SMTP id t6mr9865546wrn.411.1599756428201;
        Thu, 10 Sep 2020 09:47:08 -0700 (PDT)
Received: from dell ([91.110.221.246])
        by smtp.gmail.com with ESMTPSA id v7sm4283096wmj.28.2020.09.10.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 09:47:07 -0700 (PDT)
Date:   Thu, 10 Sep 2020 17:47:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
Subject: Re: [PATCH 27/29] ath9k: ar5008_initvals: Move ar5416Bank{0,1,2,3,7}
 to where they are used
Message-ID: <20200910164705.GE218742@dell>
References: <20200910065431.657636-28-lee.jones@linaro.org>
 <0101017478dee7a5-d1bf9eb4-8ec4-44d0-bc89-11497cdf681c-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0101017478dee7a5-d1bf9eb4-8ec4-44d0-bc89-11497cdf681c-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:627:18: warning: ‘ar5416Bank7’ defined but not used [-Wunused-const-variable=]
> >  627 | static const u32 ar5416Bank7[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:548:18: warning: ‘ar5416Bank3’ defined but not used [-Wunused-const-variable=]
> >  548 | static const u32 ar5416Bank3[][3] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:542:18: warning: ‘ar5416Bank2’ defined but not used [-Wunused-const-variable=]
> >  542 | static const u32 ar5416Bank2[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:536:18: warning: ‘ar5416Bank1’ defined but not used [-Wunused-const-variable=]
> >  536 | static const u32 ar5416Bank1[][2] = {
> >  | ^~~~~~~~~~~
> >  drivers/net/wireless/ath/ath9k/ar5008_initvals.h:462:18: warning: ‘ar5416Bank0’ defined but not used [-Wunused-const-variable=]
> >  462 | static const u32 ar5416Bank0[][2] = {
> >  | ^~~~~~~~~~~
> > 
> > Cc: QCA ath9k Development <ath9k-devel@qca.qualcomm.com>
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Already fixed in ath.git.

Ah, this is the repo that takes a while to filter into -next?

NP, thanks.

> error: patch failed: drivers/net/wireless/ath/ath9k/ar5008_initvals.h:459
> error: drivers/net/wireless/ath/ath9k/ar5008_initvals.h: patch does not apply
> error: patch failed: drivers/net/wireless/ath/ath9k/ar5008_phy.c:18
> error: drivers/net/wireless/ath/ath9k/ar5008_phy.c: patch does not apply
> stg import: Diff does not apply cleanly
> 
> Patch set to Rejected.
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
