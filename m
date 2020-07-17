Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBEAC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212862070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 21:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AwxyDNiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGQVAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 17:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQVAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 17:00:21 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FBBC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 14:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qYoU5Y/zLsrXkJq9U4RfXTDC4zNRBe8Z7Hb20eSgPnQ=; b=AwxyDNiB6H5WBPPp7/Avl8CTcU
        fnaotue3qZeyoXrwpReCXm0S5MGXyUmikphXpWA5uyoO/14KCjV3vuTZo5IaeaCwIwZiyMUGkUQuP
        WPgZr5wDxXYpyQZypc//Zbds8CGN0KiyfNSg5yRc8HlBaG5oieq5Ug80BmQ+liokmM1g=;
Received: from p200300ccff0b8f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0b:8f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1jwXSs-0007vJ-32; Fri, 17 Jul 2020 23:00:18 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1jwXSr-000788-KQ; Fri, 17 Jul 2020 23:00:17 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org, phh@phh.me,
        stefan@agner.ch, b.galvani@gmail.com
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] mfd: rn5t618: Fix caching of battery related registers
Date:   Fri, 17 Jul 2020 23:00:02 +0200
Message-Id: <20200717210002.27366-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Battery status changes dynamically, so the corresponding registers
need to be considered volatile. Affected registers are:
- fuel gauge
- battery status
- battery interrupt

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/mfd/rn5t618.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 232de50562f9..55c47e555dd8 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -44,6 +44,9 @@ static bool rn5t618_volatile_reg(struct device *dev, unsigned int reg)
 	case RN5T618_INTMON:
 	case RN5T618_RTC_CTRL1 ... RN5T618_RTC_CTRL2:
 	case RN5T618_RTC_SECONDS ... RN5T618_RTC_YEAR:
+	case RN5T618_CHGSTATE:
+	case RN5T618_CHGCTRL_IRR ... RN5T618_CHGERR_MONI:
+	case RN5T618_CONTROL ... RN5T618_CC_AVEREG0:
 		return true;
 	default:
 		return false;
-- 
2.20.1

