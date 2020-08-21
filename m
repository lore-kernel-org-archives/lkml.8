Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06CAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9150B20724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="kJrVOdIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgHUTyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgHUTyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A42C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so1490714lfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KJANaxWQksktmcdpt1vpEvTKGf7eyf5hPRoBA+TJZ88=;
        b=kJrVOdIXLOjbRM1ug3UwwnDKa3IM7/QSTo42xxKuh8+jtUB19alU08stSTGQR5gup3
         ENyiHOCJo3yp515bEK4VfhDUBSG1L7C3JNxbiaWeJY0CdJBGAA3d7nsvW7Cq03BA5/is
         qBZ5fyS6KRsAoeskWWRFyCeOhxo/qsmDjzQGkD54exKLZSvg8iZYxpRpFNbo/lB771F9
         FGB+4wQvRWUnfGBQ9+ajB/YBTEt12oflRPTl8rf5SdXsRcRgompRq7As508+P3Vpll1N
         BysX0xoshJnX468Ewgl55HUkJuOYt97kkZ5OBvbm4tZo2LgX54L3/XUHT2xBUTnt6zc5
         3LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KJANaxWQksktmcdpt1vpEvTKGf7eyf5hPRoBA+TJZ88=;
        b=Tcea6ZZqYnX4f0Odv/WK/cwR6LW0lxKU9aaPvEuGGxoMZNiLCr06t3g9xfBNTE3LU7
         57tE16fLv/FEuu8tObTJ7WK8gBDrp93iIoR21P2hNIW6KoOgr/WhtNZaFGlcA2YOCqVU
         vUK+fbATT0ILROkPb41LUPD9ujN3jCchj3Fuk9Zg5UvNW21Q1wJNXPFTbdgyVaVysVg8
         9mwEcOfhqGHW+5tip+O2hClSWiCSl55jroUnXTLa71gkNIDI2bcpLcOy5r92z2vFiv86
         D8nPIl9sAH+7q4UFWLkq25Zah93XAUGTFvWo6LmW+PVuqRgdxHou3xouHBF7PmAjQiXa
         P6Sg==
X-Gm-Message-State: AOAM533OOQkhSOXGQgu3iO6AUaoZtYuB1zdCuV/UvC415kEPy7hckf+V
        JJ/zsSdAYp/hVPoaxWe15xTUn2KivPlfXN8b
X-Google-Smtp-Source: ABdhPJx61phnZE+0v199dWLX3X1fWs9S+cuOGQX5EkGw6DlUw0N2Dl3p+Q1wEGjH0LM9pfkmik+PQA==
X-Received: by 2002:a05:6512:1048:: with SMTP id c8mr2032156lfb.101.1598039673364;
        Fri, 21 Aug 2020 12:54:33 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id e14sm566846ljl.96.2020.08.21.12.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:32 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:46:03 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@armlinux.org.uk, w@1wt.eu
Subject: Re: [RFC PATCH 2/3] ARM: mstar: msc313-intc interrupt controller
 driver
Message-ID: <20200821184603.GA3407@lx2k>
References: <20200730130044.2037509-1-daniel@0x0f.com>
 <20200730130044.2037509-3-daniel@0x0f.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730130044.2037509-3-daniel@0x0f.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jul 30, 2020 at 10:00:43PM +0900, Daniel Palmer wrote:
> Add a driver for the two peripheral interrupt controllers
> in MStar MSC313 and other MStar/Sigmastar Armv7 SoCs.
> 
> Supports both the "IRQ" and "FIQ" controllers that
> forward interrupts from the various IP blocks inside the
> SoC to the ARM GIC.
> 
> They are basically the same thing except for one difference:
> The FIQ controller needs to clear the interrupt and the IRQ
> controller doesn't.

Sorry for the late response, going through patches we might have missed or that
need replies now...

This needs to go to the irqchip maintainers for review. If you get their
acked/reviewed-by, we can merge it through our tree if that is easier. But they
need to sign off on it. Feel free to cc soc@kernel.org on them though, and we
always merge the dts changes through our tree.


-Olof

