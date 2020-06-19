Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B421556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="a0RId+sy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389394AbgFSTeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389030AbgFSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:09 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97605C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B20E91500CE6;
        Fri, 19 Jun 2020 21:34:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1tBADHw4Gt6hzC3jPSK4Q2NTfNKEEFfLDN4shW140U=;
        b=a0RId+syMjI/qbZz8baLRiQHNjCBXNJKcqG7a/IkxzpNai25MOGnBvFaz9fQ9cfEZNV0sK
        bDznbg07Zz0KwSSm9uAFzjxAZ2VHLrIj3tRIXvspLvyFKJk5hp5on06kP5rSKu3i77EokN
        UAW+YrwoIuj0G49dEi4NSRWw80UhIKb6gnRb3FpbdqdC1b4m+b3536Xl4fVyDSIxFXWFpN
        JTKgv74aS/Nt21Jn9KxE4Er5m2xi6D8j4JkBC0uh3R7g1NoS2ocsJSj9CyRySCTkoHf5Yz
        j/IdFii+45rV+RbQcGMlQyyvheDbKtaDMsWtFwrbJHtjpSAW/znKZ6DRgtj+pA==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 4/9] drivers: cdrom: rewrite embedded assignments in multiple lines
Date:   Fri, 19 Jun 2020 21:33:36 +0200
Message-Id: <20200619193341.51209-4-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were reported by scripts/checkpatch.pl.
All of them have been fixed in this patch.

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 76 +++++++++++++++++++++++++++++--------------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index e27af76199eb..49073b1c7919 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -461,7 +461,8 @@ static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 	cgc.cmd[8] = sizeof(buffer);
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	mfd = (struct mrw_feature_desc *)&buffer[sizeof(struct feature_header)];
@@ -469,7 +470,8 @@ static int cdrom_is_mrw(struct cdrom_device_info *cdi, int *write)
 		return 1;
 	*write = mfd->write;
 
