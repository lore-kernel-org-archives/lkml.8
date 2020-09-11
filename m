Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A318C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F77D221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Fy6iD3fF";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="iKe9tTiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgIKGTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:19:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:56564 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgIKGS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:18:59 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B6CDEU022346;
        Thu, 10 Sep 2020 23:18:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=CiPwOXS1v8dFYYdNteYIQaREF/X2UjLwn7jDQRiG7Pc=;
 b=Fy6iD3fFrmVMCW9BIXBydufoWtJt+cP2J9iEvkZxBSoRnww/9xeKNV6pZwlkLyTkmb01
 2Gj1ZvTTVewNXvCL+sYpewaJPypMmZ96r38iCTo7acEx3bnNvW0jV6tVpNjwpV+MV7H6
 /UZxxxlHMVXiJ3Yl+nUbMusCUEaZoxuTpL75vbCPgzAuGodcfwj8vISpQtViLtB7CyVw
 R1cgwN3er3EiluBJa23xgqGVjrbmaVMAt9cv7/SKCN87C5sw7xXOd7LyzYaxxvAWa1Pi
 4sho3XEQs3WLmJFwGQ1fg3jHdqNzjGr4eICz/P1zoSZMqLNUOFvR76hTVNig06IJ24ys FA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2058.outbound.protection.outlook.com [104.47.36.58])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33c68wx0rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 23:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUgRa9MYGq+JYPEqNZEYH7WEnSOerKJc9a+jemAZcEYbfKK5VhclYk5XOU8yfV3EX8vw+Ymb/VclQNVdp6FB3RD0Tj0tP9YNrJKIbr6L+dIT8ovJqgC171bwS0iyQw1N36l0x5Uvtr+V76FeENg1+m1b8gxTVftEyZnNkKglJtxYnGvVv6ubWodc25BWFzaM5JD5RZNCBHqeUBjnoXNX+Z2/anvB9jTbOB/w5idcctiFPB/j+ntZeVl2w7GEHLwIWVkeGf4xmOdUAGHXy5G5ptGGQaqD0pE+ljTYXUhK/ib2C6ex30wcIcReKeLxzlNKmhCIlSOBkJ3zgWFSNItpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiPwOXS1v8dFYYdNteYIQaREF/X2UjLwn7jDQRiG7Pc=;
 b=mNtiLgt13KO8GinhMCEeYGM3h+L3XPqHprjOgnYkEbsoX0p1e8HGcTfZOV9iTyiVxHY3lU4Hb0GQbez6LpU3ASZnxDJ0MXybAOCJ0duYyIAz/MkUlJGMtAaWvkxZZ9MgVcgMRPPzoyCn+7cgI0yibuqovCJg04YBwRh/G6yUGi/onkaS+fUNWbHkVTvOd7Bnajp1hkJCbqlfixBeMsRcppI6fjlyRcFOSkqGHnGlyLTuyg4Q+s/owM8CPWppcj5mWzrXU+Q0CLXulGf2qBZlst/qBTblYMJ30kN2drzXkihPk6ACc8voN3mRs0FpCRbzuFk+PaDzk3ligu7mx0qgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CiPwOXS1v8dFYYdNteYIQaREF/X2UjLwn7jDQRiG7Pc=;
 b=iKe9tTiNZiDDp7LYcMVft0iT7wk4Z0l3P/lxA0valB1XFV6UKk+KegKj1HfjqKnq5nPU+W7YmK+eUowsLvb1E4HmWPrKTDrSwK/HyBIjkMJCSJQ092rFlC23LgCjd2v1dAi0SeKPVvxrhbDZRg+ujPN7rGlhQq7TydoUSY5oK04=
Received: from BN6PR13CA0040.namprd13.prod.outlook.com (2603:10b6:404:13e::26)
 by BYAPR07MB5943.namprd07.prod.outlook.com (2603:10b6:a03:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 06:18:43 +0000
Received: from BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::ce) by BN6PR13CA0040.outlook.office365.com
 (2603:10b6:404:13e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.5 via Frontend
 Transport; Fri, 11 Sep 2020 06:18:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT010.mail.protection.outlook.com (10.13.182.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Fri, 11 Sep 2020 06:18:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 08B6Iacn037565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 23:18:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Sep 2020 08:18:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Sep 2020 08:18:36 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08B6IZVh022128;
        Fri, 11 Sep 2020 08:18:35 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08B6IZrV022125;
        Fri, 11 Sep 2020 08:18:35 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v6 1/2] phy: Add new PHY attribute max_link_rate
Date:   Fri, 11 Sep 2020 08:18:33 +0200
Message-ID: <1599805114-22063-2-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df915740-2ca1-4868-aed9-08d8561a8771
X-MS-TrafficTypeDiagnostic: BYAPR07MB5943:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5943707F97363892C6B81967C5240@BYAPR07MB5943.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8EuC8pDONpSIYCb5umzqnJvUY3iA7Rtsa/FG+xP8RSc6EUl5ux7/ZJ8vBibi9GqfMufkI360Zvqjt3NWacNVjUiVs6vMLT6OD6Z+FbvIFQsdrcfzxDiL9sX4lI1reY2sirrjOd9jjsuD+SRSfCZ3dCxQqB9G4bPkb14v9j5s94fKo8cBarfb9t3fDVJ/76nnDzHff0lzVVgfFqQKu7UI5003fmxlTEqcyMb4JJEv532CdxtDSpPGLqLrH4q4AsDwJw3kvtJk6kQ/jFevorfApMRcjjC7m5f2qtGRzZF+IrX5+o1MYS460UT9EdSLUNwgfuQB8aHEfmyq5vrCz8YSZF4fYhWqxuAkAD0AkbRGWDUMDeXIPWhOaVsUQbXPTy1rNwjHOAYJuMN17Ck9BdQqCHcCi4NrbvUuv5B7X96krc=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36092001)(46966005)(2906002)(47076004)(42186006)(316002)(4744005)(110136005)(54906003)(356005)(70586007)(186003)(70206006)(336012)(8676002)(36756003)(5660300002)(426003)(82740400003)(478600001)(4326008)(8936002)(81166007)(86362001)(82310400003)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 06:18:41.2909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df915740-2ca1-4868-aed9-08d8561a8771
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT010.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5943
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_02:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=975 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new PHY attribute max_link_rate to struct phy_attrs. This indicates
maximum link rate supported by PHY (in Mbps).

Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/phy/phy.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bcee8eba62b3..e435bdb0bab3 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -115,10 +115,12 @@ struct phy_ops {
 /**
  * struct phy_attrs - represents phy attributes
  * @bus_width: Data path width implemented by PHY
+ * @max_link_rate: Maximum link rate supported by PHY (in Mbps)
  * @mode: PHY mode
  */
 struct phy_attrs {
 	u32			bus_width;
+	u32			max_link_rate;
 	enum phy_mode		mode;
 };
 
-- 
2.26.1

