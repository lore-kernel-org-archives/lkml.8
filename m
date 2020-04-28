Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCEEC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7429B206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="gs18q3Kr";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="dgrRp26S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgD1HK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:10:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:31756 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725867AbgD1HK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:10:26 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S78KwL013124;
        Tue, 28 Apr 2020 00:10:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Sra+64/jWOPKQJWfk2Zvw0TizoNTJbih4KB+fHiS04Y=;
 b=gs18q3Kr8XwU94PomkzlX/IdpY+dSnzdkG3v/zKDZf3cKixtCAhZ7MmOv6Ps2BSMJGd/
 J+1RDg8IPmVtnm7z6DxKbYitv29SaUvqjBJOuR85uN5BGNK7vegLxAYIokKCnLE74VNJ
 XLGhV4suKK7dinYe+25/1tlzUpDy1vM3rXECJ9xNOkhvelomLnIZWDUSlbJeAwnD5PVp
 ojo/PFPnzHjUM+qAlPFM8W9+VTGJdZ0QzFKLfrAa957uoT3PBl5Kr7Kli4yWhwU0Y69t
 goQ62HhHwrMZjdSQtg689GfgIXdVy3NBkKGr6bU5RkDesG+Tv7xgftX0/eFiAiACmQb7 cQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by mx0a-0014ca01.pphosted.com with ESMTP id 30mhrv2xqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:10:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m4iYF1E6ixy/Ag4OSLITtLiJg2yJWFtmxiDLnkttu6I5TuavTGRS/rN8KS/MlUR/yN/dd8AMwsMHcnzrrJ/XmjU+STb30KA2ENkoEU3DDm7xzYyd54GuwFXSzKSPQJqci9/AhNaJtMKaSqQRdLdpBTfTZA29CvsVC43bbBRbS8z0yCdKbyM67Cj7wMwCWwF40RcKLIKJ4JyiMs6j6miDCKXNCZWxJ6sY8IbPEaRX9hUjJxSArzfPzeyoWZWYpjYOswPnoLg4rG4TU+Nb2w3pzrq3/2XnaPDagpbs0RRHT8JJg8T6To3TvvwYdaDnA+yR+fsLZuWG21zfMFfVG6Dquw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sra+64/jWOPKQJWfk2Zvw0TizoNTJbih4KB+fHiS04Y=;
 b=lkNaG9IQbiuFw5sMOahMB2Eo0zSBl4Mc+aEeefpiPySNmgXMdMwNxVLiqZ3xQOnX2C/BQGyRPerxcIgZFYu94gZKqJ5rHY+TZph+Vndui7XsRgdyWSSl2Zt/6oSyZinVm+56csPJMaiDb5rFNWeefGSpAGGTsWEbcQMk7d4/b+rv6qoV6ufXHNpuJmDl7hnyd+OMWfyr7skWuy00AAAjduyQPXjHWybhw5uw79IP5ljCEuxeh9KVgZZScNzAGFaizFv9rHCvK6ibTEoQdmnANPhEjQwnsh0R0W4XFHuqoJdhUUQ4PqNKGdmiYV5NfEfVrl0F2L+x5BObanYPamISCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sra+64/jWOPKQJWfk2Zvw0TizoNTJbih4KB+fHiS04Y=;
 b=dgrRp26SHH6+hfh1MlLLmtAl1LWG4T1oLsjAQSw0YfD1gkE0Vf+tD7gikZP5pI/SpVOMmFpuj7OR/G6b9Edvq3Nj3BDiBg3gNzmmQLFDNs6zD9wi00M4x6lmq/EHkQ1CcIyQCdfFDrNaEvK+IF5TYaYp3wmZfN+ucvmylNlXvXw=
