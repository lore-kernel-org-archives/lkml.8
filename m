Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11D3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 864D2206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 17:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dKuT6xEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgGLRUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 13:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGLRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 13:20:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74736C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:20:25 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so4980848pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 10:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2/BZBNLZm+qL2x6Ipr/wPnrawFw/bsrU0+BzXd5bhPM=;
        b=dKuT6xEHUngz0aO2JjtirfwMibUZU1NVMNf+leerXt8IRt/C0eymExYgC9c4EVVaex
         rYsAr7x3PrJLYuf+UjBD7AFi+quK/lkIMsZy+pfBbiKUzKEb+dadDsaBVWIO+bnuyzro
         /Q7g0MfKOcE9Ja16tkepE+cUimZFrjXrXjs8XaOrsdCbfl4wokrto4Z3xxV/Zfc/93ba
         XDNwOykrqI1kM6gEp+qQAVzjhPlXXJ1fbFyYH/gypLNJXDd46K1WSCauHsolI74Zjt4j
         vGK262WRc3Xgu1ZGxNrDCJeAiC6rNsRe/VRjamQiS4IyqTZAEykAUktaYcm1bBHdROo2
         ol+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2/BZBNLZm+qL2x6Ipr/wPnrawFw/bsrU0+BzXd5bhPM=;
        b=Kjzs3ods4wza02OeOTC12V/uz/TQK44axGSbrWKofQ8QwtKoeR8B6cYMzqwbHxxYm+
         qJiBZ66RtExUw5pzqMrQP5HWDxBXu3IpmheLIHVY6XutHXlvNMUVGbEJ8OEKzRqUTiu1
         wQLyJBZsnj/lv70p1tOjZvDMcBIJB2lgyynUoirUtoRIJssUfJ1UBRnKgQEOMr50KxCR
         MQZRe9ppOm2lKqfVozZRM1z+dBcaakh55G/pgNNuoQ5EQnOvaaKVGIH02N6n3YBlPK1k
         XMzPZJa0ysFAN/PJU5u5iRpJPkcGUqHp/JpKmmPHB8nelZt3GEmI01PL7uEN1kElUCP+
         EOjA==
X-Gm-Message-State: AOAM533fDXlsGtm/fI/LCCfY2wXvMYNivjmwRjFUs7WFWhVRUhRW4FBh
        PMgNfnY5Hy4QzOD88ilgXpJf
X-Google-Smtp-Source: ABdhPJzyWDNBMzOIYvwj4t/ebwrznHyp3Nui5F9225YFChg9m+mRdAP7ZBtOuthH8pet6xjIwfjS6g==
X-Received: by 2002:a17:90a:206a:: with SMTP id n97mr15782979pjc.94.1594574424759;
        Sun, 12 Jul 2020 10:20:24 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id y7sm12323276pjy.54.2020.07.12.10.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 10:20:23 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:50:19 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Singh Tomar <amittomer25@gmail.com>
Cc:     andre.przywara@arm.com, afaerber@suse.de, sboyd@kernel.org,
        cristian.ciocaltea@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v5 04/10] clk: actions: Add MMC clock-register reset bits
Message-ID: <20200712172019.GF6110@Mani-XPS-13-9360>
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-5-git-send-email-amittomer25@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593701576-28580-5-git-send-email-amittomer25@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:22:50PM +0530, Amit Singh Tomar wrote:
> This commit adds reset bits needed for MMC clock registers present
> on Actions S700 SoC.
> 
> Signed-off-by: Amit Singh Tomar <amittomer25@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes from v4:
> 	* Reordered it from 03/10 to 04/10.
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
