Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE4CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC68021D7B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 09:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592473413;
	bh=iuQKCiWXc9wM8xeOmmKjRhno6rEFdv12AJl4+8sTOs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yoDCYaZAv8EG6XWWJdWt0bc7aYFuzx20fnk6SfKpV3+g+dCsz5gHeQBcRCizdAUqS
	 fWvd3KQnZd9fx3ALE9QawyKqUjachVqICgzRr4PLd5FmhAn8mN9JWQv7iiD0stc2QU
	 oGxjtnRSYk33/Iu3Zyk0oyEoIc/pq5j1EVQgHtr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFRJnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 05:43:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729164AbgFRJn1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 05:43:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68E721548;
        Thu, 18 Jun 2020 09:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592473407;
        bh=iuQKCiWXc9wM8xeOmmKjRhno6rEFdv12AJl4+8sTOs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeKdyWB0MIZRtQV51OmrspXojZTSUJf2p+fDnmTbv5wSyyfHyrHHBPsOWKBQnNzhg
         bdatqSOGa9QSIzDZ/UIPGaQ3F/fK6P7W8+COTbpOYCJb9dqeEbybdWVodOqmJlv2+o
         4PRvelSrjQSYocUwIyCAzdh7mQKm+YJWP3zhwLD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 6/8] USB: storage: fix wording in error message
Date:   Thu, 18 Jun 2020 11:42:58 +0200
Message-Id: <20200618094300.1887727-7-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
References: <20200618094300.1887727-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it obvious that the UAS driver is being ignored for a specific
device by fixing up the wording to be more clear.

Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/uas-detect.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/uas-detect.h b/drivers/usb/storage/uas-detect.h
index 3734a25e09e5..3f720faa6f97 100644
--- a/drivers/usb/storage/uas-detect.h
+++ b/drivers/usb/storage/uas-detect.h
@@ -120,7 +120,7 @@ static int uas_use_uas_driver(struct usb_interface *intf,
 
 	if (flags & US_FL_IGNORE_UAS) {
 		dev_warn(&udev->dev,
-			"UAS is blacklisted for this device, using usb-storage instead\n");
+			"UAS is ignored for this device, using usb-storage instead\n");
 		return 0;
 	}
 
-- 
2.27.0