-	if ((ret = cdrom_mrw_probe_pc(cdi))) {
+	ret = cdrom_mrw_probe_pc(cdi);
+	if (ret) {
 		*write = 0;
 		return ret;
 	}
@@ -702,7 +704,8 @@ static int cdrom_get_random_writable(struct cdrom_device_info *cdi,
 	cgc.cmd[8] = sizeof(buffer);		/* often 0x18 */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	memcpy(rfd, &buffer[sizeof(struct feature_header)], sizeof(*rfd));
@@ -723,7 +726,8 @@ static int cdrom_has_defect_mgt(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	feature_code = (__be16 *) &buffer[sizeof(struct feature_header)];
@@ -741,7 +745,8 @@ static int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
 
 	*write = 0;
 
-	if ((ret = cdrom_get_random_writable(cdi, &rfd)))
+	ret = cdrom_get_random_writable(cdi, &rfd);
+	if (ret)
 		return ret;
 
 	if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
@@ -851,10 +856,12 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	struct rwrt_feature_desc rfd;
 	int ret;
 
-	if ((ret = cdrom_has_defect_mgt(cdi)))
+	ret = cdrom_has_defect_mgt(cdi);
+	if (ret)
 		return ret;
 
-	if ((ret = cdrom_get_random_writable(cdi, &rfd)))
+	ret = cdrom_get_random_writable(cdi, &rfd);
+	if (ret)
 		return ret;
 	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
 		ret = !rfd.curr;
@@ -877,7 +884,8 @@ static void cdrom_mmc3_profile(struct cdrom_device_info *cdi)
 	cgc.cmd[8] = sizeof(buffer);		/* Allocation Length */
 	cgc.quiet = 1;
 
-	if ((ret = cdi->ops->generic_packet(cdi, &cgc)))
+	ret = cdi->ops->generic_packet(cdi, &cgc);
+	if (ret)
 		mmc3_profile = 0xffff;
 	else
 		mmc3_profile = (buffer[6] << 8) | buffer[7];
@@ -1354,7 +1362,8 @@ static int cdrom_slot_status(struct cdrom_device_info *cdi, int slot)
 	if (!info)
 		return -ENOMEM;
 
-	if ((ret = cdrom_read_mech_status(cdi, info)))
+	ret = cdrom_read_mech_status(cdi, info);
+	if (ret)
 		goto out_free;
 
 	if (info->slots[slot].disc_present)
@@ -1384,7 +1393,8 @@ int cdrom_number_of_slots(struct cdrom_device_info *cdi)
 	if (!info)
 		return -ENOMEM;
 
-	if ((status = cdrom_read_mech_status(cdi, info)) == 0)
+	status = cdrom_read_mech_status(cdi, info);
+	if (status == 0)
 		nslots = info->hdr.nslots;
 
 	kfree(info);
@@ -1446,7 +1456,8 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 	if (!info)
 		return -ENOMEM;
 
-	if ((ret = cdrom_read_mech_status(cdi, info))) {
+	ret = cdrom_read_mech_status(cdi, info);
+	if (ret) {
 		kfree(info);
 		return ret;
 	}
@@ -1473,7 +1484,9 @@ static int cdrom_select_disc(struct cdrom_device_info *cdi, int slot)
 
 	/* set media changed bits on both queues */
 	cdi->mc_flags = 0x3;
-	if ((ret = cdrom_load_unload(cdi, slot)))
+
+	ret = cdrom_load_unload(cdi, slot);
+	if (ret)
 		return ret;
 
 	return slot;
@@ -1678,7 +1691,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.quiet = 1;
 		setup_report_key(&cgc, ai->lsa.agid, 0);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lsa.agid = buf[7] >> 6;
@@ -1689,7 +1703,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_KEY1\n");
 		setup_report_key(&cgc, ai->lsk.agid, 2);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		copy_key(ai->lsk.key, &buf[4]);
@@ -1700,7 +1715,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_CHALLENGE\n");
 		setup_report_key(&cgc, ai->lsc.agid, 1);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		copy_chal(ai->lsc.chal, &buf[4]);
@@ -1717,7 +1733,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.cmd[3] = ai->lstk.lba >> 16;
 		cgc.cmd[2] = ai->lstk.lba >> 24;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lstk.cpm = (buf[4] >> 7) & 1;
@@ -1730,8 +1747,9 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 	case DVD_LU_SEND_ASF:
 		cd_dbg(CD_DVD, "entering DVD_LU_SEND_ASF\n");
 		setup_report_key(&cgc, ai->lsasf.agid, 5);
-		
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lsasf.asf = buf[7] & 1;
@@ -1744,7 +1762,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 0xe;
 		copy_chal(&buf[4], ai->hsc.chal);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->type = DVD_LU_SEND_KEY1;
@@ -1756,7 +1775,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 0xa;
 		copy_key(&buf[4], ai->hsk.key);
 
-		if ((ret = cdo->generic_packet(cdi, &cgc))) {
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret) {
 			ai->type = DVD_AUTH_FAILURE;
 			return ret;
 		}
@@ -1768,7 +1788,9 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		cgc.quiet = 1;
 		cd_dbg(CD_DVD, "entering DVD_INVALIDATE_AGID\n");
 		setup_report_key(&cgc, ai->lsa.agid, 0x3f);
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 		break;
 
@@ -1779,7 +1801,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		memset(&rpc_state, 0, sizeof(rpc_state_t));
 		cgc.buffer = (char *) &rpc_state;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 
 		ai->lrpcs.type = rpc_state.type_code;
@@ -1796,7 +1819,8 @@ static int dvd_do_auth(struct cdrom_device_info *cdi, dvd_authinfo *ai)
 		buf[1] = 6;
 		buf[4] = ai->hrpcs.pdrc;
 
-		if ((ret = cdo->generic_packet(cdi, &cgc)))
+		ret = cdo->generic_packet(cdi, &cgc);
+		if (ret)
 			return ret;
 		break;
 
@@ -2059,7 +2083,8 @@ static int cdrom_read_subchannel(struct cdrom_device_info *cdi,
 	cgc.cmd[3] = mcn ? 2 : 1;
 	cgc.cmd[8] = 16;
 
-	if ((ret = cdo->generic_packet(cdi, &cgc)))
+	ret = cdo->generic_packet(cdi, &cgc);
+	if (ret)
 		return ret;
 
 	subchnl->cdsc_audiostatus = cgc.buffer[1];
@@ -2929,7 +2954,8 @@ int cdrom_get_last_written(struct cdrom_device_info *cdi, long *last_written)
 
 	toc.cdte_format = CDROM_MSF;
 	toc.cdte_track = CDROM_LEADOUT;
-	if ((ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc)))
+	ret = cdi->ops->audio_ioctl(cdi, CDROMREADTOCENTRY, &toc);
+	if (ret)
 		return ret;
 	sanitize_format(&toc.cdte_addr, &toc.cdte_format, CDROM_LBA);
 	*last_written = toc.cdte_addr.lba;
-- 
2.27.0

