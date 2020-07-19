Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B469C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0992E208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="xjRq7OvE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="PVgbZv72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGSRMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 13:12:07 -0400
Received: from relay3.mymailcheap.com ([217.182.66.161]:33616 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSRMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:12:07 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 69AB23ECDF;
        Sun, 19 Jul 2020 19:12:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id ACAFD2A354;
        Sun, 19 Jul 2020 13:12:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1595178724;
        bh=FV+wR9CULgMQqlgDNOjT69yBHwivGDyAlFaoqfduitg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjRq7OvEaFLeXZv+/7n4rBzF8vXU6RnULYcxdyK9axzD3ITmr6j+8nqxSPeGERhPL
         wKOs2PwMCgUoIjNFJUBPArtoJcPN5RUukZQ0butZfZuu7tEPMs83WQhwVqF8dVlKsl
         fYKZWwfZwQ4hNPt/9Cu9Jbf7s1UGvP38QBIb/1ao=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lZL9LLXvAdRh; Sun, 19 Jul 2020 13:12:03 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sun, 19 Jul 2020 13:12:03 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id E323240854;
        Sun, 19 Jul 2020 17:12:02 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="PVgbZv72";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id B42D140854;
        Sun, 19 Jul 2020 17:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1595178718; bh=FV+wR9CULgMQqlgDNOjT69yBHwivGDyAlFaoqfduitg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVgbZv72Q+weuV5/PjECAIuV/ZgPjm9ZKkOB4wDSetLzo+KgVLrVxjG/SAdpEFbum
         tO8wTIgn3D2p8o3yKBmN9Zq4zlKcEoKiZw5ORf/RM8xVBfss45gvOsVPTBQigCUXX8
         8WPhTHvLsW56+aMqSfHc+uChV9S9E43b+2a/o234=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 4/4] [DO NOT MERGE] arm64: allwinner: dts: a64: enable K101-IM2BYL02 panel for PineTab
Date:   Mon, 20 Jul 2020 01:11:34 +0800
Message-Id: <20200719171134.276652-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200719170411.275812-1-icenowy@aosc.io>
References: <20200719170411.275812-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E323240854
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com,ravnborg.org,kernel.org];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.116:received];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         DBL_PROHIBIT(0.00)[0.0.0.0:email];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Newer PineTab may switch to K101-IM2BYL02.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index dc4ab6b434f97..15c4f5b5b17a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -152,6 +152,7 @@ &dsi {
 	vcc-dsi-supply = <&reg_dldo1>;
 	status = "okay";
 
+#if 0
 	panel@0 {
 		compatible = "feixin,k101-im2ba02";
 		reg = <0>;
@@ -161,6 +162,15 @@ panel@0 {
 		reset-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 		backlight = <&backlight>;
 	};
+#endif
+
+	panel@0 {
+		compatible = "feixin,k101-im2byl02";
+		reg = <0>;
+		power-supply = <&reg_dc1sw>;
+		reset-gpios = <&pio 3 24 GPIO_ACTIVE_LOW>; /* PD24 */
+		backlight = <&backlight>;
+	};
 };
 
 &ehci0 {
-- 
2.27.0
