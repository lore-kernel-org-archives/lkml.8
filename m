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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0DFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F7ED2067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XCh1Bvui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgFDAH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:07:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA88EC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:07:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so298708pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
        b=XCh1BvuiQnQ9Zm1oZ2yD4vKaikfXRb54M1szSL15zdmA4Wu3zIleoiijey1ihZJYmu
         yH73ihq2hNe4EPGty0ElAgH+2jO8uB3PwYRbUhMIb4DwZaakWiQkO4TsYbjZ5ZfQwLla
         Dqk8QEEEN5t2OKagg3lhOVoFlGROQAl6R4HBIvKnIpKE18gJTBbEaBog8i2qLQqPs1dN
         gxCOB8YGuOkwR1p5JZYt2ci26kspsM5+IdV/AzGK/7iHdc/Le+ZHHkfGXsx0vT868TpG
         GNtNEkGq5vrpV81Zk9flKNsy1k2xnXdO4yq9GaGhqZJdAhQZsPom222FE/RMcP8kfewk
         hkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=37s08ZuqFcndX7aAAI+JFevMdaZ0bnJEocIhn4/lh78=;
        b=ARUjMHdbaA+oatWWoj6zoco1HGOBDsuxbSxjyqoZSILab1lSR1MpOowKXQq3eEutCR
         PqY11ojeba0Sfb2KIeh9Bb+KFknX5sOwZqcBRTxWeThGqvW6g5Q2o0qaoXlonfttK+yZ
         KnZgpJLEwyM1Pr/QMchKSBJ+KuiHja2Y+rmBnl77Ba81ZZRF1I16kMohRXZ6r9I1Abhd
         xNEw6fy0HKdnn1KHCVuilaI/2qxYbicCSDzZA2s1TOSPWzQMyP0FGpzt1FGyK5LAJBSq
         FBROpjwITSJn/bgJa4T0RaMFRYs1LvaBFPwXmRelg6+vZTWNH7y6pHtyykBINBzFnp5A
         wilQ==
X-Gm-Message-State: AOAM531Vkuw/UQm5KvPdH/Fy16EWL7vwRbcIDVYQcaqiVvjyF9eTrtJl
        4uaWnNhfbgw+7c2Nzm1Ev2E=
X-Google-Smtp-Source: ABdhPJyx19haOwN64kw7j8RFpa8HEmcAYpFxgEWl1NTCvbX0UCfPaYbv4AlWn6qfCVsMTOK0HzJ54Q==
X-Received: by 2002:a17:90a:a107:: with SMTP id s7mr2777391pjp.199.1591229277291;
        Wed, 03 Jun 2020 17:07:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id b14sm2549035pgb.32.2020.06.03.17.07.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 17:07:56 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:07:54 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ASoC: fsl_easrc: Fix "Function parameter not
 described" warnings
Message-ID: <20200604000753.GC17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d166b868e6d294de47a89857be03758ec82a0a61.1591155860.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:39:41AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'easrc' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'infilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'outfilter' not described in 'fsl_easrc_normalize_filter'
> sound/soc/fsl/fsl_easrc.c:403: warning: Function parameter or member 'shift' not described in 'fsl_easrc_normalize_filter'
> 
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
