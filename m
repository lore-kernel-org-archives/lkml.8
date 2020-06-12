Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D851C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4395220801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESWNW/5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFLII2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLII2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:08:28 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AF5C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:08:28 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so3937064pfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=deHfCGYK7sImHkT4VukXUAJWu2KR/QGBA+6TyAj97pI=;
        b=ESWNW/5E+/g3NHeWm+fOP0obMgnb450CQdjU9D6UtJeGj3oPKXbGFuVQMzmWkRgmg9
         COtq4vJ2noq7dW4on1wypjVYXjgWHyB0fRMnV6QZ9j1FiTm00VYKKwgR7MASZKZMRyeA
         dR9T/ajdR5gD7/4IFojbFiUs4rdI1lUswID/e1U5pm2aKElj8noMcoOe4/keDRVrB6ef
         KyjJ6r7qxss1ilwRip7YdYpZw7twEqIm1eAZyvF1m+86gx9AtNA/C3e9NQOzdUmhgAcW
         qAnKk1GUYgxglmNMpsPNlxuYqzdMpn8JRXN/hty9YdAgM4jkMhKH9jTDoRFk0+GOfrG0
         xaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=deHfCGYK7sImHkT4VukXUAJWu2KR/QGBA+6TyAj97pI=;
        b=KgCipMiUfiEl+/SF30Ijod6ixu62WHRvDCkhZk0rGO3JHJ/NOWFNK2enQkYdNOFaop
         icd9dpYrVz8mWLgOACHeqbi4F4/Jj8wkydJuK+KTqmPRZW3bvtoUh+xkvaqcpangJ2P3
         +c3+6zjt9vp5dD7C78nGjFd35xtrzJqQBDy4mhyiBKXFBYd+aRV51eS1fCDboAAwWuOb
         HItUMrSlBNi3Uy8OXfKBKN+v+R4nbWnUJ6Noj4A1NQXMOHnfs5ffKV2JqwC+e0TjcEkC
         mbxnKCRKDvgZfEq8qaVwR8XQdhavwmjk5Kfk5v0XShLKey0how4a3zOA1Vsg0tvn4dFN
         NbKg==
X-Gm-Message-State: AOAM532pv4RJxzpDfd+6/oBnmouzvjIGggmOJBj0YkGTmDXCwVpZrCye
        LwU1d0FQi5QsRurzIxMDTSo=
X-Google-Smtp-Source: ABdhPJztp5H64H8nc4ALDD29MNCP1/wMgS7+B5pkRhRu2tCOBn/u6z+JZFa6hKutRRkWyc4Y2CsnqA==
X-Received: by 2002:a62:ed02:: with SMTP id u2mr10494227pfh.283.1591949306759;
        Fri, 12 Jun 2020 01:08:26 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m9sm5306088pfo.200.2020.06.12.01.08.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 01:08:26 -0700 (PDT)
Date:   Fri, 12 Jun 2020 01:08:17 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 3/4] ASoC: fsl_asrc_dma: Reuse the dma channel if
 available in Back-End
Message-ID: <20200612080817.GC22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a79f0442cb4930c633cf72145cfe95a45b9c78e.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:37:50PM +0800, Shengjiu Wang wrote:
> The dma channel has been requested by Back-End cpu dai driver already.
> If fsl_asrc_dma requests dma chan with same dma:tx symlink, then
> there will be below warning with SDMA.
> 
> [   48.174236] fsl-esai-dai 2024000.esai: Cannot create DMA dma:tx symlink
> 
> So if we can reuse the dma channel of Back-End, then the issue can be
> fixed.
> 
> In order to get the dma channel which is already requested in Back-End.
> we use the exported two functions (snd_soc_lookup_component_nolocked
> and soc_component_to_pcm). If we can get the dma channel, then reuse it,
> if can't, then request a new one.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
