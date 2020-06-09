Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670B0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A0520737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgFISJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:09:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41480 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388182AbgFISF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:05:59 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidG-0001pF-8u; Tue, 09 Jun 2020 19:05:54 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1jiidF-006Vvp-9A; Tue, 09 Jun 2020 19:05:53 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Hannes Reinecke" <hare@suse.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hannes Reinecke" <hare@suse.de>,
        "Todd Poynor" <toddpoynor@google.com>,
        "Christoph Hellwig" <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Johannes Thumshirn" <jthumshirn@suse.de>
Date:   Tue, 09 Jun 2020 19:04:18 +0100
Message-ID: <lsq.1591725832.809977277@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 27/61] scsi: sg: reset 'res_in_use' after unlinking
 reserved array
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

From: Hannes Reinecke <hare@suse.de>

commit e791ce27c3f6a1d3c746fd6a8f8e36c9540ec6f9 upstream.

Once the reserved page array is unused we can reset the 'res_in_use'
state; here we can do a lazy update without holding the mutex as we only
need to check against concurrent access, not concurrent release.

[mkp: checkpatch]

Fixes: 1bc0eb044615 ("scsi: sg: protect accesses to 'reserved' page array")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Todd Poynor <toddpoynor@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/sg.c | 2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2062,6 +2062,8 @@ sg_unlink_reserve(Sg_fd * sfp, Sg_reques
 	req_schp->sglist_len = 0;
 	sfp->save_scat_len = 0;
 	srp->res_used = 0;
+	/* Called without mutex lock to avoid deadlock */
+	sfp->res_in_use = 0;
 }
 
 static Sg_request *

