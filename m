Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E59C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F5AF20771
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEWt3ATI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGBSre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGBSre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:47:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A007C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:47:33 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc15so4337774pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zL1njao5U3QawtZRIy9WHRW3s8av22W5Zvsb2TW9baU=;
        b=nEWt3ATIQVLQyXkuQdvn1aiYxeRtcTjZA48sxFRfIWaLltWScvk8SuHv2VmRvSpuVT
         FSHcUHlaudUvwG06wYP6l35iSlpxk3fp/GUwCX8D1hgFuszx4mGzbibW/ggdVu5oj2rH
         LiqDGS5rNTYKOgdGa/r1Z+p3uYiYkUdQ+Y4QfiGpr9NMW5Kt09S9HID+2JZTlAkFSycb
         ZpXh6DyCVPkz36RuK0FW8QbJoQlBz3ZY1fsTlfs1OejByxVdOlW5eF4F4MBNLIYV6FdA
         Vr8NWzwEytfBRihxLiBrDQYSW/TNC31MVGV53CWTdGbLxLUE5mdw2EQREOpFwTe72m/n
         9Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zL1njao5U3QawtZRIy9WHRW3s8av22W5Zvsb2TW9baU=;
        b=ABU6Fr5z6+9A1uBksjXIqcMRv3st9AGZzK1UwkOHPHQJguggJ2iKH6EKEYWuwWLsdL
         LQjR8QKGI+HIY/TVSMKBVSk1N1KNpxSiXuCrbDUp1bbnEkpmlOVAGQgdpztlt7YPOJn6
         43TBWBg/6GlTRcn2MpWzPrV8hm9USR1kv/NohVviKlvGDufd22ExFRLLGldvk/Q8/Hvv
         jkNArc51XvZ6REdvpJbFm08kf9E0ffnUq4EgcwxzF0EszTe9Wz6vP9i/q3K8bQHpFcSA
         4YzX/vNYXli+4HO8kol4IsBFMMd7Oqmoq2hi1wlH4bnabIyTH4pWqcFA3Cw5rC+Pw4qf
         SRcQ==
X-Gm-Message-State: AOAM530M2Chy9tMQWEOpUP4uBRxdIS3AGZOBC1MPweWKRtqj1QpJqgPa
        XxsbNrSCbXIz4SNzrVsPXgg=
X-Google-Smtp-Source: ABdhPJzqWFlPtZQNtr1q8muNtABj2+NjawquW0DDONjn5yLdHttAns0cWnp1iJmb2C1ByT8ZNU3J5w==
X-Received: by 2002:a17:90a:2a09:: with SMTP id i9mr19383865pjd.50.1593715652929;
        Thu, 02 Jul 2020 11:47:32 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id d65sm1575040pfc.97.2020.07.02.11.47.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:47:32 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:47:28 -0700
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
Subject: Re: [PATCH 3/6] ASoC: fsl: fsl-asoc-card: fix kernel-doc
Message-ID: <20200702184727.GD23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-4-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-4-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:24PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. Kernel-doc syntax was not properly used.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/fsl/fsl-asoc-card.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c

>  /**
> - * Freescale Generic ASOC card private data
> + * struct fsl_asoc_card_priv - struct Freescale Generic ASOC card private data

Just a nit, can you drop the "struct" before "Freescale"?
Other parts of your changes don't really add this word.

Otherwise,
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
