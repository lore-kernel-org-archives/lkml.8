Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0598CC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80B214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050257;
	bh=qeJIGrrKdtjjhYFAXGoPTkTclmMEdQSo7v/P9jFqUMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o+H2UGKil5/1Z5a03PbKrQA6figPYGWE4bAlumpsLhSo8KK6hHDt7w53ZhmbmYm9h
	 H7SCNAgNkWGMJtItuki2/534Mrpy6qU5yzERTs48ZnuMrlhj2j+kaN4lwfsIwF44Zv
	 cCHPZR+oWNgOsSed7VcDlveFLheDuFLm773wkR/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394972AbgDPPRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:34790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898514AbgDPNst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59BAB21744;
        Thu, 16 Apr 2020 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044928;
        bh=qeJIGrrKdtjjhYFAXGoPTkTclmMEdQSo7v/P9jFqUMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bJpLShqjNDF9/s/oJF1AqT52NZiQfWauBIHtW6tLF39IdRvl9cNAYmS4PdMHwo+dJ
         5oqgSbf9k8EG5R1pQIA4it+FQsI1Bf+rjhGZOb+yjcbjs6BlQgwN51a9D/wt15074f
         cbouu2xEDLWU0ZG6DJJ4mpd5jYFS2MJYHwpiU5dI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5.4 159/232] arm64: dts: allwinner: h5: Fix PMU compatible
Date:   Thu, 16 Apr 2020 15:24:13 +0200
Message-Id: <20200416131334.893614640@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

commit 4ae7a3c3d7d31260f690d8d658f0365f3eca67a2 upstream.

The commit c35a516a4618 ("arm64: dts: allwinner: H5: Add PMU node")
introduced support for the PMU found on the Allwinner H5. However, the
binding only allows for a single compatible, while the patch was adding
two.

Make sure we follow the binding.

Fixes: c35a516a4618 ("arm64: dts: allwinner: H5: Add PMU node")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -77,8 +77,7 @@
 	};
 
 	pmu {
-		compatible = "arm,cortex-a53-pmu",
-			     "arm,armv8-pmuv3";
+		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>,


