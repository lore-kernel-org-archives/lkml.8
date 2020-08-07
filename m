Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB09C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C572075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="bIWUrR+V";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="UajC6gl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgHGLqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:46:50 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:32730 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728207AbgHGLq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:46:29 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 077BhVmP011321;
        Fri, 7 Aug 2020 04:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=/P2Ll+LL7LhKbJVTcstS6XFp4bpzBOE03E0iB6c8Uwg=;
 b=bIWUrR+V6NBkvXOTSM/B3Qn1sAcrfABUewzSoEwm9hG1E2/dIG/2YqtdYsUEvM86SDX0
 hN4JSn4SCo8Z9qDB8QA+MUUKq/BQ/lIg9k5zsGDxqc/qMd/UEGUCvfdCrqa6wPt3XrvV
 DeVf5kezFaB0AHvfcu3VOV1WlsD2R9FWLzVldk/1DBi0vQ0GRmZKlPXD+ON7s+jHjAIs
 CSer0ZIkpcYeaAcFyuHP5ThNmp2vbT89Od8kwpXT5Em+MO/c8dP1g08OO8diVUMt+UIc
 474FiZZOPfSv7HUCX4EhN/dtZ3LrrYTDIPQVp8fy0wmEEAqnJsXnYDxGCaIXFyBAOJyg Sg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by mx0a-0014ca01.pphosted.com with ESMTP id 32nme0mc3h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 07 Aug 2020 04:46:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MsnYtL8Gf6RYkSdbADU+HlQo3sTR+VU8tfcziaT/Qcbh46IXpxaeZQJsNdVIihPlenqb7nZmHVQ4VWPEkEtiN+ulnXELsEhctO9Edxu0h9PZEcgE3ld+dWqeQDUFR5i+lLu2Gy3DiCgH56ZgpJkjzHbTmk8G15385bPk/b+YIa/KUfZ1R3DaDGxXbXHRj0wqJQdl2weUykTSZcYsyLqsB6hU3jCy5FrUapKoEowgk6B2fnGr4fOSYrUuSfkKFv4XW9fE7vD5YpvGEd26ZBX1uf/IcrWEMlky3jErAwEYIgU12KSJCkt7Xn6MxyDqn6cNgpDF+ohsWWFlbhX3+8apGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P2Ll+LL7LhKbJVTcstS6XFp4bpzBOE03E0iB6c8Uwg=;
 b=lBqB9EyZjzRkn74lywZNRMMRw69swAfvLpi4CzDrtGxqcoUUgFiLroftMVgZebjVXJ3uFvGekdzhZCDV6WuKLXtdhpWPlJ8zcaMjUtYR4Kb/Ka3vtfUgrxZH4GQOl6wOzFqNKTlPLHLB9TNtnYVu6v0ts6yIEbQeMsj8y9+lY2MCER2XDKdOcvNK9Ky5LrYrTuTB6LTcq2TcBUDH2g2VD9LfLXMxfRxyANEAgPcuBOKnBYnPnU2ka9r+YDVnbmGR92r/fF8MPm31egDrv9m4bzMKWNvcsNf6cmmRFl8OAy0+bz6wiWzXUp0ciU/WGePOK8DMvf8Czr/CpWKaftkhoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/P2Ll+LL7LhKbJVTcstS6XFp4bpzBOE03E0iB6c8Uwg=;
 b=UajC6gl9o+N/xLs2Ww8izW3H/2q5tGelMdaKpQKuLcXLGMs/3v5LahtwOxUizqUkq9SzAHiOygreWYw0LhZC1LHdO8DugUmYp2TvDAWb4lAdIy6AVE+j/LOSv2HZyLHCFjWl778Uy39LicIpiAlz5CSVURmTOA3TBDap3c1w2Xw=
