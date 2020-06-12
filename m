Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0047207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 08:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpLD6GPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFLIAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 04:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgFLIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 04:00:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9E0C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 23so3920686pfw.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 01:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tf6ndzUcORoBXdwJ742om4LN/SmZ3Qj0kiAjVJpLMKc=;
        b=KpLD6GPa1LiJdiGXWZtlAf3FCCQaL2P+jEHXZXpY0DK6/JwqBCfMEUa6SycwKn36pV
         fIU7NQzgMPjlZDT6/IgfHOy47FlKgE318Lpks/2XmKxd5ssYI/JhxLhUQ75NrwSA+FgI
         WwR9W/Kd/eb/WW1vtpNmQ9luP94CdVn8iknLZhGVcTLxXCE6AOHNN7mJqKJ9Lc/iCNKJ
         AmEDtdeCOQrtGcSJIcVAUggLVeknItOjsof4ZZKoN+u8vQ8mGV1UW+HWOCH9ZqIxe4wq
         8t6k+b6hVLXOTtMTvWBax2XusbsF8sNZOXOOhxUDzzwcEiUU8r0WY8sevY40vdjtQHLE
         pVzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tf6ndzUcORoBXdwJ742om4LN/SmZ3Qj0kiAjVJpLMKc=;
        b=OH/gS+8gDWVTIOUrmppywOyUJLO6dsNpwWK9Pa8gMGINzfzwNYF0IXuTu1I2HZWlty
         hS9M7xfiFzojGV/RDarvx+U2aJ8UA+6CaQ1d3b95m4KUGaRia5cVwlbf1Lom7kEpOOii
         ecZDSOc+QBptqNP2pBdyoCEK7sdSzmM0N/qeHEN4KiWOkJoM8rItEPwAJttv3u8W7Ik4
         adcZzQ/dzOZXABVM3huLQwmaFO5dFnO6XsUf8TgEEDbGjMAOz8VCBBPhK+J0+7w8yWAZ
         rOTmIGyQG+uYlThQTyKcjbF+2UFy/XVq+V3nZbYLlc2e2Wb3WOkISZXOmc2bzTwj6b+V
         rGvw==
X-Gm-Message-State: AOAM532VM92R9+K2uQfUVvqi02j/aGuZRzSVof/KIBbmDX4kRHbqHmgV
        L64l+bljilKCnHwWXd74Tfg=
X-Google-Smtp-Source: ABdhPJw376HozhA54nKnNRb/izTEe/+VX9TjxpQMNrnO9HjCzAoOeOAkAY3whh0s2i+FcSh4Kp67PA==
X-Received: by 2002:a63:4f1b:: with SMTP id d27mr9654512pgb.389.1591948851063;
        Fri, 12 Jun 2020 01:00:51 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id ca6sm4579180pjb.46.2020.06.12.01.00.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jun 2020 01:00:50 -0700 (PDT)
Date:   Fri, 12 Jun 2020 01:00:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, broonie@kernel.org, timur@kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 1/4] ASoC: soc-card: export
 snd_soc_lookup_component_nolocked
Message-ID: <20200612080037.GA22422@Asurada-Nvidia>
References: <cover.1591947428.git.shengjiu.wang@nxp.com>
 <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591947428.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55f6e0d76f67a517b9a44136d790ff2a06b5caa8.1591947428.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 03:37:48PM +0800, Shengjiu Wang wrote:
> snd_soc_lookup_component_nolocked can be used for the DPCM case
> that Front-End needs to get the unused platform component but
> added by Back-End cpu dai driver.
> 
> If the component is gotten, then we can get the dma chan created
> by Back-End component and reused it in Front-End.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Nicolin Chen <nicoleotsuka@gmail.com>
