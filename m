Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FFFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E839020672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 11:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6hFVbaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733127AbgF3LtT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 07:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgF3LtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 07:49:18 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61ADFC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:49:18 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s1so22097026ljo.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 04:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VLWfC/I0m+b+BajP44XmmXWYTkVKOmiOTvGSpdorkHg=;
        b=Z6hFVbaNjuuUrbTvS1Chtjn5aa79g9IbQ9LmKKQfUVZvWM1dQLXFrFUZSCbCu+ONf2
         KFH50WaSvU+vktISGXbTqPCUm3UbbLIe5PVUfGvosjPiJUzNixtMhIRipPcTylHmBI4P
         ncg17l2zubUu9PKIiHgzoiX2n7dVnyHfIrnSyXzn6kjxz309AYNdNQhs9Ry3ayoP7C3C
         2yOELZwrjRRHvJmUojNPZgADpSibdaTHPaETwHZZzbvD6NN96nLfv2T8T/9+hP5eoviW
         yaD6u/RfMRVUF3Z9rFFSNSadwLSf5vz+fnd6tKqI3U2Ye6wEVNvljqWmDc8By5WOC9kz
         Bqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VLWfC/I0m+b+BajP44XmmXWYTkVKOmiOTvGSpdorkHg=;
        b=itQ8VtgSYGtj1tI5xd2pLWxYp+YF2jPQjG6NSLquVjKW+D8LyT9P2rXMUsB4O/C1MN
         M/904QEojY0Of3BuYkLBt1fK4svNAcymOwR3na+3vMC2tAg9zDCy244YhcPSmtHZnXIQ
         fRWx7da6f0Gv0cB3eF9hfaS7UM09ZvYvOmlzdOUS3mB9wmNyg8Dpncjq8fZ5uFbjON2W
         2QZ8d61TnF6Wl2eDI5GTlYp5P/JSsIo/VST+AsfcCVnUpeXRye7roFrjrdVpOnELbm06
         iua7jtJ9LKzOBrpO2VlmqBdKZCCJkYz0JrJKzyVniCUYWmbvsYfO/C0vjTgiAFlmoDrL
         rDTg==
X-Gm-Message-State: AOAM531yMFHamxaJPJF2yfGbQ1S0ANrROX4xf1aCRwUr8xGQiLvlc1mZ
        f1g8IZGF7XJQwjTaIv0OHZ0oDGItVm2R9PHTBNkywYpjefI=
X-Google-Smtp-Source: ABdhPJx40MfNvznMlGbChPLcVRQNDhANMvmB5hqW/XA50SubTkPrtYdZiujNsmgpOiebvdmZGMKO74xkoWogFJKxEUo=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr10822585ljk.44.1593517756880;
 Tue, 30 Jun 2020 04:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200625140105.14999-1-TheSven73@gmail.com> <20200625140105.14999-2-TheSven73@gmail.com>
 <CAOMZO5AWiHWSLAcd=dj9dDFj8jLPAVAuoiOAJ8qKGPwRq1Q41g@mail.gmail.com>
 <CAGngYiXJy4ASTNfT+R+qzJ3wA=Wy2h6XZm+8oo09sD+Jmse02w@mail.gmail.com>
 <CAOMZO5Cr3k+oy_Sf0kL9gge7bwqkvJR8BQhY-FvxVXN00A2ARw@mail.gmail.com>
 <CAGngYiW=Pc_QjsjCv4Pc_R9OZk7nOAKm=k=b4TMbYRZ-08zKrQ@mail.gmail.com> <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB36077C422DABCB4F2EA650A0FF6F0@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 30 Jun 2020 08:49:05 -0300
Message-ID: <CAOMZO5B8vU0iNVF7209rnYo0xH57Hs=WcVgz-mbACjwFb289Yg@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v4 2/2] ARM: imx6plus: enable internal routing
 of clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 30, 2020 at 3:36 AM Andy Duan <fugang.duan@nxp.com> wrote:

> Fabio, our QA double verify 5.4.24_2.1.0, no matter SD boot or tftp/nfs boot,
> both work fine on i.MX6QP sabresd board,  please double check your environment.

Is static IP or DHCP used on these tests?

I have an SCH-28857 REV A2 imx6qp sabresd board here and "udhcpc -i
eth0" fails 100% of the times if GPR5[9] is set.
