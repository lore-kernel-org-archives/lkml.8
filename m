Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C91C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F43020704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699858;
	bh=ic33uoAVKVnzOnT9K0frrp+YlGW8qj6wsHLkx6rMn9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Om6/SjF7WJZ1qHij3FDZe0YPg/gecZXxvBTXNQGG/1XX0RW5qUpAjeAiXPo9UpVZ6
	 LMysHQTNob38YG8N4sUSDc3UpqsI2ayH1sT60wZRvFiLZ55VakGCwDQS4sw/rCSTAr
	 1hPP9vB1gxf+3DomZl48R9oZWE8s2wFJNcVIT+1A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgAVNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:21:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:37966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728792AbgAVNVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:21:12 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F27552468D;
        Wed, 22 Jan 2020 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699271;
        bh=ic33uoAVKVnzOnT9K0frrp+YlGW8qj6wsHLkx6rMn9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOHMXC6Kzf+X5iF/2Crs36+ol9SK9hqZO2rKPtpzot0Jtl1KmBlOwT6TX6hnq+/qR
         V5rElZ0UO56zB7lkZ5dfhTON7Da5ZLSowNr0MaGGqRr0Iwi/PSMZkEAZbgkeVTbs7G
         RXL7wmaJv+wbcy4LgtHtYkwUMOAvD6R/DfP/CqBc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anson Huang <Anson.Huang@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 5.4 093/222] ARM: dts: imx6qdl-sabresd: Remove incorrect power supply assignment
Date:   Wed, 22 Jan 2020 10:27:59 +0100
Message-Id: <20200122092840.396293510@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

commit 4521de30fbb3f5be0db58de93582ebce72c9d44f upstream.

The vdd3p0 LDO's input should be from external USB VBUS directly, NOT
PMIC's power supply, the vdd3p0 LDO's target output voltage can be
controlled by SW, and it requires input voltage to be high enough, with
incorrect power supply assigned, if the power supply's voltage is lower
than the LDO target output voltage, it will return fail and skip the LDO
voltage adjustment, so remove the power supply assignment for vdd3p0 to
avoid such scenario.

Fixes: 93385546ba36 ("ARM: dts: imx6qdl-sabresd: Assign corresponding power supply for LDOs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi |    4 ----
 1 file changed, 4 deletions(-)

--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -749,10 +749,6 @@
 	vin-supply = <&vgen5_reg>;
 };
 
-&reg_vdd3p0 {
-	vin-supply = <&sw2_reg>;
-};
-
 &reg_vdd2p5 {
 	vin-supply = <&vgen5_reg>;
 };


