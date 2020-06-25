Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B849C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB3B2081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 23:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSo74f0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFYXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 19:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgFYXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 19:34:26 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D61C08C5C1;
        Thu, 25 Jun 2020 16:34:25 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id dp18so7605639ejc.8;
        Thu, 25 Jun 2020 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuIjcnCSzV2GGU37BswH0h5xAjSoK1v2PkU8p66tEjc=;
        b=gSo74f0weOkI0waVjSvTiaUs1MCKDyrsP2JShWPwG3FZ9jd4KLNeASFpPO8fXRH6RL
         re7cblW3uNjQowDX/DY7y2eugWJoDTDCpqYCkWiJZa5Birmwd24Yb4wSbB1a3/Ay7mKS
         a6hrpTKSJPJFjsfo/FxAZAKK+FV0q6xmoPeyOA/PZejPpHsr3QMjGbL9DCoAHNe8GZl/
         R4nD3INrLzguvDpWYhVZ1tT2MdqqwXlWmMbzOQsD5G3UmogyOxg63lOheteyLJA5fZJF
         vdY7PQJkmHEXXcROYz2W6linzuv7IqDANipL8Rlsdksl8SRTJPYOAJCOqzh3/CAEe2VT
         mI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fuIjcnCSzV2GGU37BswH0h5xAjSoK1v2PkU8p66tEjc=;
        b=MPsFULfDkhRjVHUzNu5F32S6oC3H1Fpjb0sKhQJMbt8dgE8foDTeFal32Y1TpG0eKR
         X4BHHcLh7ZQSHWcGwqplTW7oWM8WiTwfkXvV0Qqs59vqMgzVloNeAX+sekxCYbm7jFLy
         /0xEIKol8NsdivYrMRP9qyhSY2uLs13CCCNImly5liqOhDjmaan4Uik5vbQFmguv2M+R
         vBCTG4dYzH4X9ghmvJm7j7B5oLeWp3kISoO3UYvZd6xoz7slkQxZ2ZgUGE4AwX8fU4wK
         2sMu0lsgBDycr+7pBqIOLZ5r0MJlN1qF/bJ/dZm/cV2u/DHQGYy3v1zwvntQp2SjTyrw
         +C2w==
X-Gm-Message-State: AOAM530Y9JpJEPCcc7LV3VfNKpTGK88dC6QthEhgmMnsVLJau5rNDrEh
        l6UCO/hD8xcRJAxUX8AJBQP6/+vw2h0=
X-Google-Smtp-Source: ABdhPJzyS7JVPrAl/Rmmi/CF9YEEthIkkjJM0Vq0cnUVYPHSRXgq58NeTYUQXNXM4nMBtH3KLxxlFw==
X-Received: by 2002:a17:906:bb0c:: with SMTP id jz12mr174776ejb.27.1593128064664;
        Thu, 25 Jun 2020 16:34:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.137.55])
        by smtp.gmail.com with ESMTPSA id u2sm13699184edq.29.2020.06.25.16.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 16:34:24 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
Subject: [PATCH 00/10] Add CMU/RMU/DMA/MMC/I2C support for Actions Semi S500 SoCs
Date:   Fri, 26 Jun 2020 02:34:12 +0300
Message-Id: <cover.1593124368.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset brings a series of improvements for the Actions Semi S500
SoCs family, by adding support for Clock & Reset Management Units, DMA,
MMC & I2C controllers.

Please note the patches contain only DTS changes, but most of them
depend on previous work which is currently under review:

 - Add RMU and DMAC/GPIO clock support for Actions Semi S500 SoCs
https://lore.kernel.org/lkml/cover.1592941257.git.cristian.ciocaltea@gmail.com/

 - Add Actions Semi S500 pinctrl support
https://lore.kernel.org/lkml/cover.1593112402.git.cristian.ciocaltea@gmail.com/

For the moment, I have only enabled the features tested on RoseapplePi,
the SBC for which an initial support has been already submitted via:
https://lore.kernel.org/lkml/cover.1592123160.git.cristian.ciocaltea@gmail.com/

Thanks,
Cristi

Cristian Ciocaltea (10):
  arm: dts: owl-s500: Add Clock Management Unit
  arm: dts: owl-s500: Set UART clock refs from CMU
  arm: dts: owl-s500: Add DMA controller
  arm: dts: owl-s500: Add Reset Controller support
  arm: dts: owl-s500: Add pinctrl node
  arm: dts: owl-s500: Add MMC nodes
  arm: dts: owl-s500: Add I2C nodes
  arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
  arm: dts: owl-s500-roseapplepi: Add uSD support
  arm: dts: owl-s500-roseapplepi: Enable I2C0

 arch/arm/boot/dts/owl-s500-roseapplepi.dts |  96 ++++++++++++++-
 arch/arm/boot/dts/owl-s500.dtsi            | 130 +++++++++++++++++++++
 2 files changed, 221 insertions(+), 5 deletions(-)

-- 
2.27.0

