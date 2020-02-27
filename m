Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE9EC3F361
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DC72468D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811328;
	bh=Y3rmB0n2Bwds4vY+xXhnHcjSIlguK30yVGX2AiFZnUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F4SX2D8zXvdE7CijtVxEwQjdDSLXMAchlaHLrC6PabPpX29o9t8yWJE6Xrw6+QX+5
	 92TkQqzEm9NuSbka2WRyQPnMtFDBfmd6q7yTensum0wbR28nb9Xmeb0a/nL5nDu1Ez
	 S4sc9Z5m/ey5RnRthIf4tbNIdVmy6volLZct6l2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730934AbgB0Nsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730653AbgB0Nso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:44 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546BA24688;
        Thu, 27 Feb 2020 13:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811323;
        bh=Y3rmB0n2Bwds4vY+xXhnHcjSIlguK30yVGX2AiFZnUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=drYdc28dyvHHtIK0FyukKP2ridGvDRtJL2AfZ4PlIz0VbPTj2IeduQkV5yMTds5wR
         oGS/AkHEmdYysfo0NVrs/19inD348X/Wl4lL06jZIcGJ/yqwBvrQ1g9fNHABmumJXg
         Ovs6it44vZjT9VL9gUeoUmkSSe94HPJ71ng+tHMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 049/165] NFC: port100: Convert cpu_to_le16(le16_to_cpu(E1) + E2) to use le16_add_cpu().
Date:   Thu, 27 Feb 2020 14:35:23 +0100
Message-Id: <20200227132238.368579899@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 718eae277e62a26e5862eb72a830b5e0fe37b04a ]

Convert cpu_to_le16(le16_to_cpu(frame->datalen) + len) to
use le16_add_cpu(), which is more concise and does the same thing.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/port100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 3cd995de1bbb5..151b220381f95 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -573,7 +573,7 @@ static void port100_tx_update_payload_len(void *_frame, int len)
 {
 	struct port100_frame *frame = _frame;
 
-	frame->datalen = cpu_to_le16(le16_to_cpu(frame->datalen) + len);
+	le16_add_cpu(&frame->datalen, len);
 }
 
 static bool port100_rx_frame_is_valid(void *_frame)
-- 
2.20.1



