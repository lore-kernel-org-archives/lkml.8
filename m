Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E049C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C01206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLIreSFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390149AbgF2VBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731200AbgF2TM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:57 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5AC02E2EE
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:26:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f8so5981454ljc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hd2MMVVnXUbscP3hzSX359CMV7dNZSM4sZEMF0UOJXI=;
        b=CLIreSFviDpqPwYAU9TYkfCpvCYZGhdDaCIpQp9/rVeqvGhxeP/XKzS+0zgJVMs5Da
         mROjN0Zcll4HiiSpuWfyAVT0+dinkiiSg/PZh2aTUdLOkbzqW3FKmeX621Th59C220jQ
         G/T7+sE3unXZPernYsPooyb097t4jqoQAJ9GKvBAN5cUnVKp0vu/ZANjtz9Vxvc8hVlX
         S9axoaFN5unHOkT22mCY4sG11qAFJh075GM6lo/k9RNOqU64JUHrm8jqiboYRqtrsWv9
         jtRPzJckeNCCozASP5YeKKr0+8U+8B8vCmw3JWINbemfGOqhkiH4qXPE49XOR9eK8jQd
         hJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hd2MMVVnXUbscP3hzSX359CMV7dNZSM4sZEMF0UOJXI=;
        b=L6w3kwZI37crjB6gsMglETg+tnXVAHJa0pzbzCcQMLADphB5DasqRxTbWv+29/Atg9
         V9o1Er0gyEDVNI5RkKom5s40KrYinJyQRCYL1pdeoxwSpvsPB4CuYwRv/L3dkqj9KuO8
         XjdBWFXwMz1QPfvRtnMemxXabHF6+yr7uEpMQTsmVR6y9hU7JQjQaDQbI6c+4JSD8iuG
         C2bxZWHDK5c0ByZkOj+EBTXqXbLL4kaOZ/TBX03VTr+ZNlVi7soEKBLRJfjEBh+kJZpS
         pcc9MQCeUf79QxTAU1ZQAqLWa/hES+oW0KQ7Ns4GzU6n9GCkPqRkLsg+UmO7PuanAMlv
         B+/A==
X-Gm-Message-State: AOAM532vLqAEBDVQkqc+iBMAYmrQgwUx7yDOThhZf961cqMYPPyAmzvv
        CUB0rvMAGivcOWhQ0Zp84GCN7LEOiInXopVFZ24=
X-Google-Smtp-Source: ABdhPJwv+2TBJnR+v+U9uRgOsmF6mxAOltYDtWKeiCc7/svgER2YODEPW03+PgrAQa+o23NEqsLCFeHS7iG7RPEgBSE=
X-Received: by 2002:a2e:808d:: with SMTP id i13mr4871204ljg.452.1593440762030;
 Mon, 29 Jun 2020 07:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com> <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
In-Reply-To: <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 29 Jun 2020 11:25:50 -0300
Message-ID: <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>, Fugang Duan <fugang.duan@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sven,

On Mon, Jun 29, 2020 at 10:40 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> Thank you for testing this out on a different platform !
>
> I had a look at how things are done in the Freescale fork of the kernel
> (5.4.24_2.1.0) and I noticed that this kernel has almost the same
> behaviour as this proposed patch: the GPR5 bit is _always_ set
> on a plus. The code does not check how the enet clock is generated.
>
> https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm/mach-imx/mach-imx6q.c?h=rel_imx_5.4.24_2.1.0&id=babac008e5cf168abca1a85bda2e8071ca27a5c0#n269
>
> Now, I'm assuming that the sabresd-plus can run on the Freescale
> kernel fork. The GPR5 bit will always be set there.

Just tested 5.4.24_2.1.0 on an imx6qp sabresd and DHCP also fails there.
