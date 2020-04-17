Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA56C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9292072D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="VI5XJFMM";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="cD3716sN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgDQQU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:20:27 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:7262 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729581AbgDQQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:20:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03HGAD2t019642;
        Fri, 17 Apr 2020 09:20:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=Qr1yTcN6uN2CdFICAHvcOQnScg3Cv5NmMYwyak2/6/k=;
 b=VI5XJFMMsVMlO8jFUSzHSYVVIE5vSFLmEnZlvPQPPKLLX1HJ/QuMtHgx8Xy6+PQZG9LC
 Ovpm+aV8pgPnvTAU21zMyhPm/W20xihWLhGqGBbt/5OPtT0qGYoWxkaLd/Pf2SlSCL6E
 sRN0kXahEV5ujzQONIcYIfar2p8WtDAB8qqrKpBB9crz8d9Mrn7psZZApmqrjIW5bcwr
 HEHi5y2xLXCp4PZUNi+iTgpZ/H3e0LAtoC2bAP19DxrUNeJ3rGQOoT9oX/3AmwGUQR4N
 alJHf7vsGNVu/QlV7QIQHU/hKgpeRuNindXDHH7i0lbqsyFA4c22cnHU3nrPwLiCr6FY aQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0b-0014ca01.pphosted.com with ESMTP id 30dn7954tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Apr 2020 09:20:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFKZYw47d7YHPnVX1pSkFi/JSWCCDBeFnSfxqoxI4WykCOZgdeCad3N32kODkS0uc8/2Fr+x/ou8d/Ew73p5f19/HxkS7xyavc/MZLMnUQtdnYj7qnnt8MjgUfMLedzLJzgCJrFarhlJ3+FM26q6fU8Cu1FVSJIIT968LdcQW2QmujP7r9NXqvGz3SF/X5SPsF7/AbyaHKzj3+fUlazrMRivppUU71X3RCngCSU1ewg/Iy4zJm5qv4URrqcGmPEf22mA+A21bPAwnK7atpE9Lxl577jzR7D4jYpIb4lgia30Snnjj2ZM7lc8tYTpdYclJbbQf86+IGb3MwIlS05faw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr1yTcN6uN2CdFICAHvcOQnScg3Cv5NmMYwyak2/6/k=;
 b=EC7a5A4VvzRP3t0/P99854Z+Af4vTsde2L2RIv76c1P1DZfQn2eTu6Z/Dtv/JokjXH4HlpTPcAshW6DCIZB+LCFnP7XaZTc3n4LIAsUVrEe2/q75OZfQ5+9pxpzgy6HEEfdDsz5zfbH+3so6Tm4+3pmgjB5I1iuIg1Cx36GowyRXv7VvFx4FLyYIcjBHZmNYR85qTNo95qX3+vIlTObDoX4COLccEddD1aUYxpd/RDYkmFEQfjtatq8NDDNCoSuemx+MQseZ9b/nqB9LHVO1BiLq/zoCDeoYflrEcegInDXxO6cB7rpMuPjRK8JDzKEmNAwp0kbxj5OkBqjDJq+HOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qr1yTcN6uN2CdFICAHvcOQnScg3Cv5NmMYwyak2/6/k=;
 b=cD3716sNKJbkLO1HAIEkfkNSwrn6baNAld5hMRPh+rMucXTNpRFikMJW0j2Kdnjl+WveNKbqDeH4O3T+njARfNNBQXHm3jBcHpRxuhlAv9VBQAR9Hj83lrBdcf7RV5JvzuDaj/lsxOoKuQyMzt5u3/QdYWxoLsBzw/bjPZcgivc=
