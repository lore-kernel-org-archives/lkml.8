Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E0DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D891206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maOaOzmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgD1Qmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgD1Qmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:42:52 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215EC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:42:51 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n4so17752261ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y34gdr8oiGfvII8h6ZtZVDiqiMwD2EZedv3EJCzGWlY=;
        b=maOaOzmZtckBS7Rj0h+gutu2QHc3znF9tqd05omFsVTffYUQcgDF34mLFDzS8GkXoi
         3K3jsG/xrqVJUaE5Le1yH5iVvF0zRlCgzmVTohcpFUTxtgUSpBekhq/HNnel8GPXrmnF
         pVsWabHGv8u0yjOTisBCWpdR0CN1N0mJKjJ+cv2hGo94QW3yOrZZlJ+bX8w1qB1KJyQV
         2H3f9GaamNYf4Qcvj1dtrfJt9iNRzsAr3gjr7Zxe53M95qxaqnju0AG1gWpXuVJALX3x
         j17bD0dSX9GRB/NUvXp4AwBVTzCsT2N611NxaG14M5APMI3gnFZp1HxGzGvLhTXvMrDO
         gPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y34gdr8oiGfvII8h6ZtZVDiqiMwD2EZedv3EJCzGWlY=;
        b=sGDgVFJU3AtUnvxLAgFE4KPpRlGTH6uFS2dfy2v2nijZgGw+rSKEMIeSbE1Pt/l6Az
         sX/YG6/35YzK5MD4bs7joayuhlcvnKd6hqwewFxECOHILVtIcvCmLHNOiG1JSwp5sXpy
         q/Atq65/eEHiqTwtK7RJ5l4wYKFsoMSBsmE4pIpvd2uS4S2IM43icuTYym5eXoJbpOCL
         RfIJZaQn+BdMYnIQEGDDJ40fVkgywN2fkwXzBoRZ8fDsaYgqhReaGFiySgyCXE8giv1t
         0Q+7XPGtPGKUkjgbh2duteuC7sXLLSIUEefN2yYSubKJ41hM3cIm/7OF9WFBYKXXyw1T
         35Sg==
X-Gm-Message-State: AGi0PubaWaeMbkmAeXunGSYYKUeO+oXnyb8S+OsB2ojm2ZfhCf6fKk2Q
        uebDdosSL6pOOuv7zFT2TWCDXX3Z4BdDO+6jnFo=
X-Google-Smtp-Source: APiQypLvpZPfzun+J0YihXBvkkbH1EJjdB1GYaQH9AhZAaBAgge1ys9/K8kEiJivo2HQeboWLVIsx9ny3WBZ0Gxiri8=
X-Received: by 2002:a17:906:2d4a:: with SMTP id e10mr26158324eji.222.1588092170642;
 Tue, 28 Apr 2020 09:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200425080026.143127-1-chentao107@huawei.com>
In-Reply-To: <20200425080026.143127-1-chentao107@huawei.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Tue, 28 Apr 2020 19:42:38 +0300
Message-ID: <CAEnQRZA3g-AE-PE7yiKn0XpfWURV9wm=ztbtvyCoYnNv8G9O0Q@mail.gmail.com>
Subject: Re: [PATCH] soc: imx8m: Make imx8m_dsp_ops static
To:     ChenTao <chentao107@huawei.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Shawn Guo <shawnguo@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Liam Girdwood <lgirdwood@gmail.co>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        kai.vehmanen@linux.intel.com, Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 11:03 AM ChenTao <chentao107@huawei.com> wrote:
>
> Fix the following warning:
>
> sound/soc/sof/imx/imx8m.c:95:20: warning:
> symbol 'imx8m_dsp_ops' was not declared. Should it be static?
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>

Can you please resend (picking Acked-by/Reviewed-by tags) and
as Kai said add:

To: Mark Brown (broonie@kernel.org
Cc: alsa-devel@alsa-project.org
