Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D641BC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F5520721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZfLiVbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgEEUJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728076AbgEEUJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:09:38 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D6C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:09:38 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 1so16504vsl.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=JZfLiVbOazuTfcm+4u4Ye0gOFndtkBrreUkn1ry7gNBs4ECkgFDKdo/rHdu1AQBEAh
         nKFyCywESZj5Me5GBCATHxdJitFyX+6tAYa9RDi6KDchtEehsdOVIu9TApHb7HSPxGFb
         baKBP7c/tyVCnB2NH8zq6rKRHXhb/2wTgvjIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eb3sWwf5IKoZQzOvkPaaI1IVQ2HjKkCnRKRFnGOH6+c=;
        b=oBn2It4A2i31zA4jUXudFUWrLA537NiXdT+Db+lixecmlat8VhrQDBfWeWY4qKvzZI
         x0T/47FCzI02w5ksWhV5UKWOGjW9xWGhmjGu9ZiER4ceqZHiAFyx3NpB4lDtr7GnJDSM
         vJvYYo0braiJ0kPokWxg1n+TarnBTu5qiJ66EuZjUtRjI4Pax1tmW23Xidc7sz3WuEEr
         BK/Psj6ee3iOI+qDRpy8ClFyi2FYHGorF8xkt3hCKRL4vwz4OW/zaN7pbLkPC1/Dfmcp
         PmAR7glE1xjTKbqsRiS1ofZxvGc5Lqx5K8khuZVg5m6zuauIHfhe3SkMjnxnyytZH3OJ
         90Tw==
X-Gm-Message-State: AGi0PuZ2XWUVhlBEIwarQ66RQudEyx/T/r4IoIrECYDWWSIG/K8x8KF8
        0KPLvtJxL8daSAkjfiVHRPUy9dDTjZLNSasbaipRUXpk
X-Google-Smtp-Source: APiQypJowiNqq0i+QKhqmj//hMMvq70bO2RQ9UV0gMFrlpNrwuxFoMcSnTC6aIq3Ry7VS3vRYjcYHV/I6y+hbezoCRQ=
X-Received: by 2002:a67:de0a:: with SMTP id q10mr5173302vsk.138.1588709377331;
 Tue, 05 May 2020 13:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200505031331.122781-1-evanbenn@chromium.org> <20200505131242.v6.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid>
In-Reply-To: <20200505131242.v6.2.Ia92bb4d4ce84bcefeba1d00aaa1c1e919b6164ef@changeid>
From:   Julius Werner <jwerner@chromium.org>
Date:   Tue, 5 May 2020 13:09:25 -0700
Message-ID: <CAODwPW-9Yz5zBpSTGOuXzZnhkze+CX5hDAegMQiXs-d=cPgNWw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] watchdog: Add new arm_smc_wdt watchdog driver
To:     Evan Benn <evanbenn@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Julius Werner <jwerner@chromium.org>
