Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668B2C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35AD0246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 21:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rz8PdD9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgB1V2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 16:28:09 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:50014 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1V2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 16:28:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SLMsPf005552
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : content-type :
 content-transfer-encoding : mime-version : date : subject : message-id :
 to; s=corp-2020-01-29; bh=oImuifTpYNk8lG3PdcuMkS3w5Vx5Llw/cJtUmARLtAc=;
 b=Rz8PdD9j0DsYsMyIjUvDyqES5Me1RIeosS+GWH1KzJQDRZ9I5hmDwSWbi5iYq+iqq2rh
 ASCp3BB8zjsu7I7j99dTuhVcfLTaK/qjiahAHEOtQdkqmK4BhUbCYZexWgpQoSGohKNI
 IaH/Vl0RsXHirW13U5OYLIrvdOYLFW5FNaKRzeswTwNHqeD/sqEIArYgxN6fJc0G3M59
 L8I+OR9z4x7IH8AyrBXA7INbPfqqYY3lr5Rzy381PDpNDk8j6uJMYg1uGO3t3LoMR4hB
 4hW+k2Srh4PFSFdJtsI/n4BVE5/HhWobchYD4jYJXcwbsMRvJwqGPYq92cozpFG95j/5 9A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2ydct3nc9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:28:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01SLGlkk115071
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:28:07 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2ydcsg7arm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:28:07 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01SLS6s6026950
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 21:28:06 GMT
Received: from dhcp-10-154-108-96.vpn.oracle.com (/10.154.108.96)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Feb 2020 13:28:05 -0800
From:   John Donnelly <john.p.donnelly@oracle.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Date:   Fri, 28 Feb 2020 15:28:04 -0600
Subject: [PATCH v2 ] ipmi_si: Fix false error about IRQ registration
Message-Id: <95A6B0CD-9C09-4165-AF60-A2789C53E926@oracle.com>
To:     linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=5 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280150
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9545 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=5 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7723f4c5ecdb ("driver core: platform: Add an error message
to platform_get_irq()"), platform_get_irq() will call dev_err() on an
error,  even though the IRQ usage in the ipmi_si driver is optional.

Use the platform_get_irq_optional() call to avoid the message from
alerting users with false alarms.

cc: stable@vger.kernel.org # 5.4.x

Signed-off-by: John Donnelly <john.p.donnelly@oracle.com>
---
 drivers/char/ipmi/ipmi_si_platform.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_si_platform.c =
b/drivers/char/ipmi/ipmi_si_platform.c
index c78127ccbc0d..638c693e17ad 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -194,7 +194,7 @@ static int platform_ipmi_probe(struct =
platform_device *pdev)
 	else
 		io.slave_addr =3D slave_addr;
=20
-	io.irq =3D platform_get_irq(pdev, 0);
+	io.irq =3D platform_get_irq_optional(pdev, 0);
 	if (io.irq > 0)
 		io.irq_setup =3D ipmi_std_irq_setup;
 	else
@@ -378,7 +378,7 @@ static int acpi_ipmi_probe(struct platform_device =
*pdev)
 		io.irq =3D tmp;
 		io.irq_setup =3D acpi_gpe_irq_setup;
 	} else {
-		int irq =3D platform_get_irq(pdev, 0);
+		int irq =3D platform_get_irq_optional(pdev, 0);
=20
 		if (irq > 0) {
 			io.irq =3D irq;
--=20
2.20.1

