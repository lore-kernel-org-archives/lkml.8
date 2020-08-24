Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5BDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E730720639
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598263190;
	bh=1wL/Z6LurwxbTSysMOzB72LpziDJn+ht/d2FVBvJ8u8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wz5Piy8su3agxeAkGNske4qJowKg/iV7a4u8EJ8moulMbRuRZ83k58mI71nPX8E6+
	 bBMjvh2UsaZdYNmsNMLumd9NFtl54Xmdyz0rwGT+seRKlMIJ3NqYUcGMQMzkT2ASJq
	 o5KuNTVjf48TxUWPYgiL8RUL8y6YaRErw9TG+ZXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgHXIdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgHXIdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:33:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7DE2075B;
        Mon, 24 Aug 2020 08:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598257982;
        bh=1wL/Z6LurwxbTSysMOzB72LpziDJn+ht/d2FVBvJ8u8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYLVJ30aRY0cuPVQ8fxhkNpUcCkQnmL++ZdwEZVrVUo8kiZDNefUZM8bcWXX+mjqw
         SYzo7lQxrA+XXGF+wpcNmyPvJW9w4SbT2LU2/1m1TKoSGLzq/BMUuIUfPoAnNnIF6c
         yHMVFq2dSD0blBOftH3gXhqkTTfhkC6S5ZQPUeM8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 5.8 031/148] s390/pci: fix zpci_bus_link_virtfn()
Date:   Mon, 24 Aug 2020 10:28:49 +0200
Message-Id: <20200824082415.448863145@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Schnelle <schnelle@linux.ibm.com>

commit 3cddb79afc60bcdb5fd9dd7a1c64a8d03bdd460f upstream.

We were missing the pci_dev_put() for candidate PFs.  Furhtermore in
discussion with upstream it turns out that somewhat counterintuitively
some common code, in particular the vfio-pci driver, assumes that
pdev->is_virtfn always implies that pdev->physfn is set, i.e. that VFs
are always linked.
While POWER does seem to set pdev->is_virtfn even for unlinked functions
(see comments in arch/powerpc/kernel/eeh.c:eeh_debugfs_break_device())
for now just be safe and only set pdev->is_virtfn on linking.
Also make sure that we only search for parent PFs if the zbus is
multifunction and we thus know the devfn values supplied by firmware
come from the RID.

Fixes: e5794cf1a270 ("s390/pci: create links between PFs and VFs")
Cc: <stable@vger.kernel.org> # 5.8
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/pci/pci_bus.c |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -132,13 +132,14 @@ static int zpci_bus_link_virtfn(struct p
 {
 	int rc;
 
-	virtfn->physfn = pci_dev_get(pdev);
 	rc = pci_iov_sysfs_link(pdev, virtfn, vfid);
-	if (rc) {
-		pci_dev_put(pdev);
-		virtfn->physfn = NULL;
+	if (rc)
 		return rc;
-	}
+
+	virtfn->is_virtfn = 1;
+	virtfn->multifunction = 0;
+	virtfn->physfn = pci_dev_get(pdev);
+
 	return 0;
 }
 
@@ -151,9 +152,9 @@ static int zpci_bus_setup_virtfn(struct
 	int vfid = vfn - 1; /* Linux' vfid's start at 0 vfn at 1*/
 	int rc = 0;
 
-	virtfn->is_virtfn = 1;
-	virtfn->multifunction = 0;
-	WARN_ON(vfid < 0);
+	if (!zbus->multifunction)
+		return 0;
+
 	/* If the parent PF for the given VF is also configured in the
 	 * instance, it must be on the same zbus.
 	 * We can then identify the parent PF by checking what
@@ -165,11 +166,17 @@ static int zpci_bus_setup_virtfn(struct
 		zdev = zbus->function[i];
 		if (zdev && zdev->is_physfn) {
 			pdev = pci_get_slot(zbus->bus, zdev->devfn);
+			if (!pdev)
+				continue;
 			cand_devfn = pci_iov_virtfn_devfn(pdev, vfid);
 			if (cand_devfn == virtfn->devfn) {
 				rc = zpci_bus_link_virtfn(pdev, virtfn, vfid);
+				/* balance pci_get_slot() */
+				pci_dev_put(pdev);
 				break;
 			}
+			/* balance pci_get_slot() */
+			pci_dev_put(pdev);
 		}
 	}
 	return rc;
@@ -178,8 +185,6 @@ static int zpci_bus_setup_virtfn(struct
 static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
 		struct pci_dev *virtfn, int vfn)
 {
-	virtfn->is_virtfn = 1;
-	virtfn->multifunction = 0;
 	return 0;
 }
 #endif


