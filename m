Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611BFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3950420738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 03:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acxpzdL1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgHCDMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 23:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgHCDMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 23:12:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01973C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 20:12:20 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so11387548pfd.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 20:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pqH4xv/zgdnQFeooWFmsVR6/ZHVzntVgyMsibxvmXWY=;
        b=acxpzdL1bbItPmnT/RyUVyi9BBGxsth39Fs/4E3YDPQLwgcw/EFVW69/ykgtFURgvL
         DnsHAfxza5CEv6nL3V5jw8mdQ0A2mpr1UoR1Z54iESGC/hiVmKlE5HAkiEvscqzffLGZ
         27+8T18hbT24cgN4QOMJ959mztebaiWQt6hq8/WHLOJK6MmNj41gE6P5etE/P9ZUcXEt
         T213U6Euj/24EZgdq3R5cPxXcbimpweAwFMO5oqg4v6KEAXFLOxC/P5uBbA2hyAc9LsJ
         nCxDxcuT2PUDRLvChqWb2sO61s1R2+kL7VVIWmZom5eJBC8FBcKo8Z2jNqOdx09mQPLh
         fm8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pqH4xv/zgdnQFeooWFmsVR6/ZHVzntVgyMsibxvmXWY=;
        b=luGt1juPV9XLtyAGauGcCenr88i6P9SIkFOI1wfMSC5VFWqpZN8sW3UReyz8c94fj/
         Lf42yVINnSJ2xLlCLyjc7xqtpOXKZqtZhJ30hsRKclcbq7CaIkzXHO/1CoCzweKYpAn6
         3KHb8TjNFOauIWUULeUFWhEzrWlUbXAiLyMJgAaGeQt0MHOct3s3z7wGsayuueXrNMvC
         GWT+0qqZwjcX072NvVBLVrs7AcEiJFGgO5GbxVurVGxupbC2EhLirt81skc7CAJJ1bzZ
         8AT6d8+AJyYZn9U8qoPfEtyh6KRP+thZc9iU1jEuwKdUGIfw2Q4q+CfzIQ0ws7WVLSkO
         I6aw==
X-Gm-Message-State: AOAM5307vfl6tbCRpaeDJZ01o2/62FDXSyCTQ3TSJyPnkbV5svXOZ4YX
        j2FInnV1kglC3fV1TOlVsHQ=
X-Google-Smtp-Source: ABdhPJxkW69u4758fMnybzasE3bFymgtHmmra2XXahudLeTVKS5ejJspO5JAQaQ123pvUuYtFeDZjA==
X-Received: by 2002:a62:206:: with SMTP id 6mr10419191pfc.228.1596424339410;
        Sun, 02 Aug 2020 20:12:19 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id v22sm17795945pfe.48.2020.08.02.20.12.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Aug 2020 20:12:19 -0700 (PDT)
Date:   Sun, 2 Aug 2020 20:12:07 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ASoC: fsl-asoc-card: Remove
 fsl_asoc_card_set_bias_level function
Message-ID: <20200803031206.GA28838@Asurada-Nvidia>
References: <1596420811-16690-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596420811-16690-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 10:13:31AM +0800, Shengjiu Wang wrote:
> With this case:
> aplay -Dhw:x 16khz.wav 24khz.wav
> There is sound distortion for 24khz.wav. The reason is that setting
> PLL of WM8962 with set_bias_level function, the bias level is not
> changed when 24khz.wav is played, then the PLL won't be reset, the
> clock is not correct, so distortion happens.
> 
> The resolution of this issue is to remove fsl_asoc_card_set_bias_level.
> Move PLL configuration to hw_params and hw_free.
> 
> After removing fsl_asoc_card_set_bias_level, also test WM8960 case,
> it can work.
> 
> Fixes: 708b4351f08c ("ASoC: fsl: Add Freescale Generic ASoC Sound Card with ASRC support")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
