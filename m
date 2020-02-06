Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4D6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBAF206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Xc7suWqK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AJHJ/6ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBFGLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:11:51 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:23742 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727862AbgBFGL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:11:29 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01669B67015929;
        Wed, 5 Feb 2020 22:11:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EmGoU7ZRE8EvrxN02KVFmRbGGbPSA87SXMjAVhATWH0=;
 b=Xc7suWqKmNe8JgyukDwKFVzASXpogqOHJixWrD/0l/sGtaMm7a60XtZvH9wC8tnRjTLB
 uZlsWgXtpjSlgSTKNXJxKKu/pXZa+1eSUSp4RsnoLLvlgtsjwthXrN22qxAFjArQ0s/u
 ko8KqCROk6G9/zX7C4OI04el9oV0xkZHTbMPCmlrnAUqnMGpmywYAaMIh3kQMj0nVors
 tadtKRYfydibUxsRsU0Y2e9ob7kV55JW7Fa7GTygacJDOMEJOiXFpwjou+sTB8mM2PmF
 tatGtnjCVK0cXLJT9JzyeCbJxQiI4H4/xkkBc9yVRrkhQfXD9WWyvRtKoOc7Jh5PlryM 5A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xyhkunrb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Feb 2020 22:11:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wz8LpupH9X1plEvc0SouidJ93/onkuyOzmUdim0FtF0rKpNTkEiGNxPVFj7zRYACN3dlFbYhrIx5FO5JJ2VcJn31/18E9qQvtHVSVO4PUx4MDDtHWtvNJWiXi2gWryg9C8uxxBf79KLF8fE6kRc/8dC+YJfIojfdMvZW8LHM3mYu7r9OgZ9HX/vu/Z03MlhlIMtITtj17uLvUklmhslzVzLogl1MUWKKNCrhfslw097P4FQI6n3pZrkm2wWjHzrH7HkIA3uMd2n8ov+PBZhN08uv0Z3TwpVPJ2eISm0VPu0lq27sxhG9P9516sAYz5tWKfiIMgX3lCs9PiZaSME+Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGoU7ZRE8EvrxN02KVFmRbGGbPSA87SXMjAVhATWH0=;
 b=RD0fxnDPKlbfDbKv/ibEkzrfKsyL0FNAJ/c9/3HSF0pvkM24oPL/xHqg/94OZAGUplkoW+mh90JttQmf+9ROni7IFFjgIQrJ0fQ3VR+KHOp5CGvSWK2F8kqbmJIA2Qs0Mxkv8E3sdOgKtaafjhucYxuI0OiFbXAY2k/d/RnABfFQ/ZE8JmO+LDb1wCxvYo6+dXb4iNRStACIxE0IXjKQ6esh3d+t1FviVR2YOhCbttvZrpzlWAHy3qHpqPxTaXj/Vb+TeqdF4FMoCNojSwnZ+NAue84sgqC8IPEsfE7pY8I5rhcEpBn5GsGvnHJuOtmu3aQI95lBaCMHPM6yTBttKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.243) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGoU7ZRE8EvrxN02KVFmRbGGbPSA87SXMjAVhATWH0=;
 b=AJHJ/6ZV7f56ATy967R+Pn4FBUaOsb5unAoRXjfhn/0sZjvv44d/0L9VSd5aJ3/wpgMk6vKXLg/RFaz6viLRI/Fctfbw9ecK7npXkp+SAclx6KAiEZX+1WLzcev2kdjdOXBq/umG4F4ZNU6+3TrPDHHpvdE6pOzFXkIUBXF4nDU=
