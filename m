Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7780C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFA02071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri27KJ57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgEYGQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbgEYGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:16:53 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59349C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:16:53 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t8so6029788pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1y4ds9zBC1SyppOslu2mLkxYcNHMS7bdeKWM7VoLVJM=;
        b=Ri27KJ57iDhs85zxL0RpQLEdYtlE2a3/aJma/2msgokrz+N411A+WrgmoubU77/pCl
         Yd8CtuzMQQZ9st9XfemTdl/UDK+Lg2y2aV0zsjqMoJbjiy2dgh2mSgMc1BI/S/ykes3y
         bnjRyoMAbybFPqi2XL/PoLK3RGacV1GBBnvZHLEElv8DAIpwmdKS2xMwU+uXmaZxKxrp
         azXyJBvjfpmt1G9WrzH6mgCWYVkGn6owSOkeU5ce18CWs9iujmuSPAWRB+XiD1xovLrk
         R+eCt1fDZtETLygzNUbhw8jyvId4OqGNVsZlEzfcx4PmA/PrHURT1ZljgOWcDxpndrWw
         FjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1y4ds9zBC1SyppOslu2mLkxYcNHMS7bdeKWM7VoLVJM=;
        b=j/2y4D3msYJT7JxdtW8sPGc2TjCBiZU1SD6xclodyedqLlcGg/8zWw+eN0+egxy2Xg
         hLN9m9kGQzfTa8b9D0G0HqQTc3bVG2kBc+Sjt2LOgDOeaZ13YQoQX30nGSPen55um6bZ
         t65+03Y/7WFcdiaxlhtyicOAGMs5F6HIbBKrOBcI0x8SU0Bx7kF3sPoW01I4jw1LMRkc
         08TZmErTITP1Xx11VrzU5o86np5xu7xhqRpDm59E/iefmTFY6iWtnvMbYl1ToANfhXIz
         s6GLFOPyeu4WS6Bd663cnBo51YqgOi/S+8mxkP+I8g6qZkR2jT0jP8U+S2IerPHEM7Ne
         remQ==
X-Gm-Message-State: AOAM531NZepTwrwBM7ql8hZggIT73iAKvljgjuSCfgJ4TomqCmfXQUJI
        R2TMqTTC0UTGRsnVAJyG06g=
X-Google-Smtp-Source: ABdhPJyLnql6NYz3i6BDhhM9Z530+1CTHhFC5iBW0B2EeJA9dSWqab0WegzIfvg2UY2Fb/PuDkNTfg==
X-Received: by 2002:a17:902:7787:: with SMTP id o7mr20963332pll.52.1590387412768;
        Sun, 24 May 2020 23:16:52 -0700 (PDT)
Received: from Asurada (c-73-162-191-63.hsd1.ca.comcast.net. [73.162.191.63])
        by smtp.gmail.com with ESMTPSA id o16sm3623730pgg.57.2020.05.24.23.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 23:16:52 -0700 (PDT)
Date:   Sun, 24 May 2020 23:16:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_asrc: Merge suspend/resume function to
 runtime_suspend/resume
Message-ID: <20200525061645.GA12112@Asurada>
References: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590141444-28668-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 05:57:24PM +0800, Shengjiu Wang wrote:
> With dedicated power domain for asrc, power can be disabled after
> probe and pm runtime suspend, then the value of all registers need to
> be restored in pm runtime resume. So we can merge suspend/resume function
> to runtime_suspend/resume function and enable regcache only in end of
> probe.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
