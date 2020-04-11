Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568DEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305DF215A4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607458;
	bh=x8qWc3hLwwOsdjb5R6YsYTuGLj3zhF4WasWIQAL3D8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xmJeJEw3K87uX17R3HkCOg4DPWrySG1YQe9Xj8+2OuxsYfrFim5emujC0pUmqIqoZ
	 r9O9hYFdmaMLDpbr4ktR8kwp9jpyCM+JXlTCZXF9QRgxjqtypIdEjStiO2yUusg6u/
	 usZr58BEQmLXT41nOpA7c2yQUPkP5H1OPXB4ou6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgDKMRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728429AbgDKMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:17:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7911821655;
        Sat, 11 Apr 2020 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607452;
        bh=x8qWc3hLwwOsdjb5R6YsYTuGLj3zhF4WasWIQAL3D8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y9jPbbGt88fOi7brIftc7feLNRUAiBIl1fu6tI4u2vK9yF1snzXMvsdPT8Vc+G4f9
         kVtuQ0/UFxH2B17QU+yzyuQzBHB4t7UipFhAMoWKlAVfTLeWYeP3fsQqGljL++clVR
         jMUsimA03fy8Fb2cy/eh9G1RuWkjzxlj/QD96Ud8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 25/41] IB/hfi1: Call kobject_put() when kobject_init_and_add() fails
Date:   Sat, 11 Apr 2020 14:09:34 +0200
Message-Id: <20200411115505.872920513@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115504.124035693@linuxfoundation.org>
References: <20200411115504.124035693@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaike Wan <kaike.wan@intel.com>

commit dfb5394f804ed4fcea1fc925be275a38d66712ab upstream.

When kobject_init_and_add() returns an error in the function
hfi1_create_port_files(), the function kobject_put() is not called for the
corresponding kobject, which potentially leads to memory leak.

This patch fixes the issue by calling kobject_put() even if
kobject_init_and_add() fails.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200326163813.21129.44280.stgit@awfm-01.aw.intel.com
Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Signed-off-by: Kaike Wan <kaike.wan@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/hfi1/sysfs.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/infiniband/hw/hfi1/sysfs.c
+++ b/drivers/infiniband/hw/hfi1/sysfs.c
@@ -674,7 +674,11 @@ int hfi1_create_port_files(struct ib_dev
 		dd_dev_err(dd,
 			   "Skipping sc2vl sysfs info, (err %d) port %u\n",
 			   ret, port_num);
-		goto bail;
+		/*
+		 * Based on the documentation for kobject_init_and_add(), the
+		 * caller should call kobject_put even if this call fails.
+		 */
+		goto bail_sc2vl;
 	}
 	kobject_uevent(&ppd->sc2vl_kobj, KOBJ_ADD);
 
@@ -684,7 +688,7 @@ int hfi1_create_port_files(struct ib_dev
 		dd_dev_err(dd,
 			   "Skipping sl2sc sysfs info, (err %d) port %u\n",
 			   ret, port_num);
-		goto bail_sc2vl;
+		goto bail_sl2sc;
 	}
 	kobject_uevent(&ppd->sl2sc_kobj, KOBJ_ADD);
 
@@ -694,7 +698,7 @@ int hfi1_create_port_files(struct ib_dev
 		dd_dev_err(dd,
 			   "Skipping vl2mtu sysfs info, (err %d) port %u\n",
 			   ret, port_num);
-		goto bail_sl2sc;
+		goto bail_vl2mtu;
 	}
 	kobject_uevent(&ppd->vl2mtu_kobj, KOBJ_ADD);
 
@@ -704,7 +708,7 @@ int hfi1_create_port_files(struct ib_dev
 		dd_dev_err(dd,
 			   "Skipping Congestion Control sysfs info, (err %d) port %u\n",
 			   ret, port_num);
-		goto bail_vl2mtu;
+		goto bail_cc;
 	}
 
 	kobject_uevent(&ppd->pport_cc_kobj, KOBJ_ADD);
@@ -742,7 +746,6 @@ bail_sl2sc:
 	kobject_put(&ppd->sl2sc_kobj);
 bail_sc2vl:
 	kobject_put(&ppd->sc2vl_kobj);
-bail:
 	return ret;
 }
 


