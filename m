Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18C1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF60B20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJOEMzB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387452AbgF2Tia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387450AbgF2Tho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9AC02A573
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:40:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n6so15541065otl.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 06:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2yPHKowUi96Vn2b3DOoicWlqu6R072c9j8HQHzbwdU=;
        b=qJOEMzB7xbxdQjpO+XL5H0gKfxvjsVXEi6ZaHyfxCFOI5uO9ZlyJzc3O6PJoV2fkmv
         loacqs6nDBuoGABmSYSH7aZL4osJDtZbvQzHSUGu1mmO/EEXyyV3RGKTlb+LYOiNz6eK
         qjEkdk1p9Z2GTjVS7xRdj1ocEXJL9XX/jBQ03tgMrwLsf1aDakKhjRRtrqfRSryeO0K+
         o+Hv92Tx+nGSK1WzW7EvZjrBFhJc8infvGvOVcLjEJ3Q9BgyTayq9rWYD5nsP2BYmsiw
         55XmrnGd/w3ufr6QwTCIFKgnkXF+y94EJDQL1UEM8MxNA17C2VJYFjNrmrx5QdB7q/6q
         zWgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2yPHKowUi96Vn2b3DOoicWlqu6R072c9j8HQHzbwdU=;
        b=MPetrr2mB0/dLnabLs/wOWYBlkN06B/BeVn8BO5D50+4kEUAgHSB6LsnX6kbCo0Ial
         VF1y0mi7X+KpNK3b8wrQhx7BbcEXU8+hqKsrwv0GVbcC11x90BZotHombcM6nAJrUAxr
         QlBwvULLnqSm1KCZUhV6/Tw4JmTVONM4geoibqOHH6lkW7S0OkCoGYlUIk4x7XEInckM
         yZyGOuihrJDVhwxwRZXZSXU550q+It3FGkyh8opUExYlZqGQkc9HQCLu3pqSRVDpmJki
         ZArBb6/SLZpNYKmWD99qQ9J5VKHne09XoCXGrAxH5PNSG0NCzmT8Zr/KQR2bKnk5225r
         M+Hw==
X-Gm-Message-State: AOAM530C5utNzzm3OQN7LxtDsFaYJ1IcNW47P4NG0SV5vIS4YZWZvevK
        Lrlm4fpfNbpQOU5HMNuq0ktcZLAcsMCyakopJnw=
X-Google-Smtp-Source: ABdhPJw7kEzXBxJJnUuNUUoU45XMZoYtBPe0snAmYN8gjM/GZ/pcyzUWVZ8CWfI2On4ChM+3h/EaYLLVeEcrx/mUa+o=
X-Received: by 2002:a9d:2c26:: with SMTP id f35mr13978875otb.232.1593438050647;
 Mon, 29 Jun 2020 06:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
In-Reply-To: <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 29 Jun 2020 09:40:38 -0400
Message-ID: <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
To:     Fabio Estevam <festevam@gmail.com>
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

Hi Fabio,

On Mon, Jun 29, 2020 at 9:10 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> I have tested this series on an imx6qp sabresd and unfortunately, it
> breaks Ethernet as I can no longer get an IP address from the DHCP
> server.

Thank you for testing this out on a different platform !

I had a look at how things are done in the Freescale fork of the kernel
(5.4.24_2.1.0) and I noticed that this kernel has almost the same
behaviour as this proposed patch: the GPR5 bit is _always_ set
on a plus. The code does not check how the enet clock is generated.

https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm/mach-imx/mach-imx6q.c?h=rel_imx_5.4.24_2.1.0&id=babac008e5cf168abca1a85bda2e8071ca27a5c0#n269

Now, I'm assuming that the sabresd-plus can run on the Freescale
kernel fork. The GPR5 bit will always be set there.

So why won't mainline work with this patch? What have I overlooked?

I'm sure you've checked that sabresd ethernet works ok on mainline
even without this patch?
