Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04148C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A7F207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMODgyNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgFZNy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:54:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2271C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:54:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g17so4296792plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMbNe3bvovs/HF4L4pFZ6HHy0t3ZDNuS6KDaRE+CO9g=;
        b=zMODgyNpvqgSvfmhpS5ocDb2fyOJlPjvlHYiUmnneT/02SoUlBtXH/fRmO71OtRiBM
         pqy6AgmVbJ6SQpw34Jj4lYyRt2iwQZt2pHUDOheXET5vzl+t2fr7mnj+tFOQb1lhVecU
         19w+vR+D01H/tGFID+w9M+9czHAm9gqoYq2TwCbe1KHwGl38tKc4SCj/NvYXFj5EyqFg
         WjgR+/oV6yf8v5PWwZ+9Fi1kGu4Xm7eMjCS2rp9FI+oU/tc+a3sdTPr6f0ONHa1Tpyz7
         Q4e+1mSimc1+mTtGW9UXto5VF4rnRH1eLCUFHIelT7kEFwa06F0fHV5u8tg+uMuVa1H/
         /lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMbNe3bvovs/HF4L4pFZ6HHy0t3ZDNuS6KDaRE+CO9g=;
        b=kJr/xhnDdHnQhML4LhG/S1g0WupAKuwe9VqDLMVLTJE4AVJQkPDWHsJNQCQZFO0bat
         e3dSVC26iMChNen2YRMXvCzfUk8FdAPaemiYi10ZS0odNNKO1Yq61Na32RZFYCuF+a0B
         4WYUl7EWvKc1AFC8Lw5wvt3h1RlFSwxJdmPz6WJ9RZgj+w3Q3UKGHPEbykLjj44BVh5h
         +9s29XtMkCIgGQ0jWlhzy+y4jWBwaSNYiVjI1yubE7DNawe08GWhXeEwNi++SLdTJPFQ
         pFtiCbZS4VUOFD8yZZ6no+n0NNY1Skyb0SJRu7RejpXcknf1FmDcb32DZiNVTkI5MM+M
         yULw==
X-Gm-Message-State: AOAM531CTIRXgPH/sshf7f04vWZqWb915ZNFr6wsbUBKDNboha4SdgZS
        SBMIBi2Cr+t0sx+0DX0UxB+L
X-Google-Smtp-Source: ABdhPJzZ/XQHczKnQ1Sm/1IPTxvXLNgqgj4T9DiHLdtbLRBslZWLgu28jWeNZQ/+aJHxhoCVuljndQ==
X-Received: by 2002:a17:90a:df8f:: with SMTP id p15mr3866933pjv.164.1593179663995;
        Fri, 26 Jun 2020 06:54:23 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e11:8623:980f:4d73:2b9:f602])
        by smtp.gmail.com with ESMTPSA id y27sm3335138pgc.56.2020.06.26.06.54.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 06:54:23 -0700 (PDT)
Date:   Fri, 26 Jun 2020 19:24:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v2 6/6] MAINTAINERS: Add reset binding entry for Actions
 Semi Owl SoCs
Message-ID: <20200626135415.GD8333@Mani-XPS-13-9360>
References: <cover.1592941257.git.cristian.ciocaltea@gmail.com>
 <c7db5abf78656af8d5a4ff8d677a08e03713c1f3.1592941257.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7db5abf78656af8d5a4ff8d677a08e03713c1f3.1592941257.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 08:47:57PM +0300, Cristian Ciocaltea wrote:
> Add a reset binding entry to match all members of Actions Semi Owl SoCs.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b5ffd646c6b..e6285c13bab0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1533,6 +1533,7 @@ F:	drivers/mmc/host/owl-mmc.c
>  F:	drivers/pinctrl/actions/*
>  F:	drivers/soc/actions/
>  F:	include/dt-bindings/power/owl-*
> +F:	include/dt-bindings/reset/actions,*-reset.h

You can just use, reset/actions,*

Thanks,
Mani

>  F:	include/linux/soc/actions/
>  N:	owl
>  
> -- 
> 2.27.0
> 
