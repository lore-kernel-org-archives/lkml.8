Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A235A20734
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxfbcYL8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHJXNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgHJXNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:13:19 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17527C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:13:19 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so6562142pfw.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
        b=DxfbcYL83VI2tavwmTPi4J7eMSAsVh5SiXRXgr7w6VpnDWom8eqTPeZM8kNx8aL71a
         YNZoipg4ai47uUfLCO0TnZ91g/QuIs8WREnZk/H0YzF7U0oi4AVYSpa0/AhTDktapZMm
         +cqkDu7gKDDEZg/oD43W+K3+eGJVqa6jxoEdOXuiHP6AMTsB/rnpkSev/8TXRtRBlLNJ
         w+SE3h9I5KCD64mEmOANa/VzYKCKJc9fdAP5BwCZnjSMApRtpocutZiNjy9jEeV/kyDK
         uwQQaxAS9KK+svH70uw9w6/i3VlM0a7nFuMa42dpeHI4vYLfebLjf9P60kMHU7i6p/hq
         rl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5OYueSLJAlabAdhrq7Fym2M2F+FohXn8TYzF7kdpcA=;
        b=QYHD+ufUo13cYpu6MfkeszX4ZEPsKqaccxVrxaGMLZ8rXCzUDOp9hoE5Hd2u4/+Idh
         TyooYcBUvYxK39Rctcd1eeKBJWDaVnmoSqCspOAFJi1mJDT//cQ5tJyWkfkhLHu0YJLK
         sOUWxguSR1V90n03a4f1432B9t7EpgufW3Zyg+GJ6kzmhsbfGs+4yM69mQRTLCBfTZ+I
         eb1l3FsU8gzyKd/QR5Z8GAd/JZrKL5X0UcQr5/ENSz9f2JAjLXSvaPtOtpHB2Qf6eYZB
         PThrhMDmn3v8O0A8MPRtBjU2PMmoNrsZy6Oak4s6AXBsQEyxrrSswgzsPU4rOOgoCr3R
         N7Iw==
X-Gm-Message-State: AOAM533pY7HGY0wxw3Gj7PhxYTWtfj0DpNm1ImhCQhwRcFEMx/PW6uDO
        U4BfK/AGdJlJJ9y+KL16cRo=
X-Google-Smtp-Source: ABdhPJxv/TJg5AlqUpTIn9TvhqOmpz9wa9cBMbF4+XxBG2Uvfkj7gl65QPxHpEMaYIt+NDJjbmpUrQ==
X-Received: by 2002:a63:3850:: with SMTP id h16mr23683492pgn.218.1597101198635;
        Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 193sm22875595pfu.169.2020.08.10.16.13.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 16:13:18 -0700 (PDT)
Date:   Mon, 10 Aug 2020 16:13:15 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: fsl-asoc-card: Get "extal" clock rate by
 clk_get_rate
Message-ID: <20200810231314.GB16645@Asurada-Nvidia>
References: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597047103-6863-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 04:11:43PM +0800, Shengjiu Wang wrote:
> On some platform(.e.g. i.MX8QM MEK), the "extal" clock is different
> with the mclk of codec, then the clock rate is also different.
> So it is better to get clock rate of "extal" rate by clk_get_rate,
> don't reuse the clock rate of mclk.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
