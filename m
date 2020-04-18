Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9378C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 21:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48BB21927
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 21:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZVUggX0x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDRVm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 17:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgDRVm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 17:42:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C402FC061A0C;
        Sat, 18 Apr 2020 14:42:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id z90so5292234qtd.10;
        Sat, 18 Apr 2020 14:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=w/47EmjUE3OUhd2M0nQ4aXQ8hyh3Kb7PGgRqxtZ7DE0=;
        b=ZVUggX0x5rhoXJFUBIldk0DtR/0RR5CPGISHzpnQ+TQnYKrfeMt/KhQQ6q8bIhavOj
         zS5q0fnSx2Qee65hTc8gbTJ22xqcr+E296piNk9oudT07Nb82xX0hBs724JULPmy2x4q
         GJJwWJcNpbmjPbYl1I3v7RhZl331/lkk1TY7969iA0lNpVOYq6SKDsqasccvZ9MjMB4i
         0kUKFWtdXOtUj+1L/TOQnaMqL4x10dyz57zTQnjSaLraneT0/j3K6BnGGG1Pq/Avekeu
         NGM/J24mt5TYyVDDqTHVsWWj/2lHkGdr1t9WzV7e2IJ+pq+90XlqbWTaYHg99pIxSELt
         5wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=w/47EmjUE3OUhd2M0nQ4aXQ8hyh3Kb7PGgRqxtZ7DE0=;
        b=ceWzO0GxfroZfT1efGV6rgxUhvCcBBGejOpbxayU9sYTHAoiq7E9cYKuf3JvL20zrH
         tWEzcKkLo/67vQYcoIm0P7P9HiDgq/sfmmdPGJJr2a4LzdPMcVcWTCd3CWQVgpN0aSmM
         7RkApAHcU6/3faH6LmguWbXBFKy41gW/5wvMAeAieMDl8Es0bJhatGG3FKhVy0JNW12h
         uha3s8tsL/IJXSJj/wLL45FJ6SQMpUBG9Zdvo1SdvuZvG7yLhBnLAoeZAHmRmGfkEig5
         E8V7G2pDkQ22x2p7n0k5ZvlAW/uOedS+MsBHvzO4mpOusF+yawsmK9vQgEuaRZRml2mT
         ZMWg==
X-Gm-Message-State: AGi0PuYFVTbUUlaJJ5HOhcXpowLXGLfHl1sxJRL78db1VZNRPkUUtP/Y
        TvcVpVatu6EDm/VlSUfwdRk=
X-Google-Smtp-Source: APiQypK/ZNb28CwxyoAZvAhkzL57dtO3+k9ZptxS3i9hczv3oFx6wdSujk2rkeT1CVCQDJTCIa6JzA==
X-Received: by 2002:ac8:1904:: with SMTP id t4mr9678039qtj.367.1587246146742;
        Sat, 18 Apr 2020 14:42:26 -0700 (PDT)
Received: from imac (dhcp-108-168-12-59.cable.user.start.ca. [108.168.12.59])
        by smtp.gmail.com with ESMTPSA id p31sm18381085qtf.11.2020.04.18.14.42.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Apr 2020 14:42:26 -0700 (PDT)
Date:   Sat, 18 Apr 2020 17:42:23 -0400
From:   Tim Lewis <elatllat@gmail.com>
To:     elatllat@gmail.com
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        christianshewitt@gmail.com, joy.cho@hardkernel.com,
        tobetter@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: [v2] arm64: dts: meson: odroid-n2: extend cpu opp-points
Message-ID: <20200418214223.GA4484@imac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Odroid N2 has a large heatsink and HardKernel supports overclock
through the addition to extra opp points in their official kernel
sources [1]. Add these to the N2 dts only, as other S922X devices
may not have suitable heatsinks.

[1] https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6bd5a2ad2f
Signed-off-by: Tim Lewis <elatllat@gmail.com>

---
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 42f154057..6f32ac83f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -260,6 +260,25 @@
 			};
 		};
 	};
+
+	cpu_opp_table_0: opp-table-0 {
+		opp-1992000000 {
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1001000>;
+		};
+	};
+
+	cpub_opp_table_1: opp-table-1 {
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <981000>;
+		};
+
+		opp-1908000000 {
+			opp-hz = /bits/ 64 <1908000000>;
+			opp-microvolt = <1022000>;
+		};
+	};
 };
 
 &arb {
-- 
2.17.1

