Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76CD120739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d14XyL+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgGFAvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgGFAvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:51:16 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF7C061794;
        Sun,  5 Jul 2020 17:51:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id k6so31489050ili.6;
        Sun, 05 Jul 2020 17:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=OSBt4nSn7hJZVdI7BgkbTR9q+HgFMkaY3ea5mhDOzwA=;
        b=d14XyL+o7eqh6a5MgrZL9BGvJ37uZXJJkEHIfxOMchmvIrpOzhvJ2g/VNRf98ETRRI
         wTdu1d9GXYIBQgfLRN9HnDn998Yw5hmEbBrJiW8wNd/+LzeHT4rTPiyP409gI2tSvjcz
         kHHaMBVjGRX6Wmh9ncWya0TB1zWDR6n2gmjdCW+RVhzUA7KjzAqpGIcEU3ShRHb9O1Ef
         tGrtO7hJZ9qmcjp4jUuB8KzRDs/dVpSIIzFHTaM5o8tIuyUtyVQAqHCaYgYw2GPbqn6C
         rxUjjMNJtDLzJnEndCA6Mz430W/93O9BrkKDb0esQVT3K69zD8+gUulS4JVuu/IulJ3q
         eCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=OSBt4nSn7hJZVdI7BgkbTR9q+HgFMkaY3ea5mhDOzwA=;
        b=CVkh7RKh/RKXcX1PnO/Zdmew/1dOTq7JvVYSY/zujHMNrma32pSg1uJLO1JVrXDAs4
         OEckLOZqFNmueiU23v6kcIEJKw8OWTTBYJrOZMIacQm7/NeANSZabZpqXWNM49LfuuVR
         kDlXFDvbnaWA/s+VPmH5nfgtSoU2EwxGgOiioRnVfHbtMOzOvuXIu9XMkgyKfhOvMyeb
         sueZ+V0+865CWKNqXvyDEFj5zI/2+Gf+qjvcXkXgQ1RlJu/TwouXDNNvJuv1BAvon3KM
         RHyv7txgBbk0E2HsFV7z+zokcbzhhC0fSE/s6E8tiboYTQ8PHQRqQYvRl3ZqQbG7D78e
         rZMQ==
X-Gm-Message-State: AOAM530YkKPAG5qjtJ/Bsf2AdXzI8lDnKYKw/j3xSN1H9jsLV9lLgZcF
        IUhJwvBLji3t+ERWtX1BKMICYpJM4bMkn8ZIqJk=
X-Google-Smtp-Source: ABdhPJxZzvvwLzBoCvQn8YNXNkhlrQtmKErPtMC6oEx68/U4Eg9WjVqUHKYT0afdxFIJtkM+qMuXvn4B+q608q2595A=
X-Received: by 2002:a92:c78d:: with SMTP id c13mr28371793ilk.85.1593996675546;
 Sun, 05 Jul 2020 17:51:15 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Healy <cphealy@gmail.com>
Date:   Sun, 5 Jul 2020 17:51:04 -0700
Message-ID: <CAFXsbZrFRH2=+OgBARRkku2O0Okv=jg-uZaN+1Cv1tEwq-8k5Q@mail.gmail.com>
Subject: [PATCH] ARM: dts: vf610-zii-dev-rev-c.dts: Configure fibre port to 1000BaseX
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SFF soldered onto the board expects the port to use 1000BaseX.  It
makes no sense to have the port set to SGMII, since it doesn't even
support that mode.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
index 778e02c000d1..de79dcfd32e6 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-c.dts
@@ -164,7 +164,7 @@
                     port@9 {
                         reg = <9>;
                         label = "sff2";
-                        phy-mode = "sgmii";
+                        phy-mode = "1000base-x";
                         managed = "in-band-status";
                         sfp = <&sff2>;
                     };
--
2.21.3
