Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDCDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6500206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="NMrJNqcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895811AbgDOJrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895800AbgDOJrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:47:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:47:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u15so2975752ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0qy5LvgHxuRhiqgWueJQ6xJ9sv8tPQCF7n+fvQHiOs=;
        b=NMrJNqcK5eyfNz31lPbY+TyReQxJrnuEFiiI4ZHZ0RnGAep4m9OjU2s0Rahr5YHYpY
         6WRSCNOS4baRnCAsvEYr+dpc/PQ6WzUxxo3xfLtRealkbI7fZee+//V3BHy5FJKc/9j9
         90g6sX9fD4OSQuzvj6/DnLoV1DG5J9cQYAgGEEpl7v2ioZmNBalV6Oq5fKi3raobEXpa
         Fp4AYfeeJ57k3lRyyTphoQPXEhGnFLELLopIT5C+oSfwpe9Y9ZLHBDQBYPctrB/9Po8g
         pPMCcgWu8JTWAkQEFXN3DYv2QwvGGVaPmM/bcRIGn8n8FtTHP0YX3J5KDzH3zs6zIy7y
         xLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0qy5LvgHxuRhiqgWueJQ6xJ9sv8tPQCF7n+fvQHiOs=;
        b=D5tiBIuhXGB81enkweMrwWlUDUDOgoxa/Kypr38RgpG4SRlM0AvBrKqrzyUJ8TpTe1
         mwAgL7Su18UOpD9iWG6dRsNDk36HIhzt3+FCei9XwvnD4je6YlaLpWQ3IpxTddXQZ1T3
         wfrDOY3vBvmJRN98JovlrVNtkfBmukZNtXu4jZ+TRCYaufguRayT1BYsfiRLJxgjlga8
         O9pxYpF72Wh54tpDkpOYUr6u8qOXPYdL5FQGEVr1BwSf52jaY5+oLRUIQLvU2vm4kAJ4
         rdNyyDTD4JGS61ppJU0RDkSjQEOrPNiQ7ZxRIAM0F+iqBVeH8+/2hboEpG1rWgDsrWsK
         pmcA==
X-Gm-Message-State: AGi0PuZbuJ5WScEg6UAT2NeNAF1iPzRy9GeQD7U7HSeGVMHdfNwFEN45
        YGc9TMpWBmDVsUgu+6fC9fY/vhNWX8t/1k+EgemYrg==
X-Google-Smtp-Source: APiQypL8XMn5RnIEI3l+oru1L0UvcAugx1E2ZOCgi2uoo8JXWePaVPOi0V09wbIxJKMCZ9MtgPVJV073Y9PJRgdOM4M=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr2665731ljd.15.1586944042730;
 Wed, 15 Apr 2020 02:47:22 -0700 (PDT)
MIME-Version: 1.0
References: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1583944596-23410-1-git-send-email-yibin.gong@nxp.com>
From:   "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Date:   Wed, 15 Apr 2020 11:47:11 +0200
Message-ID: <CANh8QzwanSewjJ98HL_yR1juiHo1RN77JQyNNKrMrud3B0dnww@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] add ecspi ERR009165 for i.mx6/7 soc family
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, vkoul@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, dan.j.williams@intel.com,
        mark.rutland@arm.com, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,


On Wed, 11 Mar 2020 at 09:35, Robin Gong <yibin.gong@nxp.com> wrote:
>
> There is ecspi ERR009165 on i.mx6/7 soc family, which cause FIFO
> transfer to be send twice in DMA mode. Please get more information from:
> https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf. The workaround is adding
> new sdma ram script which works in XCH  mode as PIO inside sdma instead
> of SMC mode, meanwhile, 'TX_THRESHOLD' should be 0. The issue should be
> exist on all legacy i.mx6/7 soc family before i.mx6ul.
> NXP fix this design issue from i.mx6ul, so newer chips including i.mx6ul/
> 6ull/6sll do not need this workaroud anymore. All other i.mx6/7/8 chips
> still need this workaroud. This patch set add new 'fsl,imx6ul-ecspi'
> for ecspi driver and 'ecspi_fixed' in sdma driver to choose if need errata
> or not.
> The first two reverted patches should be the same issue, though, it
> seems 'fixed' by changing to other shp script. Hope Sean or Sascha could
> have the chance to test this patch set if could fix their issues.
> Besides, enable sdma support for i.mx8mm/8mq and fix ecspi1 not work
> on i.mx8mm because the event id is zero.
>
> PS:
>    Please get sdma firmware from below linux-firmware and copy it to your
> local rootfs /lib/firmware/imx/sdma.
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma
>

A couple of questions

1) Is this series needed for the i.MX6DL? (the document you linked
only seems to mention i.MX6D/Q
2) If the laterst SDMA firmware mentionned above is used will this
break systems running mainline kernels without this patch series
applied?

Regards,

Martin
