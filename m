Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F07CC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68C26205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmbt/s57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCIMvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:51:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45657 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgCIMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:51:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id m9so1946317wro.12;
        Mon, 09 Mar 2020 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x1PptPbFNehJRLUAcVtBI+Vv+nO2YeUsId4RwTPHqBA=;
        b=Fmbt/s57JOvGC+t5yT6BOuG+VuAV+C1vdOBucJ2qiE9DA5S13as4YRRV/vKilghnS1
         qCmwRQ40bTYX/E5Oi7OqKpaTZPPYm0UHI8wV6UnPq3oD4SxiMkxf3m3RrE3cd05LWt7d
         jaFr8ytttI+TRgfOzMo/KMzE7oIfFm9pHBCKqyqPH0CpRWtaatkaWFXV42k9l9KwYWMG
         MZC5ngxwUkLTnxmkUh1rMZxbIBFMpw77ykaPWiQ8hHMK7ACE0Zdtfo0q439DXKeCex1E
         PF+0tMWqcOhzJFm8QAOKg8Rb9ig1E6S+Jdwo0rhRV58/yiKfAB/jdye8798KS4/++TlP
         XdZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x1PptPbFNehJRLUAcVtBI+Vv+nO2YeUsId4RwTPHqBA=;
        b=YsDVP7cZ7iL3ErWLSuX4r2ZbhwvQ3AnDpolNMNN2cqrb/JVkRbqD590HpjXv1SjODD
         QAWUH+NG9J5rNDArMChl3T93SVZznhWQssryrEEm6TcTj0AUu71sTZ6WREd4NzE3m2oJ
         lQej4GBxTvejnZHZEiVWgwDcks4IEr77QwgunrqY/+luZHufWWANhCLZCepG1MQ7iURc
         Y7riFqotEnVch69WmzML64lUR2WEcah11oQS+TDdBtcR9LJnVd1igjWI7FvxQ/q2vQtr
         onA5Vpft61yJ16sptHGonJojlIJ5v44drz5xwiHq/Cl7/o+jOBIGNLQscxGIwAKppw7V
         zRUQ==
X-Gm-Message-State: ANhLgQ2okOvPXrnUZUktgFKTtObVjwcWN1XY8IxfvlMQYQVROZZfA8z+
        WTjotNQ+TLMwxPwupFLcAlU=
X-Google-Smtp-Source: ADFU+vugr4WovSuV+zASQpMXVbLmM8ABazZhoZEpd53p08W7sWLhtWk5N82r7d6SgIM3qCpKurVBLQ==
X-Received: by 2002:a05:6000:1081:: with SMTP id y1mr20922811wrw.52.1583758312017;
        Mon, 09 Mar 2020 05:51:52 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k133sm6417635wma.11.2020.03.09.05.51.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 05:51:51 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove max-freq from &spi1 node for Hugsun X99
Date:   Mon,  9 Mar 2020 13:51:45 +0100
Message-Id: <20200309125145.14455-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below does not detect all errors
in combination with 'additionalProperties: false' and
allOf:
  - $ref: "spi-controller.yaml#"

'additionalProperties' applies to all properties that are not
accounted-for by 'properties' or 'patternProperties' in
the immediate schema.

First when we combine spi-rockchip.yaml and
spi-controller.yaml it gives this error:

arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dt.yaml: spi@ff1d0000:
'max-freq' does not match any of the regexes:
'^.*@[0-9a-f]+$', '^slave$'

'max-freq' is not a valid property name for spi nodes,
so remove it.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/spi/spi-rockchip.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
index f2ffee639..ee4867fbe 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-hugsun-x99.dts
@@ -610,7 +610,6 @@
 
 &spi1 {
 	status = "okay";
-	max-freq = <10000000>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
-- 
2.11.0

