Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A847C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6324A2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 03:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lh3AakFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgICDbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 23:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgICDbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 23:31:43 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80EC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 20:31:42 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id w7so1104184pfi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 20:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
        b=Lh3AakFc2ktTayAXJ3pnozs/7S5cR9pjcLsMH65p4Oypa4yVlDrB9sxuRsvs1ZqnJf
         m4Q0T8KEeVSiLJk58AEEWBzSDM22WlwCsu4r4uQ95h9GjGMNX3XSWrqAFEsSskncgFZM
         ZThvCDfsFIa0zcXzx+ihAjyoiDVREI78q1NU113ynXd6tHcph1oO0oWBDRxpkBAdG/Ed
         5wvVArnBumGOdJcZFzgCNkqry+qjE/zQjZv0i8Sk4f7qiZfT39t+qUXyf/Dcy/UONlin
         L/2zLZHpqboem355bgN5gcnEYmbfmbqBCBe+GU/vMmSTFIbKgsK/Nl4Z+5Utskgx5iic
         D6DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jVbQJV7FQRWnjXc4WFRtSyL4necLOFwK41hOpTt0Y3c=;
        b=ly6n0s94BV626NaevRovlEd44hoPyJLBsaFY4NpjXSl9FGPrg/fzn9zCKi8Mbq+W+K
         poxyJMKPPvk8nBiCI5QznHwrtwdBtRxUYS/4p/3TvoKYWJOXnN/NNJMtTbug44IhHBNL
         omrKS8gDSHmI7rqZRWmiNqtbKBwDU7E9tGIb2x4XzL5bVwJGNmNvmHAbFVKhx7fddtdb
         fkogtRzMk9hchHk/iJJbSx5ipm7fy5GQnpCYwIqtgyJCsiNuGkt8km0SIMnD2LJ8P2tA
         sohnt6XPLEMPseRMdXw3bjQJY1/uwlfuI/SH6NQErTD495am78h8PwKsN23K1S8tpQMz
         z1aQ==
X-Gm-Message-State: AOAM533650s9RYe6NfkfqWxdxE/MpVAI7vZpFr4W+omLhUWRmU1lQCBd
        TykkE2CuVBeNCMJyTMtC8+M=
X-Google-Smtp-Source: ABdhPJyeeNghFiK0krO7HS3KViJMyxOmRd6O6x+am6iTWrNYXrgGQ1ZUoP1V6uOaTIiWadIkyIrllw==
X-Received: by 2002:a62:ea01:: with SMTP id t1mr1699823pfh.125.1599103901928;
        Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x22sm1047250pfn.41.2020.09.02.20.31.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Sep 2020 20:31:41 -0700 (PDT)
Date:   Wed, 2 Sep 2020 20:30:57 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: fsl_sai: Support multiple data channel enable bits
Message-ID: <20200903033057.GB4517@Asurada-Nvidia>
References: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598958068-10552-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 07:01:08PM +0800, Shengjiu Wang wrote:
> One data channel is one data line. From imx7ulp, the SAI IP is
> enhanced to support multiple data channels.
> 
> If there is only two channels input and slots is 2, then enable one
> data channel is enough for data transfer. So enable the TCE/RCE and
> transmit/receive mask register according to the input channels and
> slots configuration.
> 
> Move the data channel enablement from startup() to hw_params().
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
