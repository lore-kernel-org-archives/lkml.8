Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA54720702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945661;
	bh=wicaoCAJNuk7XntjN2HU1xs0spmHSn5Q2EMQqELHpJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kW7Sr/r20FFagNkUicQ/bWcOGf6yGR3nyU4yB+B/OzrhOPXKM+Qx+aLSQ7QYY9lI6
	 ao2qcgcbATZtf3JduVQuGlHSUpHBgBFeTItISKoorBlbmOtB5H88GhXvYBNYq6L/QX
	 yBITtz8Y881GN/S1VW3tqJzrDWNW5JPt8uLXSGCU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392794AbgFWUqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:46:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392786AbgFWUpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:45:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A851620656;
        Tue, 23 Jun 2020 20:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945155;
        bh=wicaoCAJNuk7XntjN2HU1xs0spmHSn5Q2EMQqELHpJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qo87JOGE2/PPOX5IgETZs72tWFlAhpGFJHxMrRhyo/tQzxLcHq5ti2j9JFnlZWZ6k
         1CHqec7lAYmYYFiWNyNJRMBlvnVIj3J97+f2cqClArfYSd6W6s+pmwfOJ2xU+ICn9B
         Gy09AmYmTQrzNaAKvAG/jMGtNSLPPx1GrsmJ+ctA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 060/136] vfio-pci: Mask cap zero
Date:   Tue, 23 Jun 2020 21:58:36 +0200
Message-Id: <20200623195306.701731577@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit bc138db1b96264b9c1779cf18d5a3b186aa90066 ]

The PCI Code and ID Assignment Specification changed capability ID 0
from reserved to a NULL capability in the v1.1 revision.  The NULL
capability is defined to include only the 16-bit capability header,
ie. only the ID and next pointer.  Unfortunately vfio-pci creates a
map of config space, where ID 0 is used to reserve the standard type
0 header.  Finding an actual capability with this ID therefore results
in a bogus range marked in that map and conflicts with subsequent
capabilities.  As this seems to be a dummy capability anyway and we
already support dropping capabilities, let's hide this one rather than
delving into the potentially subtle dependencies within our map.

Seen on an NVIDIA Tesla T4.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vfio/pci/vfio_pci_config.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index c2d300bc37f64..36bc8f104e42e 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -1464,7 +1464,12 @@ static int vfio_cap_init(struct vfio_pci_device *vdev)
 		if (ret)
 			return ret;
 
-		if (cap <= PCI_CAP_ID_MAX) {
+		/*
+		 * ID 0 is a NULL capability, conflicting with our fake
+		 * PCI_CAP_ID_BASIC.  As it has no content, consider it
+		 * hidden for now.
+		 */
+		if (cap && cap <= PCI_CAP_ID_MAX) {
 			len = pci_cap_length[cap];
 			if (len == 0xFF) { /* Variable length */
 				len = vfio_cap_len(vdev, cap, pos);
-- 
2.25.1



