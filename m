Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EF9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0EB22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmKcGM6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHUOpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHUOok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:44:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD0C0617A1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:44:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 12so1028757lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dCxd2Q4l5lkrNLliGFJQWYHxizvRKPbrS09MX/RoHLM=;
        b=GmKcGM6UHhTOSrzyGoon8fimsUsJsoCmfRi2IX7drBYlygMYxMH+UN27VCNCU1t3AG
         C6uS7uOwqapSy69YRq29pHHahyG3Z+49HchV+3KC25FAyTZasPEnxRLa1PdHVU0WJ0Gq
         mm25ZZImCfybEp8lRAcrSSJ5lEoxK9ctEzOKnJirmpymflqtczwRXdrIlNPawPiSb30n
         OGdx7u9DWqzbahDTGzZdXsXrvGScFStGCRT/0+COD3hX8YlG3C3msC8Us3RoQYrROPCY
         Ked5yYkGMsOAXVN/IFfl8JrXSg5XwrYlEXFQV6Cxcg2VnqycEwfx5+61IBjaOG1Fyhvm
         Z0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dCxd2Q4l5lkrNLliGFJQWYHxizvRKPbrS09MX/RoHLM=;
        b=sAzWNfHx0rphQ291RSK9qKxLezqn7zn/cvbFLhlUIzeEMeJ2HjlIIHjyHiT5mjKr6Z
         FDZjwaSt/cQbinLZHcL1rVvMpkbGaIWOClGmHHdM65WeCpNmFdFFeU1KX0BaXsJwO50O
         TkkHHs/cVwZNjEUyty5g7XZrep2I2FUqXGlOIlzqOhlZgTjUCR6zofIAZPlmKWHWhWiq
         RXTIwHtTnVLkG2PzIAhLG1V+KhhQ3tCZy5rpIwghbs7Madbt9W8V/ay6LhZVAkGJRdXK
         yJkJOh9bpfOhRJ53lli93TEXfr7PJAZ9kP7N+fleZKac6Z9LTWpul+jxbTA4432IapCO
         VLKA==
X-Gm-Message-State: AOAM5330uLVboujECbWjDiIgujKRGIENvH61k3v2xNI/Q/Asxx8skT/D
        eri+WmKdu4xPk6wTCApjd3AQfQ==
X-Google-Smtp-Source: ABdhPJy+O9TCor1YYjDT1vPpSOc3rLR+SybCootz5q6qINXbs623zAq/NPoBXcSDtFn6O6eD3oRHSQ==
X-Received: by 2002:ac2:4881:: with SMTP id x1mr1621731lfc.162.1598021075745;
        Fri, 21 Aug 2020 07:44:35 -0700 (PDT)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id u10sm425301lfo.39.2020.08.21.07.44.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:44:35 -0700 (PDT)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        robh+dt@kernel.org, lee.jones@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, tony@atomide.com
Subject: [PATCH v2 7/7] soc: ti: pruss: Enable support for ICSSG subsystems on K3 J721E SoCs
Date:   Fri, 21 Aug 2020 16:42:44 +0200
Message-Id: <1598020964-29877-8-git-send-email-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598020964-29877-1-git-send-email-grzegorz.jaszczyk@linaro.org>
References: <1598020964-29877-1-git-send-email-grzegorz.jaszczyk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The K3 J721E family of SoCs have a revised version of the PRU-ICSS (ICSSG)
processor subsystem present on K3 AM65x SoCs. These SoCs contain typically
two ICSSG instances named ICSSG0 and ICSSG1. The two ICSSGs are identical
to each other for the most part with minor SoC integration differences and
capabilities. The ICSSG1 supports slightly enhanced features like SGMII
mode Ethernet, while the ICSSG0 instance is limited to MII mode only.

There is no change in the Interrupt Controller w.r.t AM65x. All other
integration aspects are very similar to the ICSSGs on AM65x SoCs.

The existing pruss platform driver has been updated to support these new
ICSSG instances through new J721E specific compatibles.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
v1->v2:
 - New patch which was not present in v1.
---
 drivers/soc/ti/pruss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/ti/pruss.c b/drivers/soc/ti/pruss.c
index ccc9783..37df543 100644
--- a/drivers/soc/ti/pruss.c
+++ b/drivers/soc/ti/pruss.c
@@ -164,6 +164,7 @@ static const struct of_device_id pruss_of_match[] = {
 	{ .compatible = "ti,am5728-pruss" },
 	{ .compatible = "ti,k2g-pruss" },
 	{ .compatible = "ti,am654-icssg" },
+	{ .compatible = "ti,j721e-icssg" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pruss_of_match);
-- 
2.7.4

