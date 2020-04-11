Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4D5C2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4E52051A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648087;
	bh=omF1iRanyQ8S752QBPEFo8RD9YAGvCRHuHarTQ18A/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xojE5z+MqjfGDZ+tdzJYsLWWrTmjKGiDrjKKEzcVclK/blNcXVq+TsG70kFqxMZps
	 RkyezaBIl63lU9gsPuAnmWKNc814UeSLesfzHcByPtJZtvnvDD/eiXal9BM/FUVVOH
	 b3JRksd1wiUZ/0S3AfCb8x/xSJpOTfCSHVvHHNQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbgDKXJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbgDKXJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:09:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06AD020787;
        Sat, 11 Apr 2020 23:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646550;
        bh=omF1iRanyQ8S752QBPEFo8RD9YAGvCRHuHarTQ18A/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=riGlpz6tKtUpfJSYKkfW0PMVhBRX1tPMm6ldywOiC0KrsZlCGSiwB+aGR8s2Xgt/G
         vRTsCc42ZBttBItDMTh39xSUwCELgiYvXrk2ZLgTCarfON7RpVwFvsCn+JRQWfXQ5P
         Q24afZ8fWPuNt6uYnVolkRwXO1d+bSpDXcaAP200=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Patrick Daly <pdaly@codeaurora.org>,
        "Isaac J . Manjarres" <isaacm@codeaurora.org>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 101/121] of: of_reserved_mem: Increase limit on number of reserved regions
Date:   Sat, 11 Apr 2020 19:06:46 -0400
Message-Id: <20200411230706.23855-101-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230706.23855-1-sashal@kernel.org>
References: <20200411230706.23855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Daly <pdaly@codeaurora.org>

[ Upstream commit 632c99084052aef1c9dcfe43d2720306026d6d21 ]

Certain SoCs need to support a large amount of reserved memory
regions. For example, Qualcomm's SM8150 SoC requires that 20
regions of memory be reserved for a variety of reasons (e.g.
loading a peripheral subsystem's firmware image into a
particular space).

When adding more reserved memory regions to cater to different
usecases, the remaining number of reserved memory regions--12
to be exact--becomes too small. Thus, double the existing
limit of reserved memory regions.

Signed-off-by: Patrick Daly <pdaly@codeaurora.org>
Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 6bd610ee2cd73..1a84bc0d5fa80 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/memblock.h>
 
-#define MAX_RESERVED_REGIONS	32
+#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
-- 
2.20.1

