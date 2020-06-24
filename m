Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A024EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN/2WJZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbgFXC4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbgFXC4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:56:33 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725BFC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 19:56:33 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n5so570570otj.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 19:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDL9pKZ/aY/6GF+LYS6OgXAXDW+bnN8p+ujXzgAstfY=;
        b=AN/2WJZsaL5zQ4JKy5XIeRuc7Er5Q9ZQRulkYR3C1CL9h7aV2IL7/S68jA5RSjZV93
         9sVJuGr0Bor4RgUpuJQjeqbMoeFTpYLeTcqB5Iy/ZRAsTCwFjXcjWerTV6nC6FOKs4hM
         YiLlfz+XAYPVoOUgVn/Y/RfKNfOJU5GkWZAcyHblX50sKA9PujJse7a21PgIJuoYsQa5
         klWW6SWYiFR4tia+zULRWPmCtoPdPt2ieTW7En0Na7eyrvniLnlZhMzgR1myFzt4irQ8
         /WUqAxjP9sZxroqlgEWj7H6MsVS4lwYz2ESzKb/xSmnpjFkhscjpO1/S3FqxdVIhMGek
         g73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDL9pKZ/aY/6GF+LYS6OgXAXDW+bnN8p+ujXzgAstfY=;
        b=Jv2zXgZmyjj0q9XMva+uCfDtKf8ppJOu2WVFQ5owyfMbLIWEKhM989SMUaDy+crqD9
         u7DKXUI+7FzbhtwdButLY27i+zdHigUZLPPazSzINamM+6Zu3OqYBtPM5meyO29NWHTi
         4I/jeGx7Usij4WX+c9our/WfB+QhPAHmU3QPVvAUJaGvvID5wf5JAFDCY5yWn4aGLCGD
         /zRzEwrLztp8m0EjDD5aH8qQvexjl9SYhvf5gNTxSOASqK4Yzk+LIhlL0txa10kMWdy+
         Lj0/BoBKAAqNlBYXwhUSxC/81g+9fv5gLW8TQIIi+gdaFldYBhj9pSxh4Z6ttjy+3KUO
         K4KQ==
X-Gm-Message-State: AOAM532p142aUO8t8Pm3juysooOz3+PNJaFMIUT4LDkxWrG/euoYUKCw
        YRnR/91ak7IiTO12mXlrG+UYmmmxnKlL7jcOup8=
X-Google-Smtp-Source: ABdhPJzB7NNJejyE2ko2eEIDNx3flC26avxHIwjWADj6wLS2giyp8JGF4cYsFt8PQgCjehinqymfHHm4ZoR2Wa2k6uI=
X-Received: by 2002:a9d:629a:: with SMTP id x26mr21604188otk.116.1592967392687;
 Tue, 23 Jun 2020 19:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200613201703.16788-1-TheSven73@gmail.com> <20200623115335.GC30139@dragon>
 <AM6PR0402MB3607AD6AA7968D3A93D93007FF950@AM6PR0402MB3607.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR0402MB3607AD6AA7968D3A93D93007FF950@AM6PR0402MB3607.eurprd04.prod.outlook.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 23 Jun 2020 22:56:21 -0400
Message-ID: <CAGngYiWJ+0PVyNcvTSX+MXdKnO-=_w=jPtoaKZoAAExrXwxOyQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v1] ARM: imx6plus: enable internal routing of
 clk_enet_ref where possible
To:     Andy Duan <fugang.duan@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 23, 2020 at 9:40 PM Andy Duan <fugang.duan@nxp.com> wrote:
>
> The patch looks good.
> Reviewed-by: Fugang Duan <fugang.duan@nxp.com>

Thank you !

To check we're on a plus, the patch uses:
cpu_is_imx6q() && imx_get_soc_revision() >= IMX_CHIP_REVISION_2_0

Fabio Estevam suggested that perhaps checking
of_machine_is_compatible("fsl,imx6qp")
might be preferable. What is your opinion on this?
