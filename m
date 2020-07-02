Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13C8208FE
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3G4MtAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgGBS4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:56:01 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD596C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:56:01 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so2388144pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qBFSIEqb3Ng7/lC0JUelHpDcsFXn4/YiY3KJn+e0D5Y=;
        b=A3G4MtANzT6glf9L54RU8hc1oacj7n2KB3QD7g0+kHEo/8S28CgBxelB4vKRcvhnc3
         RSnK4atX1dx5Qih53uU7m0JQvP9hx1zMxNvFzp7+kEavqGXpPcfBUUXibPw5AEBVkSUW
         CpQ82qvhwyIsH9H84QtLcbpcR5C0Xe9EKZhqpVrvMckIzbA8EvZNHDCRzqpqWXVmOo6u
         2b25n3RkYBpMCZnTiTlNwEQDAhnVecoxMzHzgobV4ZxLWKRAqqPFu5bcBygECag2dI2x
         IT9Nf76Z1P0cPoKdTmSIC3Y+fSJeUwVLG1Z0Jj2dgYvKb9bZ3p8Wq1jYn9xzLe1y6b1T
         D9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qBFSIEqb3Ng7/lC0JUelHpDcsFXn4/YiY3KJn+e0D5Y=;
        b=b6M1KGLSCY6uwclhjUgmv5jjovev//4GgG3bdQDZDB8v8kXXhUFme/h/nuj1HjoIDq
         pJnqLpVZ2GP+IrSmJqyjyetCVT2VsPemjP67nMugrLfBaqojiepFWjj++SemzHW7yI6N
         j28SbXfia0V6lGS0662LwJXldY28ze+m0DFoUBxNpFpIqGJR/r+Qej1p7rcSOKxLiOMk
         iurnRhH+QJqjtH3fcAcYUR6DxqiRZtUKspq1n6/qlppmaQhhKcM/zWc2Pzg6uGgq3l/b
         NS5v95M6bzF4iiYQOpHOdJ6Z9XfLRp/4r7vgQMJmG9qKnd5KkwVh0L680fptZUCJ+6n6
         zlzQ==
X-Gm-Message-State: AOAM533QiQPI0XVdZ5p2n2oAsAfxznh35KDS/Ijx93xk/JOukos0MqrZ
        Xcg6CQuXUYZlDLcDFIlTM6I=
X-Google-Smtp-Source: ABdhPJzmLnrOT4bL83BOEWHbMjWQcuvAWjX4ZOEdS5WteN03EusTe1EhtKuJZhn9XxejD3G2LQnkxw==
X-Received: by 2002:a17:90a:2465:: with SMTP id h92mr3998120pje.26.1593716161116;
        Thu, 02 Jul 2020 11:56:01 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id m92sm8863055pje.13.2020.07.02.11.56.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:56:00 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:55:56 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "open list:FREESCALE SOC SOUND DRIVERS" 
        <linuxppc-dev@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: fsl_esai: fix kernel-doc
Message-ID: <20200702185556.GG23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-7-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-7-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:27PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. Fix kernel-doc syntax and add missing parameters.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> + * fsl_esai_set_dai_sysclk - This function mainly configures the clock frequency of MCLK (HCKT/HCKR)

Can drop "This function mainly"

>  /**
> - * This function configures the related dividers according to the bclk rate
> + * fsl_esai_set_bclk - This function configures the related dividers according to the bclk rate

Here too -- dropping "This function"

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thanks!
