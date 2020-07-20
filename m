Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C4EC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CA1920684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261453;
	bh=KE6R2F8uuV0eRZb3TgQs0qWi4zwtTOolzKA25kcL3pE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mwIEmynpXOKVo5INX4NHE/deYmzW+f5JfJ0c52Bg0IAlsAaJLiRYiY2JFt5cLH9m4
	 OOCrhqHw5HHuXYA6caRV+g9lBzj6BGtwALmfcmMaGFUIwcKqz90fvWkqPQH7kMQq0F
	 sYfDmYqgJB9JCZuRwMvwAKjVbqXG3ErLTHlPFqh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387710AbgGTQKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387704AbgGTQKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:10:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0C320684;
        Mon, 20 Jul 2020 16:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261448;
        bh=KE6R2F8uuV0eRZb3TgQs0qWi4zwtTOolzKA25kcL3pE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bdtNEqASnJQFp8V8kBjiZ0qBbJX5/QDPt2UMZBSTqBaRAeQ7s3/NY32uWqHO9z3WX
         7NlD5McoxfWDpgngPFubtVVwfAD+FEW/zFsL4BrSNH9fv1z5ILkHnnZdu9bwqVGXO+
         Vo9+NKDyFap0LZWj1KKq/yecmAifQYpoTLtEyEE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.7 120/244] dmaengine: ti: k3-udma: Disable memcopy via MCU NAVSS on am654
Date:   Mon, 20 Jul 2020 17:36:31 +0200
Message-Id: <20200720152831.544473667@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

commit a4e688535a0829980d5ef1516c0713777a874c62 upstream.

Trace of a test for DMA memcpy domains slipped into the glue layer commit.
The memcpy support should be disabled on the MCU UDMAP.

Fixes: d702419134133 ("dmaengine: ti: k3-udma: Add glue layer for non DMAengine users")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Link: https://lore.kernel.org/r/20200327144228.11101-1-peter.ujfalusi@ti.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/ti/k3-udma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3186,7 +3186,7 @@ static struct udma_match_data am654_main
 
 static struct udma_match_data am654_mcu_data = {
 	.psil_base = 0x6000,
-	.enable_memcpy_support = true, /* TEST: DMA domains */
+	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
 	.rchan_oes_offset = 0x2000,
 	.tpl_levels = 2,


