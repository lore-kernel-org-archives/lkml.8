Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7563120734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388524AbgFISJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:09:57 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41440 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388178AbgFISF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:59 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-0001oz-22; Tue, 09 Jun 2020 19:05:54 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidF-006VwQ-KQ; Tue, 09 Jun 2020 19:05:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johannes Thumshirn" <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Douglas Gilbert" <dgilbert@interlog.com>
Date:   Tue, 09 Jun 2020 19:04:31 +0100
Message-ID: <lsq.1591725832.86016505@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 40/61] scsi: sg: fix static checker warning in
 sg_is_valid_dxfer
In-Reply-To: <lsq.1591725831.850867383@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.85-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>

commit 14074aba4bcda3764c9a702b276308b89901d5b6 upstream.

dxfer_len is an unsigned int and we always assign a value > 0 to it, so
it doesn't make any sense to check if it is < 0. We can't really check
dxferp as well as we have both NULL and not NULL cases in the possible
call paths.

So just return true for SG_DXFER_FROM_DEV transfer in
sg_is_valid_dxfer().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reported-by: Colin Ian King <colin.king@canonical.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/sg.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -796,8 +796,11 @@ static bool sg_is_valid_dxfer(sg_io_hdr_
 			return false;
 		return true;
 	case SG_DXFER_FROM_DEV:
-		if (hp->dxfer_len < 0)
-			return false;
+		/*
+		 * for SG_DXFER_FROM_DEV we always set dxfer_len to > 0. dxferp
+		 * can either be NULL or != NULL so there's no point in checking
+		 * it either. So just return true.
+		 */
 		return true;
 	case SG_DXFER_TO_DEV:
 	case SG_DXFER_TO_FROM_DEV:

