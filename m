Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD33C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6B62080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="wbR1S5Lf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgGWMG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:06:57 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728147AbgGWMGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:06:53 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06NC3Ev0006535;
        Thu, 23 Jul 2020 14:06:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=8C43QyHOLftUsfDVTeWAc7KU52Huh5OjUoVIJgaRBEI=;
 b=wbR1S5LfSkgiOfYQDjKgBZC7NocJglbCA92aqaA1hQW95m3wmZt31vXECkUUOw323AYi
 v7KCfVuNp7K+NH8TCkLfSitSC3TBWrVyBluQHK4w47vslSFSgUZ5F/dKZxFZt43ebFKQ
 WHVBclgzDCoB5o7oeFQf0EJWjE7xNF/1mXdM4O6PH95fwAlm6H1JIltLjXVGOyW/osDH
 VEcH2n/XdMXgNtc75zr8cOvGmAQoOUTvt/CwXSmjg27QCEhZ7havQdFJPmVpoqJ+Pxux
 wpoJhG28C3X+6kWSA2uHsddronlihTJ61TR/7r6bJr5MGBq80GvCdW9Hqz79Z9R4tnGX 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32bsahakd2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 14:06:37 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 812FC10002A;
        Thu, 23 Jul 2020 14:06:36 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 705A42AF314;
        Thu, 23 Jul 2020 14:06:36 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE2.st.com (10.75.127.8)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 23 Jul 2020 14:06:36
 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Subject: [PATCH v2 2/6] usb: typec: add typec_find_pwr_opmode
Date:   Thu, 23 Jul 2020 14:06:20 +0200
Message-ID: <20200723120624.26291-3-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723120624.26291-1-amelie.delaunay@st.com>
References: <20200723120624.26291-1-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG3NODE1.st.com (10.75.127.7) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_05:2020-07-23,2020-07-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a function that converts power operation mode string into
power operation mode value.

It is useful to configure power operation mode through device tree
property, as power capabilities may be linked to hardware design.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
No changes in v2.
---
 drivers/usb/typec/class.c | 15 +++++++++++++++
 include/linux/usb/typec.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 02655694f200..35eec707cb51 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -1448,6 +1448,21 @@ void typec_set_pwr_opmode(struct typec_port *port,
 }
 EXPORT_SYMBOL_GPL(typec_set_pwr_opmode);
 
+/**
+ * typec_find_pwr_opmode - Get the typec power operation mode capability
+ * @name: power operation mode string
+ *
+ * This routine is used to find the typec_pwr_opmode by its string @name.
+ *
+ * Returns typec_pwr_opmode if success, otherwise negative error code.
+ */
+int typec_find_pwr_opmode(const char *name)
+{
+	return match_string(typec_pwr_opmodes,
+			    ARRAY_SIZE(typec_pwr_opmodes), name);
+}
+EXPORT_SYMBOL_GPL(typec_find_pwr_opmode);
+
 /**
  * typec_find_orientation - Convert orientation string to enum typec_orientation
  * @name: Orientation string
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 9cb1bec94b71..6be558045942 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -268,6 +268,7 @@ int typec_set_mode(struct typec_port *port, int mode);
 
 void *typec_get_drvdata(struct typec_port *port);
 
+int typec_find_pwr_opmode(const char *name);
 int typec_find_orientation(const char *name);
 int typec_find_port_power_role(const char *name);
 int typec_find_power_role(const char *name);
-- 
2.17.1