Received: from DM6PR07CA0055.namprd07.prod.outlook.com (2603:10b6:5:74::32) by
 BN6PR07MB3492.namprd07.prod.outlook.com (2603:10b6:405:6c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 06:11:17 +0000
Received: from MW2NAM12FT058.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5a::202) by DM6PR07CA0055.outlook.office365.com
 (2603:10b6:5:74::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.32 via Frontend
 Transport; Thu, 6 Feb 2020 06:11:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.243 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.243; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.243) by
 MW2NAM12FT058.mail.protection.outlook.com (10.13.181.237) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.10 via Frontend Transport; Thu, 6 Feb 2020 06:11:17 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0166B5FC174490
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 5 Feb 2020 22:11:16 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 6 Feb 2020 07:11:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0166B4GA017073;
        Thu, 6 Feb 2020 07:11:04 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0166B4Or017072;
        Thu, 6 Feb 2020 07:11:04 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kishon@ti.com>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v4 12/13] phy: cadence-torrent: Add platform dependent initialization structure
Date:   Thu, 6 Feb 2020 07:11:00 +0100
Message-ID: <1580969461-16981-13-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
References: <1580969461-16981-1-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.243;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(39860400002)(396003)(199004)(36092001)(189003)(86362001)(81156014)(2906002)(8676002)(36906005)(2616005)(81166006)(8936002)(107886003)(110136005)(26005)(54906003)(316002)(42186006)(36756003)(5660300002)(426003)(6666004)(4326008)(336012)(186003)(356004)(478600001)(70206006)(70586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR07MB3492;H:wcmailrelayl01.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:unused.mynethost.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaed9f7d-8db0-499e-a841-08d7aacb6097
X-MS-TrafficTypeDiagnostic: BN6PR07MB3492:
X-Microsoft-Antispam-PRVS: <BN6PR07MB3492219797553DC5D1AB4A9ED21D0@BN6PR07MB3492.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-Forefront-PRVS: 0305463112
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rH0oMCSWLMT/NCQwc/61oQtWP8BC6jah5IyK1BzRv0rZ+MtOR2RJukWJJBVS3OIIa0RQucMzG5y81qT/GX1oH07z7pq57XRj485RxC+iJLw90fb7wqf8RF8/Jpj7nydjd9Xqxj0YRBHhd62xz5g0MI5NTPYDdvQezhedovHWYNxIsWmhmhDm5N9UE7AGEV3Bp2pXyulXPL04we42rm3sxTm2/PGYJhmIdwfn7KSSTBU9piguj+OsdlEM9M9aHpMDS9KfZAnUNyjkwS+NFI6UmSOP24exGYKL+JTcA7TjhfTcAU/jC2bn1s1zxCYnJl12+rZMpGduA/N4kPDThP2XgdgVsaCW1u6CvTPOagd/yMz61jaGOhIrNLgrkPTMIq91RMw+7y1CWUlif/KcJQJ55AXJwL6PEAB5psRqyo5QdOZWaTSz/ZKmW1E4pXXbOSb9hGmA/hdlud2vJdQGIlQIkEO2xwKI+XXRvQFAA46Bvo8HvnceC3rvpsmaTIaODZYz
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 06:11:17.1289
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaed9f7d-8db0-499e-a841-08d7aacb6097
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.243];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB3492
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-05_06:2020-02-04,2020-02-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002060048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Swapnil Jakhade <sjakhade@cadence.com>

Add platform dependent initialization data for Torrent PHY used in TI's
J721E SoC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 0e03d3cb4c23..851a68590788 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1770,11 +1770,20 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 	.reg_offset_shift = 0x2,
 };
 
+static const struct cdns_torrent_data ti_j721e_map_torrent = {
+	.block_offset_shift = 0x0,
+	.reg_offset_shift = 0x1,
+};
+
 static const struct of_device_id cdns_torrent_phy_of_match[] = {
 	{
 		.compatible = "cdns,torrent-phy",
 		.data = &cdns_map_torrent,
 	},
+	{
+		.compatible = "ti,j721e-serdes-10g",
+		.data = &ti_j721e_map_torrent,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, cdns_torrent_phy_of_match);
-- 
2.20.1

