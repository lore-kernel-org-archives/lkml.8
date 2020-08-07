Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08927C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEE2F2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596768257;
	bh=z0b3+lkAtXOfsjk4lQD+8RIgaBeJk9H/mxLTxQgaeoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=K8OiBqeaJp9JL0ugsowA2BCW15EFRTe4gtQIsBQy/6jif43NraE2vpdOYqmGWXT61
	 XpVIkPDtsj+dM6/P8P307s0ZyoNygqy+q1cSse0II/4h3ihShFGluUz6jrhZbAji0W
	 QwNjsD8x03tYfH9SQh6gZPqTUui+xk+/mOG86RvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgHGCoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgHGCoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:44:16 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2E6C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 19:44:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id s9so224844lfs.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p73U8e1ovm8Oc1EqA5iQZyfM2pjvXY3OFxbeoRQJG2I=;
        b=KLp1Ds8eG5JRlnSSwdEN+OnGNAs7kXb02mDvWX8rcYTRjEvSHW36G9/e6bxOrVCPde
         s7tb1TfadHk6CAR9hQzubkDScrM6Pld2nYc6tZGNyuCsQQUXlsgFZXGodc1jpkDiCprO
         2e9Jun2EFHdByneIomAeVOp02/+vpN3r8tCN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p73U8e1ovm8Oc1EqA5iQZyfM2pjvXY3OFxbeoRQJG2I=;
        b=rdmzw2Ft+viuTzJFBsLXQXTUR9sQrCNdzAH1UvmLEc+TIsZz7F79Oup0nz8sXJwpMY
         sCok4/72PiQLYnOgSWUdgxs42lhkGw9e/L/SKvPJtpeIn1J4OqTAGvnk1Zyt6iu3oRU3
         GlLiIL+iA/3wCjkSMW3gZBYhzrxw1hKY3KxwxjL4dFHUO4FSGFsTYHTDDmVSzwWokEo4
         gMIsLdTBuT/ZfJEXUGJQQCu6qulEYjq5PGfjPhH7oxM7qiY2xJx7QidqZbXaI9kvzUfq
         8vY4MdkZE72W9q7IDYFHgFyqHZUXNvIeZGDLVDSxA0FaljIdbSVRxbOrPhiBjz8DZmQZ
         gkhw==
X-Gm-Message-State: AOAM531tLgEDJCHXa+raf6M3zQCzb9xndN7gAdgMPO5r533NZvHG1vS1
        r0IhdxjYTzWw+xCmP/SwHFz4x7ydF4Y=
X-Google-Smtp-Source: ABdhPJz17kYjnlS2kzvC6oj1NUHCXiCnd0yv1p8loYpvO69VwcedQDY3ATqlh9Dgyja9qgABZHkG8Q==
X-Received: by 2002:a19:8044:: with SMTP id b65mr5216118lfd.91.1596768253448;
        Thu, 06 Aug 2020 19:44:13 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a1sm3574315lfb.10.2020.08.06.19.44.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 19:44:12 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id v9so575322ljk.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:44:11 -0700 (PDT)
X-Received: by 2002:a05:651c:503:: with SMTP id o3mr3024241ljp.312.1596768251568;
 Thu, 06 Aug 2020 19:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
In-Reply-To: <db1dc155-0c7c-f4eb-7fa6-047a78829a82@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 Aug 2020 19:43:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Message-ID: <CAHk-=wgLt61owJ_eKwy43bBujxy3-s=xQXwsSi6VHME7SiAgiA@mail.gmail.com>
Subject: Re: [GIT PULL] RESEND: thermal for v5.9-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Colin King <colin.king@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lukasz Luba <Lukasz.Luba@arm.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Marian-Cristian Rotariu 
        <marian-cristian.rotariu.rb@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 1:19 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> - Add generic netlink support for userspace notifications: events,
> temperature
>   and discovery commands (Daniel Lezcano)

This is "default y".

Why?

The help text doesn't explain either.

Please explain, or remove the default y. We don't add new features and
then try to force people to use them by enabling them by default.

"default y" is mainly for when something unconditional gets split up
and becomes conditional (so now "default y" means that you don't break
peoples setups when they don't even know what it is).

Alternatively, "default y" is for things that are make peoples lives
immeasurably better somehow, and it would be a crime to not enable it
because it's _so_ wonderful.

So far, I'm not convinced we've ever hit that second case.

Convince me that the thermal layer is so magical that it really
warrants it. Tell me why and how my life is improved by enabling it.

             Linus
