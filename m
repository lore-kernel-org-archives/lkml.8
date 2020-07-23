Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE13BC433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB0A822CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmQUEr4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgGWJNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:13:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20997 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725984AbgGWJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595495589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RSy4LtbaD8levFOBIayUOWSmIYzMSd7fCPXVTaSTU+s=;
        b=GmQUEr4+dQja6pz2mgqL8Ngh079n357xDRIRI2dIEeP8aysYjaMcZDQ093LOyPeL9ur5w9
        eNd4DErXvaj4qua6MQI4xKrO7aViGQLUl5H7dJ06i1CkjAkjrxAc4XgTTWW/kOavIKBBan
        mONcz9PQUaOk+93Xppx3ucVn9sYfzWM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-2gLebz6nP6-9gOiGYakW6w-1; Thu, 23 Jul 2020 05:13:04 -0400
X-MC-Unique: 2gLebz6nP6-9gOiGYakW6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6809691271;
        Thu, 23 Jul 2020 09:13:03 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-141.pek2.redhat.com [10.72.13.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D44870596;
        Thu, 23 Jul 2020 09:12:58 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH 1/2] vdpa: ifcvf: return err when fail to request config irq
Date:   Thu, 23 Jul 2020 17:12:53 +0800
Message-Id: <20200723091254.20617-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We ignore the err of requesting config interrupt, fix this.

Fixes: e7991f376a4d ("ifcvf: implement config interrupt in IFCVF")
Cc: Zhu Lingshan <lingshan.zhu@intel.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index f5a60c14b979..ae7110955a44 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -76,6 +76,10 @@ static int ifcvf_request_irq(struct ifcvf_adapter *adapter)
 	ret = devm_request_irq(&pdev->dev, irq,
 			       ifcvf_config_changed, 0,
 			       vf->config_msix_name, vf);
+	if (ret) {
+		IFCVF_ERR(pdev, "Failed to request config irq\n");
+		return ret;
+	}
 
 	for (i = 0; i < IFCVF_MAX_QUEUE_PAIRS * 2; i++) {
 		snprintf(vf->vring[i].msix_name, 256, "ifcvf[%s]-%d\n",
-- 
2.20.1