Received: from BN6PR20CA0049.namprd20.prod.outlook.com (2603:10b6:404:151::11)
 by BY5PR07MB7267.namprd07.prod.outlook.com (2603:10b6:a03:211::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 07:10:10 +0000
Received: from BN8NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::66) by BN6PR20CA0049.outlook.office365.com
 (2603:10b6:404:151::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend
 Transport; Tue, 28 Apr 2020 07:10:09 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT059.mail.protection.outlook.com (10.13.183.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Tue, 28 Apr 2020 07:10:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03S7A6aS203012
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 00:10:07 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Apr 2020 09:10:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Apr 2020 09:10:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03S7A51R029216;
        Tue, 28 Apr 2020 09:10:05 +0200
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03S7A4KL029205;
        Tue, 28 Apr 2020 09:10:04 +0200
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <kishon@ti.com>,
        <mark.rutland@arm.com>, <maxime@cerno.tech>
CC:     <jsarha@ti.com>, <tomi.valkeinen@ti.com>, <praneeth@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v1 0/2] Add support to get/set PHY attributes using
Date:   Tue, 28 Apr 2020 09:10:02 +0200
Message-ID: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:unused.mynethost.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36092001)(46966005)(86362001)(966005)(110136005)(186003)(54906003)(26005)(478600001)(81156014)(36906005)(5660300002)(8936002)(316002)(42186006)(8676002)(426003)(2906002)(107886003)(82740400003)(36756003)(2616005)(70206006)(81166007)(336012)(47076004)(4326008)(70586007)(356005)(82310400002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5eb41b-530a-4b18-e2e7-08d7eb432fc0
X-MS-TrafficTypeDiagnostic: BY5PR07MB7267:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7267024D801C66D6AC91DF78D2AC0@BY5PR07MB7267.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0387D64A71
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OPW7qT5Whex8YGjN5huIFbWtZbaFOFy300m9/H2fLmzzbeOe8xe1lSJ11A7d56z2kckUx4XPY6ZHUqSQR89U6mYLB/uIB+nQMa4jkO55OfZC29cCCG4y3b5ix3JYxi2BPspFV2UzuTzCtEX+eLwsuTiTzLozdQxpmWwdsp6Ami/kCNhHPHeOA831NoyQVW86B2hwNecQObicQJs+VfS4waKCWQBlJPdMNjNJBTclUyMLF1ZopmjityXSORFc57zIDh1yaEcKBoiReo9OSHNQtF5pcoMFeknpHgJ25k1CKk3hekawGy3TRmBrbviIflXuJze5FRglZ5zNZ0C3dyn+OgvCOPZBbyfS76pUAqlDroqb4Bv/WAh6uQIq9Xi1YLg23APCixnIu1v6FAgRuNTfi4vlvky0FI7xh2svFJtYG0JCcVL5BGfF5TW4OReGQgJkNXFLiLFGoOykVt/qsKsMAkBameEFfUHsmF1k/qyQCM5DFuuHlOe1DIYk/j6+Q9kgqe9RcJEri70czK7GsB36PlmkraUsl3GfIWmugTOfM1DFSBQ4gyNLQRlYoKZKAsXO6ifp0aW0crERAlxeJ7e5J0oxG9c7nCdLm5nbJ6Ob9mzJPh6bdaLR1SKd68scDW/
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 07:10:09.1221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5eb41b-530a-4b18-e2e7-08d7eb432fc0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7267
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_03:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=784 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280061
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to use kernel PHY subsystem APIs
to get/set PHY attributes like number of lanes and maximum link rate.
It includes following patches:

1. v1-0001-phy-Add-max_link_rate-as-a-PHY-attribute-along-wi.patch
This patch adds max_link_rate as a PHY attribute along with a pair of APIs
that allow the generic PHY subsystem to provide information on the maximum
value of link rate supported by the PHY. The PHY provider driver may use
phy_set_max_link_rate() to set the value that PHY supports. The controller
driver may then use phy_get_max_link_rate() to fetch the PHY link rate in
order to properly configure the controller.

2. v1-0002-phy-phy-cadence-torrent-Use-PHY-kernel-APIs-to-se.patch
This patch uses kernel PHY APIs phy_set_bus_width() and phy_set_max_link_rate()
to set corresponding PHY properties in Cadence Torrent PHY driver. This will
enable drivers using this PHY to read these properties using PHY framework.

The get API's will be used in the Cadence MHDP DRM bridge driver [1] which is under
review for upstreaming.

[1]

https://lkml.org/lkml/2020/2/26/263

Swapnil Jakhade (1):
  phy: phy-cadence-torrent: Use PHY kernel APIs to set PHY attributes

Yuti Amonkar (1):
  phy: Add max_link_rate as a PHY attribute along with APIs to get/set
    its value

 drivers/phy/cadence/phy-cadence-torrent.c |  3 +++
 include/linux/phy/phy.h                   | 21 +++++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.26.1

