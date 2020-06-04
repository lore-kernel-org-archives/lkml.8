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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB322067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbRusUEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFDAHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:07:06 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D576C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:07:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fs4so288545pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wW9z6dg9gtAyJMDZbmTtIDy0Zz6R5BIjGsT/C/EraEE=;
        b=hbRusUEBEuXE43+h8g3Pvw81RsDWZKa0dvCSbxNYz78B1eNTcn2Pnq05G3QMZd5gzx
         70P3CSV0FOq+qRA076Tlw61da/eYYkgLKinDK4FfLSA4JeKaOSz5+ojszcktpXRtI34y
         GdgQbxNrr+wMFg9z9z9KVx7xyCoHDnkAg41ewHMrMeFmQvH433MmUryuwVTZxzTpHmT7
         nXCFnvpCkBeS2EUM4oRMqrworUamYwAajGO52p67jp+y8DJ7PDk1h2xoH5Ck3XIJH3BN
         YdZRpVQej+qKFERrZ0PH+nyJAvnZJbRPetvr/UssZd8jOBchORcWXDFyRMwLd+5Msjq6
         7GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wW9z6dg9gtAyJMDZbmTtIDy0Zz6R5BIjGsT/C/EraEE=;
        b=uD8p1vj3if7druKqtFyZeN7YaGepHp7VyxhJaW7lNlDWjStfrmmnFi1KcDfwQ3cnXj
         ppYd+2fU/cEsHykYo6ErUUafygfyZFOgkPQDZ4XtCtWMIhO+6EXxyNz1BZhnvuPwmBYK
         +6kcYzJeL94odjbAoQ4NDX6bHGoapYzblgpHkiov1pzkVzZLBqUdKSYMnYw2k60zJpC8
         gLw6m36fH7J3vGoKcbErfEyGhCN/MHTjb5uGO4WOyMhfchD46pvOVOUIDiRKl50ySaB3
         /Wd2Z+cIzWS+94G4Nf3HTk8iEAUkikFCZI5hsQdVB01BrCV8QFzKjweIal0MwYZLDBS6
         xxdw==
X-Gm-Message-State: AOAM533t4sFyR1zrjGFXP4YjDE3VAHehdjZnY7s4Re70H9c2Z0WBpt79
        QI5yxua/mVYY5VFLYayUKfI=
X-Google-Smtp-Source: ABdhPJySQ1XeZeT8TPYoiRNFfTzkpxUVKzVYueW0EDHFb2AOz5sAtiVyA6sIuTRIpxdg2f6zYH/GCA==
X-Received: by 2002:a17:90b:193:: with SMTP id t19mr2899534pjs.47.1591229225665;
        Wed, 03 Jun 2020 17:07:05 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id f136sm2691842pfa.59.2020.06.03.17.07.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 17:07:05 -0700 (PDT)
Date:   Wed, 3 Jun 2020 17:07:02 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ASoC: fsl_easrc: Fix -Wunused-but-set-variable
Message-ID: <20200604000701.GB17364@Asurada-Nvidia>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
 <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 11:39:40AM +0800, Shengjiu Wang wrote:
> Obtained with:
> $ make W=1
> 
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_rs_ratio':
> sound/soc/fsl/fsl_easrc.c:182:15: warning: variable 'int_bits' set but not used [-Wunused-but-set-variable]
>   unsigned int int_bits;
>                ^
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_ctx_organziation':
> sound/soc/fsl/fsl_easrc.c:1204:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
>   struct device *dev;
>                  ^
> sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_release_context':
> sound/soc/fsl/fsl_easrc.c:1294:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
>   struct device *dev;
>                  ^
> Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Reported-by: kbuild test robot <lkp@intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
