Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A255C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D1F208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gm07vZha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgHaJRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgHaJRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:17:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AA7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:17:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so268201pgd.12
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vfcvTku+KOCTi3fqkNJytle1L11dWohYbUojV1rq2bM=;
        b=gm07vZhaG/iPEU1hgpRJcQFQCsU7iGFvRuKOD0ul0DVZpEBT/DvKPqIW9OcpTVlQHo
         G+atZd0QmkB1mkOHM2hE2HRRbJk+TQ28E3YlWJFy4Pt891XgF8fM5qDLdvjDtOCMTVMW
         3eaPOCcuFxNa0TvVDE9v8ndGKXDul/u6JS5X2m4Vb2RtNJIYiBFWvvkFAQyvvlukgUMv
         8qKRTxz2s2fcVM8SXrATJMBuILExOkQarMHEemymRzex7CZzUozyxQlRM73ygUTs3qbH
         vx9SsYakO5Aob0BG1bEWpag1Wc2/FKmhF9z6JEEWNEOpSHqxGoe23yd3XfIGPNPqddX+
         xacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vfcvTku+KOCTi3fqkNJytle1L11dWohYbUojV1rq2bM=;
        b=TXceyPkUQ6v/sfPMDjLpkQII/kJ6Gv5CNbqx3lPlpJXZE0HlntiXSO3C7dcAVOLAVI
         KMmKCjZFFv75nlA9GY28g4GhEXRfVGMMi9ipBQr0aGaoj88aYE/XlAZ9/1UPUefpq9fV
         03QCaz1lML4oe7uK0DFFKjAMAz2ZY1/AoPvZhvvLVXQHwlViJJGo7V4V4G8vcXC2gmN3
         mfxpCHBczrdTMQa9Mw3Hg+P0QAm+l+2POnN3rrA7KmRCjDoMc2M4dHMyT84AJ0W2IFpm
         7IVzstHnxZvXV2HKfgO5F0tzhCLxgV8X4Aet1Q+8VLGwR1o7PeWO6T6xCl9EJ3aAh8q+
         EK5w==
X-Gm-Message-State: AOAM533P/Ok0wPSr/4K9wQJ6Oyj877TL/CVNdSmlsYcROCjakfqvk1q0
        B6iA8oQ/FOx86KMwcIdp1BXbR3b5Za7w
X-Google-Smtp-Source: ABdhPJwtJL7ZWu9i9kPfW2U4MnTs9xb5FHaktbqdU3xChuNXgAuQhH/bP0ATqnL39N++nF74J3mUvQ==
X-Received: by 2002:a65:4389:: with SMTP id m9mr526055pgp.127.1598865458718;
        Mon, 31 Aug 2020 02:17:38 -0700 (PDT)
Received: from mani ([2409:4072:70f:fdfa:1d6f:524d:c4d3:917e])
        by smtp.gmail.com with ESMTPSA id s23sm6430697pjr.7.2020.08.31.02.17.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Aug 2020 02:17:38 -0700 (PDT)
Date:   Mon, 31 Aug 2020 14:47:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Subject: Re: [PATCH] const_structs.checkpatch: add pinctrl_ops and pinmux_ops
Message-ID: <20200831091731.GB4154@mani>
References: <20200830224352.37114-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830224352.37114-1-rikard.falkeborn@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 0831, Rikard Falkeborn wrote:
> All usages of include/linux of these are const pointers, and all
> instances in the kernel except one, that are not const can be made
> const (patches have been posted for those separately).
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  scripts/const_structs.checkpatch | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
> index cd45cb3c2b04..1aae4f4fdacc 100644
> --- a/scripts/const_structs.checkpatch
> +++ b/scripts/const_structs.checkpatch
> @@ -40,6 +40,8 @@ nvkm_device_chip
>  of_device_id
>  pci_raw_ops
>  phy_ops
> +pinctrl_ops
> +pinmux_ops
>  pipe_buf_operations
>  platform_hibernation_ops
>  platform_suspend_ops
> -- 
> 2.28.0
> 
