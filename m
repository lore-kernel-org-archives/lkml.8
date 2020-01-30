Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BFC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123D1206D3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580412309;
	bh=H4t/SyMHDSpl0Q1YtkS9iIl4djy51MFiH1e1PuY0s3I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XC9AZpKLff10c9YeYj7dtQBM1Jy7uJ3DIiOv3qtBKjn2J5p8nBvjW5j7V4msJG09v
	 zQec+ILBl2NMqwWPckq9minqHJ4LZFhf+GExpwEgaBlHro3aiZeo4uaZBg7Q0CQgYG
	 toXW0mwfi0j7H0GQ3ovrBHV3CNX5uBlbcQYt/MaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgA3TZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727438AbgA3TZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:25:08 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ED78205F4;
        Thu, 30 Jan 2020 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580412307;
        bh=H4t/SyMHDSpl0Q1YtkS9iIl4djy51MFiH1e1PuY0s3I=;
        h=From:To:Cc:Subject:Date:From;
        b=lkaPfshCeYemhkddFoSbl2Km4mEetWUBG2ArvJB1h2KZpWcqvqp7zvDKNY3dqCogm
         1lebeQDdhzd6ghMoNf1alRc2StK3/hiI6Ewm41WNNCBzZvCX98unOBkpCNJ6EBqqOT
         1ecrNtcXhNpL/VMyCOwLMDhq85MbJv53yzC02I58=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] parisc: Cleanup IOSCHED_DEADLINE
Date:   Thu, 30 Jan 2020 20:24:58 +0100
Message-Id: <20200130192458.3142-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IOSCHED_DEADLINE s gone since commit f382fb0bcef4 ("block: remove
legacy IO schedulers").

The IOSCHED_DEADLINE was replaced by MQ_IOSCHED_DEADLINE and it will be
now enabled by default (along with MQ_IOSCHED_KYBER).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/parisc/configs/generic-64bit_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index d39e7f821aba..cca42a18a3c3 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -23,7 +23,6 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_BLK_DEV_INTEGRITY=y
-# CONFIG_IOSCHED_DEADLINE is not set
 CONFIG_PA8X00=y
 CONFIG_64BIT=y
 CONFIG_SMP=y
-- 
2.17.1

