Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF22C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177CB24672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 11:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="b7U4dGqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbgANLVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:21:25 -0500
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:58410 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbgANLVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 06:21:23 -0500
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EBKOEY020023;
        Tue, 14 Jan 2020 06:20:34 -0500
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0b-00128a01.pphosted.com with ESMTP id 2xfbvb7cg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 06:20:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ULIF6rgXZ5cYoxn+rM7z1+hgw0MSAbGmu+O/pNGtfvfQ4DzFooXKnHVvqbRUKstuIXCtKEbmDEft8EUYhQV2hEeMCjYcZoMMwok3HEF/jnJQN8stNBk3fk0uUI5Hlf1xaHMkARgOigCZFInvp0Nz6mHBQHkJ/pkwFE2PTO4uvtN6VIETbjK8S17azvQ6wrFce6wFxUYZ1VFhwaTMZexXHvm1CkM7XuQnuQ6lG8Qa+ZSG0D0Pl6ldP+xel5cHR5XLyZTIoWNsp9uOrEA7+AHWkiYmGbQzAj7X42FAaWBDwgXO+Rb4CY8HWpxY91FinUU0ceNdiA36yTQw5GjeeHIeUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lkDrglQDq4DZ3v+4XrZM8Gv+2b+I/k5mQsIIR3j7zw=;
 b=AiJQaguStJ6eF6qw+31+opyPh68X46KE+bXnsLem9BkkgCdUocEtmSvF9IhSZi8f8HhpHaTLwEB+G+8AwdpJvZ0gSOm5y2nrX4+lGD8ykwRZBvtGrqSPZdPeztoJ9VGThFR7/Fl51NV/G4BkhjOjclSqFFNVzlVO5qrrNbzhWPi4X0NBnMlVNQxCzM1mkB4tfKP/JatkpxsNr/SXBDZKJzev5aHO8AMH5DwTwpboCDLC4vcT5hywgJbxM2Jm2yFffG3irQlawAaldFKUGPIwlEahR/pV+GkM+ecub56SCSh/x9A9H2n19teOLC4du2cCafXP9285lF9+QpA89EuARA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 137.71.25.57) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=analog.com;
 dmarc=bestguesspass action=none header.from=analog.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lkDrglQDq4DZ3v+4XrZM8Gv+2b+I/k5mQsIIR3j7zw=;
 b=b7U4dGqXmcG/tZNLLUCCNzuhLghzaIeVOVL2cQh+4JfntYOghOvxNNIPGbUe4neeMceNACichMf+0TWfeT3yg6ZqK2tkZDpO0a2llzaVew+kEUuow8pajKMLJeP900sgXuwLDhJhTvCWVuCJpRuCN0M+OJU+Y9aun8iovJWSL6o=
Received: from CH2PR03CA0004.namprd03.prod.outlook.com (2603:10b6:610:59::14)
 by DM6PR03MB4682.namprd03.prod.outlook.com (2603:10b6:5:15f::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13; Tue, 14 Jan
 2020 11:20:33 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::201) by CH2PR03CA0004.outlook.office365.com
 (2603:10b6:610:59::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 14 Jan 2020 11:20:33 +0000
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta2.analog.com;
Received: from nwd2mta2.analog.com (137.71.25.57) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2623.9
 via Frontend Transport; Tue, 14 Jan 2020 11:20:32 +0000
Received: from ASHBMBX8.ad.analog.com (ashbmbx8.ad.analog.com [10.64.17.5])
        by nwd2mta2.analog.com (8.13.8/8.13.8) with ESMTP id 00EBKW7K007127
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 14 Jan 2020 03:20:32 -0800
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 14 Jan
 2020 06:20:31 -0500
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 14 Jan 2020 06:20:31 -0500
Received: from ben-Latitude-E6540.ad.analog.com ([10.48.65.231])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 00EBKJnM022085;
        Tue, 14 Jan 2020 06:20:28 -0500
From:   Beniamin Bia <beniamin.bia@analog.com>
To:     <linux-hwmon@vger.kernel.org>
CC:     <Michael.Hennerich@analog.com>, <linux-kernel@vger.kernel.org>,
        <jdelvare@suse.com>, <linux@roeck-us.net>, <mark.rutland@arm.com>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>, <biabeniamin@outlook.com>,
        Beniamin Bia <beniamin.bia@analog.com>
Subject: [PATCH v4 3/3] MAINTAINERS: add entry for ADM1177 driver
Date:   Tue, 14 Jan 2020 13:21:59 +0200
Message-ID: <20200114112159.25998-3-beniamin.bia@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200114112159.25998-1-beniamin.bia@analog.com>
References: <20200114112159.25998-1-beniamin.bia@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(376002)(189003)(199004)(36756003)(6916009)(2616005)(7636002)(2906002)(246002)(336012)(478600001)(26005)(8676002)(44832011)(966005)(70586007)(70206006)(4326008)(426003)(4744005)(1076003)(86362001)(7696005)(107886003)(8936002)(186003)(5660300002)(316002)(54906003)(356004)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR03MB4682;H:nwd2mta2.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac529bf5-7761-4db3-3ba4-08d798e3c539
X-MS-TrafficTypeDiagnostic: DM6PR03MB4682:
X-Microsoft-Antispam-PRVS: <DM6PR03MB46821E4939E8C751C28B6FD2F0340@DM6PR03MB4682.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-Forefront-PRVS: 028256169F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rfaPcitBn6CjnmmRqivbW1bCYIwR6TqbZJzk0IjqEAYaLOyRTaXlqOtqG0i7AEvWaccuQtPw54MjnD1luYRLqihK/JoxEDZbX+rq8I0jM1tD1RRY1NiKRitqJhro80j+899eDjEdPtqcAyuB+pRXTO/ass2umjmeyJ2ehs46X1Y/UVLyGBohaE66PUl18tISYNX3/f5KvBAESUXXfPutU6ITqgTsb7w3nPyBMRxnCpTmUP0C5+8TOxzWcW9nRXOtF1GcNrTkywjnksg5wWxsif1bC+gmLAr7MpM/33c8TpSRq7Mf2B6HUzsKv7ivXHvMijBguJtAkTykzfAQmCVJW8vDiGpbE9JpRVCQJovdgq09mlZFBiud+aakqauCuMS5uywWhGSgjr+o2Rko2uz1bS6x5Ikg5FMI5xfhjbaQbLgF8QU7B0o3B8w5tTC1tWXfU+7AYKSRumSZDFRMFWevUBHHQezo58wfv2LrZrbl0xr4hjed/ihwwNGqHs8l7vm+Cbr707gemu8DSDtorHIQg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2020 11:20:32.9594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac529bf5-7761-4db3-3ba4-08d798e3c539
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta2.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4682
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_03:2020-01-13,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001140101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Beniamin Bia and Michael Hennerich as a maintainer for ADM1177 ADC.

Signed-off-by: Beniamin Bia <beniamin.bia@analog.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Changes in v4:
-nothing changed 

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd5847e802de..a71f56d3b891 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -975,6 +975,15 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	drivers/iio/imu/adis16460.c
 F:	Documentation/devicetree/bindings/iio/imu/adi,adis16460.yaml
 
+ANALOG DEVICES INC ADM1177 DRIVER
+M:	Beniamin Bia <beniamin.bia@analog.com>
+M:	Michael Hennerich <Michael.Hennerich@analog.com>
+L:	linux-hwmon@vger.kernel.org
+W:	http://ez.analog.com/community/linux-device-drivers
+S:	Supported
+F:	drivers/hwmon/adm1177.c
+F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Stefan Popa <stefan.popa@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.17.1

