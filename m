Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E296EC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2838215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDo/4WF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDVXjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDVXjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:39:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615CCC03C1AA;
        Wed, 22 Apr 2020 16:39:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c23so2834066qtp.11;
        Wed, 22 Apr 2020 16:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=E1PBrkT1LoNCkirZimCNKHoVPu32mXxSCEKcm1zSQdY=;
        b=oDo/4WF/ApXIvPS+YZM/b4AuPq4KMtNUrAx4kPRyrKcfDY/7N/wACbuVSV9Bv/+yzf
         fsnHPe6JvdEzXhWLh9tQ6LLzYjBZVEjddVBn1gtQAALZMkA67fSSmIEs97PND8XNvZYp
         /CLble/z+CslEMET1pTe/sVN52S4rwol8nho+e70U31cQydk8ItNbaD2Aun5iR9YbF6y
         S2gA8LYXgnTxOjCa8ODOggGJVmTiCJMrAfqWMBASVIq+rkmiTUfucLWHgc1v7UxPm/SA
         KXTVxF1f1yGF6eVCicEPf0DvQnww0cq8E9wKeCSoC9OtuV2k7GYnhhDWSC8guN4M4SP1
         qKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=E1PBrkT1LoNCkirZimCNKHoVPu32mXxSCEKcm1zSQdY=;
        b=o3iyGTgInp+JDbK3ZKu1V8KCVnFcy5Swx8zmg3Gi7K+NT3Rvx4qniorndN+yaKVsn2
         SejvSGlhYTwCkGMipEu+4FbdOEmIPK0D/9RvL5UpzqV9OrJdOvU9ePxgmBjQsNSdgdII
         jV0ceMr9XLgzQKUSZdiybHjGOdyPZktOlc3ODFwW2j8LtXlI8LrdFAR4TnuE1sJE91py
         oLZwpagFVTxzBmirBvuOidhJPP6EvJr4GBuLI/LsASESp2NXDped6TxuRaksRbw/9vF/
         L3olmqhOKUKcvPmipIxEAecihYVOZwu8F6bQqdPKk1tu8DNMIVDfJwxAuHGWSxFA0WGs
         wdvg==
X-Gm-Message-State: AGi0PuaLDmC1JDCp7KtFfwHP+xUdA4XumqsOfzi5PtxVlb6GL3d5qF7X
        rOLFEfIScTJCbF54vSNzdoU=
X-Google-Smtp-Source: APiQypIx5CG1YBGE7PM0vaWxnGyfc8b17Jq+bNco8g/8Tp6x3Az3BOQ4nLnVYoI1NU6hWc+y49zG8Q==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr1262025qtj.181.1587598771607;
        Wed, 22 Apr 2020 16:39:31 -0700 (PDT)
Received: from imac (dhcp-108-168-12-59.cable.user.start.ca. [108.168.12.59])
        by smtp.gmail.com with ESMTPSA id i6sm475709qkk.123.2020.04.22.16.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 16:39:31 -0700 (PDT)
Date:   Wed, 22 Apr 2020 19:39:28 -0400
From:   Tim Lewis <elatllat@gmail.com>
To:     elatllat@gmail.com
Cc:     narmstrong@baylibre.com, khilman@baylibre.com,
        christianshewitt@gmail.com, joy.cho@hardkernel.com,
        tobetter@gmail.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org
Subject: [PATCH v3] arm64: dts: meson: S922X: extend cpu opp-points
Message-ID: <20200422233928.GA2816@imac>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HardKernel supports overclock through the addition to extra opp points
in their official kernel sources for odroid-n2 [1]. Christian tested
on other S922X devices with "no obvious issues". Neil thinks dvfs and
thermal managementis can keep other S922X devices safe.

[1] https://github.com/hardkernel/linux/commit/f86cd9487c7483b2a05f448b9ebacf6bd5a2ad2f
Tested-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Tim Lewis <elatllat@gmail.com>

---
 arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi | 15 +++++++++++++++
 1 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
index 046cc332d..1e5d0ee5d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-s922x.dtsi
@@ -65,6 +65,11 @@
 			opp-hz = /bits/ 64 <1896000000>;
 			opp-microvolt = <981000>;
 		};
+
+		opp-1992000000 {
+			opp-hz = /bits/ 64 <1992000000>;
+			opp-microvolt = <1001000>;
+		};
 	};
 
 	cpub_opp_table_1: opp-table-1 {
@@ -120,5 +125,15 @@
 			opp-hz = /bits/ 64 <1704000000>;
 			opp-microvolt = <891000>;
 		};
+
+		opp-1800000000 {
+			opp-hz = /bits/ 64 <1800000000>;
+			opp-microvolt = <981000>;
+		};
+
+		opp-1908000000 {
+			opp-hz = /bits/ 64 <1908000000>;
+			opp-microvolt = <1022000>;
+		};
 	};
 };
-- 
2.17.1