Received: from BN6PR11CA0013.namprd11.prod.outlook.com (2603:10b6:405:2::23)
 by DM5PR07MB4070.namprd07.prod.outlook.com (2603:10b6:4:ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Fri, 17 Apr
 2020 16:20:10 +0000
Received: from BN8NAM12FT049.eop-nam12.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::ef) by BN6PR11CA0013.outlook.office365.com
 (2603:10b6:405:2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Fri, 17 Apr 2020 16:20:10 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT049.mail.protection.outlook.com (10.13.182.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.12 via Frontend Transport; Fri, 17 Apr 2020 16:20:08 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 03HGK44o140231
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 17 Apr 2020 09:20:06 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 17 Apr 2020 18:20:04 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 17 Apr 2020 18:20:04 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 03HGK4F9029574;
        Fri, 17 Apr 2020 18:20:04 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 03HGK1Af029547;
        Fri, 17 Apr 2020 18:20:01 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v6 0/8] I3C mastership handover support
Date:   Fri, 17 Apr 2020 18:19:58 +0200
Message-ID: <1587140398-29473-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(46966005)(82740400003)(36906005)(42186006)(316002)(70586007)(70206006)(336012)(47076004)(478600001)(2616005)(186003)(26005)(426003)(81166007)(356005)(54906003)(110136005)(6666004)(8676002)(81156014)(8936002)(5660300002)(4326008)(86362001)(36756003)(107886003)(2906002);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deca0e4b-3873-4a34-77ab-08d7e2eb325e
X-MS-TrafficTypeDiagnostic: DM5PR07MB4070:
X-Microsoft-Antispam-PRVS: <DM5PR07MB4070FF1AEC96B7E0E631E2FDC1D90@DM5PR07MB4070.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0376ECF4DD
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2Gqw/0H2gRdA3p0fc3muk4+vsc1W7hldFaw3YfF8oDUZLBNoUBeWbb8rZABB30fXtdlwMjyOPXnUI4rZc6SAPEdVAc9hijHbB3Mm8KwI7HnbDdqd7e++Spz8ekzLgxmwOIKhye4Q81AdCkbrLPPQ1nBACkEbHUnTB9BztsqzFo/H8OFD7yB9jK0bTDhL55Hm72f4Ad2eb1OomDqRp0CpNkmsYTm4KFNaqpPfjH/zLwcc2DQ52ivUbEHsi9LfTBE7GPC1LifR4V2jB3PlAYdJPBoPGLkSmVxGm1Y47BRWYHR9OCI12TY7XMN5yyuKyOT837y5UapHYDM5yZohk9R2QLLSM0QT0V5OPsI6yQGy4m2S/D+hov69ehYHfpOvRUQmRg4PKlGmEqNRDKyOARYlx/McpUX+Qh1FEiBZKCn2WyNRCF8Nnsvg/gbVMyc/mqkea6mNA4SgoFkN5R/t6dvslUxB5SmSidxV/WBHCG0xemGbb30dE9w5+Tjw3SjAG5h5xUSTu70R8UDgWK+GKNJ5rqzx7XP6oSSBNDKO98bDMM=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 16:20:08.4989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deca0e4b-3873-4a34-77ab-08d7e2eb325e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4070
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-17_07:2020-04-17,2020-04-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004170129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is to add secondary master support, mastership
handover, DEFSLVS processing to I3C master subsystem and
Cadence's I3C master controller driver.
In comparison to previous patch set to enable mastership handover
support, there are some design changes and improvements listed
in v5-v6 change log below.

Also, I am adding flow diagram in documentation to help understand 
the code changes and intended results.

Please have look and provide your feedback.

Main changes between v5 and v6 are:
- Moved populate_bus() hook to master subsystem code.
- For secondary master initialization i3c_master_register
  spawan separate threads, as secondary master may have to
  wait for DEFSLVS and bus mastership.
- Populate bus info is based on DEFSLVS data and take care
  of hot plugged / unplugged I3C devices.
- Split bus_init into bus_init and master_set_info callbacks
- Moved mastership aquire and handover to separate state 
  machines.
- Added DEFSLVS processing code.
- Moved back all locks in side the subsystem code.
- Secondary mastership support to Cadence I3C master
  controller driver
- Sysfs key 'i3c_acquire_bus' to acauire bus.
- NULL check for pool pointer in i3c_generic_ibi_free_pool.

Main changes between v4 and v5 are:
- Add populate_bus() hook
- Split i3c_master_register into init and register pair
- Split device information retrieval, let add partialy discovered devices
- Make i3c_master_set_info private
- Add separate function to register secondary master
- Reworked secondary master register in CDNS driver
- Export i3c_bus_set_mode

Main changes between v3 and v4 are:
- Reworked acquire bus ownership
- Refactored the code

Main changes between v2 and v3 are:
- Added DEFSLVS devices are registered from master driver
- Reworked I2C registering on secondary master side
- Reworked Mastership event is enabled/disabled globally (for all devices)

Main changes between initial version and v2 are:
- Reworked devices registration on secondary master side
- Reworked mastership event disabling/enabling
- Reworked bus locking during mastership takeover process
- Added DEFSLVS devices registration during initialization
- Fixed style issues

Regards,
Parshuram Thombare

Parshuram Thombare (8):
  i3c: master: mastership handover document
  i3c: master: split bus_init callback into bus_init and master_set_info
  i3c: master: i3c mastership request and handover
  i3c: master: defslvs processing
  i3c: master: check for non null pointer
  i3c: master: secondary master initialization
  i3c: master: added sysfs key i3c_acquire_bus
  i3c: master: add mastership handover support to cdns i3c master driver

 Documentation/driver-api/i3c/index.rst        |   1 +
 .../i3c/mastership-handover-flow-diagram.rst  | 209 ++++++
 drivers/i3c/master.c                          | 627 ++++++++++++++++--
 drivers/i3c/master/dw-i3c-master.c            |  29 +-
 drivers/i3c/master/i3c-master-cdns.c          | 426 ++++++++++--
 include/linux/i3c/master.h                    |  48 +-
 6 files changed, 1235 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/mastership-handover-flow-diagram.rst

-- 
2.17.1

