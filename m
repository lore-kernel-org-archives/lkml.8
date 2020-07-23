Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CDE222CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Avs4LYyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgGWJNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:13:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726558AbgGWJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595495589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DV/00EyCP590tmCFq6jIThJcEZgsODjna9x+BTGXHYM=;
        b=Avs4LYyfxc4OS7R86rEz+rJpw6E5t0aeVRaOr3zxBhbSb2wXFPCFj62IY/QTtVOyIRnD6D
        l3FF7qox0B2O8J8Yt3bgT8lIdTkEEybhT8+HHaBzm4RnDcQlJpcRbN0SrdnIkkJhTSDZrp
        1899U0MSATmT/JvsHpwWkVZ2Hw3KPeI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-N4SglXDZNtOGwyhkG2emPw-1; Thu, 23 Jul 2020 05:13:07 -0400
X-MC-Unique: N4SglXDZNtOGwyhkG2emPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B25A6800597;
        Thu, 23 Jul 2020 09:13:06 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-141.pek2.redhat.com [10.72.13.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2658619B5;
        Thu, 23 Jul 2020 09:13:03 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 2/2] vdpa: ifcvf: free config irq in ifcvf_free_irq()
Date:   Thu, 23 Jul 2020 17:12:54 +0800
Message-Id: <20200723091254.20617-2-jasowang@redhat.com>
In-Reply-To: <20200723091254.20617-1-jasowang@redhat.com>
References: <20200723091254.20617-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't free config irq in ifcvf_free_irq() which will trigger a
BUG() in pci core since we try to free the vectors that has an
action. Fixing this by recording the config irq in ifcvf_hw structure
and free it in ifcvf_free_irq().

Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_base.h | 2 +-
 drivers/vdpa/ifcvf/ifcvf_main.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_base.h b/drivers/vdpa/ifcvf/ifcvf_base.h
index f4554412e607..29efa75cdfce 100644
--- a/drivers/vdpa/ifcvf/ifcvf_base.h
+++ b/drivers/vdpa/ifcvf/ifcvf_base.h
@@ -84,7 +84,7 @@ struct ifcvf_hw {
 	void __iomem * const *base;
 	char config_msix_name[256];
 	struct vdpa_callback config_cb;
-
+	unsigned int config_irq;
 };
 
 struct ifcvf_adapter {
diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ae7110955a44..7a6d899e541d 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -53,6 +53,7 @@ static void ifcvf_free_irq(struct ifcvf_adapter *adapter, int queues)
 	for (i = 0; i < queues; i++)
 		devm_free_irq(&pdev->dev, vf->vring[i].irq, &vf->vring[i]);
 
+	devm_free_irq(&pdev->dev, vf->config_irq, vf);
 	ifcvf_free_irq_vectors(pdev);
 }
 
@@ -72,8 +73,8 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 	snprintf(vf->config_msix_name, 256, "ifcvf[%s]-config\n",
 		 pci_name(pdev));
 	vector = 0;
-	irq = pci_irq_vector(pdev, vector);
-	ret = devm_request_irq(&pdev->dev, irq,
+	vf->config_irq = pci_irq_vector(pdev, vector);
+	ret = devm_request_irq(&pdev->dev, vf->config_irq,
 			       ifcvf_config_changed, 0,
 			       vf->config_msix_name, vf);
 	if (ret) {
-- 
2.20.1

