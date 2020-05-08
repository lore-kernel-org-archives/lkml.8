Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5CCC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B828208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588944262;
	bh=7Bp1WIBxFr2BJvFRS88L6nOxxroACqnQNoc7Tvi4kqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u74seifsshlGsqRUiW9sPqSVsE2xTLRniPhcgopp5meHBmWRowIsQYAJCH8af/ykZ
	 /fAJkgVmd8VP62Jrn/w6zq5ApexD1OSKYz1N5pXg8S8uKcynWaclrhkgZCHP9HERU/
	 Cg/Ujo6UhIOKaYXPN5KjVodGqw2fOhWBIUygddf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgEHNYU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:24:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727981AbgEHMhF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:37:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB2224953;
        Fri,  8 May 2020 12:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588941424;
        bh=7Bp1WIBxFr2BJvFRS88L6nOxxroACqnQNoc7Tvi4kqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z2VHmNoq0Vb6570jX5jWJ8MRiP0fwP9nQvt6GzLjVA4Tu3b7FyFTEDLTB/nqvyLhO
         hVen3PKtWJbS1RdlbB0f86uOYkV1JUDDjilIceuJYpGQ8qEUadq1YIerjQzB2FqYxE
         ZhxSI4YlXIUBLhXQwfuRzBMOkCgyqAkgHzQf1Rxo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, john@phrozen.org, cernekee@gmail.com,
        jaedon.shin@gmail.com, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 019/312] MIPS: BMIPS: Adjust mips-hpt-frequency for BCM7435
Date:   Fri,  8 May 2020 14:30:10 +0200
Message-Id: <20200508123125.838999737@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123124.574959822@linuxfoundation.org>
References: <20200508123124.574959822@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 80fa40acaa1dad5a0a9c15ed2e5d2e72461843f5 upstream.

The CPU actually runs at 1405Mhz which gives us a 175625000 Hz MIPS timer
frequency (CPU frequency / 8).

Fixes: e4c7d009654a ("MIPS: BMIPS: Add BCM7435 dtsi")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: john@phrozen.org
Cc: cernekee@gmail.com
Cc: jaedon.shin@gmail.com
Patchwork: https://patchwork.linux-mips.org/patch/13132/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/dts/brcm/bcm7435.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/boot/dts/brcm/bcm7435.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm7435.dtsi
@@ -7,7 +7,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		mips-hpt-frequency = <163125000>;
+		mips-hpt-frequency = <175625000>;
 
 		cpu@0 {
 			compatible = "brcm,bmips5200";


