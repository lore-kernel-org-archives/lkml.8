Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15105C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16C120734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOm0rklr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgHJXLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHJXLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:11:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:11:51 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so6556482pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iyYx+79mwCrZYi3nlfml4tfsSp9D2+EXuOvJ+LHVxHU=;
        b=YOm0rklrG+M8yFJVFuQfstvRO3v/Hq2XyONxrwKB7WZOa58+I2waQdvBPnfANWEeWd
         v5WN019344fkBd/eUIc5q/mc3sglQTBGZDEbM8ImbMp2WhdkG5RRxU7pqJnJaPrw3WCn
         +VCZvNgkDjq9REtEPH2RI17kTTXfMsoGMrpDtzTMLDGVK/Hs4tuMJinvZbhtK5F0CDfW
         vD2Lf3HLMgqNmaMxZfzFed+8IPMFkA3udQF3G1LCYaCNG0raW05Dxr9MbiCOHu/8QXal
         0WXPqS2vz1Z7OsqX/2vdlYryvbQk7whq3a/jKkt4UUUnuIODEDf7pXoMTvj+s4CZjfqc
         IVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iyYx+79mwCrZYi3nlfml4tfsSp9D2+EXuOvJ+LHVxHU=;
        b=ggDl3Uo+naQ+CMs0/SXO9EVerQkToh7fdNngeUZd6uARlcnCHmOtj6jQE4iNdLUA3C
         wcenzEQ0JcZE+PyNsH2IFujlnLfSaLuKnILcn4wl2LzJ9uA4XM0C0A/copIxJavQ4Md5
         x7iHzc0rIPPKgtYeAgnR0m6xoNIpbD1eE77XXGyTBi8PGfzvGim8GRlCHzMXXW4N5Yk2
         /INCQNkihhA22mTjVaB+6+jcofn3MEEakW8Fm/b8UzeBIbTe2lVJezoc1NQ5+eI7ewIf
         Jt2bCtEwNc2BeRYVb4K8j5vMmsZqLQ/sFD3jBaPbaue6h9zR+eCoVzdVLAzqlIoBMGVt
         HfAg==
X-Gm-Message-State: AOAM533Dd+NTlhwo4ov0vi01JpNofnWK7NMR+STd/OqcwYh4OEnd8k9Y
        9QmHwLH1StNQsJM8qo0ZN34=
X-Google-Smtp-Source: ABdhPJyuVXKLUZzlX+04asv1rO5NDwf3RYoPK3yQ/Y5WBimvbdL5XOOKrIANZFoQMNYFlRtNl7BTDQ==
X-Received: by 2002:a63:705b:: with SMTP id a27mr21206295pgn.405.1597101111429;
        Mon, 10 Aug 2020 16:11:51 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y4sm19161705pgb.16.2020.08.10.16.11.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 16:11:51 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:11:45 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
Message-ID: <20200810231144.GA16645@Asurada-Nvidia>
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> Regmap initialization may return -EPROBE_DEFER for clock
> may not be ready, so check -EPROBE_DEFER error type before
> start another Regmap initialization.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
