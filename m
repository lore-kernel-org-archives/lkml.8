Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91670C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E367206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 05:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lM7xYNKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFPFXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 01:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgFPFXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:23:24 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267CBC05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:23:24 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v11so704390pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
        b=lM7xYNKXNC3/18xNrWIVK8uekEsB6xz+aF3OvLQ+WQIAjqOxxrV8QNtErcVGyjuFYg
         g2ekGJtibX1TQHLUZjVom/gQ9oi3PiHmEHLFjd3KY7POCjycjtV/31bAAc+1sdmzT3wg
         Cx1zS4qoeLjGbtlpMuEJw+mtrkfV25ndvHW68jWZDEuri/PNWiNlS1GwyOUVSu8H+RDY
         UYtFd2wci0vd0yvpivgutSmG5c70wvCz7AH+y5R5KA6+n/DKwUZ0Qc5blx5dy8Gq7ljM
         9LF9mi16mdnjqFoTQpRlgZXl+AHQOlwBrEXSMqWB0bmXsUN14uYuObilLRMZRY638bir
         nDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F8di4l+s/Ly7rCfnAJCSNumrdSsKS4ibEMc0wr155Lw=;
        b=iDN9Se+Gi5NFhaL0rjQDCiX815fzVBc3mAhqn3MBrvSCXve7juVm2hDxdgjWRskn25
         7jofDFFHf5F/1GfO1WAiB5uLByDEclXJa8trfIEPH9usIS9pLlM0aScbOsy7L7l1pv4B
         4Lr0mgx9j4bb123EX2IN6jObp5DmkkC0RyPHXftXK35fpU3SbHI4yn/IXXaM/aV72Kdd
         tZcWJ4WG7t6Osw+n4FfMHvmIrVM8qaVVh5RSlBw+78OHk/nHscPL0EdmUr+HbUu5DXZd
         M+4ChvJ+TYdPIz9bqgSa/5c9IM4XOU6bu/gtVD4E3Cax46l783MRrmKloDyzJRDizq+c
         PGKQ==
X-Gm-Message-State: AOAM533yCCuazeXlbrxE1nnLF6dZnga3IzcokMqJiJfX+/WLwL/7nRLu
        RRYPh5x9YFvaRLCoezkwuNBf9ovAxlA=
X-Google-Smtp-Source: ABdhPJy/DgyZOR7OSTrsOc0TGFWHgdklAdqqTv+6cq9ydXh1cUOIgbk3cVS/IZxiJP2tDbUJtD47xg==
X-Received: by 2002:a05:6a00:843:: with SMTP id q3mr579487pfk.107.1592285003585;
        Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id h6sm15684333pfq.214.2020.06.15.22.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 22:23:23 -0700 (PDT)
Date:   Mon, 15 Jun 2020 22:23:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200616052304.GA24055@Asurada-Nvidia>
References: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <034eff1435ff6ce300b6c781130cefd9db22ab9a.1592276147.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:53:48AM +0800, Shengjiu Wang wrote:
> For mono channel, SSI will switch to Normal mode.
> 
> In Normal mode and Network mode, the Word Length Control bits
> control the word length divider in clock generator, which is
> different with I2S Master mode (the word length is fixed to
> 32bit), it should be the value of params_width(hw_params).
> 
> The condition "slots == 2" is not good for I2S Master mode,
> because for Network mode and Normal mode, the slots can also
> be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
> to check if it is I2S Master mode.
> 
> So we refine the formula for mono channel, otherwise there
> will be sound issue for S24_LE.
> 
> Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
