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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C259BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89FD020772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r6HE+0mZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgGBSnV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgGBSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:43:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEFC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:43:19 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j1so12899795pfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T8AFzNr8FTwNK1ymuDjuXty3ke3mxQ2LEmj5APqSzAs=;
        b=r6HE+0mZ02w7MurOAipYo+NhP+BXB+/ZheXD3JdoLZTRukq/OOKHZJHm/5DpdUZVYV
         8e/d2StblsM1xLyj0G+WXd+YBpY0tZb8VuZBdzesAbY6aSS+GE/d+e/sbyw/EV8BQo5u
         4iUQr7tSE53nEj3vSDrahVbtJ/01g6PsWhbPO4KueXaZQGbrsL0CLnr0OBKaRa5zHoCs
         By7G26zmROIR5XQMzCloUCTxr10YGwbOBWaHqPGt3a+WLIvc7mUwbeaoqET6HC0il/ML
         cJ9pHCUydheBLoq7TX8aCQQj6/ZKoe2uN0S7WfZ3NP5kx7e8RfVDUQJuWMQlG1JXWTLZ
         xZog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T8AFzNr8FTwNK1ymuDjuXty3ke3mxQ2LEmj5APqSzAs=;
        b=c0DXs/rYWnawJ8AdqR8xHnAnUMY5+V17H3QKFYdJ/+7y6UiqsjGddVr7PdekIe3TGL
         Oxbjn4VkJNLLxira/9DThveOBCzROXJiYYW10Rfd/kjfHocveuvBypt0BsGqUz84OQN5
         b3CWQmbx/jtv/Mg3jZRZob22m1sssK6vl7AzmaRsC99m0BXi3S+HXd6jaOx7RE0Ly7Hl
         7Li95V9YDnku76OA2lmYREatEHhXqetd5Hkf+/atkt31Udj6N7RF9lXKjTzw6RMcsH6F
         +ZQFyy+Tgrm6zTmRjvB89MdhpO3jZe6qGasZMw87vTc7xSbGOdojz/uz5dhV3lHArmaM
         E4xQ==
X-Gm-Message-State: AOAM531NRADFgzqQSazzxciynEOAKkgmo4k6Yq0riiV7SUW+7DWwQsy4
        sS+OiO5BDPC3NYv+Hv3s/Bw=
X-Google-Smtp-Source: ABdhPJyf9rPXrraJ4zNdrCsJxDRxl6SVVSEajMec5OJdQ6AmrIx6KJJeJD6+gb4cN2DXsLXo3syu9Q==
X-Received: by 2002:a62:5e83:: with SMTP id s125mr27945470pfb.315.1593715398982;
        Thu, 02 Jul 2020 11:43:18 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n2sm9335901pgv.37.2020.07.02.11.43.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Jul 2020 11:43:18 -0700 (PDT)
Date:   Thu, 2 Jul 2020 11:43:14 -0700
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
Subject: Re: [PATCH 1/6] ASoC: fsl: fsl_ssi_dbg: remove spurious kernel-doc
 comment start
Message-ID: <20200702184313.GB23935@Asurada-Nvidia>
References: <20200702172227.164474-1-pierre-louis.bossart@linux.intel.com>
 <20200702172227.164474-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702172227.164474-2-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:22:22PM -0500, Pierre-Louis Bossart wrote:
> Fix W=1 warnings. There is no kernel-doc here.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
