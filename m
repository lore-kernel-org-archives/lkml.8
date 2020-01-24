Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756B6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB892077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860568;
	bh=W+g4RWPxBysTaAJRlR6u2/CrxkupBVTisvp39ikA+e0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sQ5Q+7/h9YJMrbzUnQSCvGNNfdwF/sSH6sJ24IqYucTnHpNgHa6B88SsxhRAt/cmh
	 HfGeL95LGXlVLKx8Q7WwRkZv8gHHvcOirzGhL+OVNeVfFM0Wsqbl3BtQUdK5cN44Qc
	 ajxCDcHv3FvjG2IOqzevfaPVTkupAkFMcFXkptX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389621AbgAXKJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:09:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389613AbgAXKJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:09:24 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79DA320709;
        Fri, 24 Jan 2020 10:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860563;
        bh=W+g4RWPxBysTaAJRlR6u2/CrxkupBVTisvp39ikA+e0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J/zkOAs33reewMQlgh8gDdrseoatwKaqOod55U7uvlfLkNt6XsvRITZDyszVNe1mw
         4f9Ci51cHrcY/Ls6/BTUyJ4h68ZtHLgWyXxIafYlKbSP/hXa5/eijf+M0/zVhqqgjQ
         PB/+2DHeBQ732TF+6PTrgx1n2oFtMVHdonL90hbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 020/639] ARM: dts: at91: nattis: make the SD-card slot work
Date:   Fri, 24 Jan 2020 10:23:10 +0100
Message-Id: <20200124093049.736770488@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Rosin <peda@axentia.se>

[ Upstream commit f52eb2067929d533babe106fbc131c88db3eff3d ]

The cd-gpios signal is assumed active-low by the driver, and the
cd-inverted property is needed if it is, in fact, active-high. Fix
this oversight.

Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
Signed-off-by: Peter Rosin <peda@axentia.se>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
index bfa5815a07214..4308a07b792ea 100644
--- a/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
+++ b/arch/arm/boot/dts/at91-nattis-2-natte-2.dts
@@ -221,6 +221,7 @@
 		reg = <0>;
 		bus-width = <4>;
 		cd-gpios = <&pioD 5 GPIO_ACTIVE_HIGH>;
+		cd-inverted;
 	};
 };
 
-- 
2.20.1



