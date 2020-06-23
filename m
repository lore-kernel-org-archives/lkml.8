Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A57BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FE420772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkvvS8tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgFWFeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgFWFeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:34:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:34:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j1so9567043pfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw0cFZLgC9JersHygrJb/SoVH5zyPcZOPd+eIbg7N9A=;
        b=kkvvS8tA2dHGIqkqWVaFEbyD/nNUcyhtytbI92XDvjh1EWLg63eW6ZygliZfyJf6XN
         VgkjmEX+uV7WJ0k5QMy8yMfCbspbNu8riS8kQ5Ozfe0EQ32v+MWp8p06G4tQJHIv9NSN
         enVw/l57/iL1HzpcDMpHWv7y0lFBxEnLAa+lCssxe6ugKpeuvr1rkcDOdKXjBi1TSN3f
         TvrekhC9W8CrfG/LOWuypaNCmK+7SKcYrFhLaLW4rg8zH5RMQAFXySUCUWBUh9K2/ufF
         TO7OV4XuoX45rNFxXjbK+8qfmERsz3A/rJ/sZFxe3VL0NzBNifco3K9BpPz/a5Gz6beM
         di8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw0cFZLgC9JersHygrJb/SoVH5zyPcZOPd+eIbg7N9A=;
        b=Y9lFXMdODQ4eWaMvCdahDheIL8AbEef4pVPmXVbi/dYs6dkldRO3gapysi0WHcba4D
         xBzp9fo89zmK8/qYacTasVvIOnu/qZglN45R8bogi+cPOQ7Z07H7b8tA8dpZV12dcGcm
         EKhiqGf8N+r2Njcn3fDKEy2Pwq0DYOpljWmlK8ovlDRC0/hA8Y4Gogx3ZmVXYTt5gs5Y
         kCQZdvu1NgVgCmaBBPjAYLryGXtGhRSRrLfVofxcWkRaagGg+/t9MrSlJKlBTzHJL5Kg
         BEC+Po+VLoxqGQyZASaiUqdBs7EEjRE6kcynUnAJmAlOihiq2l16ppqjf+vtdDhm5vNK
         5dvw==
X-Gm-Message-State: AOAM531ewU1+Hdl2J5vBhlZ5heskzCxePaO8KQKWp2/2KmVjxIWPvuig
        a9g5k6th3VoO14ncWFlhou4=
X-Google-Smtp-Source: ABdhPJw1nFeLEWTr0Aixs6TirejroBAE2/O59QCNX1jBOTew5i1D81DQ/Sy2Lv436Bu4/2+08CPyhA==
X-Received: by 2002:a62:ea0b:: with SMTP id t11mr10457134pfh.276.1592890474504;
        Mon, 22 Jun 2020 22:34:34 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id i125sm12458923pgd.21.2020.06.22.22.34.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2020 22:34:34 -0700 (PDT)
Date:   Mon, 22 Jun 2020 22:34:08 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_easrc: Fix uninitialized scalar variable in
 fsl_easrc_set_ctx_format
Message-ID: <20200623053405.GA9039@Asurada-Nvidia>
References: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592816611-16297-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 05:03:31PM +0800, Shengjiu Wang wrote:
> The "ret" in fsl_easrc_set_ctx_format is not initialized, then
> the unknown value maybe returned by this function.
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
