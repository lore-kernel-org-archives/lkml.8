Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7ADCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B91924688
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685994;
	bh=I7dlXjRbJ5ROP2NmstYpT9Prk+guF4Hnv28jyGcDR00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L+ihnWsCl/Fb4QLCZtSMKBVb9zN5paLrMbWtctA33bNXZNRror6NyEZmLAzh85nIl
	 yyRXQ8FB5TayRoI1MZAMalYzF3vyNzk2vj5J0HgTZfN80k3khf3YvVDjWQILe2Y5pm
	 U7ey3JZ91a0PbU3gIUAMZ5pZi8bdMro2clDBSYMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732758AbgAVJjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:39:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733278AbgAVJjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:39:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3356C24686;
        Wed, 22 Jan 2020 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685987;
        bh=I7dlXjRbJ5ROP2NmstYpT9Prk+guF4Hnv28jyGcDR00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zPpta//gGMo0ATPeYLesklCEPz02g4yz9jHuZJAzBu2sO8ggVSrcoh+BedKFA1cZl
         ouMc8yKOLaxjiU9niF6FZb8SnSWNt5KyE8gAPaSxYo9aDyKvqmWWEEVE22Pf3J436w
         MzfssE3i5d3d4KoZv9pTtujGDv6JFuYCFqTikAq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Bond <dbond@suse.com>,
        Martin Wilck <mwilck@suse.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.14 62/65] scsi: qla2xxx: fix rports not being mark as lost in sync fabric scan
Date:   Wed, 22 Jan 2020 10:29:47 +0100
Message-Id: <20200122092800.857296720@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
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
@@ -5145,8 +5145,7 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 		if (test_bit(LOOP_RESYNC_NEEDED, &vha->dpc_flags))
 			break;
 
-		if ((fcport->flags & FCF_FABRIC_DEVICE) == 0 ||
-		    (fcport->flags & FCF_LOGIN_NEEDED) == 0)
+		if ((fcport->flags & FCF_FABRIC_DEVICE) == 0)
 			continue;
 
 		if (fcport->scan_state == QLA_FCPORT_SCAN) {
@@ -5171,7 +5170,8 @@ qla2x00_find_all_fabric_devs(scsi_qla_ho
 			}
 		}
 
-		if (fcport->scan_state == QLA_FCPORT_FOUND)
+		if (fcport->scan_state == QLA_FCPORT_FOUND &&
+		    (fcport->flags & FCF_LOGIN_NEEDED) != 0)
 			qla24xx_fcport_handle_login(vha, fcport);
 	}
 	return (rval);


