Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BF8C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D80312051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048873;
	bh=fiGMzYdcKj1wMdAjWB8tpXxgYUTFGPSDkacsRCk08pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mezCCtOjDkgHKut/+QOdBRDi/cfYes8+1OEpoHWvqb01UnpPoH98RAgW07Zfj9JYy
	 caizMKCEhEHGAHcjzNbLyGRF+EuVIcvyDZMvdD5b9fQGoPLlyRQPpD03vWqPhm/+pq
	 PNjDCbXotqsYWFd4tPnk4PGd+2GjAAm7cMPm4how=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405730AbgDPOya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409220AbgDPN4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A56EF20786;
        Thu, 16 Apr 2020 13:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045408;
        bh=fiGMzYdcKj1wMdAjWB8tpXxgYUTFGPSDkacsRCk08pA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMTgHq4H7jH3jnPGD9nsZVfm4SUdDz097aryWrLzgu6gdHARYki3A4YaQ+i+opo6F
         NAP7GMyKs9p4qgR+rB48whK5i0NEGkSyW+OiB/YQJcOEcO9Y/JUW5UQ2WFyC1duWFi
         NYk0TpBOQr/1kJ1LfdWvWbpudY8mSyPkPkR7aCmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.6 122/254] PM: sleep: wakeup: Skip wakeup_source_sysfs_remove() if device is not there
Date:   Thu, 16 Apr 2020 15:23:31 +0200
Message-Id: <20200416131341.600717164@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Neeraj Upadhyay <neeraju@codeaurora.org>

commit 87de6594dc45dbf6819f3e0ef92f9331c5a9444c upstream.

Skip wakeup_source_sysfs_remove() to fix a NULL pinter dereference via
ws->dev, if the wakeup source is unregistered before registering the
wakeup class from device_add().

Fixes: 2ca3d1ecb8c4 ("PM / wakeup: Register wakeup class kobj after device is added")
Signed-off-by: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: 5.4+ <stable@vger.kernel.org> # 5.4+
[ rjw: Subject & changelog, white space ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/power/wakeup.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -241,7 +241,9 @@ void wakeup_source_unregister(struct wak
 {
 	if (ws) {
 		wakeup_source_remove(ws);
-		wakeup_source_sysfs_remove(ws);
+		if (ws->dev)
+			wakeup_source_sysfs_remove(ws);
+
 		wakeup_source_destroy(ws);
 	}
 }


