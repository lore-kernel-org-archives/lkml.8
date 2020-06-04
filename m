Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21717C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBF32067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NASVovjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgFDAF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:05:58 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD99DC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:05:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id f3so2506370pfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uF2n/gB3gDDP2hMwoQuaaueDJkaKtOoysRJtoTkMSDw=;
        b=NASVovjhwK7+HIO80yPXssp+od2Hj2d9eiKlapTw++P1bMpxgSBWmZWUJ0Js8p1fiB
         COH3UNC0JBHTjqVioC60wuQYj1RX8kglcJJOKWvyGdoUdYxhDo7lgrJJsnWmmwEOOnls
         GcWCSPxRy9zAbMJ7nMRszUCbpYU4qAb/KhOH8/Np8lUaDK8+qUddDyBu0T7i9cK2Q/z0
         IDedlFEsLhmXp3TpSpDuCorOYb8vG5doQsgNwk0P5CfjW5HuC7i51dX2b/EN0xJTER0u
         zGGYodiltvH/TmC9ebxBfVpybt4NFF6aebkphUU9nfM6Eqs+npjtS7j88HNdrymau7A8
         fObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uF2n/gB3gDDP2hMwoQuaaueDJkaKtOoysRJtoTkMSDw=;
        b=lSPSeTK1NC1VLPGJ6zPhMDh3XBueWapmak8bbuOqJj4bUCv1MJIDd/xRnFr+PXJUCT
         dAIELZdVmbxEhq98N9sC2lzdGMISlBw0rmtXcACkHqVjltSlqopueNALKr0uuQNHv+hp
         LXOMWTMrDrh8Mdn7yTNe+hqvRqfY+ZrnJ7jZLFhgtIZoqwrVgf7fN3+N+xut22LYFZA+
         1neTygB8K8Hn7bY1O1Ywgqs83hFUMsieNZSnj0Hs4OiURNZQ2O+qujWr9EykGzhagE2+
         k5pOv9qwS6oJGknkr73NS+NqyykXTvjkdF5C3b2S2eHe9KujmmeGEzyOwuFiaVm6zcYq
         oPyw==
X-Gm-Message-State: AOAM533tWWRlaHoPtck2Ni7jP3oEAGall/AJICZb57+4hYffPMiRPxEI
        XG9/fjhCT1Zsv9eLRaq7V0Y=
X-Google-Smtp-Source: ABdhPJz9ZYK9jizQG8WXYX8Y04FQk4jgCjJhaM7jL6RxuPb2xp3UDdovwx057LKm/fMposyBvBJGzg==
X-Received: by 2002:a05:6a00:ce:: with SMTP id e14mr1523090pfj.44.1591229157170;
        Wed, 03 Jun 2020 17:05:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f11sm2767786pfa.32.2020.06.03.17.05.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 17:05:56 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:05:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: fsl_easrc: Fix -Wmissing-prototypes warning
Message-ID: <20200604000551.GA17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <ab1b83a56c71f4159a98e6da5602c2c36fe59f4d.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab1b83a56c71f4159a98e6da5602c2c36fe59f4d.1591155860.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:39:39AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c:967:5: warning: no previous prototype for function 'fsl_easrc_config_context' [-Wmissing-prototypes]
> int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
>     ^
> sound/soc/fsl/fsl_easrc.c:967:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_config_context(struct fsl_asrc *easrc, unsigned int ctx_id)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1128:5: warning: no previous prototype for function 'fsl_easrc_set_ctx_format' [-Wmissing-prototypes]
> int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
>     ^
> sound/soc/fsl/fsl_easrc.c:1128:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1201:5: warning: no previous prototype for function 'fsl_easrc_set_ctx_organziation' [-Wmissing-prototypes]
> int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1201:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1245:5: warning: no previous prototype for function 'fsl_easrc_request_context' [-Wmissing-prototypes]
> int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1245:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1290:6: warning: no previous prototype for function 'fsl_easrc_release_context' [-Wmissing-prototypes]
> void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
>      ^
> sound/soc/fsl/fsl_easrc.c:1290:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1317:5: warning: no previous prototype for function 'fsl_easrc_start_context' [-Wmissing-prototypes]
> int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1317:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_start_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1335:5: warning: no previous prototype for function 'fsl_easrc_stop_context' [-Wmissing-prototypes]
> int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
>     ^
> sound/soc/fsl/fsl_easrc.c:1335:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> int fsl_easrc_stop_context(struct fsl_asrc_pair *ctx)
> ^
> static
> sound/soc/fsl/fsl_easrc.c:1382:18: warning: no previous prototype for function 'fsl_easrc_get_dma_channel' [-Wmissing-prototypes]
> struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
>                  ^
> sound/soc/fsl/fsl_easrc.c:1382:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> struct dma_chan *fsl_easrc_get_dma_channel(struct fsl_asrc_pair *ctx,
> ^
> static
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
