Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ABDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA67C207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=yehs2007@zoho.com header.b="nqvwkCtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgFLP4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:56:14 -0400
Received: from sender4-pp-o92.zoho.com ([136.143.188.92]:25213 "EHLO
        sender4-pp-o92.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLP4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:56:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591977365; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=Agc3IKRHXUGW6x+nrxvlCv3cOc8hz+yosPNHClx+b8o3ba8vWHSbHXW86oDJkehi3F5+5nO2RM0bUTidbUBldiwIyUyfZpYcp5jvc9amj/2pEextemRDuddCKWdjXlXuoroWXw0PcXebxpQECzQhW3qdiYtg4BBd4+ODHI8p7Kw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1591977365; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=ux0XK/KllVcDT9frERy+i5aI2PpALEGnPgdm8/WW9NU=; 
        b=Zdw7hqhzqVNC+Q4aGs+S5KyngKcx0WYG6EO72lEFH87vMSffsYSbfPOAR7RlErlFXvCUGhGH/5GuMXsUSC8aEV+9bB1aC6n60oNA1GnesNyQhpa/pnPovTfnOQG3v7mlXwNJ9iU9GBQJyATBQvfmOPQ5eGLDM8mP2DvHVZ4ujKM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=yehs2007@zoho.com;
        dmarc=pass header.from=<yehs2007@zoho.com> header.from=<yehs2007@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=vJwJXSqwD1evDm12+N1z4hvQCTPTSLWJGxgC/c2OJlC9xkFqYBUScBdtOV/goP9K5kVLd3ZI0FqP
    T1Mh4XAWe6sIpWT9EUMS3UlgkiqnShLznaL0niRTvEOQhWPKJdFj  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591977365;
        s=zm2020; d=zoho.com; i=yehs2007@zoho.com;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=ux0XK/KllVcDT9frERy+i5aI2PpALEGnPgdm8/WW9NU=;
        b=nqvwkCtV1ql3bNG9cYgOEq4I+QzXSEYJhvvnmz7Lk/Iz8ZonFR9Bd2pN4+c9QpRD
        HcI4/cK3HHqATclVd1KHv4TEkeYx9tk82Uqhfr7Ui712w1AuxsMZSgRXBXdC+c6OhMj
        xZpk8ZkRnHdvJaUFfCoqt52NEIutABDUTpMIgu18=
Received: from YEHS1XPF1D05WL.lenovo.com (111.197.254.230 [111.197.254.230]) by mx.zohomail.com
        with SMTPS id 159197736366961.0283403658716; Fri, 12 Jun 2020 08:56:03 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     mpatocka@redhat.com, snitzer@redhat.com, agk@redhat.com
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH] dm writecache: skip writecache_wait when using pmem mode
Date:   Fri, 12 Jun 2020 23:55:44 +0800
Message-Id: <20200612155544.90348-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

The array bio_in_progress is only used with ssd mode. So skip
writecache_wait_for_ios in writecache_discard when pmem mode.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/md/dm-writecache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 66f3a3b..4367cc7 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -849,8 +849,10 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
 
 		if (likely(!e->write_in_progress)) {
 			if (!discarded_something) {
-				writecache_wait_for_ios(wc, READ);
-				writecache_wait_for_ios(wc, WRITE);
+				if (!WC_MODE_PMEM(wc)) {
+					writecache_wait_for_ios(wc, READ);
+					writecache_wait_for_ios(wc, WRITE);
+				}
 				discarded_something = true;
 			}
 			writecache_free_entry(wc, e);
-- 
1.8.3.1

