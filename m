Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443FFC3524B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA3C206E6
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 10:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=duncanthrax.net header.i=@duncanthrax.net header.b="aT2gESsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgBBKKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 05:10:01 -0500
Received: from propper.duncanthrax.net ([91.207.61.48]:58360 "EHLO
        smtp.duncanthrax.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgBBKKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 05:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=duncanthrax.net; s=dkim; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/DFSL+JIs7vC6XfTnmAq7s3cDEMLEVt9B2+G1TYYNyM=; b=aT2gESsxByThcX9BHZK3AF98qx
        inkqDoqw9ns3YG+WT0eZota9qG6wEmqIhvZHpy03QD6fykI0EavCA0L7GGPdWAUxFci2UT2V09YTQ
        90GTFsEi2NFvLDSvldiuEQA5ht08UTsq+/5c81orLm0Idw05nSo6v5eOXRbPCaqUMIoo=;
Received: from [134.3.47.90] (helo=x280.stackframe.org)
        by smtp.duncanthrax.net with esmtpa (Exim 4.90_1)
        (envelope-from <svens@stackframe.org>)
        id 1iyBhn-00009N-T5; Sun, 02 Feb 2020 10:38:16 +0100
From:   Sven Schnelle <svens@stackframe.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, Sven Schnelle <svens@stackframe.org>
Subject: [PATCH 1/2] usb/storage: add SCSI ID and LUN to debug output
Date:   Sun,  2 Feb 2020 10:37:48 +0100
Message-Id: <20200202093750.4439-2-svens@stackframe.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200202093750.4439-1-svens@stackframe.org>
References: <20200202093750.4439-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the LUN and SCSI ID to the debug output so it is a bit easier to
figure out which device is actually adressed.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 drivers/usb/storage/debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/storage/debug.c b/drivers/usb/storage/debug.c
index d7f50b7a079e..4787656b4f4f 100644
--- a/drivers/usb/storage/debug.c
+++ b/drivers/usb/storage/debug.c
@@ -136,7 +136,8 @@ void usb_stor_show_command(const struct us_data *us, struct scsi_cmnd *srb)
 	case WRITE_LONG_2: what = "WRITE_LONG_2"; break;
 	default: what = "(unknown command)"; break;
 	}
-	usb_stor_dbg(us, "Command %s (%d bytes)\n", what, srb->cmd_len);
+	usb_stor_dbg(us, "ID %d:%lld Command %s (%d bytes)\n",
+		srb->device->id, srb->device->lun, what, srb->cmd_len);
 	usb_stor_dbg(us, "bytes: %*ph\n", min_t(int, srb->cmd_len, 16),
 		     (const unsigned char *)srb->cmnd);
 }
-- 
2.24.1

