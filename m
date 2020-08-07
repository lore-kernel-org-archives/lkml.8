Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6511C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70C1221E5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="Bx5jHojb";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="6CQjQGON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgHGKM6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:12:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:5056 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgHGKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:12:58 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0779vSur023725;
        Fri, 7 Aug 2020 03:12:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=yFKryULve5+jNtinVUWg1nOPY+Js3m/9FCCInR0sSi4=;
 b=Bx5jHojbChEo6a5v0iMwWrSRfLxJlAGendtKrCNyhLFJv4Pi7frrEXnJM3GAJx+QC2yh
 7GT7R7RskjNNaIx+xlxE4uFj7Hv7y50nkDz7QID3HOBOgZ3dtkFK26+hVUY1Nsk3SNya
 oo7GOvHVWE12VoCIUY5Wr+FsVu/WtpSG9GaGW8ZiCPulvBXz8OTHzmlV/nTCyRtMQod+
 2eV1/CZQT8WtxecQsf7zVY9di5nv8/EUVb13hf1LxOlu+ZgH0Nzi3L/KL8n770u4v1Dn
 Aj1a5xPArKkC+Lw2XXVPf9mdYmaiy1H1ZjGHdYwOdKduSwSjZFv17Fru1EEwEwzRbNmp Yw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com ([104.47.56.103])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0m4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 03:12:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5MTSui31yC9AAXL/QcCEcjEvCkxTXPCSAskT9da9TZ9k3g8qOyJHtuJkemSWOiv0E2wBy/1FkhIDjBwVozMyG9y/zn5uQYCKlx5Am5olj0qj+lfZYZU0VIcDVBdE6lyj/cMU4794sorbUKF3L9uuCmlzH6olGiYxJMZkIzNnNORSLYPRK6RRjTDQgz7+QXPPHdFLMdBbjQtXu945tSO8FOm13z10dYG93lK8wS92uFt6e4+lBymB1s8dyas8UGmaA7vBeFAGN4eFDRbZZJz+ER2hv+hwJLLObPGsKEWTs6m+BBHeKnyK+OBPgXK2/Ce9fyVoKx2bdBH6tS6XhHRjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKryULve5+jNtinVUWg1nOPY+Js3m/9FCCInR0sSi4=;
 b=K+d3ylrlUaO8Oh5VEOHKB43cpdfIP8z1xBdEyTv4R2RJgNQGYuunUnVGhX4IsOWaX9nnCHOWnsTR3xxvvbStDH5XctE3VcQWv7w4lXU6gPHnJEqDk5us6XlfNEsF0fKw6rpT79tcECxM1KHQuEI5lWuti4VQwV8fX3niViQAnewvRUnkhbEJ0N4ISXNgmiSkh2y2hqwaPB68y/38SsRDeHmDlmJskBO/2zFlZS5/jAOAfjGGGNpDguB9yqImPIDy/KfwgJ4W4ED+aw9pXm48XhDStfQA7eHKZQSGntW7Wqd1E+zhoUI8IQln6+2izUlZBs695n+4UCriVKajs6ZUyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKryULve5+jNtinVUWg1nOPY+Js3m/9FCCInR0sSi4=;
 b=6CQjQGON+Cp4pboAmrCezPgD1Xj0thk9dZPZ4dSe7TqpSm9T3f4XL5+sGRO1xzE2mzqohHZeNaSySlGRVL//hqaU8coWuxGZj8pcriNH7ekNohKRKQReMN3r9LdhGw9yXrLOEdyplOoktiXmp3FLTk7UIQZmT/jwCdpR4wAPfjk=
Received: from MWHPR2201CA0054.namprd22.prod.outlook.com
 (2603:10b6:301:16::28) by BY5PR07MB6609.namprd07.prod.outlook.com
 (2603:10b6:a03:1a3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Fri, 7 Aug
 2020 10:12:50 +0000
Received: from MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:16:cafe::4e) by MWHPR2201CA0054.outlook.office365.com
 (2603:10b6:301:16::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16 via Frontend
 Transport; Fri, 7 Aug 2020 10:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT051.mail.protection.outlook.com (10.13.181.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 10:12:50 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk5a021638
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 06:12:48 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 12:12:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077ACk36013379;
        Fri, 7 Aug 2020 12:12:46 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077ACkrY013378;
        Fri, 7 Aug 2020 12:12:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 0/7] PHY: Prepare Cadence Torrent PHY driver to support multilink configurations
Date:   Fri, 7 Aug 2020 12:12:38 +0200
Message-ID: <1596795165-13341-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fce8c9a1-3f2b-42c3-004d-08d83aba70d1
X-MS-TrafficTypeDiagnostic: BY5PR07MB6609:
X-Microsoft-Antispam-PRVS: <BY5PR07MB6609AAEA5A042CF0CCD550DCC5490@BY5PR07MB6609.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UIie6s17tCxHt+h82ejSYur/Z9m/YSwnIY0Q4NWdLzly7KcnmN+Wcm4SzX4WYOywUt/XSJPHAJnsv0VVVZCMoDsMifPoh58upTqAY/aNj6eucxaS+ahJyZzFWkX2giruXN3TMMZxj/viZzb4yCZKSu4qvObrPoBaThpZX5RPWvBglEomrk39+V0dPjuI6fU1Sll5Hf8Az0c+a09AjbjufFtNq57tcl4czmqBUt7c6z7Sbj5L6sC9o4Suu5t6WXwtnGAvsjuYulSVPTBXji8yp9VgeY+OzUNO7Biq2+2w1IhbEU6OxjsVAvLPrGUotvsEdv6hW26iZkL9yS0S+BVbnupIKJeRR3f0IHQq/p70XTSjnZ1/y2gQTTN6U/cAVA07DMLSWAOvUYKUhTe0qWthvSTm2cxyiG7wI3o8lDDFdGUR04I/3QNEj1xNS43uRJoRrNcJt5dML13XStNixrXPnLN3bORRA10TMZL7i9sWpzvtqUwGrfY5wCpcl8RZluMx
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(396003)(36092001)(46966005)(426003)(36756003)(966005)(36906005)(70206006)(110136005)(70586007)(81166007)(8676002)(478600001)(336012)(54906003)(82740400003)(8936002)(4326008)(42186006)(316002)(83380400001)(6666004)(26005)(82310400002)(2906002)(186003)(86362001)(356005)(2616005)(47076004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 10:12:50.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce8c9a1-3f2b-42c3-004d-08d83aba70d1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT051.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB6609
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_06:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=703 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070075
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
Existing Torrent PHY driver supports only DisplayPort. This patch series
prepares Torrent PHY driver so that different multilink configurations can
be supported. It also updates DT bindings accordingly.

Support for different multilink configurations with register sequences for
protocols above will be added in a separate patch series.

This patch series is dependent on PHY patch series [1].

[1] https://lkml.org/lkml/2020/7/17/158

Swapnil Jakhade (7):
  phy: cadence-torrent: Use of_device_get_match_data() to get driver
    data
  phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg
    addresses
  phy: cadence-torrent: Enable support for multiple subnodes
  phy: cadence-torrent: Add separate regmap functions for torrent and DP
  phy: cadence-torrent: Check total lane count for all subnodes is
    within limit
  dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
  dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for
    generic use

 .../bindings/phy/phy-cadence-torrent.yaml     |  85 +++++++---
 drivers/phy/cadence/phy-cadence-torrent.c     | 146 ++++++++++--------
 include/dt-bindings/phy/phy-cadence-torrent.h |  13 ++
 3 files changed, 164 insertions(+), 80 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

-- 
2.26.1

