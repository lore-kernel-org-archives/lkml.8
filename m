Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D2EC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECD02187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGyoSAm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388667AbgBNT1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:27:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43400 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387576AbgBNT1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:27:20 -0500
Received: by mail-qk1-f195.google.com with SMTP id p7so10298621qkh.10;
        Fri, 14 Feb 2020 11:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=keLfPhE4Ew2fJjPOO0h+Ikr94hI4U8Ahj9pUlPHGqTg=;
        b=bGyoSAm7bVU/WOL0Bt768495trYhUnfkR9+rrHNuhlHAt8hg4lUnEcj5YYfwc6K8WV
         4wrZ0ytdBZeCqZ6A/lLkX7uEaIj4z4Jd/guLstDF5euKKhEoja2ugEVzNRzXzvds9Whw
         bybPcz+4+iPtualAN74gr0eLWr8UxqQXKFhhJ7oK65IjpwzD4nNrpy6di5wwFH8IZ/UU
         rfMQghXUJmllLMAQFHbSV5aYlv0HRseg28FpGI2LZpMv7jkyx+wMqBkwhNbkI+5TE1Bz
         2zmYooBWsJIKIJsdujXRLKeDvpkB1o39odLwn295YFpx99derFD00H0+wa1E5zz0FRFb
         PBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=keLfPhE4Ew2fJjPOO0h+Ikr94hI4U8Ahj9pUlPHGqTg=;
        b=AYUVdjlCZtZNybYxboCTx9YSEUTE5R2AhD7f8VL1hSa+HWeZO9nKfwnXeYWukLN1A3
         1I8UY7bPWvD0nBkcbJMERKheHTT/+kttrOkehWYrn1yj//pDQ9ogh2UQpEd9Lk0B5ETU
         VRSvHosSjJ91s3qHfClOFBV9Eazb1YqZha45l4Czqp0LiFAms6sa9VF02kg0JVYqaaVJ
         8/BdT/Sfu4KGipBwT4CPy6Yu7yBgvsfn8IfyxYwy/t/yLT2dn0GHOLT1Frv9lQvvgfau
         l7hCE7bgIWKleAKpALVwXYFVL/09gbN/uiwst2dy0fKlZwJ60x0YAkWS2DQI+kdJ5d1I
         lwDQ==
X-Gm-Message-State: APjAAAWQhWC03Uhbhp9hNP7fP8xfCCdJYa2X+M3SWb+kMHy9owI4XAJ1
        vCCaxUUaBdIkuyMucF9a0Zk=
X-Google-Smtp-Source: APXvYqwa0fHRzPH7J98XzsYYYx4uEShZEC2h9Cf/Msxb1TcTkvujnJJv7TrIhtum2hbpRDuukCKJaA==
X-Received: by 2002:a37:4743:: with SMTP id u64mr3997368qka.289.1581708439650;
        Fri, 14 Feb 2020 11:27:19 -0800 (PST)
Received: from L-E5450.nxp.com ([177.221.114.206])
        by smtp.gmail.com with ESMTPSA id o55sm4009953qtf.46.2020.02.14.11.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 11:27:19 -0800 (PST)
From:   Alifer Moraes <alifer.wsdm@gmail.com>
To:     robh+dt@kernel.org
Cc:     mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        peng.fan@nxp.com, leonard.crestez@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alifer Moraes <alifer.wsdm@gmail.com>
Subject: [PATCH 2/2] arm64: dts: imx8mq-evk: add phy-reset-gpios for fec1
Date:   Fri, 14 Feb 2020 16:27:50 -0300
Message-Id: <20200214192750.20845-2-alifer.wsdm@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214192750.20845-1-alifer.wsdm@gmail.com>
References: <20200214192750.20845-1-alifer.wsdm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

imx8mq-evk has a GPIO connected to AR8031 Ethernet PHY's reset pin.

Describe it in the device tree, following phy's datasheet reset duration of 10ms.

Tested booting via NFS.

Signed-off-by: Alifer Moraes <alifer.wsdm@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index c36685916683..a49e2bf8afe5 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -110,6 +110,8 @@
 	pinctrl-0 = <&pinctrl_fec1>;
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethphy0>;
+	phy-reset-gpios = <&gpio1 9  GPIO_ACTIVE_LOW>;
+	phy-reset-duration = <10>;
 	fsl,magic-packet;
 	status = "okay";
 
-- 
2.17.1