Received: from BN6PR17CA0037.namprd17.prod.outlook.com (2603:10b6:405:75::26)
 by DM6PR07MB5753.namprd07.prod.outlook.com (2603:10b6:5:7b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Fri, 7 Aug
 2020 11:46:17 +0000
Received: from BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::a2) by BN6PR17CA0037.outlook.office365.com
 (2603:10b6:405:75::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend
 Transport; Fri, 7 Aug 2020 11:46:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 BN8NAM12FT064.mail.protection.outlook.com (10.13.182.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.10 via Frontend Transport; Fri, 7 Aug 2020 11:46:17 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk9P9029785
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 Aug 2020 07:46:16 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 7 Aug 2020 13:46:09 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 077Bk8jw000836;
        Fri, 7 Aug 2020 13:46:08 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 077Bk8Qa000835;
        Fri, 7 Aug 2020 13:46:08 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v1 03/13] phy: cadence-torrent: Add PHY APB reset support
Date:   Fri, 7 Aug 2020 13:45:57 +0200
Message-ID: <1596800767-784-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
References: <1596800767-784-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3602d618-bd4b-4847-81c9-08d83ac77eaf
X-MS-TrafficTypeDiagnostic: DM6PR07MB5753:
X-Microsoft-Antispam-PRVS: <DM6PR07MB5753828248D134B577461541C5490@DM6PR07MB5753.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBnZkjg9H/4hCnWfvjHpBzkaK7PKyfSXpLUOXoEf2V2LyLUIENKS4P2Pt3ONAyM3+a+E6BiSz9cFqjr46Xts7z32gGdLIRyfluR1WBoNpdi+1GMBIs1wBEIy/fZaNzoT0AR1oK3g25H+oq4EKAl+CqjoR1+h0otdpkUkY4gn7fh/1lLv9pgsib+zITWCRFg21TYcWMy3ZMDJ1mOk2XwLerszyI/SW/5LTM3i9wVlMbuxjfTZTkixPhvZWnDBzdtSA5vKIxtVvyoA2TSgeN/zmzLZeOIkvqvee8nS5MFTNsBdz5rXq0yG6U+p8dzhwb03DTdqfsaY8PE3h1gl4IcoJLDOI8hCFPViIVZiMjBJPG9Dza0U00DgUfJ40zIPIggA5UQYkmlFuFnyyW5gr7qIBb8DfJtI0chSTqiTMmN5dgY=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36092001)(46966005)(426003)(336012)(356005)(4326008)(5660300002)(82310400002)(83380400001)(8676002)(8936002)(36756003)(47076004)(26005)(478600001)(54906003)(110136005)(2906002)(70206006)(316002)(70586007)(86362001)(2616005)(6666004)(81166007)(36906005)(82740400003)(42186006)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 11:46:17.0989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3602d618-bd4b-4847-81c9-08d83ac77eaf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT064.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5753
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-07_08:2020-08-06,2020-08-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008070085
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for PHY APB reset and make it optional.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 8c6e1aa93b64..7ccdb3105783 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -228,6 +228,7 @@ struct cdns_torrent_phy {
 	void __iomem *sd_base; /* SD0801 registers base */
 	u32 max_bit_rate; /* Maximum link bit rate to use (in Mbps) */
 	struct reset_control *phy_rst;
+	struct reset_control *apb_rst;
 	struct device *dev;
 	struct clk *clk;
 	unsigned long ref_clk_rate;
@@ -1884,6 +1885,13 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		return PTR_ERR(cdns_phy->phy_rst);
 	}
 
+	cdns_phy->apb_rst = devm_reset_control_get_optional(dev, "torrent_apb");
+	if (IS_ERR(cdns_phy->apb_rst)) {
+		dev_err(dev, "%s: failed to get apb reset\n",
+			dev->of_node->full_name);
+		return PTR_ERR(cdns_phy->apb_rst);
+	}
+
 	cdns_phy->clk = devm_clk_get(dev, "refclk");
 	if (IS_ERR(cdns_phy->clk)) {
 		dev_err(dev, "phy ref clock not found\n");
@@ -1908,6 +1916,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	/* Enable APB */
+	reset_control_deassert(cdns_phy->apb_rst);
+
 	for_each_available_child_of_node(dev->of_node, child) {
 		struct phy *gphy;
 
@@ -2062,6 +2073,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	for (i = 0; i < node; i++)
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
 	of_node_put(child);
+	reset_control_assert(cdns_phy->apb_rst);
 	return ret;
 }
 
@@ -2071,6 +2083,7 @@ static int cdns_torrent_phy_remove(struct platform_device *pdev)
 	int i;
 
 	reset_control_assert(cdns_phy->phy_rst);
+	reset_control_assert(cdns_phy->apb_rst);
 	for (i = 0; i < cdns_phy->nsubnodes; i++) {
 		reset_control_assert(cdns_phy->phys[i].lnk_rst);
 		reset_control_put(cdns_phy->phys[i].lnk_rst);
-- 
2.26.1

