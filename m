Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D27C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9E6922CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="XsruPRkm";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="YysEtGd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHGLqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:48 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15820 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728269AbgHGLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhS1m011307;
        Fri, 7 Aug 2020 04:46:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=GLU49mv6ygpOZj+96HgufVlUa7IQf6II1Nx7+47hFwY=;
 b=XsruPRkmM98oiHB1hP8rm0NUWxCPqxZecbeNKtI1j4QC+zY10mCB5nPZuxhHswHqk3EY
 zHi8zJK0aPuXrKTv4BEBy1ds3op4tAcyfhmjCK6zW42d2FdrIx0HYsiQYSACfz3nuYBw
 VCvZaol33CHWp/ojOtpDZrCgM7iTt4N5VSZWN/9ndWu/ZKl15eceb55FdJsQmp50iWlP
 ieC5H5+xDmCahsvwc2Hx5ohiBGwLZ+4L1J7UZz6TZXfGmzW0WrptgRVK+fBseSMqHeL0
 N64sj6RX3Xc0YcaZerNHuVxPed/ECEg86wWKK0ikjkrP3Nss0q0jXQI2IyU/x4ndJA1O lw== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YemWZr7ysntOdTI+jBPaDQSrRECg9xq5rb33Z1NwKB9iEjhKUD4TWZJ+TBseUMvLHpMUFadi3iy/mCwjXNMU65PMXOWInq0G7EwKqzGnZLGFO3tEKVgmlyjVEFhZP7y9mw0vt9P4pH9iPvtHEyuo6EFbjhmf794vTImTLJNSrWExiY7t8xTWACGLMVPcS/1IwbF3h/Te7IxtJ0XJcaW3avYlRWq18FPSM/9X/D//esU4Nh6aEoDV320dBSTYvA2Rd8QXdmwsXYF8PAPSzjlsGJukzZRe8XlIGSJ6rnraULXM4/SVp8vPfjvSsG02DG/Tcz5X69Di+35+j3Owgnjesw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLU49mv6ygpOZj+96HgufVlUa7IQf6II1Nx7+47hFwY=;
 b=Sw03duhZ49b3hsmr2P1c3q0RWpKN/d4sPJ2JofAXMK4ejnogK589AwiTdmfXkLxUFpyv95Lv64lCFSeLQKURexi6eiZ10B+vwQ5hKYZtUWAww75/kOQaYGUki0XnaLl5o3a+fz+3fRaFUCqif8nJLPE4V1jdeEk3gOeAjr0MTcGztIBc1t6YSI1onM7h0lZMsesQwMk4kzBuWo4n5+M9eZ2cLZi88h7viXqLQV5SDXihRXIWbzfuZVS2yMRzTqAdN/TupbJvsKytmNjs2mxr2E0H4VaG5KccKhLscNOmv62yjaMkI/Vw4oHwvrdNQKjY5G8vvHWiOy0zo+AZ197Zyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLU49mv6ygpOZj+96HgufVlUa7IQf6II1Nx7+47hFwY=;
 b=YysEtGd65Ioxi9LFB4WgqdEehc/3crGWeOZO/k+o8d6H/255zmu13l+B2wUchU5/vw32KbDu62r2Iqn/t+TfsrlvdVnFbdEWiDCi/20u5YgrKqiH+mYY6L12tgHhgiGf2wtrmS5cPhV2XaP1G98r1QTue4ypmpgeGPMOLL+VJ0E=
