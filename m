Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89261C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4FC21BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QREs/SmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504014AbgDPJmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503897AbgDPJlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:41:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B4C0610D5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:41:32 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so5480565ljl.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cXqd/FYXB0lbGufBrqDJUqh9/OZeedfUjtBKEKKPBY=;
        b=QREs/SmDJvEf1zq17GMjwgTqEIyMlkJEjg5f3v/HeaLYKjVC8QYC1tgHS9NiE8NKcc
         TGpmQwdmfUl79CLFpobpVIg7Y71DLmUEMoO4SybCkM0m/qJTWd8TH7fD8AW6GTjZh5E2
         3xB3Gmop1M/FTGW91HEFmJs0231flS44BMs2mjhSI3HDKbtBPY4kMr+le/vVy6MecdtM
         36GNDW5Lz27hb9BKmDCXci7WaRgb054h8OPccGeiMoEExPEgMfHxCK1ZBv+Rux+HEuDy
         gMC87Sq8XSDg34xBrMmEcMt62x/S+my0Xke4M9RSm63NB88ahjLVCRWh9rFJMdVUhp5/
         d7RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cXqd/FYXB0lbGufBrqDJUqh9/OZeedfUjtBKEKKPBY=;
        b=hC2KpMtUgBqyPzyt3dFjt6JmfEAmMYkM7hhYvoJJPZNFO7kH8Rfr9bohr3NZHpX/JK
         LLWVHnF8ECgyFcgIW9NWGtPVRt1U6l6utMVJu0fvM0hiLZ9g7U3AMJAAQVM5a7MFB7gs
         StoyGGrg2tVsTTRe4jT1BvA8YETED2W7Qt+BOPCboZ0s6b9NvoiDE7FzxA8FHOObiyfO
         hgwrSheApNthnjJReGOyRXnOfIt+hpSkgy+SA9+vTgBSCGgWR52yPQvJkCeR/ht0ltCY
         C9NWGoKTY+7aWlXi78Ix22EtPKwaZDDu3nwO//MqwGtzgqyOwaXrNpQfqkSZiYFOVjTU
         jRJQ==
X-Gm-Message-State: AGi0PuatcS5dGNYfvdbEZSPGXRaeDIR+uSxjSpPrT9W4lhn6z8HAnaMt
        uZvG4xn3K90+YpIJYZ1rz+tijqqMwLE4S7xhz9QKhw==
X-Google-Smtp-Source: APiQypJnieW207MTrrcDCpD/6xCHVrwXn13tNVmDwtrOVmdK3UPhTDARFtiYg95ApfvlUAdHmjKJ2IVQP/pmqh19PEI=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr5437034ljd.99.1587030090524;
 Thu, 16 Apr 2020 02:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <1585306559-13973-1-git-send-email-Anson.Huang@nxp.com> <1585306559-13973-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1585306559-13973-2-git-send-email-Anson.Huang@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:41:19 +0200
Message-ID: <CACRpkdajgsshQ25eCsx8FS5qZ10AMcG9_PC5bwQfqGTXSprSvg@mail.gmail.com>
Subject: Re: [PATCH 2/3] pinctrl: imx: Add imx8dxl driver
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peng Fan <peng.fan@nxp.com>, Andy Duan <fugang.duan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Leo Li <leoyang.li@nxp.com>, Olof Johansson <olof@lixom.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 12:03 PM Anson Huang <Anson.Huang@nxp.com> wrote:

> i.MX8DXL contains a system controller that is responsible for controlling
> the pad setting of the IPs that are present. Communication between the
> host processor running an OS and the system controller happens through
> a SCU protocol, add support for the SCU based i.MX8DXL pinctrl driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Patch applied.

Yours,
Linus Walleij
