Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77803C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 512D2214D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257810;
	bh=eXH0Lw7R8lry8SxdwB/97tWAq5fyMwwcouwvVe2oLZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mzw4TSxDpekZltYfhB2x4g1760zRsdPGUTX8IZDxOow+ecRnC0q7Ow05W5nmAlmP5
	 pa4wg4YhC81qxdPpENihTALtthpQcayTYZ7uw1np58ZlqTkiqQXZ+bdZWWr/WhjVLR
	 8K5m9NAPOIwF30e+QAMxkVcpiXx5B7aRpMFnhOEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgCCRuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:50:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbgCCRt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:49:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7118020CC7;
        Tue,  3 Mar 2020 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257796;
        bh=eXH0Lw7R8lry8SxdwB/97tWAq5fyMwwcouwvVe2oLZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAvHgYcbjQ0rCEjD+eIBytN1qTE9urDF3A/sNAOjZ4xQlM73xdiJZ4z3Lc0UgJ9Kz
         8pIxUzr7TKIkmbU/k/64LOX1DCPFn+G5bIiZ310NiPi2mxnLp8W8K4LBqnAc6NoNAE
         iW3tLQM1++E0C+sGfFEJv6wdiUO0RaIfznTBnTok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Belous <pbelous@marvell.com>,
        Nikita Danilov <ndanilov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Dmitry Bogdanov <dbogdanov@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 131/176] net: atlantic: possible fault in transition to hibernation
Date:   Tue,  3 Mar 2020 18:43:15 +0100
Message-Id: <20200303174319.884935076@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Belous <pbelous@marvell.com>

commit 52a22f4d6ff95e8bdca557765c04893eb5dd83fd upstream.

during hibernation freeze, aq_nic_stop could be invoked
on a stopped device. That may cause panic on access to
not yet allocated vector/ring structures.

Add a check to stop device if it is not yet stopped.

Similiarly after freeze in hibernation thaw, aq_nic_start
could be invoked on a not initialized net device.
Result will be the same.

Add a check to start device if it is initialized.
In our case, this is the same as started.

Fixes: 8aaa112a57c1 ("net: atlantic: refactoring pm logic")
Signed-off-by: Pavel Belous <pbelous@marvell.com>
Signed-off-by: Nikita Danilov <ndanilov@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -359,7 +359,8 @@ static int aq_suspend_common(struct devi
 	netif_device_detach(nic->ndev);
 	netif_tx_stop_all_queues(nic->ndev);
 
-	aq_nic_stop(nic);
+	if (netif_running(nic->ndev))
+		aq_nic_stop(nic);
 
 	if (deep) {
 		aq_nic_deinit(nic, !nic->aq_hw->aq_nic_cfg->wol);
@@ -375,7 +376,7 @@ static int atl_resume_common(struct devi
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct aq_nic_s *nic;
-	int ret;
+	int ret = 0;
 
 	nic = pci_get_drvdata(pdev);
 
@@ -390,9 +391,11 @@ static int atl_resume_common(struct devi
 			goto err_exit;
 	}
 
-	ret = aq_nic_start(nic);
-	if (ret)
-		goto err_exit;
+	if (netif_running(nic->ndev)) {
+		ret = aq_nic_start(nic);
+		if (ret)
+			goto err_exit;
+	}
 
 	netif_device_attach(nic->ndev);
 	netif_tx_start_all_queues(nic->ndev);


