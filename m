Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521D2C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2332720658
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="insSbL1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgC0VIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:08:04 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44428 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727352AbgC0VID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:08:03 -0400
Received: by mail-lf1-f68.google.com with SMTP id j188so9028136lfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vy4A4qxxBdA1VleutrEnlGSM+k4IB/RyFCwjbH/DwRs=;
        b=insSbL1QKr3lV5AjtxrrpT3lHkcvsXqses2tRsZBuLG1gwklF0Y+N9EVvzO07/hLsU
         wu7zN34y5FLWLN1QLMBlpmL2STUMMAzQAF6tn6tg0u1uOjM74xN7q2yogJX5qzuPbGEH
         Lqt+dYUamNPhBQZSOKc47DW762uhfVqspYXWTddaXEu2ykfgBgpWzthwxPwSBov1/InY
         s4nv0AARFXvOo5+nzswznHeguw6+EedK9hShcRc06x2wu97IvqF96Ap4/hfn3+sXlpgI
         yN1bTDXjyZSxMYQE7GzhErFJYfgV3AXbBd4P473sH8JuScGH6LSMOQ5aOfznVunftSWt
         N67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vy4A4qxxBdA1VleutrEnlGSM+k4IB/RyFCwjbH/DwRs=;
        b=b92dGxWqE9Vu2b0vKSN9wiaUElOQR7U4jymubwdFxf1qQuZom3NYYVA+x0yqYIDHGN
         IASq4X7iTawi5lQDHaskirQsv52OD5k/kxlytHS5LQO3YWjLJnWkKVqU+MA1SmPKiSCH
         W/wfpAJO6q4EL4MOn9cJgASQ40DoWvemMepUaPiNbhi6fv9L+KsUzzei2oPbSGVI+ZCe
         YJzt+xxzh7a0iEsPuchZ2CDKzgo6kILabXXFaDWlhi577/fbNu/wLGQBJ64aqRPdeQuK
         Ln/k/fPWfj3vBzWVShcmkd28Fr2T3V1BT/qiX+mGlwNOIo/zw+Tm6SHKrPWnIIIm+2d7
         +L6w==
X-Gm-Message-State: AGi0PubMIc6PdU/fopxT24AZuDSOR5EgmvIIDrPNFCPLWND7cKCni1hd
        Qszq+sggWZssBlRmd7r4nUlzEvDyng7kpWZk284Ebw==
X-Google-Smtp-Source: APiQypJ76gczVMcd8gIpx1lrB7rS9+3XkZL25VcWYPLe4V0BJq4mARvycmKskia8Vsz2vK5dkIxe3xkmkoEOmu4PDwI=
X-Received: by 2002:ac2:5b49:: with SMTP id i9mr749117lfp.21.1585343282366;
 Fri, 27 Mar 2020 14:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
In-Reply-To: <8a6f91b49c17beb218e46b23084f59a7c7260f86.1585124562.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 27 Mar 2020 22:07:51 +0100
Message-ID: <CACRpkdZr7aexy3cbF+VemXyQYKJ_VQkFD5svEO9COcxAqKNKpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: sprd: Use the correct pin output configuration
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     linhua.xu@unisoc.com, Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 9:25 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> From: Linhua Xu <linhua.xu@unisoc.com>
>
> The Spreadtrum pin controller did not supply registers to set high level
> or low level for output mode, instead we should let the pin controller
> current configuration drive values on the line. So we should use the
> PIN_CONFIG_OUTPUT_ENABLE configuration to enable or disable the output
> mode.
>
> [Baolin Wang changes the commit message]
> Fixes: 41d32cfce1ae ("pinctrl: sprd: Add Spreadtrum pin control driver")
> Signed-off-by: Linhua Xu <linhua.xu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied.

Yours,
Linus Walleij
