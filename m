Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D41C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9346520665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXlpefbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgH1Lyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgH1Lyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:54:40 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38539C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:54:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g1so340200pgm.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vERU/kKQ/eSKZaF6L1Z2jAoctBkNFjAEpr35ycgKP4s=;
        b=qXlpefbiKEMsNV+2h6hcy39Gb4Wc9raxkkIGEVJwrv5NVakbv56oogcfzt1QyF7f6w
         9YdGeCf5HsI7/00l/pvzdlyfpmtwOwm2+itCyCxuvdpkIBmCX712L8NVwue1WZVRxVaF
         iqLxVzFdYT2BXT7Hc6k2ZKt46DA/NIR6cMlGncrR5DJAHXhok+nKAANZTEBzlrNV4Dpg
         nMq0k5n9CsmHV5EuDqzk9TJa7NtgKQ9+S9ipRYcwVnzI+WFD0rCs38EfOCam/JA1od2W
         Qs0eTdky/YZPQQQVvDAK5HubiGhQ+Cb9rSvDHSbjk9lAksE9k8r69eEynBGG5IUuM/AB
         UM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vERU/kKQ/eSKZaF6L1Z2jAoctBkNFjAEpr35ycgKP4s=;
        b=di7HoMGVNoLfd+vLYsXwDVf5RRFvunjtssQghH+OMqLzEOT3+AC7Th0kZj2d5cQrZ5
         bv6y5mUpmcmL1UXjLVT5niA53YwQ30l/JThA2242rYfQHlD7ECMeoaEJbo1Ik+dqgmUJ
         rdpROTT+KiCEmsmLJdbgNkT9Q1qxcd8pgjqMvHuOUkVk4zEPjp0oP4aFiLBvooItNyru
         N/tC4NtZ753TGIPACDBCbR6SocCVKA0skW36C+jzi24NPN2gyPRxk9XJrGast7ixL1Tm
         1m7imAWCe/01tMpfbft0w16O5vcn1+6lKiXXcloXaU3ctA/DK6eG7XwOlPpi07Zvw2CX
         PQzw==
X-Gm-Message-State: AOAM533d2s/yYfjqX9RsbpWvJFmA+rb66BT7v8GxsUa+T5GfkSLAfPZ5
        X9f01iSv8GxP8XetfaCU6jng
X-Google-Smtp-Source: ABdhPJx+vEPDw/TcNpYJgTiD/Tcc1fGtpXoUB0x+Yd3WSbxZJokFKW3pVIFtlLu5GHBok//DF62isg==
X-Received: by 2002:a62:648c:: with SMTP id y134mr971592pfb.114.1598615679549;
        Fri, 28 Aug 2020 04:54:39 -0700 (PDT)
Received: from mani ([2409:4072:6d87:4cd4:5db4:99cb:1fe6:fc86])
        by smtp.gmail.com with ESMTPSA id w16sm1500775pfq.13.2020.08.28.04.54.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Aug 2020 04:54:38 -0700 (PDT)
Date:   Fri, 28 Aug 2020 17:24:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sboyd@kernel.org
Cc:     andre.przywara@arm.com, afaerber@suse.de,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, amittomer25@gmail.com
Subject: Re: [PATCH v7 04/10] clk: actions: Add MMC clock-register reset bits
Message-ID: <20200828115431.GA9143@mani>
References: <1595180527-11320-1-git-send-email-amittomer25@gmail.com>
 <1595180527-11320-5-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595180527-11320-5-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0719, Amit Singh Tomar wrote:
> This commit adds reset bits needed for MMC clock registers present
> on Actions S700 SoC.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Stephen, can you please apply this patch? I'll queue the dts bits for v5.10.

Andreas: Let me know if you want to do the PR! These patches are waiting to be
queued for a while...

Thanks,
Mani

> ---
> Changes since v6:
> 	* No change.
> Changes since v5:
>         * Added Mani's Reviewed-by: tag.
> Changes from v4:
>         * Reordered it from 03/10 to 04/10.
> Changes from v3:
>         * NO change.
> Changes from v2:
>         * No change.
> Changes from v1:
>         * No change.
> Changes from RFC:
>         * No change.
> ---
>  drivers/clk/actions/owl-s700.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/actions/owl-s700.c b/drivers/clk/actions/owl-s700.c
> index a2f34d13fb54..cd60eca7727d 100644
> --- a/drivers/clk/actions/owl-s700.c
> +++ b/drivers/clk/actions/owl-s700.c
> @@ -577,6 +577,9 @@ static const struct owl_reset_map s700_resets[] = {
>  	[RESET_DSI]	= { CMU_DEVRST0, BIT(2) },
>  	[RESET_CSI]	= { CMU_DEVRST0, BIT(13) },
>  	[RESET_SI]	= { CMU_DEVRST0, BIT(14) },
> +	[RESET_SD0]     = { CMU_DEVRST0, BIT(22) },
> +	[RESET_SD1]     = { CMU_DEVRST0, BIT(23) },
> +	[RESET_SD2]     = { CMU_DEVRST0, BIT(24) },
>  	[RESET_I2C0]	= { CMU_DEVRST1, BIT(0) },
>  	[RESET_I2C1]	= { CMU_DEVRST1, BIT(1) },
>  	[RESET_I2C2]	= { CMU_DEVRST1, BIT(2) },
> -- 
> 2.7.4
> 
