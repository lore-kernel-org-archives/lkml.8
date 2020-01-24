Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A9AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC4F20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865013;
	bh=M52LSmbwEf6E1f7MLtsXshZzO/h73dEq7sLvHij0OIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g0vtqNRy+ZINjrAne/usGXIdDj0SbtQ+HtZJqjdH1SS/HnLG18ZaZQ39KMqGAh3qL
	 oIK7AW9/I6Rjyq9IxqCW4c0uvG4edUYUBxmJ61ju9EStpZqjIyIt/Z3HiXhhS/zRYs
	 GR0Q25pFzNj1c2eplLo+Uz84Wr2cw1jULShlP0jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391337AbgAXLXb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:23:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:36056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390981AbgAXLX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:23:29 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 007A221569;
        Fri, 24 Jan 2020 11:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865008;
        bh=M52LSmbwEf6E1f7MLtsXshZzO/h73dEq7sLvHij0OIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KCo+Y1hJUvFXdBKPv/IRq6orPpNT8Neb1g5W9qkghEwRcQHMwtyTht4IWVEEyTn2h
         uDiTVRokhtfzICV/lUw2s0+n7MIme21Ig+0f4tVzJvpViOV5BHxPbodb2UqwFCpoA9
         fZipZ33gZV+t60tGkklNDgZeDgG89ohIenPwU0Bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 427/639] PCI: PM: Skip devices in D0 for suspend-to-idle
Date:   Fri, 24 Jan 2020 10:29:57 +0100
Message-Id: <20200124093140.491024133@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

[ Upstream commit 3e26c5feed2add218046ecf91bab3cfa9bf762a6 ]

Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
attempted to avoid a problem with devices whose drivers want them to
stay in D0 over suspend-to-idle and resume, but it did not go as far
as it should with that.

Namely, first of all, the power state of a PCI bridge with a
downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
transactions on its secondary bus), but that is not actively enforced
during system-wide PM transitions, so use the skip_bus_pm flag
introduced by commit d491f2b75237 for that.

Second, the configuration of devices left in D0 (whatever the reason)
during suspend-to-idle need not be changed and attempting to put them
into D0 again by force is pointless, so explicitly avoid doing that.

Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-driver.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 5c9873fcbd08b..e69af9b8361dc 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -526,7 +526,6 @@ static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 	pci_power_up(pci_dev);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
-	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 }
 
 /*
@@ -833,18 +832,16 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (pci_dev->skip_bus_pm) {
 		/*
-		 * The function is running for the second time in a row without
+		 * Either the device is a bridge with a child in D0 below it, or
+		 * the function is running for the second time in a row without
 		 * going through full resume, which is possible only during
-		 * suspend-to-idle in a spurious wakeup case.  Moreover, the
-		 * device was originally left in D0, so its power state should
-		 * not be changed here and the device register values saved
-		 * originally should be restored on resume again.
+		 * suspend-to-idle in a spurious wakeup case.  The device should
+		 * be in D0 at this point, but if it is a bridge, it may be
+		 * necessary to save its state.
 		 */
-		pci_dev->state_saved = true;
-	} else if (pci_dev->state_saved) {
-		if (pci_dev->current_state == PCI_D0)
-			pci_dev->skip_bus_pm = true;
-	} else {
+		if (!pci_dev->state_saved)
+			pci_save_state(pci_dev);
+	} else if (!pci_dev->state_saved) {
 		pci_save_state(pci_dev);
 		if (pci_power_manageable(pci_dev))
 			pci_prepare_to_sleep(pci_dev);
@@ -853,6 +850,22 @@ static int pci_pm_suspend_noirq(struct device *dev)
 	dev_dbg(dev, "PCI PM: Suspend power state: %s\n",
 		pci_power_name(pci_dev->current_state));
 
+	if (pci_dev->current_state == PCI_D0) {
+		pci_dev->skip_bus_pm = true;
+		/*
+		 * Per PCI PM r1.2, table 6-1, a bridge must be in D0 if any
+		 * downstream device is in D0, so avoid changing the power state
+		 * of the parent bridge by setting the skip_bus_pm flag for it.
+		 */
+		if (pci_dev->bus->self)
+			pci_dev->bus->self->skip_bus_pm = true;
+	}
+
+	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
+		dev_dbg(dev, "PCI PM: Skipped\n");
+		goto Fixup;
+	}
+
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
@@ -900,7 +913,16 @@ static int pci_pm_resume_noirq(struct device *dev)
 	if (dev_pm_smart_suspend_and_suspended(dev))
 		pm_runtime_set_active(dev);
 
-	pci_pm_default_resume_early(pci_dev);
+	/*
+	 * In the suspend-to-idle case, devices left in D0 during suspend will
+	 * stay in D0, so it is not necessary to restore or update their
+	 * configuration here and attempting to put them into D0 again may
+	 * confuse some firmware, so avoid doing that.
+	 */
+	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
+		pci_pm_default_resume_early(pci_dev);
+
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
@@ -1201,6 +1223,7 @@ static int pci_pm_restore_noirq(struct device *dev)
 	}
 
 	pci_pm_default_resume_early(pci_dev);
+	pci_fixup_device(pci_fixup_resume_early, pci_dev);
 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_resume_early(dev);
-- 
2.20.1



