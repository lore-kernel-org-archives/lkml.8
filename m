Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271EB2067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726815;
	bh=U3QhytwNJk+UyMsHRgulmS2DPA9GWdNYioYWjRTqayQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEqnkORiWsg09DDs8GkjcKw8KmtoC7UhsA1GGol7LxTmUef3wGozB1vwhg0wgi6gl
	 Jbrb/KUt5PWVyKRrW5d1theVrYGJp9TKgEeMv65mPrPKiP/vz2G0UCju+ZuYAaj3AV
	 vowGE8NIQowcjfMtp6ny9BF84up3++RGcpZLjC6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388896AbgFISUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732486AbgFIRtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:49:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9B8620801;
        Tue,  9 Jun 2020 17:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591724955;
        bh=U3QhytwNJk+UyMsHRgulmS2DPA9GWdNYioYWjRTqayQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QQ6PnNfGLAjMBWyDUFQPuOnaLbyDAsAKwrBr78/NKX36wjhynw9gjlAh1ydpfWIVC
         3MszJf89DCix5oKxcrjSodcNW8Mdqjkb3iU/49tBVKFterCu8KBHZza+pg7GPckD/c
         HYbLlVTNVsYxDg/7PduGAw6tLo+zdPWe9jPw7NXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 01/46] scsi: scsi_devinfo: fixup string compare
Date:   Tue,  9 Jun 2020 19:44:17 +0200
Message-Id: <20200609174023.054927995@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

commit b8018b973c7cefa5eb386540130fa47315b8e337 upstream.

When checking the model and vendor string we need to use the minimum
value of either string, otherwise we'll miss out on wildcard matches.

And we should take care when matching with zero size strings; results
might be unpredictable.  With this patch the rules for matching devinfo
strings are as follows:

- Vendor strings must match exactly
- Empty Model strings will only match if the devinfo model
  is also empty
- Model strings shorter than the devinfo model string will
  not match

Fixes: 5e7ff2c ("SCSI: fix new bug in scsi_dev_info_list string matching")
Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/scsi_devinfo.c |   23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -392,8 +392,8 @@ EXPORT_SYMBOL(scsi_dev_info_list_add_key
 
 /**
  * scsi_dev_info_list_find - find a matching dev_info list entry.
- * @vendor:	vendor string
- * @model:	model (product) string
+ * @vendor:	full vendor string
+ * @model:	full model (product) string
  * @key:	specify list to use
  *
  * Description:
@@ -408,7 +408,7 @@ static struct scsi_dev_info_list *scsi_d
 	struct scsi_dev_info_list *devinfo;
 	struct scsi_dev_info_list_table *devinfo_table =
 		scsi_devinfo_lookup_by_key(key);
-	size_t vmax, mmax;
+	size_t vmax, mmax, mlen;
 	const char *vskip, *mskip;
 
 	if (IS_ERR(devinfo_table))
@@ -447,15 +447,18 @@ static struct scsi_dev_info_list *scsi_d
 			    dev_info_list) {
 		if (devinfo->compatible) {
 			/*
-			 * Behave like the older version of get_device_flags.
+			 * vendor strings must be an exact match
 			 */
-			if (memcmp(devinfo->vendor, vskip, vmax) ||
-					(vmax < sizeof(devinfo->vendor) &&
-						devinfo->vendor[vmax]))
+			if (vmax != strlen(devinfo->vendor) ||
+			    memcmp(devinfo->vendor, vskip, vmax))
 				continue;
-			if (memcmp(devinfo->model, mskip, mmax) ||
-					(mmax < sizeof(devinfo->model) &&
-						devinfo->model[mmax]))
+
+			/*
+			 * @model specifies the full string, and
+			 * must be larger or equal to devinfo->model
+			 */
+			mlen = strlen(devinfo->model);
+			if (mmax < mlen || memcmp(devinfo->model, mskip, mlen))
 				continue;
 			return devinfo;
 		} else {


