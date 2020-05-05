Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFCBC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 077DC206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WbXsKMFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgEERpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbgEERpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:45:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8545FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 10:45:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id e9so2852578iok.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 10:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0d4t3WjdojD07U20/q5eVWp+2G5xuWU682MyxZ52/dk=;
        b=WbXsKMFIFpH6ExU8GPMs+ehXklgjz/p2eQPhb4qVM9RXiU5nErEMtpRDgTo/PuNeMl
         ylVJKR07XAtfhT5WIuD/HinW3vNWoGKPW1jz40Eoivc15+x8spW/VDhXOds2EvUkP1Gl
         SYfxEoqSuPtQnmM1BEA/8hzv0FeEd3MxXHlRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0d4t3WjdojD07U20/q5eVWp+2G5xuWU682MyxZ52/dk=;
        b=nc4mTanOa8PVEWH7ECgBM378IT4NzZYgzdtrOmM60fWv/VHie4ix6S+GLLNLYTK/51
         5Gk0sYvhYyG2jp4xZDB01EeXvF+S5j4yJHv7ayvo4idcg1oYgpFa4Y4jXFvoSy/KJR7h
         duhhSCz5XNNVUHYHZtlgSV2ysmIfBfO3m2dSerb0LysbzL/xBxtY8mDIV9ZLmp7PiZy0
         vDuF3XqBncA1drc0ZyqZUQ5hXAghqsQyP1uKdizo27rM04082DO96BF5kCgXedKnwdGy
         ZZuYCz+1qkmGIVzTWF2yLnugtli/jIXqTx7f2Rf04YH07vrObgkI6C/pBRZUTVGJWdNV
         uTsw==
X-Gm-Message-State: AGi0PuZi0tbACPGJ/mZbElbwB+7P3D3+OY3u0lmJKZ7i42b8wfy1UC/q
        L3wrV2PwSlh52uCypIL0P6ORdd818W03UU202rM6Lw==
X-Google-Smtp-Source: APiQypLLRpcxvQZusL/Xf0XMmd1EBwRfygNouFkqsgZZ+8IUFk4f1vnkB2SkIWFOJt66uGv5+9re8uKhsH1gb8UFSkg=
X-Received: by 2002:a02:b88e:: with SMTP id p14mr4548710jam.36.1588700708877;
 Tue, 05 May 2020 10:45:08 -0700 (PDT)
MIME-Version: 1.0
References: <f3208af6-80ad-223f-3490-30561996afff@web.de>
In-Reply-To: <f3208af6-80ad-223f-3490-30561996afff@web.de>
From:   Jonathan Richardson <jonathan.richardson@broadcom.com>
Date:   Tue, 5 May 2020 10:44:57 -0700
Message-ID: <CAHrpVsWbAdf+K1+mToj-5yoj-quFoXwF5D6_aAKufBE2tNSkFA@mail.gmail.com>
Subject: Re: [PATCH] net: broadcom: fix a mistake about ioremap resource
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dejin Zheng <zhengdejin5@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?Q?Petr_=C5=A0tetiar?= <ynezz@true.cz>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 12:20 AM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > Commit d7a5502b0bb8b ("net: broadcom: convert to
> > devm_platform_ioremap_resource_byname()") will broke this driver.
> > idm_base and nicpm_base were optional, after this change, they are
> > mandatory. it will probe fails with -22 when the dtb doesn't have them
> > defined. so revert part of this commit and make idm_base and nicpm_base
> > as optional.
>
> I hope that other contributors can convince you to improve also this
> commit message considerably.
> Would you like to fix the spelling besides other wording weaknesses?

How about this wording:

Commit d7a5502b0bb8b ("net: broadcom: convert to
devm_platform_ioremap_resource_byname()")
inadvertently made idm_base and nicpm_base mandatory. These are
optional properties.
probe will fail when they're not defined. The commit is partially
reverted so that they are
obtained by platform_get_resource_byname() as before. amac_base can
still be obtained
by devm_platform_ioremap_resource_byname().
