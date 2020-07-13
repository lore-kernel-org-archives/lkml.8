Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF88EC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00F020758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="SE2Cl7BK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="KD6S/MNp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbgGMKGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 06:06:46 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40862 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729680AbgGMKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 06:06:40 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06DA2Atj014731;
        Mon, 13 Jul 2020 03:06:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TDu8WacNDgxsaO4CCdNw1INAvayJRUr/Z+FXhQ/VFtw=;
 b=SE2Cl7BK/TcSOK/GNQkh4zTJnuSx0jkH7AV2BsKdHry1Fwz4oP3jB7Oa8Vd7ITJtJ725
 33mJKE8ImRKLra42LwNRIlV5dY6DKCsuBZkGeZVdbkl3MxX5Dkh6bdE8kwJOAZZ4ch/7
 dv+ClLpG/KC9oqwbhTgphIUxoyP1phjJL2a2kTKaAQbUbF9ogkuTJYK7GlhKdd5CTr0L
 8ssG/mFaFkpqYnZi808ZhBUo/aZkD9GB3pN1WvvbR4MzWDw0H13pJZIbw3G80a8IsiOZ
 x8DXlAuxKVFC2bqCZyb55ItKuawhnjp73A04h1tF11x8sMij1Am8DVBJIo4FcHkdJf+v Mg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftugxdm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jul 2020 03:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edyeHpkL3bR5kdX30mv2X4qFG7MkIokoAQ7JmgNnfB5X68bn8X3Kd5DsFTWwdRhR+kqG29VyVwQ3reFbxMhyvZ42B7V6teJkeQ6jTHHr6DY7eqfPWJE/KoiVUZnqWCHXaSJmnkJgw+Cqd96JCDs5B6tVmPSRRMD5rql+6DTubhs0dVi6kpAD2TewjGvjqn1kPSXpomoO36BuCMy1dZNsGktQpJZdjxNEmYAppKtbhqym1+vHTicey9t7Ym5mJ+p3GHkur0di9ONe/avtHswwVvz9he0xTRDoYHCKg/iBkmJXQ9z7efOdQQLbwDTJ1ZP3UuRE4fx1JdPAwLv90mUZhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDu8WacNDgxsaO4CCdNw1INAvayJRUr/Z+FXhQ/VFtw=;
 b=YQaN4HF/Ppc16xGZsVywwxY3uAObrPxsDRgbKxQNyt4DX8plH3yUzBTj/6tvWJmwwzD5boJe3VweoNDI3ZhSK+clQYQid5YjdP5SvwhoI4SKtaQlwPhL9mo5U1OEejlEmO4R/vgJcg4rM9J0Y8ze1bVHAD1mpCjrCku/UrS1z9VxU55wLXEv0+A+lR+Nbn0WX4gaz8neNippfaHpLuRxZPZqIdwAVqs7sPTyWb6TKYQ+INZ0OiCgfRj9QkPp4Pmlh03y4JnhTQxWs+O300YZKgMX06fmuq1sUcgfZBVedXcSnGZRVuNDnPthih5/jl8mQkXpdWnrZg0L6vSFqvESmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDu8WacNDgxsaO4CCdNw1INAvayJRUr/Z+FXhQ/VFtw=;
 b=KD6S/MNpE9wuoSNZ6ar6dmwLkD91Wdw8hRqqXHMWhS9uZhUIoXBI4rm+0K44KBmJmW/MIzkypXEEN1eD/H2jgbbSD3PHlvby4QTp4dS4SaQ5ahD2a5lN0FsQF13h1TudYBfH1/Auvw2ga5XJsUmO/aw9gBPMAQb7ehG4didMDxo=
Received: from DM5PR05CA0012.namprd05.prod.outlook.com (2603:10b6:3:d4::22) by
 BYAPR07MB4759.namprd07.prod.outlook.com (2603:10b6:a02:f2::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.22; Mon, 13 Jul 2020 10:06:10 +0000
Received: from DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::6c) by DM5PR05CA0012.outlook.office365.com
 (2603:10b6:3:d4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9 via Frontend
 Transport; Mon, 13 Jul 2020 10:06:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT046.mail.protection.outlook.com (10.13.178.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Mon, 13 Jul 2020 10:06:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Yr013926
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 13 Jul 2020 06:06:08 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 13 Jul 2020 12:06:03 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 06DA63Oo028637;
        Mon, 13 Jul 2020 12:06:03 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 06DA63LA028636;
        Mon, 13 Jul 2020 12:06:03 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rogerq@ti.com>, <peter.chen@nxp.com>
CC:     <dan.carpenter@oracle.com>, <heikki.krogerus@linux.intel.com>,
        <colin.king@canonical.com>, <jpawar@cadence.com>,
        <ben.dooks@codethink.co.uk>, <kurahul@cadence.com>,
        <sparmar@cadence.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 3/9] usb: cnds3: drd: deleted !=
Date:   Mon, 13 Jul 2020 12:05:48 +0200
Message-ID: <20200713100554.28530-4-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200713100554.28530-1-pawell@cadence.com>
References: <20200713100554.28530-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(36092001)(46966005)(70586007)(110136005)(70206006)(42186006)(316002)(26005)(2906002)(36756003)(426003)(2616005)(186003)(36906005)(107886003)(6666004)(336012)(82740400003)(8936002)(5660300002)(7416002)(47076004)(356005)(83380400001)(4326008)(86362001)(81166007)(4744005)(8676002)(54906003)(478600001)(1076003)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a8e6d40-8e0e-48a7-af36-08d827145e14
X-MS-TrafficTypeDiagnostic: BYAPR07MB4759:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4759EE647A933E0F6C2EE315DD600@BYAPR07MB4759.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ojE2KTELyCcdyl8z+OroHKdtk+qrE0giolCI/DvdC3STLrstlV+dOQ2O59sW4r5gcFkAQCoAKdp/HVTRclRieHCWvZx7Hxtc/gW0ptB/0CkgCYVekNVEMxG2pZXKeLYMy8y4QdneNjy+jVh/b3Li9lcaL4woQ4ViF5LxIOCEnRGVvRu1Rn/kj/Qg1X6P8xlXV5LuaV0LmDAgKUNROOHTu1Xi/psEeu6JKzJNA3T4QR4Y4+4FpdGn6SfzGR1QyAtuCqsv2YwnXSeI5JweOoOZddL7dAqrKCbeI3/1G2yzfMSt+cjxU69EwkbltfJzTtcHZufNr9zCVuBqtmKBrNdRl0NbMCwzOm5OyQ1UzE5eVv+swoRXIGDPbrx7xOJuK7nCRChfb8vrmIfpNPkr6npzeJzjZBhME1sseRcL7tLUQFI=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 10:06:10.3458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a8e6d40-8e0e-48a7-af36-08d827145e14
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4759
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-13_07:2020-07-10,2020-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=787
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007130075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch deletes unnecessary != from condition statement in cdns3_drd_init
function.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/drd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
index 4939a568d8a2..6d2da504ad49 100644
--- a/drivers/usb/cdns3/drd.c
+++ b/drivers/usb/cdns3/drd.c
@@ -365,7 +365,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
 	}
 
 	state = readl(&cdns->otg_regs->sts);
-	if (OTGSTS_OTG_NRDY(state) != 0) {
+	if (OTGSTS_OTG_NRDY(state)) {
 		dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
 		return -ENODEV;
 	}
-- 
2.17.1

