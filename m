Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93AD3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B604205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 10:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ULucfZvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgAVKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 05:46:51 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57596 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgAVKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 05:46:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00MAkjZW012249;
        Wed, 22 Jan 2020 04:46:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579690005;
        bh=7HJSXtNDKAYRkKn5yJ0sPxtMoqbSdl+L+xoDO+7GB3M=;
        h=From:To:CC:Subject:Date;
        b=ULucfZvtQKhgyJJ0MFcnEPfIUKWMg21pE7PNZmigPrhok4hgsn6+vNyrIRMVkdAtI
         S3xvbVftGl4Bzh0+Fiofc/41LDel1hIq0Y45Ga+I+++ggg1bn/T3hVnOvci/mPLBPj
         mhX+xr0+20AnvLW4G7dM2A/h1i8+kMvoyfNfrEl4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00MAkjUC072487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jan 2020 04:46:45 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 22
 Jan 2020 04:46:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 22 Jan 2020 04:46:43 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00MAkfBw082897;
        Wed, 22 Jan 2020 04:46:42 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <robh+dt@kernel.org>, <frowand.list@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mbrugger@suse.com>
Subject: [PATCH] of: irq: Export of_msi_get_domain
Date:   Wed, 22 Jan 2020 12:47:23 +0200
Message-ID: <20200122104723.16955-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Export of_mis_get_domain to enable it for users from outside.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Rob, Matthias,

I needed to resort to remove module build support for the new ringacc UDMA
drivers (now they are in next-20200122) due to the fact that of_msi_get_domain()
is not having the EXPORT_SYMBOL_GPL() which is used by both drivers.

I have found this old patch in lkml, but can not see the history of why it is
not applied.

Regards,
Peter

 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index a296eaf52a5b..73017506ef00 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -673,6 +673,7 @@ struct irq_domain *of_msi_get_domain(struct device *dev,
 
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(of_msi_get_domain);
 
 /**
  * of_msi_configure - Set the msi_domain field of a device
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

