Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26EB3206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rJockAN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgF2TYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbgF2TYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:24:38 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E473C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:24:38 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so4952713pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9dKxVJjlaX8jxkeSh8T6e6YHQEcdayiIxfyFI+zqbOE=;
        b=rJockAN73JAGXobfkev1y93WYQunULGBKvkHTFKad7D/eGF6tMmDd+MraUFMuEk8ni
         uXbBn82EgTam3bfIUAMR/28dBeHDZ2Ju1ZhDVGhwDN9bLMd5ab7IeRqJMfACaETguWjG
         ydJZCKge5IZiRZi904cCLfh2TZuu6KY7ZhfNqBlHwNWPwI9tE1If8SAcbqLmottXPj2z
         dUzUTfjA2PoZRb1dYCcN7cbsFQ9P9PZ563y0ZDe94rzLrXbX9u3EhaD2a4MOmnplChLU
         xAtkHqY2Rt2UHA/D4yO4QtII2iv+pNwVnQmpL1QrBEoRA9UAfEiXm+JN7Dmtiu4oV4ev
         944A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9dKxVJjlaX8jxkeSh8T6e6YHQEcdayiIxfyFI+zqbOE=;
        b=sQTJ38fZgBce9wbEWaEuSSz1dtWPZy7narGf0BnIrKBiFtmEd/45vnA0iCE8x5DuZV
         o94eEXW1YiRpcHDhQZGzJJXdo7BMJ1InnYmYGAFOnSzHCSVaqo0zbTpOtixXfTTiO0y4
         Z8n6D53MoPYQhkMyzEiLh6TMfN8fyQxVIxAqdOH14JvCbO6Jw/LQRUy2peq3XKL2UiNb
         e+1XI/x5uUngbq7JQydnK6fDaefiT6thHjMn1TeXkE/CsQlCU13l5P9HVhEYuehUnexY
         AR1xwzuS4dUW6Y0MSvisg8IpPRkl8hcDfoDavNvH0uNfeobK0AtnqBr72MHbEJqJpEHt
         4SCQ==
X-Gm-Message-State: AOAM530OR6Bry4zhJ2nxNkzRMrz28I8XsnADOj8SqOBB0+SDQh6YPrqI
        kcfBOkbjYhAe+jieNjifxs0=
X-Google-Smtp-Source: ABdhPJw2NTojIOVe1N+k9d1UhrBCtTCNAURgml2u7637EWsRsIvR4dZARYK0e7VEMzNZsiIfyPManQ==
X-Received: by 2002:a17:90b:698:: with SMTP id m24mr4120032pjz.15.1593458677861;
        Mon, 29 Jun 2020 12:24:37 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y8sm278658pju.49.2020.06.29.12.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 12:24:37 -0700 (PDT)
Date:   Mon, 29 Jun 2020 12:24:03 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Refine regcache usage with pm runtime
Message-ID: <20200629192402.GA27967@Asurada-Nvidia>
References: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593412953-10897-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:42:33PM +0800, Shengjiu Wang wrote:
> When there is dedicated power domain bound with device, after probing
> the power will be disabled, then registers are not accessible in
> fsl_sai_dai_probe(), so regcache only need to be enabled in end of
> probe() and regcache_mark_dirty should be moved to pm runtime resume
> callback function.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