Received: from BN0PR02CA0015.namprd02.prod.outlook.com (2603:10b6:408:e4::20)
 by DM5PR0701MB3814.namprd07.prod.outlook.com (2603:10b6:4:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Fri, 7 Aug
 2020 11:46:14 +0000
Received: from BN8NAM12FT033.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::61) by BN0PR02CA0015.outlook.office365.com
 (2603:10b6:408:e4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT033.mail.protection.outlook.com (10.13.182.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:14 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9P6029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:13 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:08 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:08 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk84t000824;
        Fri, 7 Aug 2020 13:46:08 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk7CG000821;
        Fri, 7 Aug 2020 13:46:08 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 00/13] PHY: Add support for multilink configurations in Cadence Torrent PHY driver
Date:   Fri, 7 Aug 2020 13:45:54 +0200
Message-ID: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44904bac-70d2-460f-e7f5-08d83ac77cfc
X-MS-TrafficTypeDiagnostic: DM5PR0701MB3814:
X-Microsoft-Antispam-PRVS: <DM5PR0701MB3814CBF652A465EFFAC8BCEBC5490@DM5PR0701MB3814.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hw8S9jnrFsVpI2plfQ2YnUVbr6LoodaB+clnT7XggyqgDyDFZyLjEHNz9hz22gjr1JxpE0HX6taC+sYlW6t8O7XdeuVDfG6TI177g0wmVEhGYvg18xzh87NaVMROxPpjXn6iEU7VLisKPISXl7jT+V0MeJAmh2Rb1JVNIV89PZJVR0CmC7KaEecQcp61s+LMMXxNJiHRGA+OK5Suh6il/ZTaN3nBvvH6pC4ckltXVYqoy3juqcJ0FZW5bHHB/Yub61S8n4ObDGYphLv42mcZKg5xz64RuWYdqpggwleueSqHyr2T7Hgd87MIVJwshEyilRa93s3CfNA0RwrGG1FH677oF5HiV0uBTu0CuKnJR4DtCKa9LVkouQ9Tt6g28NKTMXnUpk2jF+byNxTrWSUn1131IcUWNzMh6tvXD/oNrXrTJTZQS0cdyzmvifpem9CoPvHRgCQsXnqaJ3UpAN5iXaZq2JRNZHGoWfr3sldgK3idoEXv+/ayQB2SS7Hn610g
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36092001)(46966005)(478600001)(336012)(82740400003)(356005)(966005)(42186006)(110136005)(8676002)(86362001)(82310400002)(81166007)(5660300002)(70586007)(70206006)(54906003)(36906005)(26005)(83380400001)(8936002)(316002)(2616005)(36756003)(6666004)(186003)(2906002)(4326008)(426003)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:14.2477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44904bac-70d2-460f-e7f5-08d83ac77cfc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT033.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3814
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=996 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
This patch series extends functionality of Torrent PHY driver to support
following configurations:
- Single link PCIe configuration
- PCIe + SGMII/QSGMII Unique SSC multilink configuration
- Single link SGMII/QSGMII configuration
- Single link USB configuration
- PCIe + USB Unique SSC multilink configuration
- USB + SGMII/QSGMII multilink configuration

The changes have been validated on TI J7200 platform.

This patch series is dependent on [1] and [2] and should be applied on
top of these.

[1] https://lkml.org/lkml/2020/7/17/158

[2] https://lkml.org/lkml/2020/8/7/338

Swapnil Jakhade (13):
  phy: cadence-torrent: Add single link PCIe support
  phy: cadence-torrent: Check cmn_ready assertion during PHY power on
  phy: cadence-torrent: Add PHY APB reset support
  dt-bindings: phy: Add PHY_TYPE_QSGMII definition
  phy: cadence-torrent: Add support for PHY multilink configuration
  phy: cadence-torrent: Update PHY reset for multilink configuration
  phy: cadence-torrent: Add clk changes for multilink configuration
  phy: cadence-torrent: Add PHY link configuration sequences for single
    link
  phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
  phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
  phy: cadence-torrent: Add single link USB register sequences
  phy: cadence-torrent: Add PCIe + USB multilink configuration
  phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration

 drivers/phy/cadence/phy-cadence-torrent.c | 1975 ++++++++++++++++++++-
 include/dt-bindings/phy/phy.h             |    1 +
 2 files changed, 1934 insertions(+), 42 deletions(-)

-- 
2.26.1

