Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3530CC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AEB20842
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738675;
	bh=M2LHe5QnNlZndOPbv4fl/oy/tZyYqlsTgxfoviEve74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wVldxHJTwGw1Taiu3EMDa/CP1txEh3/eAlG7ngAFJgqGRfGih/mUhxcOwsHcgdo5z
	 QcniIH/lZsINGAkW7TclUsvFRWdiCFhJbWj2ut5NgVI9Ob5qwT2b6TsCQ/yS0/g38R
	 1C/6o6MSZmtxTyHw3ipxb5/aFFTHCnL1Vf5MhKsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgAKKbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:31:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:42554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgAKKbM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:31:12 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74A4C2146E;
        Sat, 11 Jan 2020 10:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738671;
        bh=M2LHe5QnNlZndOPbv4fl/oy/tZyYqlsTgxfoviEve74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TTXae3iqnLH4/Csv1Ntq1TuJvNwkPgKMhXD2NlFaWj8UwXY3AqiKad52pi4yrneDb
         e3EoivT1nMVxWHCiS4WpfSOct4jLH4Zx/EGV5QRHXWqXAjzYA/EpNkKJhX5N3ZgRIF
         Lw+aJtXrbgb9TeMr5TuFcFikQRyR/Gqc4LKWmPEo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 127/165] s390/dasd: fix memleak in path handling error case
Date:   Sat, 11 Jan 2020 10:50:46 +0100
Message-Id: <20200111094935.208049521@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 00b39f698a4f1ee897227cace2e3937fc4412270 ]

If for whatever reason the dasd_eckd_check_characteristics() function
exits after at least some paths have their configuration data
allocated those data is never freed again. In the error case the
device->private pointer is set to NULL and dasd_eckd_uncheck_device()
will exit without freeing the path data because of this NULL pointer.

Fix by calling dasd_eckd_clear_conf_data() for error cases.

Also use dasd_eckd_clear_conf_data() in dasd_eckd_uncheck_device()
to avoid code duplication.

Reported-by: Qian Cai <cai@lca.pw>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index f5622f4a2ecf..a28b9ff82378 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2074,7 +2074,7 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	dasd_free_block(device->block);
 	device->block = NULL;
 out_err1:
-	kfree(private->conf_data);
+	dasd_eckd_clear_conf_data(device);
 	kfree(device->private);
 	device->private = NULL;
 	return rc;
@@ -2083,7 +2083,6 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 static void dasd_eckd_uncheck_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	int i;
 
 	if (!private)
 		return;
@@ -2093,21 +2092,7 @@ static void dasd_eckd_uncheck_device(struct dasd_device *device)
 	private->sneq = NULL;
 	private->vdsneq = NULL;
 	private->gneq = NULL;
-	private->conf_len = 0;
-	for (i = 0; i < 8; i++) {
-		kfree(device->path[i].conf_data);
-		if ((__u8 *)device->path[i].conf_data ==
-		    private->conf_data) {
-			private->conf_data = NULL;
-			private->conf_len = 0;
-		}
-		device->path[i].conf_data = NULL;
-		device->path[i].cssid = 0;
-		device->path[i].ssid = 0;
-		device->path[i].chpid = 0;
-	}
-	kfree(private->conf_data);
-	private->conf_data = NULL;
+	dasd_eckd_clear_conf_data(device);
 }
 
 static struct dasd_ccw_req *
-- 
2.20.1



