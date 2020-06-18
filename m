Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA84C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202F221D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473419;
	bh=WtYNzP9++iS9aInYNLIZ+WR+4J+U8x7eD9R49QihPrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YRLZZ9C3kFhIxoK3VRWLNPrkS2IfF85IRg1f8gwLcdSg5xEd5ypkvV4LUPyNM0RxV
	 S2E+s2LD2ZaYOLjz1zHe/CvmiLLJDNJI52jmLtyQJ1EpMxz6Lug2J+6Q+qI46uoWXr
	 7p64Cgz0cVhq1oE0fncrz5IxadjK903tmpwjJk8o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgFRJng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:43884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729305AbgFRJna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A26D21548;
        Thu, 18 Jun 2020 09:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473409;
        bh=WtYNzP9++iS9aInYNLIZ+WR+4J+U8x7eD9R49QihPrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0thFW9dcN9kmGCGc/Mx2AvXObVEG47RtUhq0ofk7b23OFO8goK5Rtq7AmJZqWaMl1
         MTS4g/7nKuj3PcP8g21LluWWSkxfmsrajiuv+wJTCYCurSaqgSeNOf0UhFhZFzwZjT
         y1c53WNvBUFPAE2TdFaFfSAt+eZ4bpigsQPqT204=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 7/8] USB: storage: scsi: fix up comment to be more specific
Date:   Thu, 18 Jun 2020 11:42:59 +0200
Message-Id: <20200618094300.1887727-8-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up the wording in a comment for the scsi driver saying what it does
using better terminology.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/scsiglue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index f4c2359abb1b..e5a971b83e3f 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -298,7 +298,7 @@ static int slave_configure(struct scsi_device *sdev)
 	} else {
 
 		/*
-		 * Non-disk-type devices don't need to blacklist any pages
+		 * Non-disk-type devices don't need to ignore any pages
 		 * or to force 192-byte transfer lengths for MODE SENSE.
 		 * But they do need to use MODE SENSE(10).
 		 */
-- 
2.27.0

