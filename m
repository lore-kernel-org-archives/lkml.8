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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD3F20772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/eW4I1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGBSoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGBSoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:44:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD79C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:44:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u5so12906968pfn.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FP9n0qRIXc4AGMB2Cuj6evDveqJfblRxHMETVqaiIRE=;
        b=Y/eW4I1UJ6ndSlD7IHhSytnpBWDxb+Jw8Q0hLbNMEnuoySdgmvAUxHuc3C+ftqBOpN
         Lb+W15tgmK6Ryygl4oh6VGa4phdiNK184gn15nEqRVOreI5OGZ3qhIhyRkh/C/GGOmOV
         nMKdP039o6wfud5iisiozwbW58Xg/HOEiR7ymbC+2xUG7zJVX1hYcOYFZNfwiNLge27b
         ZvOUMD8IPQkfZCkG4bN/uoD7aQGFpxE0FIPb+6Colv7RsU8COSWGAWccY3kG/JKDHV2t
         6zmz9inr5prww1u+YJZ9sKz81TMTceg1Cddydsz2YUPQEO3LBVSlVhK3qbYcsy8A2ZqW
         Pshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FP9n0qRIXc4AGMB2Cuj6evDveqJfblRxHMETVqaiIRE=;
        b=OdQGNc5zResnFqtAaf685v4ofzC+CY3L8GnRO5TL8Qw9KJOU8bemVRVTVDaL2nvhUB
         TMZtOe1D+BkyuqqyrhxOvuNg50jAMqPIxOSmdblbPdgzr4H3GCRsD2ljZhZyoOVQQFzx
         8ObZeAKjSqHZL16KHYXSkHhVJiwgu7jItFmepYut4F9viIsO3amLmF9tJ9n24W9P0eLB
         MabxrZqRALULbcEmyRJJEhTcRUR4fD25GAd5AcDvMnp5LyUNzZ4nqCeVbrT6DqjoPRfb
         q7IMcOrUohjiraz+ZXx4k1uKHnVnJR6eY7Ustro88IQVCuH69ZdtMgbi6KVSsnHXAjhc
         f0Ug==
X-Gm-Message-State: AOAM5300qKoUUNXmOloUnqZhOP/3R1ylj2YKo6QEk1D+vrPjrzUaGFMp
        HpueCszik+pYH8oBBR1jMJc=
X-Google-Smtp-Source: ABdhPJwoL6GaAMdB9x4/AlPN6Z249mGTQ4ZjldoorgeCh7p+TR+j2RyiDDnQdqYC3t17qCULfe8YMg==
X-Received: by 2002:aa7:9630:: with SMTP id r16mr24760416pfg.144.1593715459899;
        Thu, 02 Jul 2020 11:44:19 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n12sm9474759pgr.88.2020.07.02.11.44.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:44:19 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:44:15 -0700
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
Subject: Re: [PATCH 2/6] ASoC: fsl: fsl_ssi: fix kernel-doc
Message-ID: <20200702184414.GC23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-3-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-3-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:23PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. The kernel-doc support is partial, add more
> descriptions and follow proper syntax
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
