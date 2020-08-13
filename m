Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D505C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361DC206B2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ObWFK6Bt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgHMTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:05:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46012 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726174AbgHMTF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:05:26 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DJ5OMp013355
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:05:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=GNih2j3ESRfeoRwPAnR3qqb1b7HSoqwKZbqqay1L3wk=;
 b=ObWFK6Bt4aH+67+3l0KseY92Gs3MZMoiEMruq5dxbtMCBFFDbqXMTN8P/njQq8sysfhe
 YRHTyOyUP/psFw3/xcmOq6ItEh2QqzBlT5tGSm54IYfJ7ArHVL/vi1ZcTGAbDAqzdlWl
 8H46mPuISzUw5RDpbUdTibBTpe2RotIGGys= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32w2yejj73-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 12:05:25 -0700
Received: from intmgw004.06.prn3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 13 Aug 2020 12:04:46 -0700
Received: by devvm4117.prn2.facebook.com (Postfix, from userid 167582)
        id 0844D4EFB4C25; Thu, 13 Aug 2020 12:04:39 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Vijay Khemka <vijaykhemka@fb.com>
Smtp-Origin-Hostname: devvm4117.prn2.facebook.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <vijaykhemka@fb.com>, Sai Dasari <sdasari@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH] ARM: dts: aspeed: tiogapass: Remove vuart
Date:   Thu, 13 Aug 2020 12:04:30 -0700
Message-ID: <20200813190431.3331026-1-vijaykhemka@fb.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_16:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxscore=0 mlxlogscore=718 spamscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008130134
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed vuart for facebook tiogapass platform as it uses uart2 and
uart3 pin with aspeed uart routing feature.

Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/a=
rm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 2d44d9ad4e40..e6ad821a8635 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -82,11 +82,6 @@ &lpc_ctrl {
 	status =3D "okay";
 };
=20
-&vuart {
-	// VUART Host Console
-	status =3D "okay";
-};
-
 &uart1 {
 	// Host Console
 	status =3D "okay";
--=20
2.24.1

