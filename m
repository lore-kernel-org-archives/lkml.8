Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93672C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D1812070B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXLAHVjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDVAtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgDVAtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:49:17 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E35FC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:49:17 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id fb4so122561qvb.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXWORpjRxTkR+i2fu0N9aGTa6+ZQqTZNmK158+3pxDo=;
        b=XXLAHVjCxmQ0g6P2WSs/mW+8skAgEVSeb5nc/EBOC+NLqjYIAm5C09vy+AXo9NYmfF
         NuHUkcuMDH0a1DRZzGjmt54BElkiJlno6nBpxUT0EPKcmqSA4/bYO2WbY7dzaNrsqOn5
         cyDQd1ZAV0QjIHtu5L4OU2ziPMQrf7AdumzEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXWORpjRxTkR+i2fu0N9aGTa6+ZQqTZNmK158+3pxDo=;
        b=QT3HVDvF5dU2RYvWkTmr7n55mBbwT6dFtLL27DZB3g1rnKTY6imPNk4QOzbEUoUok7
         4ohiwC2NF1pmRf+a3ZOl+2PP+Ih/pkxpUo6pjGnoV6MU+NSa8HQSwjokUrrn/lUk6IHE
         uXFemkxtXNgOdZjx/8da5LXBL68VlBog4qq3h5mX0EPUUdT0KsC7ZZFDolP+pb8RUOO0
         1YsS6KJ7q12DPRL5fLXruJ6RFiKojfqQNASz4OdBhdLkfmnTwPHT6Gj6G14GAvLDCu8l
         lWRJbpzM2Y/GyQJ/BzR4288NwrYKbPZM6musH1uwOvAABV0pfs0bMWIfx2arCJ0/qq6v
         JiHg==
X-Gm-Message-State: AGi0PubPvIt8T8LmVK4b4apal3CIocST4ZCtVuYhuIWYWZT8Ku3wz9ZH
        WQqLBM5+UK0m4fvkfhKI9aO4lWzE5TM=
X-Google-Smtp-Source: APiQypIMhp7JY0W4gwQZKnCtTSbtRigeRBOH8mIizZ81Igo0bb+2DddE6rIniYJ6VPwP2HYeBRn1pw==
X-Received: by 2002:a0c:a8e5:: with SMTP id h37mr2182035qvc.69.1587516556307;
        Tue, 21 Apr 2020 17:49:16 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id q32sm3028626qta.13.2020.04.21.17.49.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 17:49:16 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id i2so315501ybk.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 17:49:15 -0700 (PDT)
X-Received: by 2002:ab0:592c:: with SMTP id n41mr14287181uad.73.1587516064329;
 Tue, 21 Apr 2020 17:41:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200421110520.197930-1-evanbenn@chromium.org> <e81737bc-9461-0fdb-245f-d88bdde8f0ee@roeck-us.net>
In-Reply-To: <e81737bc-9461-0fdb-245f-d88bdde8f0ee@roeck-us.net>
From:   Evan Benn <evanbenn@chromium.org>
Date:   Wed, 22 Apr 2020 10:40:37 +1000
X-Gmail-Original-Message-ID: <CAKz_xw0wAN4rG8xF1Y7amshoECJAjiWNDFQ5GQHPAbCfXi1bDg@mail.gmail.com>
Message-ID: <CAKz_xw0wAN4rG8xF1Y7amshoECJAjiWNDFQ5GQHPAbCfXi1bDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add a watchdog driver that uses ARM Secure Monitor Calls.
To:     Guenter Roeck <linux@roeck-us.net>, Simon Glass <sjg@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        Julius Werner <jwerner@chromium.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org,
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

> Subject says v2. This is confusing, at the very least.
>
> Guenter

Apologies! I am using the patman script, it threw this message that I
did not understand: 'Change log for unknown version v3'.
And I did not spot the issue in the emails before send. Not sure why
patman worked for v2 and v3 but not v4... I will take a look.

Evan
