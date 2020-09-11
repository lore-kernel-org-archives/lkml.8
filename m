Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8DBC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F213221E5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="dze1Q7EH";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="vtL7nLV7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKGTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:19:05 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39172 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgIKGSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:18:55 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08B6CNrW022429;
        Thu, 10 Sep 2020 23:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=WCZQMkv2ebXiRCtcOMY54TwtSZ/oYKr6J0yilIEtJcc=;
 b=dze1Q7EHync4Wbai4QINWbg77cBqlUn3S/ykfvbGtjVvKXfJbcTFigqc23BsdXi6RT2h
 xcp1nPAn0BkDYVdJrG8NeDsQMMQJp+FWGPlnBCMfjga4uLXnOdeG8Iv+yM1l7aYH0QY+
 a5+YRvJVDZ8HXdLwR07UL35S09EPEmQVHqh43/87lc38TfBxta0Nx21OXVpMkxQaJqhb
 SeiPFwcL2XYvQfk4H9KJUvKjJvMcwNczyyvSEZzljW4i3LC4VjN1x4S/Fg4VJhkStPuD
 C/cW+SFgM1x+yaEI/AatO6XcjnGSTMiZbae5TXUxX3lVLf7FMnNLAni1HMbFBlm0/tM3 +w== 
Received: from nam02-bl2-obe.outbound.protection.outlook.com (mail-bl2nam02lp2050.outbound.protection.outlook.com [104.47.38.50])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33c68wx0rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 23:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5FdkBFeI+H7scqpRZANnV4iJJ8xJhhTTIcZz7SgI+pWzcQgPKNIIz4/etEWPe/MtmbDKQd9DXiRxLD4qVIGGTTPiwA5+o5WYHAOToKQcOYCnADjf6Ys04jPaaZVqDeBX1oVOoNLwDKuXRKoxfaJDs2jbbIlMLo/dRw9SG35fzN9pNwiE+to3/xI98o0JONMYnD5uuye4et9GWEKraf+qrHm3EfdyIUBxQdUFFR9FOWwHeqWqbujOpoP3ENO9WI4hp/p6Q5bALfhQhqcmIuo8hmJChz7QFJl9Z7+w+7vhd78M2v+RvS/45xZBr3ZKbzKBi+Erk1a0f7HVtIS2ctZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCZQMkv2ebXiRCtcOMY54TwtSZ/oYKr6J0yilIEtJcc=;
 b=LFSFloxctaaG4ZrQl7hQoub0i0b6RSvVByBirROdim+xqrjXOY+NqKgFfV18HCyItzvIfv4M6YlawFYgLg6LGSoJt/Lx9x5gG7J+4c502+q4+9OHac8Z4dEz+R7kRQssVr0sIO6WhmgUPY1Q06USm3HaT731BYB/SkQeYWv6Wmxj7SQZGQFLOYvQTqh660hNLgfeesMVAnzAVxjtR8xWVl6zYLGs4wwn3xwCQzwp6BrYW9KOvdFtWC9z1QXPFSEyO01tYbXRaksWLprivBcfEsoUkyW1xsurgAgZBKex3wJ3ltV+vdKCH3/5uqNRV1yBodiOBKJZuBePpcmwWmKy6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCZQMkv2ebXiRCtcOMY54TwtSZ/oYKr6J0yilIEtJcc=;
 b=vtL7nLV7Bb2jnt2WkioDViuw08DvvQpfTHzlfEkJP1XyjCwTXHV1v2NrdK9eJWEQpMfOvpk5Afpg3eKgXI0EInEAzIRyE7fOkNY75hrnyIDLKjjHhOWl9h8TSXYXgkg5JxjzdBUpAJA9fO+HwPUA5OmNgjgT15+8BfRCVQZtmjk=
