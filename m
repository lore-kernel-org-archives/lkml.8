Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED0DC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEE72070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 22:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BG2tQbWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgDZWVe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgDZWVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 18:21:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58794C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 15:21:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so6051486pjo.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 15:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=87krT2AY3IIXSFmpZQdTxrUuwCEzZrT19IZOtMtjJGw=;
        b=BG2tQbWaMlVPecrCiNejX4J+DAsEwq/APzsWFxkCTwVKg1SnkZczk7YACoyXLZ10o4
         nqOR7c4BV9OI8ZO1n6K345K2LnClacAbTcsILMCgREgjEhsLMf6JoKpY+9RrRl5NquzT
         tObNYS/0C3jFnH0bJWzQnAILzhbwOp3ZP8f58+5ubUOOc7hvbNuTXhdpKN1UbpfMRRHC
         wbW/DIgwu6WV73ypUANjq8/tIfu6H9csMyASqls+/OMZb5FKY/YNBrgYaRsr7y5hksfg
         /oQOklkarLaAbJqQwFhTKCV6BlmQWYupLhYxHIx3sZ7/Qe4TcptJECFiZBN2EW8icX2Y
         0CUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=87krT2AY3IIXSFmpZQdTxrUuwCEzZrT19IZOtMtjJGw=;
        b=Khw+AykTquBm9oAjd7Bo2cym66ZyzqeMFgSiIHO6AoE8Yv5LRE4OoEPfjkaa74aWOb
         WvwkGWkmuZseE+Jp1DVZCMWnde0/LDS4K4kP8q/55xdY4BDfJhIsuEmkUJRkxVFt8EbB
         eyfT7GlvRHoyVUmNJllU7WytlH04TbrdHdP7A5qIgyW6cDsVDACanF3tFtqbFQoSPHh6
         YaS/Su5MtquHgnCjfMOOFUdvsQxVK7uY0YDV0ajKXkFP7RRqC0PdP25rohdiHr+nPCut
         0Sr1ibFGULKl5pGHzbiqsczGjwpcqD4HeZ9YrvwcojRsQGTiYNwNqHdxisDP0G/ourwB
         UvnA==
X-Gm-Message-State: AGi0Pua8/yaBEnFa/ru5aWcxtSdHMVyKoCY8JZOVWK9Ic9MPoMARCnKu
        P1TfrKl49r8m2O18H8lBZJxiHp6sp7s=
X-Google-Smtp-Source: APiQypLF/2t+K1/Ik2f9YAXqpwjsS1ALdwWoEoZ88bxnxZu874DYOblLKqaoFUIlehzyHcSlhLWwhA==
X-Received: by 2002:a17:90a:e28f:: with SMTP id d15mr19829287pjz.79.1587939693670;
        Sun, 26 Apr 2020 15:21:33 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f21sm10781067pfn.71.2020.04.26.15.21.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Apr 2020 15:21:33 -0700 (PDT)
Date:   Sun, 26 Apr 2020 15:20:51 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before
 dereferencing "ctx" in fsl_easrc_hw_free()
Message-ID: <20200426222050.GA28661@Asurada-Nvidia>
References: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 03:19:29PM +0800, Shengjiu Wang wrote:
> The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
> drivers" from Apr 16, 2020, leads to the following Smatch complaint:
> 
> sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
> warn: variable dereferenced before check 'ctx' (see line 1527)
> 
> sound/soc/fsl/fsl_easrc.c
>   1526          struct fsl_asrc_pair *ctx = runtime->private_data;
>   1527          struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
>                                                       ^^^^^
> Dereference
> 
>   1528
>   1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
>                     ^^^
> This check is too late, to prevent a NULL dereference.
> 
>   1530                  ctx_priv->ctx_streams &= ~BIT(substream->stream);
>   1531                  fsl_easrc_release_context(ctx);
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
