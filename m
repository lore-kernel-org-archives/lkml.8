Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08357C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEE020842
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035323;
	bh=OombUnLDUghUILzH1ozKrrsKeWwOefgxuBCCbHaJg1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eYseSrJph8w19olCzcYGxnhdB8kQHoo2zJ5OzjOZiXqZ8hCl3TWZ1ga3avNhAGKF3
	 CryvqSozBvKxP5jwdDsybwqJCkkLXjJ/Ga5L7+08Kv2uqgRp/6KEF1ZhlqTfK7lPYX
	 SDvIu3qBLUI1vmH+SN8EWesyldfl4tESRH32lVwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgFASPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:15:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731574AbgFASPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:15:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 723B72068D;
        Mon,  1 Jun 2020 18:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035318;
        bh=OombUnLDUghUILzH1ozKrrsKeWwOefgxuBCCbHaJg1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zn4MhdDnddTYYZNs9Xw5JUjP4EkwtbrOvqt3a4zkxgeT1IpznXrmL8kiJ60l7Nept
         fWGuO6Aii1nXUiREeNdruRpWWXRKy3jxvwrty5euV4LnQ/S1uNXULCOMoft5B5gXkB
         nHkvpjbqM7o50B98av2L/CQOQhDp7dRp60jXbOsY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 106/177] ARM: dts: mmp3: Use the MMP3 compatible string for /clocks
Date:   Mon,  1 Jun 2020 19:54:04 +0200
Message-Id: <20200601174057.455593638@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lubomir Rintel <lkundrak@v3.sk>

[ Upstream commit ec7d12faf81de983efce8ff23f41c5d1bff14c41 ]

Clocks are in fact slightly different on MMP3. In particular, PLL2 is
fixed to a different frequency, there's an extra PLL3, and the GPU
clocks are configured differently.

Link: https://lore.kernel.org/r/20200419171157.672999-15-lkundrak@v3.sk
Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/mmp3.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index 59a108e49b41..3e28f0dc9df4 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -531,7 +531,7 @@
 		};
 
 		soc_clocks: clocks@d4050000 {
-			compatible = "marvell,mmp2-clock";
+			compatible = "marvell,mmp3-clock";
 			reg = <0xd4050000 0x1000>,
 			      <0xd4282800 0x400>,
 			      <0xd4015000 0x1000>;
-- 
2.25.1



