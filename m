Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B394C76568
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0326824656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813672;
	bh=dG1J/I8WKVAUK14Lul6+PWveA9+GuP9eZlvwnpNFn9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L1XRTHrT/bnuNr+u1p8PsuOxJx22FWMIMqzqjTjyl5j2Fc0z9Gc8d0AE7BjVjdLdj
	 Gu+sNQCHYYYTXYvmBtK7xPmQE2ji1x3hKpQtZqPZf2ydw7GeGRiL5NLWy6dURsNKN7
	 vQUI6Ww4REzY3oUa73REwhx6wO65jbegdRU9UeAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgB0OIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:46294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388249AbgB0OI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:08:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A32821D7E;
        Thu, 27 Feb 2020 14:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812507;
        bh=dG1J/I8WKVAUK14Lul6+PWveA9+GuP9eZlvwnpNFn9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYFeipOa7loet1hNKl21Aucqw8LMSZ/UBIQ1VfxnvRLGKI4lZjrOGhIjOy1eJb+bg
         GDmNVQnwzmZ/ydMbYmsamFsi+Ai+PaO5x9qXMuGmMOMPNycAd8V0MH5Hm+9Lfe1sQw
         NDnOB93/qZExvm8Cx8659CLH2dOODHNrkpn9mMXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sam Bobroff <sbobroff@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.4 044/135] powerpc/eeh: Fix deadlock handling dead PHB
Date:   Thu, 27 Feb 2020 14:36:24 +0100
Message-Id: <20200227132235.604446318@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Bobroff <sbobroff@linux.ibm.com>

commit d4f194ed9eb9841a8f978710e4d24296f791a85b upstream.

Recovering a dead PHB can currently cause a deadlock as the PCI
rescan/remove lock is taken twice.

This is caused as part of an existing bug in
eeh_handle_special_event(). The pe is processed while traversing the
PHBs even though the pe is unrelated to the loop. This causes the pe
to be, incorrectly, processed more than once.

Untangling this section can move the pe processing out of the loop and
also outside the locked section, correcting both problems.

Fixes: 2e25505147b8 ("powerpc/eeh: Fix crash when edev->pdev changes")
Cc: stable@vger.kernel.org # 5.4+
Signed-off-by: Sam Bobroff <sbobroff@linux.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
Tested-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/0547e82dbf90ee0729a2979a8cac5c91665c621f.1581051445.git.sbobroff@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/eeh_driver.c |   21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -1200,6 +1200,17 @@ void eeh_handle_special_event(void)
 			eeh_pe_state_mark(pe, EEH_PE_RECOVERING);
 			eeh_handle_normal_event(pe);
 		} else {
+			eeh_for_each_pe(pe, tmp_pe)
+				eeh_pe_for_each_dev(tmp_pe, edev, tmp_edev)
+					edev->mode &= ~EEH_DEV_NO_HANDLER;
+
+			/* Notify all devices to be down */
+			eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
+			eeh_set_channel_state(pe, pci_channel_io_perm_failure);
+			eeh_pe_report(
+				"error_detected(permanent failure)", pe,
+				eeh_report_failure, NULL);
+
 			pci_lock_rescan_remove();
 			list_for_each_entry(hose, &hose_list, list_node) {
 				phb_pe = eeh_phb_pe_get(hose);
@@ -1208,16 +1219,6 @@ void eeh_handle_special_event(void)
 				    (phb_pe->state & EEH_PE_RECOVERING))
 					continue;
 
-				eeh_for_each_pe(pe, tmp_pe)
-					eeh_pe_for_each_dev(tmp_pe, edev, tmp_edev)
-						edev->mode &= ~EEH_DEV_NO_HANDLER;
-
-				/* Notify all devices to be down */
-				eeh_pe_state_clear(pe, EEH_PE_PRI_BUS, true);
-				eeh_set_channel_state(pe, pci_channel_io_perm_failure);
-				eeh_pe_report(
-					"error_detected(permanent failure)", pe,
-					eeh_report_failure, NULL);
 				bus = eeh_pe_bus_get(phb_pe);
 				if (!bus) {
 					pr_err("%s: Cannot find PCI bus for "


