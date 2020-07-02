Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF15C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F89D207CD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTHnMqQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgGBSsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBSsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:48:18 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481EEC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:48:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so12910958pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4BlDCKXOS7pXvqwXxqNjKYulCrchCC2Y4PnA+71ZGS0=;
        b=FTHnMqQ0vFzPe5NX8PYMPQ/vnegWez+WHEPhh2nmxzXbfXlQP0DiIyTz4f2zcZ2BDE
         r1txHNFmzGKrYoRDQdMUEXLSdu2b82OK2owZWBiVkAf+nvXI0T2PskI7scOpG/RYtiGc
         TYn256t9fboOAJig+jJ83xksT4wXLqwRvexijyg6iw/lsPaGE+DBiXPbHHv2vgF4vX3j
         pZGLto3bgLJTcqdsG5f2k3ZvfRdWyWkVhvzii59vmIBb6cgfIehN/WERNUpReAn6sP+a
         tGc2HURUZ3SWnkXzNWO4+fXbM8SI5Z9JrozkLFZfHB8wtFSApn1bGnkIMSBxCfzACMMZ
         SqVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4BlDCKXOS7pXvqwXxqNjKYulCrchCC2Y4PnA+71ZGS0=;
        b=ERu6ryXyXRkCfqjUPGuwiEDbcbgsylBzmO0q1m79J6jvydw02CsyXFYSjltaZ7gPXw
         vganWuq8J5QK+Ur6QNGS+fXPMBnnRSryWDrV4TPcdGqbeltLmev8vEP/AMuFx97n+NlO
         FwU6P1qYAcMum8UbqNuAlRO9kQir/dqqpckT80ML/08AHisKdKegA2nCzv0c6tPxiQ9M
         nFTixO8po+G4LfWqNtTJc2MufXDeW78dGtSyIyoF2tewbdFqui/4w5V5gkCxDp+JA7ww
         P4DG8SwMfF90SANXBTNM9x822VJwuQgVYSpknJWD0pvrYlceMHHJv/+PKh9Da42iO9MZ
         HNsw==
X-Gm-Message-State: AOAM532DUixsrdO9XBLk3+pzLowvcVcBbHRxnH/2i12tg4FZACFB0y40
        nzQwJYftoKHtnYBjJoQ3+GU=
X-Google-Smtp-Source: ABdhPJw0IEP+truimaQl+gRg0nVTV93ibnpqE0yESRZ/GoJYfFWTUvB0mD72OigVZjVlmaeVpGhpbQ==
X-Received: by 2002:a62:7650:: with SMTP id r77mr19282735pfc.235.1593715697849;
        Thu, 02 Jul 2020 11:48:17 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x7sm9884013pfp.96.2020.07.02.11.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:48:17 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:48:13 -0700
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
Subject: Re: [PATCH 4/6] ASoC: fsl: fsl_spdif: fix kernel-doc
Message-ID: <20200702184812.GE23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-5-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-5-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:25PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. kernel-doc syntax was not followed and missing parameter
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
 
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
