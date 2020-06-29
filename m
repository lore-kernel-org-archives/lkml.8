Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F7DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C230B2074A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="CtUW1G7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgF2DT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:19:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DA7C03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id c1so138991pja.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N7ALW83XlMpZ1UNtCe3339z3xtZN1TwIo7hbmM2+bF0=;
        b=CtUW1G7rX1aMx2QF59g+J78Z94tMoXWIIVhLD2JEBHaXi7uvpEv8fC2AsCqzJZTxRC
         JBEfUwTsw5guLXx5y3oAiRFLzMkQM63qumKW1s/Q8XSLd4ghrTWGvoy5HtxDIIiTCIem
         tJ/HQ9UCOCFcjof+pojb95RYUi8143OBVYNLZYzzU8yX1BpAir30Rxi0tJsHVjXcqig+
         zjBsx5ghHMkbDPex+Z59vhpzguaVWEt98LrTeLGL15jHpPAQOkcIRfYoXdjimV0iz0ax
         v7XTQfFQc0XwSBhrxfhVAZRB5dTmWpg0fxg38DTbmxeMaNNX0YrylLRKC6RO/su+v0Ws
         k0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N7ALW83XlMpZ1UNtCe3339z3xtZN1TwIo7hbmM2+bF0=;
        b=VLyFHib3mGOoixKPHzx4SalkiLoptiSpZa1IglNPKKeEOYdbEmF95s6AYqkmSagjur
         EpEPGnq+Mayeny+Ivn4kUbV6jqFqgDCJBmXWnGWMkIyOmLyQtYnx/6B8p0XqqhG4M+AN
         EKyPCZytuFJaiVPYW+Uo0/V56+iz/lbxyLYbxPolpDSjcEJIrtVPTnRq2VD8yJdOcf0W
         JyRDeiG5N5sAM2EJsjRt0+9SFOpfeOuE2yROXY0umyrKqH5nSnUJxUKFM5Sw5lX5/t4M
         18vcv7YONEVnQzupNqyEzDW2nu+KKYF4PTmmnsinoWVy3Onkd7cNhdUFWGEt4zgtlLtJ
         Lzxg==
X-Gm-Message-State: AOAM531wZe9eCRZm38vySjn0DK9gvFrM3w+veEWeWwEYXwZHwuXDXL8W
        c1jRfkzryWnY7yFrXBjOxNcaV9k2JTkLZw==
X-Google-Smtp-Source: ABdhPJwI/FlxEB4eqDmKB/m+/Up3gTbXvrv98xnOr3oTcgypiCSZ3DcqOB2TUerg5zb4ouEh+nnZdw==
X-Received: by 2002:a17:902:b496:: with SMTP id y22mr11901540plr.224.1593400763621;
        Sun, 28 Jun 2020 20:19:23 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j70sm12876254pfd.208.2020.06.28.20.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 20:19:23 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 2/6] riscv: dts: sifive: Add DT support for PMU
Date:   Mon, 29 Jun 2020 11:19:11 +0800
Message-Id: <b90858e0baa2184d8aeac1a930c6d6882f9cc09f.1593397455.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
References: <cover.1593397455.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add performance monitor unit DT node in SiFive Fu540 soc-specific DT
file. This pmu node passes the dtbs_check verification.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 arch/riscv/boot/dts/sifive/fu540-c000.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
index 7db861053483..824351fe2a57 100644
--- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
+++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
@@ -283,4 +283,17 @@ gpio: gpio@10060000 {
 			status = "disabled";
 		};
 	};
+	pmu {
+		compatible = "riscv,pmu";
+		riscv,width-base-cntr = <64>;
+		riscv,width-event-cntr = <40>;
+		riscv,n-event-cntr = <2>;
+		riscv,hw-event-map = <0x0 0x0
+				      0x1 0x1
+				      0x3 0x0202
+				      0x4 0x4000
+				      0x5 0x2001>;
+		riscv,hw-cache-event-map = <0x010201 0x0102
+					    0x010204 0x0802>;
+	};
 };
-- 
2.27.0

