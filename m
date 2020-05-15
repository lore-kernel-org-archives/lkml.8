Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4713C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE27206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 20:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fdlLKeJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgEOUZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgEOUZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:25:28 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2056C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:25:27 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so4932343wra.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1+JLSREPICjU1AOf1yt9AUIk3xHHHjpOMeSnKLRdJk=;
        b=fdlLKeJmZHoBAKiRGldp8Wkgofrx2uoYboDia9Xn8EGJxP8Zt8ttN6yRL3vqfRxYLl
         LmVueoQjqABOiOFfkj7IGCDifjyw3oQoeAry3A5HT89sHJ54krJC+IJCjDu/d6UeQzBd
         RsUhWnOawCVhCziDYl8+gTHv8EcbC4AcuJaoW3zLpsRpN3HrS/vDgMoHaL5yD0BTV8YU
         ImcGQwuMUTcUdit16kSpD9obPkd91hWYNVj+LCrpyb+L/Q5gylnqxzD9P0OYlbh1Lhxz
         qBfeZnwiD/QFxLdTLbNZmklEhSya5Jp8xwgs5mCRELWuXTVp4fn+2QJjpAElew7KivkN
         EdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1+JLSREPICjU1AOf1yt9AUIk3xHHHjpOMeSnKLRdJk=;
        b=g8FOmCHg/VQ9mrl236XZZknwfi68qIsOdTqgHwIGqhfHOCA8kqo7A7Sm78eMolZ0XW
         qxHNZLbb/utnssUch1sQ9jr0gaICv1exD0QApdedeD1voeNOxL4kLWx4NbK7hKVSs6M1
         EX6DxCUK26bBU8VmDZ5lOjrCGmo9nJhljtU4+ZgKWK9//ocpw+5w0iKdOVdG4/777bY3
         GZ30BkUu5n1FReJfLCHl92qIuD5ksProi9wOV3y4d1LeBY5xMb9XmRb+SXGII4VWDSxq
         LGkjVqmLQqYu3lYlWX/IawTCa2C1jQIbQ/AZkAhUGYyi2QakRnzgw5oaXvRstTLWB7AU
         Cw7A==
X-Gm-Message-State: AOAM530g2XD4NRPfdZehFq3yKOpQvwyM78ucUNVN5xXd0c9qEBRtXerr
        mz4AcvO5b9ujROiInKABP1o=
X-Google-Smtp-Source: ABdhPJywobO3is2E0W6Xkrzdw3Fq6CgAgv1LL4PeVN3GVH4Iv4kv3Q42vuiepsp5lpdHcHdKYXym5Q==
X-Received: by 2002:adf:9166:: with SMTP id j93mr5775356wrj.289.1589574326432;
        Fri, 15 May 2020 13:25:26 -0700 (PDT)
Received: from localhost.localdomain (p200300F137132E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3713:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v20sm6231074wrd.9.2020.05.15.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:25:25 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     khilman@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH for-5.8 v1 1/1] ARM: dts: meson8m2: Use the Meson8m2 specific USB2 PHY compatible
Date:   Fri, 15 May 2020 22:25:20 +0200
Message-Id: <20200515202520.1487514-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Meson8m2 specific USB2 PHY compatible string. The 3.10 vendor
kernel has at least one known difference between Meson8 and Meson8m2:
Meson8m2 sets the ACA_ENABLE bit while Meson8 doesn't.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
This has a runtime dependency on the meson8b-usb2 PHY series from [0].
That one is queued for v5.8 so it would be great if this could make it
into v5.8 as well.

This patch is meant to apply on top of my other series titled "ARM:
dts: meson8b/m2: RGMII improvements" from [1]


[0] https://patchwork.kernel.org/cover/11544233/
[1] https://patchwork.kernel.org/cover/11544215/


 arch/arm/boot/dts/meson8m2.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8m2.dtsi b/arch/arm/boot/dts/meson8m2.dtsi
index 96b37d5e9afd..2397ba06d608 100644
--- a/arch/arm/boot/dts/meson8m2.dtsi
+++ b/arch/arm/boot/dts/meson8m2.dtsi
@@ -65,6 +65,14 @@ &saradc {
 	compatible = "amlogic,meson8m2-saradc", "amlogic,meson-saradc";
 };
 
+&usb0_phy {
+	compatible = "amlogic,meson8m2-usb2-phy", "amlogic,meson-mx-usb2-phy";
+};
+
+&usb1_phy {
+	compatible = "amlogic,meson8m2-usb2-phy", "amlogic,meson-mx-usb2-phy";
+};
+
 &wdt {
 	compatible = "amlogic,meson8m2-wdt", "amlogic,meson8b-wdt";
 };
-- 
2.26.2

