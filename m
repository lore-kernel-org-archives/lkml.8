Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BA6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0891F206B9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfo0PPID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440378AbgDPIEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440155AbgDPICb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:02:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFCFC061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:02:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u10so4864797lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HS3wh14onxfnVAAnelvXE++p13ZTdiNaT9jQji2UHzs=;
        b=vfo0PPID97JrT5WKWP575QXEQfMje8Y80j1J2y4VsCaINnaxBRBOwbphMCECPp2dp4
         B0B/RHjLCRYxZCwT3VKOk8T9rFGCrA9byaN8YYhGfODjonk63PPGpAkGlYgE5JJCG6t3
         brqYJkXoEUYfkA2gQEkVoUNveryy41bFDIecBXeQ8/6eLwP15B4SY1OZRlcAxaYoIirR
         NHB9W5QNDgUKLULGcDhmopaU6Oc18sPdfhqCsauY04aSSGj8PQ6dFzKaZ3FBM58TcTiX
         7Pm5np1XyoMAf9/uJ3q+fbexj3Ioq34+53S/J8DKepGd08s7ORCyG4xQJT/TryowzFmv
         +flw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HS3wh14onxfnVAAnelvXE++p13ZTdiNaT9jQji2UHzs=;
        b=F/kOuIKDgxqmSVzNJD5tL7GWb7OpRxBU5asuFfdF7Auc3SeiIDHf6VaVoQEAjYTBg3
         4lnesz7F9ujvCKEElu1HZcF4E6WK2ZafoAp9rAa2tlFig28svg/3hvS8AbL/cElgMAhZ
         LDKPsC1ROgANnLYFfoAaheRZfV8Zc3Egjiy15dPoonZBa8HvkXLA2qefvIwkL1v7PVJq
         lRUqoROabkugkp2sGvuJf2i29u8y8B1jlBpHGuPzpQxA0oVpuEAwkv3dDqBWPaKu1iYZ
         P0OQ4qE560j2bLxhEOXqddteqsrpD/88EoNzTqZmv+zRmEc08bObhO0YNkOFFwa2BAIU
         yu6Q==
X-Gm-Message-State: AGi0PuZdfDuCsvs6kYLEIeLVheq6cp6DDcA4BDOxzsha+XgC929dX+cp
        rGrQ6Kr8hYcMEeaa9H9gRKIFG6q9icEr5Ddfbu2oAw==
X-Google-Smtp-Source: APiQypLuIixLf5ucqE301E0Pfpc6UIvL9GPllhUYp731XovnEOOMBJ2YWNaowR5LKg0u97weWLvK2TO24s4t9c/jatU=
X-Received: by 2002:ac2:5c4e:: with SMTP id s14mr5389181lfp.77.1587024149690;
 Thu, 16 Apr 2020 01:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <1586255632-27528-1-git-send-email-light.hsieh@mediatek.com>
In-Reply-To: <1586255632-27528-1-git-send-email-light.hsieh@mediatek.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 10:02:18 +0200
Message-ID: <CACRpkdY_86VK2Acjk3MoJi4K_F2RP-2YW7nfEDN9Bg=TB9nr6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: mediatek: remove shadow variable declaration
To:     Light Hsieh <light.hsieh@mediatek.com>
Cc:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:34 PM <light.hsieh@mediatek.com> wrote:

> From: Light Hsieh <light.hsieh@mediatek.com>
>
> Remove shadow declaration of variable 'pullup' in mtk_pinconf_get()
>
> Signed-off-by: Light Hsieh <light.hsieh@mediatek.com>

Patch applied for fixes, thanks for fixing this!

Yours,
Linus Walleij
