Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA97FC4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF55320754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 21:54:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mE6DwdoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgCUVye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 17:54:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35990 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgCUVyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 17:54:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so5875125wrs.3;
        Sat, 21 Mar 2020 14:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/QGnM5aF633O9T+Q9bE7j7rBcANzw8cmYuGuF3OhlUI=;
        b=mE6DwdoCdvIrq6k6mckByOPROcnYRtJTsjJ01FfrQUXQfQpHOjpQ9NzteV55TDBsso
         J4bH/fAaVcbTldZtFetSL8nR6F07U7J/hNn29UDMnXCRcZVPHkFxw5gpn4B2J0hLfHip
         MxxqYLK9vMc2y7FCJaDgCV4Gt4j83HJ+X2p/NJPveRRn+SekYle/XHJEhGTkx8xJHXuw
         e7GarbzUhAR4IbNeUUfbrUIlS1iqmTJP9Wq5EgEFaFBR9JgwqPdwXbNF0htckv6c5rbQ
         O0D974ktV7tGRy4zpHbfnd6kPNXPMWZmPAIQWPfLkHeLmFO0hYFU1yK/ngn5Z2i42fby
         llyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/QGnM5aF633O9T+Q9bE7j7rBcANzw8cmYuGuF3OhlUI=;
        b=bW0bclh1xKTuopiVhzkxUzROi9hns1y17bhwx2T9sguqFR91UpIiyeMSeLiVq1bvs3
         6l/XZdQ1qQ8fwMN1RMZBw8gwE3hpDP8VkkQTskjo4hjnmBaGMKLsQEIAbyu7GTBckajP
         jRUcrkMBwI/FzUDRGyKhfOjoPz8Amxs80M16KJPGMD2zmL0Eo06pjV44zz17FVk93MkJ
         5++VjrUJR3Ic1/XvseDxC2Tl71SnSgGXiGIqnkt2FiQRNLa2Q4OyyBaaJWLP8rZN2/pC
         o2Pwv+sjH9EEQ+Q2Fe65bOwmyBxxn9T5FfgSPDrb+6UqO9Hlger7RbA8sRJmOUMTR9BT
         /4vw==
X-Gm-Message-State: ANhLgQ2+jl/25Q52JLVo4dQAG7wBYXejmIuQXby4lWeqfJ76yKQyVtYH
        97rMi2TQE0NswldV1qR6rRqeH6Ho
X-Google-Smtp-Source: ADFU+vuhRHlUNjw0nRmyX68DRkdDY/81x1nxjG77MQWmrMGsuHpBMKBLmYWp0wdtVlI085MN09BICg==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr12268879wrv.92.1584827672086;
        Sat, 21 Mar 2020 14:54:32 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l83sm14113796wmf.43.2020.03.21.14.54.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 14:54:31 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robin.murphy@arm.com, aballier@gentoo.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: rockchip: fix rtl8211f nodename for rk3328 Beelink A1
Date:   Sat, 21 Mar 2020 22:54:19 +0100
Message-Id: <20200321215423.12176-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200321215423.12176-1-jbx6244@gmail.com>
References: <20200321215423.12176-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: phy@0:
'#phy-cells' is a required property

The rtl8211f node is used by a phy-handle.
The parent node is compatible with "snps,dwmac-mdio",
so change nodename to 'ethernet-phy', for which '#phy-cells'
is not a required property.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-a1.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
index 16f1656d5..fbd06a351 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-a1.dts
@@ -114,7 +114,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		rtl8211f: phy@0 {
+		rtl8211f: ethernet-phy@0 {
 			reg = <0>;
 			reset-assert-us = <10000>;
 			reset-deassert-us = <30000>;
-- 
2.11.0

