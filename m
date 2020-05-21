Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BB142072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:31:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="ZOv3EFPo";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="49u+LOZm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgEUJbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:31:33 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:28438 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728704AbgEUJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:31:32 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04L9Tf13021553;
        Thu, 21 May 2020 02:31:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=4/0Bpvf/9l8RH5oOJ89DAbj/B0Cz098KoT009UZr0mk=;
 b=ZOv3EFPowL2Jata6tmWhauGhvmbZUPH4TnYY94upoNvZGVcpB56nygTj8BKuS0/mflXd
 ePD1g5v7j0Zj9fn4z0sTME1xd2KLxxZgPiI6XAfeOeL+v7gtFAjhAA5RDAfeRFDHx8iZ
 /zv2U2BKIWUJ1ulRWGW5FpNq+U22DoYzhGn5y/yvt2fIMzJGMzUJ2rmyEI+TkuW+SV31
 ZKp0L1WrBNvnjIgJGV7ufUE0M/UDJ5CnDfSopOPYybswnhKyWM77hsJuo2UWkOUcsaV7
 nmHjxXbrF63bJOncqLl0cFSb5O3XmObnjJltL5E2MTTvg0A+ZvDxxjkcrpYDg+gyi5s/ 0Q== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0014ca01.pphosted.com with ESMTP id 312bs0myge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 02:31:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiglQC6j8ZxZ8soRUp6n25UWq5zHmu8sroN8RTQxjKHOxIHlPCWDGy8TFOsp1KDmyVTL3rc0+i1n1XBoBsDFBEr4hUaxHw2u1bZK2jMIbLwmXLz36qOviu5VV9wdxaRVD14o508lZPugpZq/SWy2Z6UMCqZ+ueqoX2bJBmBEfQeu4JMh2yZWnOpbMFHgTtRynXiR/juuVNI5jpJBZDzzmWuj8cx/zZPZPB/NLx0XMUjDk1J29ugEIh/88ena4ccZn9OITAT3j6Tb5X1GY3vmDzGJyegJHyc5uFABs/xzwN6e0ZBJNjiyP5awjnqX+joR+M5pSn56hHGZuMxRYe/x5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/0Bpvf/9l8RH5oOJ89DAbj/B0Cz098KoT009UZr0mk=;
 b=LTx2gxY2Z2iEt3kJYl9XhmHfpDSdexldXzIDPdlp/dGaBB7Zgkm8TAx/q7bJe6rABtDo/9OR7tM/B7zKo10D8jj9GCT53zn6oEMmkzpk2/f+h1YPA1Sizzt6K/Wd3DvICsbawpP0rj/5znA1lIMfoyy5f559he8fdscJZt4nMUrtxhPPSNfDBncjVEq8OQ6RPAEX1gNFmgB62yekttdUHUrn0qqGVZNyACnkwK8KN87fKOjag/cC8OgIJ6BOQEVhXJTo2Lq/xgVoaMMt10PUhWyHEcAC4NCMOtCJDk2Yi9Nb0DxyBLlpqVr+r89LpCD6Ve4s/OpZeVrjVUFAQ0YPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/0Bpvf/9l8RH5oOJ89DAbj/B0Cz098KoT009UZr0mk=;
 b=49u+LOZmc7hzSM1GlESUOTtq4weOnyQDJsJb/HSGa3w+GmKqNfBE6QSO9ZY2aKiH7ECdRk11S+Fznm0N6nEUcj/cap60PjT8Y5kChXPXOaS5I3UY/kbNomcSMSYwd+ZuKdkGToYiv7cHswCUPk9ZHOCi/Jl27y5O3KVqpaN1yNY=
Received: from CO2PR04CA0078.namprd04.prod.outlook.com (2603:10b6:102:1::46)
 by CY4PR0701MB3795.namprd07.prod.outlook.com (2603:10b6:910:92::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Thu, 21 May
 2020 09:31:16 +0000
Received: from MW2NAM12FT061.eop-nam12.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::1a) by CO2PR04CA0078.outlook.office365.com
 (2603:10b6:102:1::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend
 Transport; Thu, 21 May 2020 09:31:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT061.mail.protection.outlook.com (10.13.181.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.11 via Frontend Transport; Thu, 21 May 2020 09:31:16 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 04L9VAXK015774
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 21 May 2020 02:31:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 21 May 2020 11:31:10 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 21 May 2020 11:31:10 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 04L9VATP032159;
        Thu, 21 May 2020 11:31:10 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 04L9V85X032139;
        Thu, 21 May 2020 11:31:08 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>
CC:     <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>, Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v2 0/2] I3C SETDASA and DAA process fix
Date:   Thu, 21 May 2020 11:31:07 +0200
Message-ID: <1590053467-32079-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(36092001)(46966005)(2616005)(7636003)(426003)(107886003)(36756003)(186003)(336012)(47076004)(8936002)(82310400002)(4326008)(356005)(26005)(2906002)(8676002)(86362001)(82740400003)(5660300002)(478600001)(70586007)(42186006)(54906003)(316002)(70206006)(4744005)(110136005)(36906005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b101abb-6b8e-4a5b-4ba2-08d7fd69b5e6
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3795:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB379574DF696B685DF5803DB6C1B70@CY4PR0701MB3795.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 041032FF37
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5GkqODUjarxy0WSmvDsvnhiYd4WksUO9wRKdbHGkDJC5wVMYziId6FiFu+rqqYmlh9TshVQ7zhNysFfSjSnmPwN+lMJjejRmXmEl85Xwj7ZxlRSk5lSajp8RVySvgTd1rasT9KUXrknb56hNG9fu5uImROl8COuI3w7bkJJt/dNiBJtRQwr3p6AZ1ZpTtGTgnSP6SYqmwQ15bIsdlEARmDzi1tTna8EriDVuVIGKOQ4kVtX7zDjtaELdOHbIJni7qd4u6xkaRZc2WQm62KQIKMfM47HacF9C9n8VNfI8wiYXd3knyHTkFqHlzhciLAJ986yg5FNf0pDUy9DWxt+9qsLiJKtDVPXoyVh2p4wZ/qt1XVqaFq/q5qXiS41Z+psjBXeUlied6yv2wsNgSsflx8xgMOKrPVCfc59k6Y1c/RxlitJ2rO35UHNhwrz22YDqJ9YYoObJiQ+XLfEn2fbduG9NnMX57g3OdG1nHqpII25oZJQSlEWvdLOqNZZuhLpN8beap6FlPKagQy7AVTWboKCR77iVf3NJQF6Zgtypsc4=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2020 09:31:16.0707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b101abb-6b8e-4a5b-4ba2-08d7fd69b5e6
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3795
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-21_05:2020-05-20,2020-05-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 mlxlogscore=833
 cotscore=-2147483648 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005210069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes between v1 and v2 are:
1. Added boardinfo attach fix.
2. Removed reattach issue related fix.
3. Reserve init_dyn_addr initially, so that it will not
   be used in DAA and  attempt can be made to set those
   firmware requested dynamic address after DAA.

Regards,
Parshuram Thombare

Parshuram Thombare (2):
  i3c: master add i3c_master_attach_boardinfo to preserve boardinfo
  i3c: master: fix for SETDASA and DAA process

 drivers/i3c/master.c | 138 +++++++++++++++++++++++++++----------------
 1 file changed, 88 insertions(+), 50 deletions(-)

-- 
2.17.1

