Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0850C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562D020C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="P1g4tv/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgIIQfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731046AbgIIQf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:35:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3D3C061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:35:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g4so3672325wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jl9MdazYbMEWqQTTd81RjRbyt2goVkCILtjWlQep6lI=;
        b=P1g4tv/aZx1p5lq5m7/VNtwAhX7o2KyOJ4wyvqVfJoA1wLHpYlQ5bvOVj8DlQI848i
         S/D5SkfiM2CYKJhbYhVqm9CG9tLp7v/MbrQUU3MeL3w113tsnGy4nNKF+2Y0hOVSTTuL
         AdYOqTAjSfbRdTsD/NzWtNhvtHTwP7awfaDcqWzRQ9tvrKEE4rMa8m4hcPcKpOGw6Crd
         SngBf654kOWp0S6hGdxvU2EYDLElXMXBSKz6XLPMHzLTWVvcTxq8Lwv9h7HV0Oq70Zof
         47POt990a1Qq8PH/HRuKp5zICdfrvpA2cJyTqZk2UzFzgyS2f+mRvIsCyI2mfPgtJus9
         59xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jl9MdazYbMEWqQTTd81RjRbyt2goVkCILtjWlQep6lI=;
        b=Kt5mReuZRSWwSDnkIFFuOErdhWIAkHktic9yHdlIpxTOavo715mgj0CJah6nbY2cJI
         t64z94fHARocW3puvI6EPZl89ARWvlEc74h3KH+ESM2MHDiMdFB9nfX9wasiy0YoUJ9h
         f8Rmo9Z2KqZ3XNcKncrVaau0pnWThXpYJFN9rLGRy2DoRnYtdRD3mxZm5yk8CNcTMbht
         Y4KlNArINrLY1k40g+hnXvPuTrlyLL6oktYIibbgI/4tPc9YtpDlsZ4MYJN25L6VRleH
         KZVRKfI44tboBKD16bPTSN2nlp/LBC7yIaQq62MzJ19y1vL/kRqOLSg+cGCl4NLBV28+
         iIqg==
X-Gm-Message-State: AOAM530pon9EVM4pSMRqGJ9Fu9x1azp8oddR409KZ7QXVcEX25sEwGZ9
        IzMeHvFRmo9X6noYWBX2rDcv2A==
X-Google-Smtp-Source: ABdhPJzAULheBBlNK80MB6HC04/qDw7O/ArPTdSVlw9oJqtOKg3QPeeAGr45u2Eqsc1lJL3Oz4pa7w==
X-Received: by 2002:adf:c58c:: with SMTP id m12mr4673332wrg.88.1599669325941;
        Wed, 09 Sep 2020 09:35:25 -0700 (PDT)
Received: from netronome.com ([2001:982:7ed1:403:9eeb:e8ff:fe0d:5b6a])
        by smtp.gmail.com with ESMTPSA id l126sm4627871wmf.39.2020.09.09.09.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:35:25 -0700 (PDT)
Date:   Wed, 9 Sep 2020 18:35:24 +0200
From:   Simon Horman <simon.horman@netronome.com>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/net/ethernet: fix a typo for stmmac_pltfr_suspend
Message-ID: <20200909163523.GC28336@netronome.com>
References: <1599653964-29741-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599653964-29741-1-git-send-email-wangqing@vivo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

On Wed, Sep 09, 2020 at 08:19:21PM +0800, Wang Qing wrote:
> Change the comment typo: "direcly" -> "directly".
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

git log  tells me that the correct prefix for this patch
is probably "net: stmmac:"  rather than "drivers/net/ethernet:'

Probably this patch is targeted at net-next and should include net-next
in the subject like this: [PATCH net-next] ...

> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index f32317f..b666bb9
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -711,7 +711,7 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_remove);
>  /**
>   * stmmac_pltfr_suspend
>   * @dev: device pointer
> - * Description: this function is invoked when suspend the driver and it direcly
> + * Description: this function is invoked when suspend the driver and it directly
>   * call the main suspend function and then, if required, on some platform, it
>   * can call an exit helper.
>   */
> -- 
> 2.7.4
> 
