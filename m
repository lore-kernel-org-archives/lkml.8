Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEC6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDE9207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595443103;
	bh=C41NSdvixYNpy8FAlvuQ8aWZEgzephgAUoyXiR9BvKM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=y5QMaw9aozvhX0aLAkZfEeAlzft1DeLCsGJkc5dcdanr+5+B12V6h6lllqCHrDlDw
	 AUVljlWVAlDIVlT3kInUYJ46J9U9jtQGidabfp+nqxoSQ1BhCP5fN7WMKLSNJ8twTt
	 Nrsye+LzSKB5tJfZf9aBakQ8AIndst5QVj+MjRsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgGVSiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:38:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgGVSiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:38:21 -0400
Received: from embeddedor (unknown [201.166.157.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEAEB20781;
        Wed, 22 Jul 2020 18:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595443101;
        bh=C41NSdvixYNpy8FAlvuQ8aWZEgzephgAUoyXiR9BvKM=;
        h=Date:From:To:Cc:Subject:From;
        b=N4yhV4EF87gDubIEadGRCHul8bJEx5mNHqryX/eg1UN4qiZwL9eNPb6hXHYc+IqIY
         ry2SUoDQqAVLGiOuhIMgtBv5AmUBHyhaHG/RJLC7AFQKt6/WScEDkpl2BGb9MqejHm
         d4RUMlU17QAu1VyCz1+33X8gDMewdgIslTXho8DQ=
Date:   Wed, 22 Jul 2020 13:43:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] tg3: Avoid the use of one-element array
Message-ID: <20200722184358.GA15694@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element
array with a simple value type 'u32 reserved2'[2], once it seems
this is just a placeholder for alignment.

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tg3-20200718.md
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/broadcom/tg3.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.h b/drivers/net/ethernet/broadcom/tg3.h
index 6953d0546acb..1000c894064f 100644
--- a/drivers/net/ethernet/broadcom/tg3.h
+++ b/drivers/net/ethernet/broadcom/tg3.h
@@ -2847,7 +2847,7 @@ struct tg3_ocir {
 	u32				port1_flags;
 	u32				port2_flags;
 	u32				port3_flags;
-	u32				reserved2[1];
+	u32				reserved2;
 };
 
 
-- 
2.27.0

