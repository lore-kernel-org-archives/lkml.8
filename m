Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB059C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1BF020723
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hcY1YkAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgFWOTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732657AbgFWOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:19:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC0CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:19:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so23577185lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m34msSYUCCf3si0VF7znOPUPlfWE0UyptutRCUWjYNM=;
        b=hcY1YkAhQpw7JJ8qyCW1plenSHQjjX4glDcP2vwgecJyI9FvLxPIoFDNRgzzTXkxDu
         mxabAh4nSYeye+Bi33uuPH/twuh0CulgMQaMPRy2gTWl5XKe3smiHsiWLZ8Ej8MIdJkY
         ZpPYW1NaWln13+vkfVYq4SXuBdrQjiIc8LFcs5DqXK7cTVgFguTAMdkxUH1m7g5RzABa
         gZQXkah6SYWiIk3N7/O1jRb0vHQh0hNHIMN8e9Wsz/0gagJSiaepSX0EwvLbPqtqGt94
         bVKAOjd+DFPglLsvnmYnR3jCAo4C/spnoL1g+eDSx4XdZrTG9V+hsgKLyxzNtEpIDABR
         nNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m34msSYUCCf3si0VF7znOPUPlfWE0UyptutRCUWjYNM=;
        b=IAWxPDIVnrT/+URfW8h0If7EooUEKWkfDcGCptP5VmZE684F2he7zD1CWQeLwHR4Vy
         bEA3DkJeg97At87LclIxgaFCx0Jj4IJHWQHm3SYEDeYo0O3drH/RYoq91i6Bz9VnEuJ9
         S/OuBNcjP/+HmPsNJ7nkIvgXo1kF1+H1AwrKPj+eUmfEr3jKn8hWRsymBP1WcBqE2NK0
         BcqolPz4Y+3IWjLS6hVGAKLq8nsLIAYt1S2tO+oz0WnANYD5sPfg/IBcvXIZnl/+MvnH
         TqmCUGRLEyFqQdRp/DG0h+UXPecTwn4qr+uLgw6N/pMWXl6tkbNnNthKywn/UyV42/wW
         AnSw==
X-Gm-Message-State: AOAM5326fTIucwiswkL5+pWjThBUnjCBrCWWDVSEpbQSe37RyYZKN1aJ
        mpSwtrNwpxYDVIXkyaF3ragO7Doi30jz7jAD4lo=
X-Google-Smtp-Source: ABdhPJwd1V4ionrQCIxe5I5d0mIgaO7s02s3CGXRf15UuCbkrPKSY6tH/1xuY1DTXua8zZ0GKaJVY2C5/g1EDZptydE=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr11950945ljk.44.1592921977248;
 Tue, 23 Jun 2020 07:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200613201703.16788-1-TheSven73@gmail.com>
In-Reply-To: <20200613201703.16788-1-TheSven73@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Jun 2020 11:19:25 -0300
Message-ID: <CAOMZO5ANnvsJ2iGrQSHiLUpd8RKCEmNZSdAvVFEQpqu8zvpp5Q@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: imx6plus: enable internal routing of clk_enet_ref
 where possible
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
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

On Sat, Jun 13, 2020 at 5:17 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> +       /*
> +        * On imx6 plus, enet_ref from ANATOP/CCM can be internally routed to
> +        * be the PTP clock source, instead of having to be routed through
> +        * pads.
> +        * Board designs which route the ANATOP/CCM clock through pads are
> +        * unaffected when routing happens internally. So on these designs,
> +        * route internally by default.
> +        */
> +       if (clksel == IMX6Q_GPR1_ENET_CLK_SEL_ANATOP && cpu_is_imx6q() &&
> +                       imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0) {

You should limit this to imx6 quad plus only, so you would better
check against "fsl,imx6qp".
