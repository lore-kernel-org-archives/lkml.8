Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2EDE24875
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 07:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGUghkd1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgFUHmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 03:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgFUHmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 03:42:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0686DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:42:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s23so6816065pfh.7
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 00:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=frGpGD1gGEK1DdHYmVp70xVzhZtdl7uz6o/kq9Sz7lM=;
        b=zGUghkd1g8cYCEAxLlIdjoC73QetExiHi8MofsyHfYXNepWTEYVE7RQNCJfo/wiNUt
         vFBvABNe+ePYrhfEfWGQj4o7SfreOo4lml/10odlB/NJNgflW73Hxec7hRt3mD8weBmT
         SqBAupQp97LO1uAYIzTB27DqiVL16O2NMr9ffqboWDTX8Bov/maXrhDUfDDLMDX3eA2N
         hkbpRAPhlf7ffes/n+InDcVYRmsKwH4KyVbLrErLnYviK7OXZbiJW7FXgRVTouoCyeWT
         PuPDm32dOB90Pxb+Chs9d8S9VINt59dZr3lSQVasT9LHr2/DPXoIdsSDkmd06hnLYhAQ
         vGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=frGpGD1gGEK1DdHYmVp70xVzhZtdl7uz6o/kq9Sz7lM=;
        b=GMMDP57Q2MJLYLYLCHi62Vwa9UMPkefwDRILVPlZ+YlOVyUE2n3Ktnfy/IkEseaBQ3
         N75SC2+AI+jfsNX0gRi46o+FZmw0GHDiyrXEJ0OylKC2mVrtuG90y2XkdQ+6g/7CIrU1
         mo3JnxxeE6NA1/dIZsET80aC1Zttv4DDrrZPGcU+tT9Ly2SQhLMcbYfV2nMpCJfh54tq
         Rg9UtaR7pXiIakGyBSq+Ds45b+gnjdDNiL+x7d+4BRPw0euj1AJPRGcAn19yzpz/cVQj
         FLw28KXZgMW7lgVucYTxZUcmwNmyj1T/c2dIqkXLR7hh3DgraaMWegT8+e4FkastGqIa
         hIFQ==
X-Gm-Message-State: AOAM532VBbj89YrbDLf10woqGVPpOMgvWxRNvv0LT7xd/sG5r9T6s95S
        FZdbXIBmJbgws6jyfbasy4ce9g==
X-Google-Smtp-Source: ABdhPJxxeebxj+wAA384otLJPlzJxSWAx7g4IEHWU6NMCdV8vlU+PV9+X2lTtdMYH0dHRanxC9G62Q==
X-Received: by 2002:a63:6d42:: with SMTP id i63mr8424330pgc.77.1592725371399;
        Sun, 21 Jun 2020 00:42:51 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d4sm6092496pgf.9.2020.06.21.00.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 00:42:50 -0700 (PDT)
Date:   Sun, 21 Jun 2020 00:40:03 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, inux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, sibis@codeaurora.org,
        vinod.koul@linaro.org, agross@kernel.org, ohad@wizery.com,
        p.zabel@pengutronix.de, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: q6v5-mss: Fix kfree build error
Message-ID: <20200621074003.GJ128451@builder.lan>
References: <20200617065658.27567-1-naresh.kamboju@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200617065658.27567-1-naresh.kamboju@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16 Jun 23:56 PDT 2020, Naresh Kamboju wrote:

> This patch adds linux/slab.h to fix build error in qcom_q6v5_mss.c
> 
> Build error:
>  ../drivers/remoteproc/qcom_q6v5_mss.c:
>   In function ‘q6v5_mpss_init_image’:
>  ../drivers/remoteproc/qcom_q6v5_mss.c:772:3:
>   error: implicit declaration of function ‘kfree’;
>   did you mean ‘vfree’? [-Werror=implicit-function-declaration]
>    772 |   kfree(metadata);
>        |   ^~~~~
>        |   vfree
> 
> Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>

Thanks for the patch Naresh, it looks correct but I've not seen this
build error myself. Could you please let me know what you built to get
this and if you have any suggestion on what caused it? (So we can add a
Fixes: tag etc)

Regards,
Bjorn

> ---
>  drivers/remoteproc/qcom_q6v5_mss.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index feb70283b6a2..903b2bb97e12 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -26,6 +26,7 @@
>  #include <linux/reset.h>
>  #include <linux/soc/qcom/mdt_loader.h>
>  #include <linux/iopoll.h>
> +#include <linux/slab.h>
>  
>  #include "remoteproc_internal.h"
>  #include "qcom_common.h"
> -- 
> 2.17.1
> 
