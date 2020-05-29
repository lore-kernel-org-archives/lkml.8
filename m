Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E480C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E687A214F1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="xfIhAUOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgE2JgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2JgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:36:21 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86595C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:36:21 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id b3so1985531oib.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 02:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fWC9mFwdb/sTGcJVbmC/E7dvGoWX0ipuEF4o83/3TTY=;
        b=xfIhAUOSReKKsQs/hRm2VJ4Jq0uggWVCpICOHGe8w6zWIZzx1Au0H1Qk61eUsbzTgi
         3Ci0Ce1HTxRMmvPy9Ss587g3ZN6x4jTlo1U/BpIC7mVx0vGQXVwthBcuYXYIauZY889G
         27qoep9RV4qxinsGbtFgMR1MHtZPxwUgZaFkLmo2ZPBDFmWx8opBLgnvkR7unEue2RqN
         snsBoQwdFNgDZEMWE4n9jzehscZTF05ANygobVuuQzkF0iOyySyvLYi97xZkxIyk4bAC
         Ed09Y839uB89UZYkHnpW03uPXxnFTqaNhpwAjWtfNhTxx/JzE3wV2Po3CbuBhBkkXH6N
         PNww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fWC9mFwdb/sTGcJVbmC/E7dvGoWX0ipuEF4o83/3TTY=;
        b=MZIbfZeO4R0SehZ9ywVImwZ38Vt16RTp2hz/hVq5R1YSob91KQXzevyySJgedVYF2P
         nvCCykJOVz2BXl6G2Ib6TE9ui+cz3ZEFz3zMOMTNstnkGkxdO8QRXF9TfytwYn7ohG0s
         1ZqS6kTc0/i/+DMncsqvqMOc5iH4BF0zp0iJnMy2JH9EPqSeK0lctth3CTphloHpRMuZ
         1y9UJ80PG2NDs6/sX83LxMxrlrPc7RR6T1f0mqFKQB2y6UOvsN7LSUtGGzkVOVCOdQkR
         NQwKKmedt6Rr4d4660wEAEE31pAfkZfDfpNY6+0NHTEdx/h17mQzpUefOknOAQH/PGkP
         5aSg==
X-Gm-Message-State: AOAM533QYMCAsXPTtqDlWXG2oS3ku2IBUx2BxQws026uXG7ZUfm4k35B
        210/X1CA+ywarkfsgau9I1XiNdONl2vaQTvLeoOyRA==
X-Google-Smtp-Source: ABdhPJwXtpTuUA91P1AUPcbP8wpLOoGZnz+TNZUWWVHXWHFimcQxq/KQIPyQ0xEj6UyvG6cfqUnKUODWSspb97RS2/o=
X-Received: by 2002:aca:a8c3:: with SMTP id r186mr5029193oie.173.1590744980879;
 Fri, 29 May 2020 02:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200503201823.531757-1-robert.marko@sartura.hr>
 <20200503201823.531757-3-robert.marko@sartura.hr> <20200504073914.GQ1375924@vkoul-mobl>
In-Reply-To: <20200504073914.GQ1375924@vkoul-mobl>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Fri, 29 May 2020 11:36:09 +0200
Message-ID: <CA+HBbNEiB+o4KxonAu4-ra+P11Yb649v6AFaPjFc8JQDQ8T=CA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] ARM: dts: qcom: ipq4019: add USB devicetree nodes
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 9:39 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 03-05-20, 22:18, Robert Marko wrote:
> > From: John Crispin <john@phrozen.org>
> >
> > Since we now have driver for the USB PHY, lets add the necessary nodes to DTSI.
>
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
>
> Bjorn, I have picked the phy and dt binding, feel free to apply this one
>
> Thanks
> --
> ~Vinod

Any chance of this landing into 5.7?
Driver and bindings have been merged, but I don't see DT nodes queued.

Regards,
Robert
