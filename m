Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2790C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B965920705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:39:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AynCMGGq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgEDVjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726338AbgEDVjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:39:42 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2435C061A0E;
        Mon,  4 May 2020 14:39:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so312759plp.9;
        Mon, 04 May 2020 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dnKlsTHwnnFXazn7zzxGnzLza7yEGHj+jI4fWn0tS74=;
        b=AynCMGGq0W5VEIeiqAdRi99uVamrPcFWpeWEkJSSFpofFC9z+cTdg2BqY7IQs4bIPZ
         GSqk0NDj1De6v3E6B8hD69oAQTlbDvt1Lx9cjx93XUcfEwcebbSsgHRMtF4qhLb0jzZX
         itI0Q8Kr1odj5D/nJN/BpvPDndUDGVSMkPUzjR5fkCIsZ0cHYIyF0GBIi0buzkkIVTYX
         vyMUc8KMOGVroi9h+Rt1Zocd5gnzZOxcPjMnShu3prz33cm7yAKqGlvhXPLfJHUQyMp3
         L/RalKi4lfErm0MP9laMKgQi1WBfOL73oLxLBoIMe2Umoj52vUyX7Fb2Vn9QenyLud+5
         JzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dnKlsTHwnnFXazn7zzxGnzLza7yEGHj+jI4fWn0tS74=;
        b=iV3tvBC1dV3jeoNR/aGEjrtX1IfcrmutBIRHbyiK4h676Qi7geqNU4IGGQ7/Rk81xc
         oUAHpzsNTVl3hWV1Xjd6q40acDqCI0LOA/kPofODUss+vw5dkXNBIOX+djzhrlDFNkz+
         tK3RQ0AkKv/npFSYG9O6/SqxUZFmPfoxolT0fCnPAnM+55Q1b9HpJu1txbdkjEuUjQHf
         2yaVzdQQ4L9s2dAaPmWIo9KWnBg5MuNvTxpTChgbixhQgp1MFf83KAoaXXv7sEBiJhg6
         mkqlmh/jvVCJcknZwib+v89uQ84qWtduEUAWEefWiBeXqh0JmFpaAZfRPM0wymEZm5P2
         r6WA==
X-Gm-Message-State: AGi0PublvgyIwp1syPYhSCTmgHVbtw+G88uLFET6PPKGPC4h4Z5JNUQq
        KbU/iyGExz+3hyrumy5MBkg=
X-Google-Smtp-Source: APiQypJ0HAeQTPu2DzaLtYV63srcvAmn2r4FeBJuSk32vuYutJBixLjLmYsfLjkggFKUUIZHiN62KQ==
X-Received: by 2002:a17:90b:3017:: with SMTP id hg23mr171014pjb.150.1588628381874;
        Mon, 04 May 2020 14:39:41 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id a12sm44947pfr.28.2020.05.04.14.39.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 14:39:41 -0700 (PDT)
Date:   Mon, 4 May 2020 14:39:05 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, Xiubo.Lee@gmail.com, festevam@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: fsl_esai: introduce SoC specific data
Message-ID: <20200504213905.GA21292@Asurada-Nvidia>
References: <cover.1588320655.git.shengjiu.wang@nxp.com>
 <27af074e47bf2b81e2dce67ea66a9f7301dfcb07.1588320656.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27af074e47bf2b81e2dce67ea66a9f7301dfcb07.1588320656.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 04:12:04PM +0800, Shengjiu Wang wrote:
> Introduce a SoC specific data structure which contains the
> differences between the different SoCs.
> This makes it easier to support more differences without having
> to introduce a new if/else each time.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Though the 2nd patch is having comments to address, this one
looks fine to me and should be able to merge as long as Mark
is okay with this too:

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
