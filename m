Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B4BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E982071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699660;
	bh=PJbRwng5GKSqDrlT0kUDX0BlEES6KWCf+PSeD1wahNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YgQzpe+yHRR/UsXfaN88nl6ZeviZ7jYToqNDM2s/2dE2Huv0kh9d4V5hOzpOVf2DX
	 sKh5TkcIsrGh7XH+412D/rVRXBi0LgTv7b2b/jFd51lykOXWkOSn2/Ai1n2FUlquZn
	 nLGx+bxXjl3zPalGm8hZ6SuOeSeQAtq7aOdbtxJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731617AbgAVN1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729016AbgAVN1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:27:36 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3371205F4;
        Wed, 22 Jan 2020 13:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699655;
        bh=PJbRwng5GKSqDrlT0kUDX0BlEES6KWCf+PSeD1wahNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eBNXQZVQ7U/ws/twrK5le2Kg/KUV51Gspj/lmIQdlJXBfUmxPx+Y/Wy0FUHrv/6Gl
         Lh45stizbirYY0T3p8VjJyELCnTKWmWPG+B4G4KD2cW19ZhV+5NsnLIewirWAHIZcY
         ibdjKWium6tCGeltM7OHF26EffHuN/XF4ZiCB1pQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Bond <dbond@suse.com>,
        Martin Wilck <mwilck@suse.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 5.4 209/222] scsi: qla2xxx: fix rports not being mark as lost in sync fabric scan
Date:   Wed, 22 Jan 2020 10:29:55 +0100
Message-Id: <20200122092848.661376864@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Wilck <mwilck@suse.com>

commit d341e9a8f2cffe4000c610225c629f62c7489c74 upstream.

In qla2x00_find_all_fabric_devs(), fcport->flags & FCF_LOGIN_NEEDED is a
necessary condition for logging into new rports, but not for dropping lost
ones.

Fixes: 726b85487067 ("qla2xxx: Add framework for async fabric discovery")
Link: https://lore.kernel.org/r/20191122221912.20100-2-martin.wilck@suse.com
Tested-by: David Bond <dbond@suse.com>
Signed-off-by: Martin Wilck <mwilck@suse.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/qla2xxx/qla_init.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5891,8 +5891,7 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 		if (test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags))
 			break;
 
-		if ((fcport->flags & FCF_FABRIC_DEVICE) == 0 ||
-		    (fcport->flags & FCF_LOGIN_NEEDED) == 0)
+		if ((fcport->flags & FCF_FABRIC_DEVICE) == 0)
 			continue;
 
 		if (fcport->scan_state == QLA_FCPORT_SCAN) {
@@ -5915,7 +5914,8 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 			}
 		}
 
-		if (fcport->scan_state == QLA_FCPORT_FOUND)
+		if (fcport->scan_state == QLA_FCPORT_FOUND &&
+		    (fcport->flags & FCF_LOGIN_NEEDED) != 0)
 			qla24xx_fcport_handle_login(vha, fcport);
 	}
 	return (rval);


