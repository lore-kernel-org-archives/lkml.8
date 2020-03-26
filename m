Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B266C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D312076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cZR32ujl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgCZQJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:09:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53259 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgCZQJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:09:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id b12so7068339wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VC7vCEcb96NN2X+1RtHiNHbQQNd8PYk2Ufc78Q16YW0=;
        b=cZR32ujlzrt8nUTq/gEyjjkJGk+dPyP8jr5UHD4ls3MRy4lbAmaRqbCN7tlou/2no1
         JETsTqOyEGxkwRCFNOADjJEfIVz3k9pwZTXPaPd4F+50Dabej/sUfPhxhLdQLR0Oe46O
         UFnrlYKd86NJJ+1xYrWV6VoLRA07JelX49Gb1bTyngekW71boQFi49dkbNm/Cwu0C6gF
         G8MRp0rUvLMQYmklI0DSIQMQcuErKgZ1NzRxmSJtaAJesQ2ZX9WnkiGN8vO2I0hAirlh
         Geb+3fvYOOp90SslSoRL63PkOVDdx8bxdApTh5m+fihST6gFtkOprJQgZoXywZqXLeQp
         tBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VC7vCEcb96NN2X+1RtHiNHbQQNd8PYk2Ufc78Q16YW0=;
        b=SlMM6b/4SB1Pqh4YbKGikqKjY23Pm8YttqVuoNXC8Z41o3LFAiJI17jTeK5/IE8SI4
         bhdtqk1noX8hj+OIbGKHiqT9ARXj+eOkV4mBlvuvQj5RRDmAf/XumZ/0OeVKiWhKtqSg
         F2TXt+5JDc/gYvk4DggD1/nihhvoqV9irIadf6qfsCLvBQ8TAkbZ24JlgcVp6wJxzsB3
         VVqTVcueYvaItz7fwo7WSsLm+JcTWKMzfB9Ngxlhl7DiacWJDZLkIPS1/1QK82Eu7F8y
         fsXzVH4SiFfNSAC0WDU1ePIoLedn3RJHYm2q2hCD+MDr3NLAZdnUmJbhAlQhzrut9aTB
         GwXA==
X-Gm-Message-State: ANhLgQ3CR8Gq7DTK4mlrEeSFoSPXluKabjQC7biEldTElOb5EXaF4Yg8
        b/v6g+1wVvrhN72ONVSM3SOhO0+UMxIeTQ==
X-Google-Smtp-Source: ADFU+vvs4kfivC/L5cN2+Rsomorx8j0QPCI1Qh8T4ckH7E9bvg+e8mxFZQeR285mqAeF3KF8/kF9GA==
X-Received: by 2002:a1c:23d5:: with SMTP id j204mr672257wmj.59.1585238942853;
        Thu, 26 Mar 2020 09:09:02 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id z188sm4093511wme.46.2020.03.26.09.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 09:09:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] arm64: dts: meson-g12b-ugoos-am6: fix usb vbus-supply
Date:   Thu, 26 Mar 2020 17:08:56 +0100
Message-Id: <20200326160857.11929-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200326160857.11929-1-narmstrong@baylibre.com>
References: <20200326160857.11929-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB supply used the wrong property, fixing:
meson-g12b-ugoos-am6.dt.yaml: usb@ffe09000: 'vbus-regulator' does not match any of the regexes: '^usb@[0-9a-f]+$', 'pinctrl-[0-9]+'

Fixes: 2cd2310fca4c ("arm64: dts: meson-g12b-ugoos-am6: add initial device-tree")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index 325e448eb09c..06c5430eb92d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -545,7 +545,7 @@
 &usb {
 	status = "okay";
 	dr_mode = "host";
-	vbus-regulator = <&usb_pwr_en>;
+	vbus-supply = <&usb_pwr_en>;
 };
 
 &usb2_phy0 {
-- 
2.22.0

