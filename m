Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B454A22B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K+SnKxwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgGWRPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgGWRPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:15:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5C3C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:15:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b79so6055664qkg.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JXiuwKSxH1v6t1t/ryYYU7zLgRgpgLMrl8o3usa+ml4=;
        b=K+SnKxwUrjhMdkKMznvv0/mSZpVVpR59yG77Q31rc69sjsc1uY1h2B4N81OGYgZcS1
         fsFtjzCQh4qQJSYBpVJxnJiFdI0biFvC+sGyjDB0cDY0hG11MHJBwW2SK2RI7m2/rwyS
         v1bd5wbArHaOuX4jaoWOMdBC00HeEJmfUwO1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JXiuwKSxH1v6t1t/ryYYU7zLgRgpgLMrl8o3usa+ml4=;
        b=FD8nWNyzDCLlf5u+MZREU1QQv5VhjdvEIH7Oq0O9d8HxPrKYC5fqdJI3UQJeC6Jfdc
         kuVHCsf0bpCLTueyJLmpbHIzkamW1BnxHwHj+fRu0uQ1892fpIZMuXi4/TJJj4GGPcoz
         LEpWTTQ2Kkp9uZE1akvwZQnrRcJXJzqEkToFR9eHGMnOMIAD1/oGQWHEEHLWb224b+Gg
         K2D8cR5Dew6jPulpl8G/btWAm7wAmRk0uxSYPM5aMVvZqZ/FBSd5cgtjYNORj56OI9XA
         Ty39g+s7Y4rXVVfZqqFSnN9A4bF2xm2deoWsGCmjrlXDq9sjQowGNndw0nIE1wTQiNg/
         1ieg==
X-Gm-Message-State: AOAM532aWlmShUCBpGFvIlYK9rMQ9mDBAntS4IV8HGPQxMfYZvHGTnIQ
        Pzis80H+iduNNfxe15PiVi7b4KoMuxGgguGIe3Zugw==
X-Google-Smtp-Source: ABdhPJxTfnoxWQUWdTg8raMcFvzXp1cWiOq8kQMMi+BDEmI/sCV1IYxPpZLXjsosKPeDkbkDYTHj+k9jFHSSpLw6ss4=
X-Received: by 2002:ae9:e857:: with SMTP id a84mr6649837qkg.100.1595524546846;
 Thu, 23 Jul 2020 10:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200723073744.13400-1-krzk@kernel.org> <20200723073744.13400-17-krzk@kernel.org>
 <b9519b7f-9cf0-3715-bca9-05905035eada@gmail.com>
In-Reply-To: <b9519b7f-9cf0-3715-bca9-05905035eada@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Thu, 23 Jul 2020 10:15:36 -0700
Message-ID: <CAGt4E5v3mbY_S2Q=Tq5ZKSY450weu9kFZ9R3bkJ1=3VPobZGsg@mail.gmail.com>
Subject: Re: [PATCH 16/23] memory: brcmstb_dpfe: Constify the contents of string
To:     Florian Fainelli <f.fainelli@gmail.com>
List-Id: <soc.lore.kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Roger Quadros <rogerq@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 at 10:11, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 7/23/20 12:37 AM, Krzysztof Kozlowski wrote:
> > The string itself can be made const for safety.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Markus Mayer <mmayer@broadcom.com>
