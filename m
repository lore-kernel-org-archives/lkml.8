Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54548C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2508E207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599079745;
	bh=/GhIFha/+TBHI6MyiiKEJbWoOQuukXfIzVKICT5nktg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ew3po1fTjsfP02e8/YDsSXVJt/MFYLbgveJHjhS26aKMxWyu7ONtYgsBPFzjpCYW8
	 puQ8aPyFuwGChZeAVEh47BxU7AgVJfj+8jKzhcBWeo63HK2JXa6jF+XswAz7OCxUeM
	 BFDhaTIQOP4/H36ABa1syYQ3zutHcVdfuKDXKV2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIBUtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbgIBUtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:49:00 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DD2F2083B;
        Wed,  2 Sep 2020 20:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599079739;
        bh=/GhIFha/+TBHI6MyiiKEJbWoOQuukXfIzVKICT5nktg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=co/qoHbiTAzDR0BKe7yk+ALRQGX6M9VQAT24HXHnyX6QT1AS2FLEr0iuuygtYDhth
         2Y45ZWyWOqgzE+dgRyTu/qxPorUj+6vMKc/7b4qho98ADAFvt46DLoemA49Ytn0dSm
         tRYWNmq2GSRu5KeRe8fiu6R2gphLESuin1E9h640=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Ben Dooks <ben-linux@fluff.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] mmc: s3cmci: Use proper printk format for iomem pointer
Date:   Wed,  2 Sep 2020 22:48:46 +0200
Message-Id: <20200902204847.2764-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902204847.2764-1-krzk@kernel.org>
References: <20200902204847.2764-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

iomem pointers should be printed with pointer format to hide the
actual value and fix warnings when compile testing for 64-bit
architecture:

  drivers/mmc/host/s3cmci.c:1355:46: warning:
    cast from pointer to integer of different size [-Wpointer-to-int-cast]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mmc/host/s3cmci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index dcd458649338..3fb597095079 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1352,7 +1352,7 @@ static int s3cmci_state_show(struct seq_file *seq, void *v)
 {
 	struct s3cmci_host *host = seq->private;
 
-	seq_printf(seq, "Register base = 0x%08x\n", (u32)host->base);
+	seq_printf(seq, "Register base = 0x%p\n", host->base);
 	seq_printf(seq, "Clock rate = %ld\n", host->clk_rate);
 	seq_printf(seq, "Prescale = %d\n", host->prescaler);
 	seq_printf(seq, "is2440 = %d\n", host->is2440);
-- 
2.17.1