Received: from BN6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:405:6f::11)
 by BL0PR07MB5586.namprd07.prod.outlook.com (2603:10b6:208:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 11 Sep
 2020 06:18:42 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:6f:cafe::62) by BN6PR03CA0073.outlook.office365.com
 (2603:10b6:405:6f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 06:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.8 via Frontend Transport; Fri, 11 Sep 2020 06:18:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 08B6Iacl037565
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 23:18:37 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 11 Sep 2020 08:18:36 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 11 Sep 2020 08:18:35 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08B6IZQ9022120;
        Fri, 11 Sep 2020 08:18:35 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08B6IY7D022106;
        Fri, 11 Sep 2020 08:18:34 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <nsekhar@ti.com>, <tomi.valkeinen@ti.com>,
        <jsarha@ti.com>, <praneeth@ti.com>
Subject: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
Date:   Fri, 11 Sep 2020 08:18:32 +0200
Message-ID: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b671461-3916-4f8a-de1d-08d8561a8734
X-MS-TrafficTypeDiagnostic: BL0PR07MB5586:
X-Microsoft-Antispam-PRVS: <BL0PR07MB558650E77D7B3828929B9743C5240@BL0PR07MB5586.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6nFGpVzyFEf6XO1nYWXpMGyoqamrzAwwJ/e7y+2UmlkIzZyYkk1GT2kZeid2ra1w+juOPQy5kFzaopB24YrWlIdAXI4udhqPpH4VClNZEVeBp70Np1p17siw+RJpcFkOWr9LHa33KE3aO2OwccB2LNirHb6AUgEFkqtZE6M5vBoblUAVLupuWRH/qRKwJNSZ24Yn4rRK25XLy4zEynGCh7y8Lqf3d5nD9dFjOjcAR4WPnVyt9Lvg36TFsUfI0UORZFtxO8zvbIAuU+9gpwpmHcHgvySGdABVJiSU5bzRNxe2wLpIX9sXlG1h/oQ7Y1iKju0kpORSzOB/3pU+2XPRfQqUtWAmZFsylStfYjp7d8/gjmRXWc6vez8fW1/JAff2F+QHvgcm3ecK5y86oKOsHkoO/rs36N/QLrq2dGWw6HgkDlmrGHDt6GqZ6yzvK1u56L8//YTn1duVbLd+9ee54eCEBugs8X5oSyn0fNQKfn43WnlaSyLsymv6cSzjVhdD
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36092001)(46966005)(110136005)(8676002)(82310400003)(82740400003)(54906003)(478600001)(2906002)(83380400001)(5660300002)(4326008)(336012)(8936002)(356005)(966005)(42186006)(70586007)(36756003)(2616005)(186003)(86362001)(81166007)(26005)(70206006)(316002)(19627235002)(47076004)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 06:18:40.8953
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b671461-3916-4f8a-de1d-08d8561a8734
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5586
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-11_02:2020-09-10,2020-09-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxlogscore=751 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009110052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a new PHY attribute max_link_rate.
It also updates Cadence Torrent PHY driver to set attributes bus_width,
max_link_rate and mode for DisplayPort.

It includes following patches:

1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
This patch adds max_link_rate as a new PHY attribute.

2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
This patch sets PHY attributes in Cadence Torrent PHY driver. This will
enable drivers using this PHY to read these properties.

These attributes will be used in the Cadence MHDP DRM bridge driver [1]
which is in the process of upstreaming.

[1]

https://lkml.org/lkml/2020/8/31/171

Version History:

v6:
   - Remove implementation of new APIs phy_get_attrs/phy_set_attrs
   - Set attributes manually in Torrent PHY driver

v5:
    - Add kernel-doc comments for phy_get_attrs/phy_set_attrs APIs
    - Pass second parameter of phy_set_attrs() as const struct *
    - Add Acked-by: Kishon Vijay Abraham I <kishon@ti.com>

v4:
    - Protect phy_get_attrs/phy_set_attrs APIs with mutex

v3:
    - Add comment describing new PHY attribute max_link_rate
    - Use of memcpy to copy structure members
    - Change commit log a bit

v2:
    - Implemented single pair of functions to get/set all PHY attributes

Swapnil Jakhade (2):
  phy: Add new PHY attribute max_link_rate
  phy: cadence-torrent: Set Torrent PHY attributes

 drivers/phy/cadence/phy-cadence-torrent.c | 4 ++++
 include/linux/phy/phy.h                   | 2 ++
 2 files changed, 6 insertions(+)

-- 
2.26.1

