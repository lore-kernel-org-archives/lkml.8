Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7C8C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 948B92145D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623459;
	bh=5YR9ksqER1KCDt9BykW9hjKGBocOSqjPVyAq4fRMxcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vAd0AFz3yAjc/2DBoofMPG6nz6FEv14wsgpz2CoxsMjxYkjmQrH5W57ktJBXASu+J
	 cdTX+Ezp5M9iAMFJGlOOIue/wPqY5phzFjNjG78jHaLPvroeAq44Yl7izZofX0Muxh
	 pUT+tBsslo3zV+kGD78E359dvAMMvZ7hgoFUqOIg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgCSNK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgCSNKz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:10:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21CAE208D6;
        Thu, 19 Mar 2020 13:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623454;
        bh=5YR9ksqER1KCDt9BykW9hjKGBocOSqjPVyAq4fRMxcY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TJHpbdooeyajE6qic38YesyRU2uhHL4D+U/OwO71zL9ErMkwd6JOthy2aUmjXkQml
         HClbqQxnVEzto3P60XbCkoSGtpv2O7YnMsOPoRMiinKhWOPG7PhjOhgeAPl6xYRSs6
         WaksuAREgJva1UyiD2aSdfxg6lDDBPlopuAK629o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.9 32/90] iommu/vt-d: quirk_ioat_snb_local_iommu: replace WARN_TAINT with pr_warn + add_taint
Date:   Thu, 19 Mar 2020 13:59:54 +0100
Message-Id: <20200319123938.499755537@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 81ee85d0462410de8eeeec1b9761941fd6ed8c7b upstream.

Quoting from the comment describing the WARN functions in
include/asm-generic/bug.h:

 * WARN(), WARN_ON(), WARN_ON_ONCE, and so on can be used to report
 * significant kernel issues that need prompt attention if they should ever
 * appear at runtime.
 *
 * Do not use these macros when checking for invalid external inputs

The (buggy) firmware tables which the dmar code was calling WARN_TAINT
for really are invalid external inputs. They are not under the kernel's
control and the issues in them cannot be fixed by a kernel update.
So logging a backtrace, which invites bug reports to be filed about this,
is not helpful.

Fixes: 556ab45f9a77 ("ioat2: catch and recover from broken vtd configurations v6")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20200309182510.373875-1-hdegoede@redhat.com
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=701847
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/intel-iommu.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -4085,10 +4085,11 @@ static void quirk_ioat_snb_local_iommu(s
 
 	/* we know that the this iommu should be at offset 0xa000 from vtbar */
 	drhd = dmar_find_matched_drhd_unit(pdev);
-	if (WARN_TAINT_ONCE(!drhd || drhd->reg_base_addr - vtbar != 0xa000,
-			    TAINT_FIRMWARE_WORKAROUND,
-			    "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n"))
+	if (!drhd || drhd->reg_base_addr - vtbar != 0xa000) {
+		pr_warn_once(FW_BUG "BIOS assigned incorrect VT-d unit for Intel(R) QuickData Technology device\n");
+		add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 		pdev->dev.archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;
+	}
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT_SNB, quirk_ioat_snb_local_iommu);
 


