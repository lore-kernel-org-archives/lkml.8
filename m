Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7BD2206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595375418;
	bh=+aPBvm7PmwXf+ngJL5CufUYjRJ3afrbzvRdmLvuJAP8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=CRgEQXhWoYoLA6CQ7CHaCfPdBufokan907d13hWjuu7KbfSUZgdbZhmyD9ME3UDLG
	 zQQGK1DPTnTa5YLGWELFPlbV6JwsKNs0hlSlRw1Yrd4IboAiX6wjG9mhq7d0RRDGGm
	 9fizYt+/G+7NRAjGwi6JY6tgp5NNybitYSrSKHpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgGUXuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgGUXuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:50:17 -0400
Received: from embeddedor (unknown [201.162.241.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1612020657;
        Tue, 21 Jul 2020 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595374231;
        bh=+aPBvm7PmwXf+ngJL5CufUYjRJ3afrbzvRdmLvuJAP8=;
        h=Date:From:To:Cc:Subject:From;
        b=DhtsisWRwm2dlRvbaqMHNVA5sEWVBHDWKH3gNt33GCOvF8b+8kSJfvxD4OF8B5lQC
         58qVUze20NBouZFXVeBVQQq/n2MjKjw+S8PzPuR+YsRukNbjwgICvim36U6Pjg4Ep3
         eP+M/CBQUqnG5KwDdBLrQqHB8tPzOS2Jwt0OxQaI=
Date:   Tue, 21 Jul 2020 18:36:09 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] i2c: synquacer: Use fallthrough pseudo-keyword
Message-ID: <20200721233609.GA2882@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1].

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/i2c/busses/i2c-synquacer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-synquacer.c b/drivers/i2c/busses/i2c-synquacer.c
index c9a3dba6a75d..31be1811d5e6 100644
--- a/drivers/i2c/busses/i2c-synquacer.c
+++ b/drivers/i2c/busses/i2c-synquacer.c
@@ -398,8 +398,7 @@ static irqreturn_t synquacer_i2c_isr(int irq, void *dev_id)
 
 		if (i2c->state == STATE_READ)
 			goto prepare_read;
-
-		/* fall through */
+		fallthrough;
 
 	case STATE_WRITE:
 		if (bsr & SYNQUACER_I2C_BSR_LRB) {
-- 
2.27.0

